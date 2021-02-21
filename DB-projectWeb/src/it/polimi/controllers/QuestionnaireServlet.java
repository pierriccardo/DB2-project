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

import it.polimi.entities.Answer;
import it.polimi.entities.Product;
import it.polimi.entities.Question;
import it.polimi.entities.Questionnaire;
import it.polimi.entities.User;
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
			try {
				ctx.setVariable("username", ((User) request.getSession().getAttribute("user")).getUsername());
			} catch (Exception e) {
				errorMsg = "Error with user session! try to logout and login.";
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
			
			System.out.println("ID: " + questionnaire.getId());
			
			ctx.setVariable("idQuest", questionnaire.getId());
			ctx.setVariable("questions", product.getQuestions());
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
		try {
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
			
			Questionnaire questionnaire = null;
			try {
				questionnaire = questionnaireService.findQuestionnaireById(idQuest);
			} catch (Exception e) {
				errorMsg = "Error during the search of the questionnaire!";
				throw new Exception(errorMsg);
			}
			
			questionnaire.setAge(age);
			questionnaire.setSex(sex);
			questionnaire.setExpertise_level(expertise_level);
			
			List<Answer> answers = new ArrayList<Answer>();
			Iterator<String> parname = request.getAttributeNames().asIterator();
			while(parname.hasNext()) {
				String x = parname.next();
				if(x.charAt(0) == 'q') {
					Question quest;
					try {
						int idQuestion = Integer.parseInt(x.substring(1));
						System.out.println(idQuestion);
						
						quest = questionnaireService.findQuestionById(idQuestion);
					} catch (Exception e) {
						errorMsg = "Error during the search of the question!";
						throw new Exception(errorMsg);
					}
					
					Answer answer = new Answer();
					answer.setQuestion(quest);
					answer.setQuestionnaire(questionnaire);
					answer.setText(request.getParameter(x));
					
					answers.add(answer);
				}
			}
			
			questionnaire.setAnswers(answers);
			
			//questionnaireService.persistQuestionnaire(questionnaire);
			
		} catch (Exception e) {
			path = "/WEB-INF/Questionnaire.html";
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Wrong request!");
		}
		
		templateEngine.process(path, ctx, response.getWriter());
	}

	public void destroy() {
	}

}
