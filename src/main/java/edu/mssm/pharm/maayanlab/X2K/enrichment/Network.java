package edu.mssm.pharm.maayanlab.X2K.enrichment;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.google.gson.annotations.Expose;
import edu.mssm.pharm.maayanlab.ChEA.TranscriptionFactor;
import edu.mssm.pharm.maayanlab.Genes2Networks.NetworkNode;
import edu.mssm.pharm.maayanlab.KEA.Kinase;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class Network {
    // TODO: Write annotations so json is correct
    @Expose
    public ArrayList<Node> nodes;
    @Expose
    public ArrayList<Interaction> interactions;

    private HashMap<String, Integer> nodeLocation;

    public Network() {
        nodes = new ArrayList<Node>();
        interactions = new ArrayList<Interaction>();
        nodeLocation = new HashMap<String, Integer>();
    }

    public void addNode(nodeTypes type, Object o, String name) {
        nodeLocation.put(name, nodes.size());
        nodes.add(new Node(type, o, name));
    }

    public void addInteraction(String node1, String node2) {
//		System.out.println("Interation from " + node1 + " to " + node2);
        int loc1 = nodeLocation.get(node1);
        int loc2 = nodeLocation.get(node2);
        interactions.add(new Interaction(loc1, loc2));
    }

    public boolean contains(String s) {
        return nodeLocation.containsKey(s);
    }

    public enum nodeTypes {
        kinase,
        transcriptionFactor,
        networkNode
    }

    public class NodeToJson implements JsonSerializer<Node> {
        @Override
        public JsonElement serialize(Node node, Type type, JsonSerializationContext jsc) {
            JsonObject jsonObject = new JsonObject();
            if (node.type == nodeTypes.transcriptionFactor) {
                TranscriptionFactor tf = (TranscriptionFactor) node.object;
                jsonObject.addProperty("name", tf.getName());
                jsonObject.addProperty("type", "tf");
                jsonObject.addProperty("pvalue", tf.getPValue());
            } else if (node.type == nodeTypes.kinase) {
                Kinase kinase = (Kinase) node.object;
                jsonObject.addProperty("name", kinase.getName());
                jsonObject.addProperty("type", "kinase");
                jsonObject.addProperty("pvalue", kinase.getPValue());
            } else {
                NetworkNode nn = (NetworkNode) node.object;
                jsonObject.addProperty("name", nn.getName());
                jsonObject.addProperty("type", "other");
                jsonObject.addProperty("pvalue", -1);
            }
            return jsonObject;
        }
    }

    public class Node {
        nodeTypes type;
        Object object;
        String name;

        public Node(nodeTypes type, Object object, String name) {
            this.type = type;
            this.object = object;
            this.name = name;
        }
    }

    public class Interaction {
        @Expose
        int source;
        @Expose
        int target;

        public Interaction(int source, int target) {
            this.source = source;
            this.target = target;
        }
    }
}
