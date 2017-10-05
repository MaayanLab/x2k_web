package edu.mssm.pharm.maayanlab.X2K.web;


import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.Genes2Networks.Genes2Networks;
import edu.mssm.pharm.maayanlab.KEA.KEA;
import edu.mssm.pharm.maayanlab.X2K.enrichment.Network;
import edu.mssm.pharm.maayanlab.X2K.enrichment.X2K;
import edu.mssm.pharm.maayanlab.common.web.JSONify;
import edu.mssm.pharm.maayanlab.common.web.PartReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;


@WebServlet(urlPatterns = { "/network" })
@MultipartConfig
public class X2KServlet extends HttpServlet {

	private static final long serialVersionUID = 6594466236752893590L;
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
//		availableSettings.put(X2K.NUMBER_OF_TOP_TFS, new String[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" });
		availableSettings.put(X2K.NUMBER_OF_TOP_TFS, new String[] { "15" });
//		availableSettings.put(X2K.NUMBER_OF_TOP_KINASES, new String[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" });
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doing get request - X2K");
		JSONify json = Context.getJSONConverter();
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		json.add("availableSettings", availableSettings);
		req.getRequestDispatcher("/network.jsp").forward(req, resp);
//		json.write(resp.getWriter());
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doing post request - X2K");
//		Part fileChunk = req.getPart("file-genes");
//		ArrayList<String> inputList = PartReader.readLines(fileChunk);
		Part geneChunk = req.getPart("text-genes");
		ArrayList<String> textGenes = PartReader.readLines(geneChunk);
		//handle both possible types of input
//		if(inputList.size() > 0){
//			enrichList(inputList, req, resp);
//		}
//		else
		if(textGenes.size() > 0){
			enrichList(textGenes, req, resp);
		}
		else{
			System.out.println("no lists received - error");
		}

	}

	public static void enrichList(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

//		System.out.println(network.interactions.size());
		json.add("type", "X2K");
		json.add("network", network);
		json.add("transcriptionFactors", app.getRankedTFs());
		json.add("kinases", app.getRankedKinases());
//		json.write(resp.getWriter());
		req.setAttribute("json",json);
		req.getRequestDispatcher("/network.jsp").forward(req, resp);
	}

	private static void readAndSetSettings(HttpServletRequest req, X2K app) {
		for (String setting : availableSettings.keySet()){
		 if(req.getParameter(setting) != null){
			 app.setSetting(setting, req.getParameter(setting));
		 	}
		 }
	}
	
	/**
	 * @return the availablesettings
	 */
	public static HashMap<String, String[]> getAvailablesettings() {
		return availableSettings;
	}
}
