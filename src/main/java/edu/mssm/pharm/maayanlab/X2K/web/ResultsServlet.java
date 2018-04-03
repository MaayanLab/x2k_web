package edu.mssm.pharm.maayanlab.X2K.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.Genes2Networks.Genes2Networks;
import edu.mssm.pharm.maayanlab.Genes2Networks.NetworkNode;
import edu.mssm.pharm.maayanlab.KEA.KEA;
import edu.mssm.pharm.maayanlab.X2K.enrichment.Network;
import edu.mssm.pharm.maayanlab.X2K.enrichment.X2K;
import edu.mssm.pharm.maayanlab.common.web.JSONify;
import edu.mssm.pharm.maayanlab.common.web.PartReader;


@WebServlet(urlPatterns = { "/results" })
@MultipartConfig
public class ResultsServlet extends HttpServlet {

	private static final long serialVersionUID = 6063942151226647232L;
	private String chEA;
	private String g2n;
	private String kEA;
	private String x2k;
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET request - Results");
        
		// X2K
		JSONify json = Context.getJSONConverter();
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		json.add("availableSettings", availableSettings);
		req.getRequestDispatcher("/results.jsp").forward(req, resp);
    }
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//	    Part fileChunk = req.getPart("file");
//	    ArrayList<String> inputList = PartReader.readLines(fileChunk);
	    Part geneChunk = req.getPart("text-genes");
	    ArrayList<String> textGenes = PartReader.readLines(geneChunk);
		System.out.println("POST request - ChEA");
//	    if (inputList.size() > 0) {
//	        System.out.println("Using files genes:");
//	        System.out.println(inputList);
//	        setChEA(runChEA(inputList, req, resp));
//	    } else
		if (textGenes.size() > 0) {
	        System.out.println("Using text genes:");
	        System.out.println(textGenes);
	        setChEA(runChEA(textGenes, req, resp));
	    } else {
	        System.out.println("no lists received - error");
	    }

	    System.out.println("POST request - G2N");
//	    if(inputList.size() > 0){
//	        setG2n(runG2N(inputList, req, resp));
//	    }
//	    else 
	    if(textGenes.size() > 0){
	        setG2n(runG2N(textGenes, req, resp));
	    }
	    else{
	        System.out.println("no lists received - error");
	    }

	    System.out.println("POST request - KEA");
//	    if(inputList.size() > 0){ //from file selection
//	        setkEA(runKEA(inputList, req, resp));
//	    }
//	    else 
	    if(textGenes.size() > 0){ //as text
	        setkEA(runKEA(textGenes, req, resp));
	    }
	    else{
	        System.out.println("no lists received - error");
	    }

	    System.out.println("POST request - X2K");
//	    if(inputList.size() > 0){
//	        setX2k(enrichList(inputList, req, resp));
//	    }
//	    else 
	    if(textGenes.size() > 0){
	        setX2k(enrichList(textGenes, req, resp));
	    }
	    else{
	        System.out.println("no lists received - error");
	    }
	    
        JSONify json = Context.getJSONConverter();
        json.add("ChEA", chEA);
        json.add("G2N", g2n);
        json.add("KEA", kEA);
        json.add("X2K", x2k);
        json.add("input", textGenes);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        req.setAttribute("json", json);
        req.getRequestDispatcher("/results.jsp").forward(req, resp);
	}
	
	// ChEA procedures
    public static String runChEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Run enrichment
        ChEA app = new ChEA();
        System.out.println(app);
        System.out.println(ChEA.SORT_BY);
        System.out.println(req.getParameter(ChEA.SORT_BY));
        System.out.println(ChEA.INCLUDED_ORGANISMS);
        System.out.println(req.getParameter(ChEA.INCLUDED_ORGANISMS));
        System.out.println(ChEA.BACKGROUND_DATABASE);
        System.out.println(req.getParameter(ChEA.BACKGROUND_DATABASE));
        app.setSetting(ChEA.SORT_BY, req.getParameter(ChEA.SORT_BY));
        app.setSetting(ChEA.INCLUDED_ORGANISMS, req.getParameter(ChEA.INCLUDED_ORGANISMS));
        app.setSetting(ChEA.BACKGROUND_DATABASE, req.getParameter(ChEA.BACKGROUND_DATABASE));
        app.run(inputList);

        // Write app to session
        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("app", app);

        // Write output
        JSONify json = Context.getJSONConverter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        json.add("type", "ChEA");
        json.add("tfs", app.getTopRanked(Integer.parseInt(req.getParameter("number_of_results"))));
        json.add(ChEA.SORT_BY, req.getParameter(ChEA.SORT_BY));
        return json.toString();
    }

    // G2N procedures
    
    public static Network makeNetwork(Genes2Networks app){
        Network network = new Network();

        HashSet<NetworkNode> networkSet = app.getNetworkSet();
        for (NetworkNode node : networkSet) {
        	String nodeName = node.getName();
        	if (nodeName.length() > 1) {
        		nodeName = nodeName.split("-")[0];
        	};
            network.addNode(Network.nodeTypes.networkNode, node, nodeName);
        }

        for (NetworkNode node : networkSet) {
            HashSet<NetworkNode> neighbors = node.getNeighbors();
            for (NetworkNode neighbor : neighbors)
                if (network.contains(neighbor.getName())){
                	String nodeName = node.getName();
                	if (nodeName.length() > 1) {
                		nodeName = nodeName.split("-")[0];
                	};                	
            		String neighborName = neighbor.getName();
                	if (neighborName.length() > 1) {
                		neighborName = neighborName.split("-")[0];
                	};
                    network.addInteraction(nodeName, neighborName);
                }
        }

        return network;
	}
	
	private static String getParam(HttpServletRequest req, String param, String defaultParam) {
		String result = req.getParameter(param);
		if(result == null)
			return defaultParam;
		return result;
	}

    public static String runG2N(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Run enrichment
        Genes2Networks app = new Genes2Networks();
        app.setSetting(Genes2Networks.PATH_LENGTH, req.getParameter(Genes2Networks.PATH_LENGTH));
        app.setSetting(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES, req.getParameter(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES));
        app.setSetting(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS, req.getParameter(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS));
        app.setSetting(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES, req.getParameter(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES));
        app.setSetting(Genes2Networks.ENABLE_BIOCARTA, getParam(req, Genes2Networks.ENABLE_BIOCARTA, "false"));
        app.setSetting(Genes2Networks.ENABLE_BIOGRID, getParam(req, Genes2Networks.ENABLE_BIOGRID, "false"));
        app.setSetting(Genes2Networks.ENABLE_BIOPLEX, getParam(req, Genes2Networks.ENABLE_BIOPLEX, "false"));        
        app.setSetting(Genes2Networks.ENABLE_DIP, getParam(req, Genes2Networks.ENABLE_DIP, "false"));
        app.setSetting(Genes2Networks.ENABLE_HUMAP, getParam(req, Genes2Networks.ENABLE_HUMAP, "false"));
        app.setSetting(Genes2Networks.ENABLE_IREF, getParam(req, Genes2Networks.ENABLE_IREF, "false"));
        app.setSetting(Genes2Networks.ENABLE_INNATEDB, getParam(req, Genes2Networks.ENABLE_INNATEDB, "false"));
        app.setSetting(Genes2Networks.ENABLE_INTACT, getParam(req, Genes2Networks.ENABLE_INTACT, "false"));
        app.setSetting(Genes2Networks.ENABLE_KEGG, getParam(req, Genes2Networks.ENABLE_KEGG, "false"));
        app.setSetting(Genes2Networks.ENABLE_MINT, getParam(req, Genes2Networks.ENABLE_MINT, "false"));
        app.setSetting(Genes2Networks.ENABLE_PPID, getParam(req, Genes2Networks.ENABLE_PPID, "false"));
        app.setSetting(Genes2Networks.ENABLE_SNAVI, getParam(req, Genes2Networks.ENABLE_SNAVI, "false"));
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
        
        return json.toString();
    }

    // KEA procedures
    public static String runKEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Run enrichment
        KEA app = new KEA();
        app. setSetting(KEA.SORT_BY, req.getParameter(KEA.SORT_BY));
        app.run(inputList);

        // Write app to session - to be investigated
        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("app", app);

        // Write output
        JSONify json = Context.getJSONConverter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        json.add("type","KEA");
        json.add("kinases", app.getTopRanked(Integer.parseInt(req.getParameter("number_of_results"))));
        json.add(KEA.SORT_BY, req.getParameter(KEA.SORT_BY));
        return json.toString();
    }
    
    // X2K procedures
	private static final HashMap<String, String[]> availableSettings = new HashMap<String, String[]>();

	static {
		availableSettings.put(ChEA.SORT_BY, new String[] { ChEA.PVALUE, ChEA.RANK, ChEA.COMBINED_SCORE });
		availableSettings.put(ChEA.INCLUDED_ORGANISMS, new String[] { ChEA.MOUSE_ONLY, ChEA.HUMAN_ONLY, ChEA.BOTH });
		availableSettings.put(ChEA.BACKGROUND_DATABASE, new String[] { ChEA.CHIPX, ChEA.PWM, ChEA.PWM_GB,
																	   ChEA.CHEA_2015, ChEA.TRANS_JASP,
																	   ChEA.CONSENSUS, ChEA.ENCODE_2015});
		availableSettings.put(Genes2Networks.PATH_LENGTH, new String[] { "1", "4", "7", "10", "13", "16" });
		availableSettings.put(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES, new String[] { "0", "1", "4", "5",  "8" });
		availableSettings.put(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS, new String[] { "0", "1", "4", "7", "10" });
		availableSettings.put(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES, new String[] { "0", "1", "4", "7", "10" });
		availableSettings.put(Genes2Networks.ENABLE_BIOCARTA, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_BIOGRID, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_BIOPLEX, new String[] { "true", "false" });		
		availableSettings.put(Genes2Networks.ENABLE_DIP, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_HUMAP, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_INNATEDB, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_INTACT, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_KEGG, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_MINT, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_PPID, new String[] { "true", "false" });
		availableSettings.put(Genes2Networks.ENABLE_SNAVI, new String[] { "true", "false" });
		availableSettings.put(KEA.SORT_BY, new String[] { KEA.PVALUE, KEA.RANK, KEA.COMBINED_SCORE });
		availableSettings.put(X2K.MINIMUM_NETWORK_SIZE, new String[] { "1", "4","7",  "10", "13"});
		// availableSettings.put(X2K.NUMBER_OF_TOP_TFS, new String[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" });
		availableSettings.put(X2K.NUMBER_OF_TOP_TFS, new String[] { "15" });
		//availableSettings.put(X2K.NUMBER_OF_TOP_KINASES, new String[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" });
	}

	public static String enrichList(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Run enrichment
		X2K app = new X2K();

		readAndSetSettings(req, app);
		app.run(inputList);
		

		// Write app to session
		HttpSession httpSession = req.getSession();
		httpSession.setAttribute("app", app);

		// Write output
		JSONify json = Context.getJSONConverter();
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		Network network = app.webNetwork();

		// System.out.println(network.interactions.size());
		json.add("type", "X2K");
		json.add("network", network);
		json.add("transcriptionFactors", app.getRankedTFs());
		json.add("kinases", app.getRankedKinases());
		// json.write(resp.getWriter());
		return json.toString();
	}

	private static void readAndSetSettings(HttpServletRequest req, X2K app) {
		for (String setting : availableSettings.keySet()){
		 if(req.getParameter(setting) != null){
			 app.setSetting(setting, req.getParameter(setting));
		 	}
		 }
	}
	
	public static HashMap<String, String[]> getAvailablesettings() {
		return availableSettings;
	}
	
	// Fields getters and setters
	public String getChEA() {
		return chEA;
	}

	public void setChEA(String chEA) {
		this.chEA = chEA;
	}

	public String getG2n() {
		return g2n;
	}

	public void setG2n(String g2n) {
		this.g2n = g2n;
	}

	public String getkEA() {
		return kEA;
	}

	public void setkEA(String kEA) {
		this.kEA = kEA;
	}

	public String getX2k() {
		return x2k;
	}

	public void setX2k(String x2k) {
		this.x2k = x2k;
	}
}

