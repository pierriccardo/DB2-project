package it.polimi.controllers;

import java.io.IOException;
import java.sql.Date;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringEscapeUtils;

import org.thymeleaf.context.WebContext;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import it.polimi.services.AdminService;

@WebServlet("/Admin/AddQuestion")
public class AdminAddQuestionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/AdminService")
	private AdminService adminService;

	public AdminAddQuestionsServlet() {
		super();
	}

	public void init() throws ServletException {
		ServletContext servletContext = getServletContext();
		ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
		templateResolver.setTemplateMode(TemplateMode.HTML);
		this.templateEngine = new TemplateEngine();
		this.templateEngine.setTemplateResolver(templateResolver);
		templateResolver.setSuffix(".html");
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		String idProd = request.getParameter("idProd");
		
		//if (Integer.parseInt(idProd) < 0) {}
		
		String path = "/WEB-INF/AdminAddQuestion.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		ctx.setVariable("idProd", idProd.toString());
		templateEngine.process(path, ctx, response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// obtain and escape params
		
		String questionText  = null;
		String idProdStr = null;
		int idProd;
		
		try {
			
			questionText = StringEscapeUtils.escapeJava(request.getParameter("questionText"));
			idProdStr = StringEscapeUtils.escapeJava(request.getParameter("idProd"));
			idProd = Integer.parseInt(idProdStr);
			
			if (questionText == null || questionText.isEmpty()) {
				throw new Exception("Question cannot be empty!");
			}
			adminService.AddQuestion(idProd, questionText);
			
			String redirectPath;
			redirectPath = getServletContext().getContextPath() + "/Admin/AddQuestion?idProd=" + idProdStr;
			response.sendRedirect(redirectPath);
			
		} catch (Exception e) {
			ServletContext servletContext = getServletContext();
			final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			ctx.setVariable("errorMsg", e.toString());
			String path = "/WEB-INF/AdminAddQuestion.html";
			templateEngine.process(path, ctx, response.getWriter());
		}	
		
	}

	public void destroy() {
	}
}