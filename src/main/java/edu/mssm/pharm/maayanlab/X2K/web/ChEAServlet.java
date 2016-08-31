package edu.mssm.pharm.maayanlab.X2K.web;


import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.common.web.JSONify;
import edu.mssm.pharm.maayanlab.common.web.PartReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;


@WebServlet(urlPatterns = {"/ChEA"})
@MultipartConfig
public class ChEAServlet extends HttpServlet {

    //idk what's going on here
    private static final long serialVersionUID = 6594466236752893592L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing get request - ChEA");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing post request - ChEA");
        Part fileChunk = req.getPart("file-genes");
        ArrayList<String> fileGenes = PartReader.readLines(fileChunk);

        Part geneChunk = req.getPart("text-genes");
        ArrayList<String> textGenes = PartReader.readLines(geneChunk);

        System.out.println(textGenes.size());

        //handle both possible types of input
        if (fileGenes.size() > 0) {
            System.out.println("Using files genes:");
            System.out.println(fileGenes);
            runChEA(fileGenes, req, resp);
        } else if (textGenes.size() > 0) {
            System.out.println("Using text genes:");
            System.out.println(textGenes);
            runChEA(textGenes, req, resp);
        } else {
            System.out.println("no lists received - error");
        }
    }

    public static void runChEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        json.add("tfs", app.getTopRanked(10));
        json.add(ChEA.SORT_BY, req.getParameter(ChEA.SORT_BY));
        req.setAttribute("json", json);
        req.getRequestDispatcher("/ChEA_and_KEA.jsp").forward(req, resp);
    }
}
