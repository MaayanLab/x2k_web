package edu.mssm.pharm.maayanlab.X2K.web;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import edu.mssm.pharm.maayanlab.ChEA.ChEA;
import edu.mssm.pharm.maayanlab.common.web.JSONify;
import edu.mssm.pharm.maayanlab.common.web.PartReader;


@WebServlet(urlPatterns = { "/ChEA" })
@MultipartConfig
public class ChEAServlet extends HttpServlet {

    //idk what's going on here
    private static final long serialVersionUID = 6594466236752893592L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing get request - ChEA");
    }


    public static void runChEA(ArrayList<String> inputList, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Run enrichment
        ChEA app = new ChEA();
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
        json.add("type","ChEA");
        json.add("tfs", app.getTopRanked(10));
        json.add(ChEA.SORT_BY, req.getParameter(ChEA.SORT_BY));
        req.setAttribute("json",json);
        req.getRequestDispatcher("/ChEA_and_KEA.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doing post request - ChEA");
        Part fileChunk = req.getPart("geneList");
        ArrayList<String> inputList = PartReader.readLines(fileChunk);

        Part geneChunk = req.getPart("textGenes");
        ArrayList<String> textGenes = PartReader.readLines(geneChunk);

        //handle both possible types of input
        if(inputList.size() > 0){
            runChEA(inputList, req, resp);
        }
        else if(textGenes.size() > 0){
            runChEA(textGenes, req, resp);
        }
        else{
            System.out.println("no lists received - error");
        }
    }

}
