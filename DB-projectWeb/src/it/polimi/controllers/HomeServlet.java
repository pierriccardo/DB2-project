package it.polimi.controllers;

import java.io.IOException;
import java.util.Date;
import java.util.List;

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

import it.polimi.entities.Product;
import it.polimi.entities.Review;
import it.polimi.entities.User;
import it.polimi.services.QuestionnaireService;


@WebServlet("/GoToHome")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(name = "it.polimi.services/QuestionnaireService")
	private QuestionnaireService qService;
	private TemplateEngine templateEngine;


	public HomeServlet() {
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
		
		String path = "/WEB-INF/HomePage.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
	
		User user;
		try {
			user = ((User) request.getSession().getAttribute("user"));
			ctx.setVariable("username", user.getUsername());
		} catch (Exception e) {
			ctx.setVariable("errorMsg", "There are no product to review for today! ");
			templateEngine.process(path, ctx, response.getWriter());
			return;
		}
		
		try {
			Product p = qService.findByDate(new Date());
			List<Review> reviews = p.getReviews();
			ctx.setVariable("product", p);
			ctx.setVariable("reviews", reviews);
			
			ctx.setVariable("compiled", qService.dailyQuestionnaireCompiled(user, p));
			//ctx.setVariable("compiled", true);

		} catch(Exception e) {
			ctx.setVariable("errorMsg", "There are no product to review for today! ");
			templateEngine.process(path, ctx, response.getWriter());
			return;
		}
		

		templateEngine.process(path, ctx, response.getWriter());
	}

}
