package it.polimi.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;


import it.polimi.entities.Question;
import it.polimi.services.UserService;

@WebServlet("/Questionnaire")
public class QuestionnaireServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	/*@EJB(name = "it.polimi.services/UserService")
	private UserService usrService;*/

	public QuestionnaireServlet() {
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
		String path = "/WEB-INF/Questionnaire.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		List<Question> questions = new ArrayList<>();
		
		Question q1 = new Question();
		q1.setText("Question number one");
		q1.setId(1);
		questions.add(q1);
		
		Question q2 = new Question();
		q2.setText("Question number two");
		q1.setId(2);
		questions.add(q2);
		
		ctx.setVariable("questions", questions);
		
		templateEngine.process(path, ctx, response.getWriter());
	}

}
