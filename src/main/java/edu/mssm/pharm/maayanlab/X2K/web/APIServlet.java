package edu.mssm.pharm.maayanlab.X2K.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import edu.mssm.pharm.maayanlab.X2K.web.ResultsServlet;
import edu.mssm.pharm.maayanlab.common.web.JSONify;


@WebServlet(urlPatterns = { "/api" })
@MultipartConfig
public class APIServlet extends ResultsServlet {
	protected void forwardRequest(HttpServletRequest req, HttpServletResponse resp) {
	}
	protected void forwardRequest(JSONify json, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.getWriter().print(json);
	}
}
