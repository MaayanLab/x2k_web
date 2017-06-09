package edu.mssm.pharm.maayanlab.X2K.web;


import edu.mssm.pharm.maayanlab.Genes2Networks.Genes2Networks;
import edu.mssm.pharm.maayanlab.Genes2Networks.NetworkNode;
import edu.mssm.pharm.maayanlab.X2K.enrichment.Network;
import edu.mssm.pharm.maayanlab.common.web.JSONify;
import edu.mssm.pharm.maayanlab.common.web.PartReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;


@WebServlet(urlPatterns = { "/G2N" })
@MultipartConfig
public class G2NServlet extends HttpServlet {

    //idk what's going on here
    private static final long serialVersionUID = 6594466236752893593L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing get request - G2N");
    }

    public static Network makeNetwork(Genes2Networks app){
        Network network = new Network();

        HashSet<NetworkNode> networkSet = app.getNetworkSet();
        for (NetworkNode node : networkSet) {
            network.addNode(Network.nodeTypes.networkNode, node, node.getName().split("-")[0]);
        }

        for (NetworkNode node : networkSet) {
            HashSet<NetworkNode> neighbors = node.getNeighbors();
            for (NetworkNode neighbor : neighbors)
                if (network.contains(neighbor.getName()))
                    network.addInteraction(node.getName().split("-")[0], neighbor.getName().split("-")[0]);
        }

        return network;
    }

    public static void runG2N(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Run enrichment
        Genes2Networks app = new Genes2Networks();
        app.setSetting(Genes2Networks.PATH_LENGTH, req.getParameter(Genes2Networks.PATH_LENGTH));
        app.setSetting(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES, req.getParameter(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES));
        app.setSetting(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS, req.getParameter(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS));
        app.setSetting(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES, req.getParameter(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES));
        app.setSetting(Genes2Networks.ENABLE_BIOCARTA, req.getParameter(Genes2Networks.ENABLE_BIOCARTA));
        app.setSetting(Genes2Networks.ENABLE_BIOGRID, req.getParameter(Genes2Networks.ENABLE_BIOGRID));
        app.setSetting(Genes2Networks.ENABLE_BIOPLEX, req.getParameter(Genes2Networks.ENABLE_BIOPLEX));        
        app.setSetting(Genes2Networks.ENABLE_DIP, req.getParameter(Genes2Networks.ENABLE_DIP));
        app.setSetting(Genes2Networks.ENABLE_HUMAP, req.getParameter(Genes2Networks.ENABLE_HUMAP));
        app.setSetting(Genes2Networks.ENABLE_INNATEDB, req.getParameter(Genes2Networks.ENABLE_INNATEDB));
        app.setSetting(Genes2Networks.ENABLE_INTACT, req.getParameter(Genes2Networks.ENABLE_INTACT));
        app.setSetting(Genes2Networks.ENABLE_KEGG, req.getParameter(Genes2Networks.ENABLE_KEGG));
        app.setSetting(Genes2Networks.ENABLE_MINT, req.getParameter(Genes2Networks.ENABLE_MINT));
        app.setSetting(Genes2Networks.ENABLE_PPID, req.getParameter(Genes2Networks.ENABLE_PPID));
        app.setSetting(Genes2Networks.ENABLE_SNAVI, req.getParameter(Genes2Networks.ENABLE_SNAVI));
        app.run(inputList);
        // Write app to session
        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("app", app);
        // Write output
        JSONify json = Context.getJSONConverter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        json.add("type","G2N");
        json.add("network",makeNetwork(app));
        json.add("input_list",inputList);
        req.setAttribute("json",json);
        req.getRequestDispatcher("/G2N.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing post request - G2N");
        Part fileChunk = req.getPart("file-genes");
        ArrayList<String> inputList = PartReader.readLines(fileChunk);

        Part geneChunk = req.getPart("text-genes");


        ArrayList<String> textGenes = PartReader.readLines(geneChunk);

        //handle both possible types of input
        if(inputList.size() > 0){
            runG2N(inputList, req, resp);
        }
        else if(textGenes.size() > 0){
            runG2N(textGenes, req, resp);
        }
        else{
            System.out.println("no lists received - error");
        }
    }

}
