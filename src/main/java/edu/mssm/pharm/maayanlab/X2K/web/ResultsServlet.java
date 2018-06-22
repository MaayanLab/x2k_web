package edu.mssm.pharm.maayanlab.X2K.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Enumeration;
import java.util.Collections;

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


@WebServlet(urlPatterns = {"/results"})
@MultipartConfig
public class ResultsServlet extends HttpServlet {

	private static final long serialVersionUID = 6063942151226647232L;
	private String chEA;
	private String g2n;
	private String kEA;
	private String x2k;

	protected void forwardRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/templates/results.jsp").forward(req, resp);
	}
	protected void forwardRequest(JSONify json, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forwardRequest(req, resp);
	}
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("GET request - Results");
        
		// X2K
		JSONify json = Context.getJSONConverter();
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		json.add("availableSettings", defaultSettings);
		forwardRequest(req, resp);
    }
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Part geneChunk = req.getPart("text-genes");
	    ArrayList<String> textGenes = PartReader.readTokens(geneChunk);

		if(textGenes.size() <= 0)
			System.out.println("no lists received - error");
	
		X2K app = new X2K();

		readAndSetSettings(req, app);
		app.run(textGenes);
		
		// Write output
		JSONify json = Context.getJSONConverter();
		
		JSONify X2K_json = Context.getJSONConverter();
		X2K_json.add("type", "X2K");
		X2K_json.add("network", app.webNetwork());
		X2K_json.add("path_length", app.getSetting(X2K.PATH_LENGTH));
		// TODO: Fix frontend to eliminate the need of these
		X2K_json.add("transcriptionFactors", app.getRankedTFs());
		X2K_json.add("kinases", app.getRankedKinases());

		json.add("X2K", X2K_json.toString());

		JSONify ChEA_json = Context.getJSONConverter();
		ChEA_json.add("type", "ChEA");
		ChEA_json.add("tfs", app.getRankedTFs());
		json.add("ChEA", ChEA_json.toString());
		
		JSONify KEA_json = Context.getJSONConverter();
		KEA_json.add("type", "KEA");
		KEA_json.add("kinases", app.getRankedKinases());
		json.add("KEA", KEA_json.toString());

		JSONify G2N_json = Context.getJSONConverter();
		G2N_json.add("type", "G2N");
		G2N_json.add("network", app.webNetworkFiltered());
		G2N_json.add("input_list", app.getTopRankedTFs());
		json.add("G2N", G2N_json.toString());

		json.add("input", textGenes);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
		req.setAttribute("json", json);	    
        forwardRequest(json, req, resp);
	}
	
	// ChEA procedures
    public static String runChEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) {
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

    public static Network makeNetwork(Genes2Networks app) {
        Network network = new Network();

        HashSet<NetworkNode> networkSet = app.getNetworkSet();
        for (NetworkNode node : networkSet) {
            String nodeName = node.getName();
            if (nodeName.length() > 1) {
                nodeName = nodeName.split("-")[0];
            }
            network.addNode(Network.nodeTypes.networkNode, node, nodeName);
        }

        for (NetworkNode node : networkSet) {
            HashSet<NetworkNode> neighbors = node.getNeighbors();
            for (NetworkNode neighbor : neighbors)
                if (network.contains(neighbor.getName())) {
                    String nodeName = node.getName();
                    if (nodeName.length() > 1) {
                        nodeName = nodeName.split("-")[0];
                    }
                    String neighborName = neighbor.getName();
                    if (neighborName.length() > 1) {
                        neighborName = neighborName.split("-")[0];
                    }
                    network.addInteraction(nodeName, neighborName);
                }
        }

        return network;
    }

    private static String getParam(HttpServletRequest req, String param, String defaultParam) {
        String result = req.getParameter(param);
        if (result == null)
            return defaultParam;
        return result;
    }

    public static String runG2N(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) {
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
        json.add("type", "G2N");
        json.add("network", makeNetwork(app));
        json.add("input_list", inputList);

        return json.toString();
    }

    // KEA procedures
    public static String runKEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) {
        // Run enrichment
        KEA app = new KEA();
        app.setSetting(KEA.SORT_BY, req.getParameter(KEA.SORT_BY));
        app.run(inputList);

        // Write app to session - to be investigated
        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("app", app);

        // Write output
        JSONify json = Context.getJSONConverter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        json.add("type", "KEA");
        json.add("kinases", app.getTopRanked(Integer.parseInt(req.getParameter("number_of_results"))));
        json.add(KEA.SORT_BY, req.getParameter(KEA.SORT_BY));
        return json.toString();
    }

    // X2K procedures
	private static final HashMap<String, String> defaultSettings = new HashMap<String, String>();

	static {
		defaultSettings.put(ChEA.SORT_BY, ChEA.PVALUE);
		defaultSettings.put(ChEA.INCLUDED_ORGANISMS, null);
		defaultSettings.put(ChEA.BACKGROUND_DATABASE, null);
		defaultSettings.put(Genes2Networks.PATH_LENGTH, null);
		defaultSettings.put(Genes2Networks.MAXIMUM_NUMBER_OF_EDGES, null);
		defaultSettings.put(Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS, null);
		defaultSettings.put(Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES, null);
		defaultSettings.put(Genes2Networks.ENABLE_BIND, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_BIOCARTA, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_BIOGRID, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_BIOPLEX, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_DIP, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_FIGEYS, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_HPRD, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_HUMAP, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_IREF, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_INNATEDB, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_INTACT, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_KEA, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_KEGG, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_MINT, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_MIPS, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_MURPHY, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_PDZBASE, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_PPID, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_PREDICTEDPPI, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_SNAVI, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_STELZL, new String("false"));
		defaultSettings.put(Genes2Networks.ENABLE_VIDAL, new String("false"));
		defaultSettings.put(KEA.KINASE_INTERACTIONS, null);
		defaultSettings.put(KEA.SORT_BY, KEA.PVALUE);
		defaultSettings.put(X2K.MINIMUM_NETWORK_SIZE, null);
		// defaultSettings.put(X2K.NUMBER_OF_TOP_TFS, null);
		defaultSettings.put(X2K.NUMBER_OF_TOP_TFS, null);
		//defaultSettings.put(X2K.NUMBER_OF_TOP_KINASES, null);
	}

	public static String enrichList(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) {
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
		Enumeration<String> reqKeys = req.getParameterNames();
		// Save all settings
		for (String setting : Collections.list(reqKeys)) {
			app.setSetting(setting, req.getParameter(setting));
		}
		// Set defaults if weren't specified
		for (String setting : defaultSettings.keySet()){
		 	if(req.getParameter(setting) == null && defaultSettings.get(setting) != null) {
				app.setSetting(setting, defaultSettings.get(setting));
			}
		 }
	}
	
	public static HashMap<String, String> getdefaultsettings() {
		return defaultSettings;
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

