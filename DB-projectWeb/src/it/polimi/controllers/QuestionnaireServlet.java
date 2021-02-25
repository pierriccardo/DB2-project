package it.polimi.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import it.polimi.entities.Product;
import it.polimi.entities.Questionnaire;
import it.polimi.entities.User;
import it.polimi.exceptions.UserBannedException;
import it.polimi.services.QuestionnaireService;

@WebServlet("/Questionnaire")
public class QuestionnaireServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/QuestionnaireService")
	private QuestionnaireService questionnaireService;

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
		
		String errorMsg = "";
		try {
			User user;
			try {
				user = (User) request.getSession().getAttribute("user");
				ctx.setVariable("username", user.getUsername());
			} catch (Exception e) {
				errorMsg = "Error with user session! try to logout and login.";
				throw new Exception(errorMsg);
			}
			
			if (user.isBanned()) {
				errorMsg = "You are banned!";
				throw new Exception(errorMsg);
			}
			
			int idProd;
			try {
				idProd = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("idProd")));
			} catch (NumberFormatException e) {
				errorMsg = "Wrong format request! Try again!";
				throw new Exception(errorMsg);
			}
			
			Product product = null;
			try {
				product = questionnaireService.findProductById(idProd);
			} catch (Exception e) {
				errorMsg = "Error during the search of the product!";
				throw new Exception(errorMsg);
			}
			
			if (product == null) {
				errorMsg = "Error during the search of the product!";
				throw new Exception(errorMsg);
			}
			
			Questionnaire questionnaire = null;
			try {
				questionnaire = questionnaireService.getOrCreateQuestionnaire(((User) request.getSession().getAttribute("user")), product);
			} catch (Exception e) {
				errorMsg = "Error during the manipulation of the questionnaire!";
				throw new Exception(errorMsg);
			}
			
			if (questionnaire.isSubmitted()) {
				errorMsg = "Questionnaire already compiled!";
				throw new Exception(errorMsg);
			}
			
			ctx.setVariable("idQuest", questionnaire.getId());
			ctx.setVariable("questions", questionnaireService.findAllQuestions(product));
		} catch (Exception e) {
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Wrong request!");
		}
		
		templateEngine.process(path, ctx, response.getWriter());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = "/WEB-INF/Greetingsmsg.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		String errorMsg = "";
		List<String> answers = null;
		List<Integer> idQuestions = null;
		Questionnaire questionnaire = null;
		try {
			User user;
			try {
				user = (User) request.getSession().getAttribute("user");
				ctx.setVariable("username", user.getUsername());
			} catch (Exception e) {
				errorMsg = "Error with user session! try to logout and login.";
				throw new Exception(errorMsg);
			}
			
			if (user.isBanned()) {
				errorMsg = "You are banned!";
				throw new Exception(errorMsg);
			}
			
			int idQuest, age, sex, expertise_level;
			try {
				idQuest = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("idQuest")));
				age = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("age")));
				sex = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("sex")));
				expertise_level = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("expertise_level")));
			} catch (NumberFormatException e) {
				errorMsg = "Wrong format request! Try again!";
				throw new Exception(errorMsg);
			}
			
			questionnaire = questionnaireService.findQuestionnaireById(idQuest);
			
			if (questionnaire.isSubmitted()) {
				errorMsg = "Questionnaire already compiled!";
				throw new Exception(errorMsg);
			}
			
			ctx.setVariable("idQuest", idQuest);
			
			Boolean emptyAnswer = false;
			answers = new ArrayList<String>();
			idQuestions = new ArrayList<Integer>();
			Iterator<String> parname = request.getParameterNames().asIterator();
			while(parname.hasNext()) {
				String x = parname.next();
				System.out.println(x);
				if(x.charAt(0) == 'q') {
					int idQuestion;
					try {
						idQuestion = Integer.parseInt(x.substring(1));
					} catch (NumberFormatException e) {
						continue;
					}
					
					String answer = request.getParameter(x);
					idQuestions.add(idQuestion);
					answers.add(answer);
					if (answer.length() == 0) 
						emptyAnswer = true;
				}
			}
			
			if (emptyAnswer) {
				errorMsg = "The answers are mandatory!";
				throw new Exception(errorMsg);
			}
			
			try {
				questionnaireService.fillQuestionnaire(idQuest, idQuestions, answers, true, age, sex, expertise_level);
			} catch (UserBannedException e) {
				user = questionnaireService.banUser(user);
				request.getSession().setAttribute("user", user);
				questionnaire = null;
				
				errorMsg = "You used a forbidden word! From now on you cannot fill in any other questionnaire.";
				throw new Exception(errorMsg);
			} catch (Exception e) {
				errorMsg = "Error during the upload of the questionnaire!";
				throw new Exception(errorMsg);
			}
		} catch (Exception e) {
			path = "/WEB-INF/Questionnaire.html";
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Wrong request!");
			
			if (questionnaire != null) {
				Product product = questionnaire.getProduct();

				ctx.setVariable("questions", product.getQuestions());
				
				if (answers != null && product.getQuestions().size() == answers.size()) {
					ctx.setVariable("answers", answers);
				}
			}
		}
		
		templateEngine.process(path, ctx, response.getWriter());
	}

	public void destroy() {
	}

}
