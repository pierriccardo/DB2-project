package it.polimi.controllers;

import java.io.IOException;

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

import java.util.List;

import it.polimi.entities.Answer;
import it.polimi.entities.Product;
import it.polimi.entities.Questionnaire;
import it.polimi.entities.User;
import it.polimi.services.AdminService;

@WebServlet("/Admin/UserAnswers")
public class AdminUserAnswersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/AdminService")
	private AdminService adminService;

	public AdminUserAnswersServlet() {
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
		
		String path = "/WEB-INF/AdminUserAnswers.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			
		try {
			int idQuestionnaire;
			try {
				idQuestionnaire= Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("idQuestionnaire")));
			} catch (NumberFormatException e) {
				throw new Exception("Problem with ID Questionnaire!");
			}
			//ctx.setVariable("idProd", idQuestionnaire);
			
			Questionnaire questionnaire = adminService.findQuestionnaire(idQuestionnaire);
			Product product = adminService.findProdFromQuestionnaire(idQuestionnaire);
			User user = adminService.findUserOfQuestionnaire(idQuestionnaire);
			List<Answer> answers = adminService.findAllAnswers(idQuestionnaire);
			
			ctx.setVariable("questionnaire", questionnaire);
			ctx.setVariable("answers", answers);
			ctx.setVariable("product", product);
			ctx.setVariable("user", user);
			
		} catch (Exception e) {
			ctx.setVariable("errorMsg", e.toString());
		}
		
		templateEngine.process(path, ctx, response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

	public void destroy() {
	}
}