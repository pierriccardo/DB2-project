package it.polimi.controllers;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import it.polimi.services.QuestionnaireService;


@WebServlet("/Admin/DeleteQuestionnaire")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(name = "it.polimi.services/QuestionnaireService")
	private QuestionnaireService qService;
	private TemplateEngine templateEngine;


	public DeleteServlet() {
		super();
		// TODO Auto-generated constructor stub
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
		String path = "/WEB-INF/AdminDeleteQuestionnaire.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());

		templateEngine.process(path, ctx, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = "/WEB-INF/AdminDeleteQuestionnaire.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		Integer qId = null;
		try {
			qId = Integer.parseInt(request.getParameter("qId"));
			qService.deleteAlbum(qId);
		} catch (Exception e) {
			ctx.setVariable("errorMsg", "Invalid Questionnaire parameters");
			templateEngine.process(path, ctx, response.getWriter());
			return;
		}
		
		String ctxpath = getServletContext().getContextPath();
		path = ctxpath + "/GoToHomeAdminPage";
		response.sendRedirect(path);
	}

}