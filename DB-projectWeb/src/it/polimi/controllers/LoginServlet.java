package it.polimi.controllers;

import java.io.IOException;
import java.security.Timestamp;
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

import it.polimi.entities.User;
import it.polimi.exceptions.CredentialsException;
import it.polimi.services.UserService;

import javax.persistence.NonUniqueResultException;

import javax.naming.*;

@WebServlet("/")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/UserService")
	private UserService usrService;

	public LoginServlet() {
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
		String path = "/WEB-INF/Login.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		templateEngine.process(path, ctx, response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// obtain and escape params
		String path;
		String usrn = null;
		String pwd = null;
		
		try {
			usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
			pwd = StringEscapeUtils.escapeJava(request.getParameter("password"));
			if (usrn == null || pwd == null || usrn.isEmpty() || pwd.isEmpty()) {
				throw new Exception("Missing or empty credential value");
			}

			User user;
			try {
				// query db to authenticate for user
				user = usrService.checkCredentials(usrn, pwd);
				/*if(usrn.equals("user") && pwd.equals("pass"))
					user = new User();
				else
					user = null;*/
				
			} catch (/* CredentialsException | */ NonUniqueResultException e) {
				e.printStackTrace();
				throw new Exception("Could not check credentials");
			}
			
			if (user == null) {
				ServletContext servletContext = getServletContext();
				final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
				ctx.setVariable("errorMsg", "Incorrect username or password");
				path = "/index.html";
				templateEngine.process(path, ctx, response.getWriter());
			} else {
				//QueryService qService = null;
				try {
					// Get the Initial Context for the JNDI lookup for a local EJB
					InitialContext ic = new InitialContext();
					// Retrieve the EJB using JNDI lookup
					//qService = (QueryService) ic.lookup("java:/openejb/local/QueryServiceLocalBean");
				} catch (Exception e) {
					e.printStackTrace();
				}
				request.getSession().setAttribute("user", user);
				
				//implementare associazione
				//usrService.RegisterLog(idUsr, new Timestamp(System.currentTimeMillis()));
				
				//request.getSession().setAttribute("queryService", qService);
				path = getServletContext().getContextPath() + "/GoToHomePage";
				response.sendRedirect(path);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ServletContext servletContext = getServletContext();
			final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			ctx.setVariable("errorMsg", e.toString());
			path = "/WEB-INF/Login.html";
			templateEngine.process(path, ctx, response.getWriter());
			return;
		}
	}

	public void destroy() {
	}
}