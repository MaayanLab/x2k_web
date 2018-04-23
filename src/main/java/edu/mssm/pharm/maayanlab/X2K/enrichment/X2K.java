package edu.mssm.pharm.maayanlab.X2K.enrichment;

import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

import javax.swing.SwingWorker;

import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.ChEA.TranscriptionFactor;
import edu.mssm.pharm.maayanlab.Genes2Networks.Genes2Networks;
import edu.mssm.pharm.maayanlab.Genes2Networks.NetworkNode;
import edu.mssm.pharm.maayanlab.KEA.KEA;
import edu.mssm.pharm.maayanlab.KEA.Kinase;
import edu.mssm.pharm.maayanlab.common.core.FileUtils;
import edu.mssm.pharm.maayanlab.common.core.Settings;
import edu.mssm.pharm.maayanlab.common.core.SettingsChanger;
import edu.mssm.pharm.maayanlab.common.core.SimpleXMLWriter;
import edu.mssm.pharm.maayanlab.common.graph.NetworkModelWriter;
import edu.mssm.pharm.maayanlab.common.graph.PajekNETWriter;
import edu.mssm.pharm.maayanlab.common.graph.ShapeNode.Shape;
import edu.mssm.pharm.maayanlab.common.graph.XGMMLWriter;
import edu.mssm.pharm.maayanlab.common.graph.yEdGraphMLWriter;

public class X2K implements SettingsChanger {

	static Logger log = Logger.getLogger(X2K.class.getSimpleName());
	
	protected ChEA chea;
	protected Genes2Networks g2n;
	protected KEA kea;
	
	private Collection<String> topRankedTFs;
	private Collection<String> topRankedKinases;
	private HashSet<String> network;
	
	// progress tracking
	private SwingWorker<Void, Void> task = null;
	int progress = 0;
	String note = "";
	private boolean isCancelled = false;
	
	private String cheaOutput;
	private String g2nOutput;
	private String keaOutput;
	
	private final Settings settings = new Settings() {
		{	
			// Integer: minimum network size; otherwise, the path length is increased until the minimum met. [>0]
			set(X2K.MINIMUM_NETWORK_SIZE, 50);
			// Integer: number of transcription factors used in network expansion and drug discovery. [>0]
			set(X2K.NUMBER_OF_TOP_TFS, 10);
			// Integer: number of kinases used in drug discovery. [>0]
			set(X2K.NUMBER_OF_TOP_KINASES, 10);
			// Boolean: output a yEd graphml file for network visualization. [true/false]
			set(X2K.ENABLE_YED_OUTPUT, true);
			// Boolean: output a Cytoscape XGMML file for network visualization. [true/false]
			set(X2K.ENABLE_CYTOSCAPE_OUTPUT, false);
			// Boolean: output a Pajek NET file for network visualization. [true/false]
			set(X2K.ENABLE_PAJEK_OUTPUT, false);
			// String: web color of the transcription factors in the Cytoscape and yEd network outputs. [#000000 - #FFFFFF]
			set(X2K.TF_NODE_COLOR, "#FF0000");
			// String: web color of the kinases in the Cytoscape and yEd network outputs. [#000000 - #FFFFFF]
			set(X2K.KINASE_NODE_COLOR, "#00FF00");
			// String: web color of the substrates in the Cytoscape and yEd network outputs. [#000000 - #FFFFFF]
			set(X2K.SUBSTRATE_NODE_COLOR, "#FFFF00");
		}
	};
	
	public final static String MINIMUM_NETWORK_SIZE = "min_network_size";
	public final static String NUMBER_OF_TOP_TFS = "number of top TFs";
	public final static String NUMBER_OF_TOP_KINASES = "number of top kinases";
	public final static String ENABLE_YED_OUTPUT = "output results in yEd";
	public final static String ENABLE_CYTOSCAPE_OUTPUT = "output results in Cytoscape";
	public final static String ENABLE_PAJEK_OUTPUT = "output results in Pajek";
	public final static String TF_NODE_COLOR = "color of TF nodes";
	public final static String KINASE_NODE_COLOR = "color of kinase nodes";
	public final static String SUBSTRATE_NODE_COLOR = "color of substrate nodes";
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		if (args.length == 2) {
			X2K x2k = new X2K();
			x2k.run(args[0]);
			x2k.writeFile(args[1]);
		}
		else
			log.warning("Usage: java -Xmx1024m -jar X2K.jar genelist output");
	}
	
	public X2K() {
		settings.loadSettings();
	}
	
	public X2K(Settings settings) {
		settings.loadSettings(settings);
	}
	
	// Task methods
	public void setTask(SwingWorker<Void, Void> task) {
		this.task = task;
	}
	
	private void setProgress(int progress, String note) throws InterruptedException {
		// System.out.println(note);
		if (task != null) {
			if (isCancelled)
				throw new InterruptedException("Task cancelled at " + progress + "%!");
			task.firePropertyChange("progress", this.progress, progress);
			task.firePropertyChange("note", this.note, note);
			this.progress = progress;
			this.note = note;
		}
	}
	
	public void cancel() {
		isCancelled = true;
	}
	
	@Override
	public void setSetting(String key, String value) {
		settings.set(key, value);
	}
	
	public String getSetting(String key) {
		return settings.get(key);
	}
	
	public void run(ArrayList<String> inputList) {
		try {
			if (FileUtils.validateList(inputList))
				runAll(inputList);			
		} catch (ParseException e) {
			if (e.getErrorOffset() == -1)
				log.severe("Invalid input: " + "Input list is empty.");
			else
				log.severe("Invalid input: " + e.getMessage() + " at line " + (e.getErrorOffset() + 1) +" is not a valid Entrez Gene Symbol.");
			System.exit(-1);	
		}
	}
	
	public void run(String inputPath) {
		ArrayList<String> inputList = FileUtils.readFile(inputPath);
		run(inputList);
	}
	
	public void runAll(Collection<String> genelist) {
		try {
			setProgress(0, "Finding transcription factors...");		
			runChea(genelist);
			
			setProgress(30, "Finding network...");
			runG2N();
			
			setProgress(60, "Finding kinases...");
			runKea();
			
			setProgress(90, "Writing outputs...");
		} catch (InterruptedException e) {
			log.info(e.getMessage());
			return;
		}
	}

	private void runChea(Collection<String> genelist) {
		chea = new ChEA(settings);
		chea.run(genelist);
		topRankedTFs = chea.getTopRankedList(settings.getInt(NUMBER_OF_TOP_TFS));
	}

	private void runG2N() {
		g2n = new Genes2Networks(settings);
		Integer minimum_path_length = Integer.parseInt(settings.get(Genes2Networks.PATH_LENGTH));
		Integer maximum_path_length = 5;
		// System.out.println(MINIMUM_NETWORK_SIZE);
		do {
			// System.out.println(minimum_path_length);
			g2n.run(new ArrayList<String>(topRankedTFs));
			network = g2n.getNetwork();
			minimum_path_length++;
		} while(
			network.size() < settings.getInt(MINIMUM_NETWORK_SIZE)
			&& minimum_path_length <= maximum_path_length
		);
		// TODO: report error message when min_path_length >= maximum_path_length
	}
	
	private void runKea() {
		kea = new KEA(settings);
		kea.run(getProteinNetwork());
		topRankedKinases = kea.getTopRankedList(settings.getInt(NUMBER_OF_TOP_KINASES));
	}
	
	public Network constructNetworkObject() {
		Network network = new Network();
		
		for (TranscriptionFactor tf : chea.getTopRanked(settings.getInt(NUMBER_OF_TOP_TFS))) {
			network.addNode(Network.nodeTypes.transcriptionFactor, tf, tf.getSimpleName());
		}
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES)))
			network.addNode(Network.nodeTypes.kinase, kinase, kinase.getName().split("-")[0]);
		
		HashSet<NetworkNode> networkSet = g2n.getNetworkSet();
		for (NetworkNode node : networkSet) {
			network.addNode(Network.nodeTypes.networkNode, node, node.getName().split("-")[0]);
		}
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES))) {
			Set<String> substrates = kinase.getEnrichedSubstrates();
			for (String substrate : substrates)
				network.addInteraction(kinase.getName().split("-")[0], substrate.split("-")[0]);
		}
		
		for (NetworkNode node : networkSet) {
			HashSet<NetworkNode> neighbors = node.getNeighbors();
			for (NetworkNode neighbor : neighbors)
				if (network.contains(neighbor.getName()))
					network.addInteraction(node.getName().split("-")[0], neighbor.getName().split("-")[0]);
		}
		
		return network;
	}

	public Network webNetwork() {
		Network network = new Network();
		ArrayList<String> tfSimpleNames = new ArrayList<String>();

		for (TranscriptionFactor tf : chea.getTopRanked(settings.getInt(NUMBER_OF_TOP_TFS))) {
			network.addNode(Network.nodeTypes.transcriptionFactor, tf, tf.getSimpleName());
			tfSimpleNames.add(tf.getSimpleName());
		}
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES)))
			network.addNode(Network.nodeTypes.kinase, kinase, kinase.getName().split("-")[0]);
		HashSet<NetworkNode> networkSet = g2n.getNetworkSet();
		for (NetworkNode node : networkSet) {
			if(node.getName() != null){
				if(!tfSimpleNames.contains(node.getName())){
					network.addNode(Network.nodeTypes.networkNode, node, node.getName().split("-")[0]);
				}
			}
		}
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES))) {
			Set<String> substrates = kinase.getEnrichedSubstrates();
			for (String substrate : substrates){
				network.addInteraction(kinase.getName().split("-")[0], substrate.split("-")[0]);}
		}
		for (NetworkNode node : networkSet) {
			HashSet<NetworkNode> neighbors = node.getNeighbors();
			for (NetworkNode neighbor : neighbors){
				if ((neighbor.getName() != null)&&(node.getName() != null)){
					if (network.contains(neighbor.getName())){
						network.addInteraction(node.getName().split("-")[0], neighbor.getName().split("-")[0]);
					}
				}}
		}
		return network;
	}

	public Network webNetworkFiltered() {
		Network network = new Network();
		ArrayList<String> tfSimpleNames = new ArrayList<String>();

		for (TranscriptionFactor tf : chea.getTopRanked(settings.getInt(NUMBER_OF_TOP_TFS))) {
			network.addNode(Network.nodeTypes.transcriptionFactor, tf, tf.getSimpleName());
			tfSimpleNames.add(tf.getSimpleName());
		}
		HashSet<NetworkNode> networkSet = g2n.getNetworkSet();
		for (NetworkNode node : networkSet) {
			if(node.getName() != null){
				if(!tfSimpleNames.contains(node.getName())){
					network.addNode(Network.nodeTypes.networkNode, node, node.getName().split("-")[0]);
				}
			}
		}
		for (NetworkNode node : networkSet) {
			HashSet<NetworkNode> neighbors = node.getNeighbors();
			for (NetworkNode neighbor : neighbors){
				if ((neighbor.getName() != null)&&(node.getName() != null)){
					if (network.contains(neighbor.getName())){
						network.addInteraction(node.getName().split("-")[0], neighbor.getName().split("-")[0]);
					}
				}}
		}
		return network;
	}

	
	public NetworkModelWriter constructNetwork() {
		NetworkModelWriter nmw = new NetworkModelWriter();
		
		for (String node : topRankedTFs)
			nmw.addNode(node, settings.get(TF_NODE_COLOR), Shape.ELLIPSE);
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES)))
			nmw.addNode(kinase.getName(), settings.get(KINASE_NODE_COLOR), Shape.ELLIPSE);
		
		HashSet<NetworkNode> networkSet = g2n.getNetworkSet();
		for (NetworkNode node : networkSet)
			nmw.addNode(node.getName(), settings.get(SUBSTRATE_NODE_COLOR), Shape.ELLIPSE);
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES))) {
			Set<String> substrates = kinase.getEnrichedSubstrates();
			for (String substrate : substrates)
				nmw.addInteraction(kinase.getName(), substrate);
		}
		
		for (NetworkNode node : networkSet) {
			Set<NetworkNode> neighbors = node.getNeighbors();
			for (NetworkNode neighbor : neighbors)
				if (network.contains(neighbor.getName()))
					nmw.addInteraction(node.getName(), neighbor.getName());
		}
		
		return nmw;
	}
	
	public NetworkModelWriter constructSparseNetwork() {
		NetworkModelWriter nmw = new NetworkModelWriter();
		
		HashSet<String> tfs = new HashSet<String>();
		HashSet<String> validSubstrates = new HashSet<String>();
		
		for (String tf : topRankedTFs)
			tfs.add(tf);
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES))) {
			nmw.addNode(kinase.getName(), settings.get(KINASE_NODE_COLOR), Shape.ELLIPSE);
		}
		
		for (Kinase kinase : kea.getTopRanked(settings.getInt(NUMBER_OF_TOP_KINASES))) {
			Set<String> substrates = kinase.getEnrichedSubstrates();
			for (String substrate : substrates) {
				if (tfs.contains(substrate))
					nmw.addNode(substrate, settings.get(TF_NODE_COLOR), Shape.ELLIPSE);
				else
					nmw.addNode(substrate, settings.get(SUBSTRATE_NODE_COLOR), Shape.ELLIPSE);
				nmw.addInteraction(kinase.getName(), substrate);
				validSubstrates.add(substrate);
			}
		}
		
		HashSet<NetworkNode> networkSet = g2n.getNetworkSet();
		for (NetworkNode node : networkSet) {
			if (validSubstrates.contains(node.getName())) {
				HashSet<NetworkNode> neighbors = node.getNeighbors();
			 
				for (NetworkNode neighbor : neighbors)
					if (tfs.contains(neighbor.getName())) {
						nmw.addNode(neighbor.getName(), settings.get(TF_NODE_COLOR), Shape.ELLIPSE);
						nmw.addInteraction(node.getName(), neighbor.getName());
					}
			}
		}
		
		return nmw;
	}
	
	public void writeNetworks(String outputPrefix) {
		NetworkModelWriter nmw = constructNetwork();
		
		if (settings.getBoolean(ENABLE_YED_OUTPUT)) {
			yEdGraphMLWriter ygw = new yEdGraphMLWriter(outputPrefix + ".graphml");
			ygw.open();
			nmw.writeGraph(ygw);			
			ygw.close();
		}
		
		if (settings.getBoolean(ENABLE_CYTOSCAPE_OUTPUT)) {
			XGMMLWriter xgw = new XGMMLWriter(outputPrefix + ".xgmml");
			xgw.open();
			nmw.writeGraph(xgw);
			xgw.close();
		}
		
		if (settings.getBoolean(ENABLE_PAJEK_OUTPUT)) {
			try {
				PajekNETWriter pnw = new PajekNETWriter(outputPrefix + ".net");
				pnw.open();
				nmw.writeGraph(pnw);
				pnw.close();
			}
			catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

	}
	
	public void writeFile(String filename) {
		String outputPrefix = filename.replaceFirst("\\.\\w+$", "");
		
		cheaOutput = outputPrefix + "_tf.csv";
		chea.writeFile(cheaOutput);
		
		g2nOutput = outputPrefix + "_network.sig";
		g2n.writeFile(g2nOutput);
		
		keaOutput = outputPrefix + "_kinase.csv";
		kea.writeFile(keaOutput);
		
		if (settings.getBoolean(ENABLE_YED_OUTPUT) || settings.getBoolean(ENABLE_CYTOSCAPE_OUTPUT) || settings.getBoolean(ENABLE_PAJEK_OUTPUT))
			writeNetworks(outputPrefix);
		
		SimpleXMLWriter sxw = new SimpleXMLWriter(filename);
		sxw.startElement("Results", "");
			sxw.startElement("TranscriptionFactors", "", "count", Integer.toString(topRankedTFs.size()));
			for (String tf : topRankedTFs)
				sxw.listElement("TranscriptionFactor", tf);
			sxw.endElement();
			
			// Filter out TFs and kinases from protein network
			HashSet<String> filteredNetwork = new HashSet<String>(network.size());
			filteredNetwork.addAll(network);
			filteredNetwork.removeAll(topRankedTFs);
			filteredNetwork.removeAll(topRankedKinases);
					
			sxw.startElement("Network", "", "count", Integer.toString(filteredNetwork.size()));
			for (String protein : filteredNetwork)
				sxw.listElement("Protein", protein);
			sxw.endElement();
			
			sxw.startElement("Kinases", "", "count", Integer.toString(topRankedKinases.size()));
			for (String kinase : topRankedKinases)
				sxw.listElement("Kinase", kinase);
			sxw.endElement();
		sxw.close();
	}	
	
	public Collection<String> getTopRankedTFs() {
		return topRankedTFs;
	}
	
	public Collection<TranscriptionFactor> getRankedTFs() {
		return chea.getRankedList();
	}
	
	public HashSet<String> getProteinNetwork() {
		
		HashSet<String> proteinSet = new HashSet<String>();

		for (String line : network)
			proteinSet.add(line);
		
		for (String line : topRankedTFs)
			proteinSet.add(line);
		proteinSet.removeAll(Collections.singleton(null));
		return proteinSet;
		
	}
	
	public HashSet<NetworkNode> getProteinNetworkSet() {
		return g2n.getNetworkSet();
	}
	
	public Collection<String> getTopRankedKinases() {
		return topRankedKinases;
	}
	
	public Collection<Kinase> getRankedKinases() {
		return kea.getRankedList();
	}
	
	public String getChEAOutputName() {
		return this.cheaOutput;
	}
	
	public String getG2NOutputName() {
		return this.g2nOutput;
	}
	
	public String getKEAOutputName() {
		return this.keaOutput;
	}
}
