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

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import it.polimi.entities.User;
import it.polimi.services.UserService;


@WebServlet("/Leaderboard")
public class LeaderboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(name = "it.polimi.services/UserService")
	private UserService userService;
	private TemplateEngine templateEngine;


	public LeaderboardServlet() {
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
		
		List<User> leads = userService.getLeads();
		
		String path = "/WEB-INF/Leaderboard.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		ctx.setVariable("leads", leads);
		ctx.setVariable("i", 1);
		templateEngine.process(path, ctx, response.getWriter());
	}
	


	
	public void destroy() {
		
	}

}
