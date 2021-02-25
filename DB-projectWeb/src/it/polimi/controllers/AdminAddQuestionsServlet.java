package it.polimi.controllers;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
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

import it.polimi.entities.Question;
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
		
		String path = "/WEB-INF/AdminAddQuestion.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		String errorMsg = "";
		try {
			int idProd;
			try {
				idProd = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("idProd")));
			} catch (NumberFormatException e) {
				errorMsg = "Problem with ID product!";
				throw new Exception(errorMsg);
			}
			
			List<Question> questions = adminService.findAllQuestions(idProd);
						
			ctx.setVariable("idProd", idProd);
			ctx.setVariable("questions", questions);
		} catch (Exception e) {
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Wrong request");
		}
		
		templateEngine.process(path, ctx, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String path = "/WEB-INF/AdminAddQuestion.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		String errorMsg = "";
		try {
			int idProd;
			String questionText = StringEscapeUtils.escapeJava(request.getParameter("questionText"));
			
			try {
				idProd = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("idProd")));
			} catch (NumberFormatException e) {
				errorMsg = "Wrong format request! Try again!";
				throw new Exception(errorMsg);
			}
			
			if (questionText == null || questionText.isEmpty()) {
				errorMsg = "Question cannot be empty!";
				throw new Exception(errorMsg);
			}
			List<Question> questions = adminService.AddQuestion(idProd, questionText);
						
			ctx.setVariable("idProd", idProd);
			ctx.setVariable("questions", questions);
						
			
			//String redirectPath = getServletContext().getContextPath()+"/Admin/AddQuestion?idProd="+idProd;
			//response.sendRedirect(redirectPath);
		
		} catch (Exception e) {
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Incorrect request!");
		}		
		templateEngine.process(path, ctx, response.getWriter());
	}

	public void destroy() {
	}
}