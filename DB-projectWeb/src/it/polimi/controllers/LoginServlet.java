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

@WebServlet("/Login")
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
		User user = (User) request.getSession().getAttribute("user");
		
		if(user != null && user.isAdmin()) {
			String path = getServletContext().getContextPath() + "/Admin/CreateProduct";
			response.sendRedirect(path);
		} else if(user != null && !user.isAdmin()) {
			String path = getServletContext().getContextPath() + "/GoToHome";
			response.sendRedirect(path);
		} else {
			String path = "/WEB-INF/Login.html";
			ServletContext servletContext = getServletContext();
			final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			templateEngine.process(path, ctx, response.getWriter());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		String path = "/WEB-INF/Login.html";
		
		String usrn = null;
		String pwd = null;
		
		String errorMsg = "";
		try {
			usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
			pwd = StringEscapeUtils.escapeJava(request.getParameter("password"));
			if (usrn == null || pwd == null || usrn.isEmpty() || pwd.isEmpty()) {
				errorMsg = "Missing or empty credential value";
				throw new Exception(errorMsg);
			}

			User user;
			try {
				user = usrService.checkCredentials(usrn, pwd);
			} catch (CredentialsException | NonUniqueResultException e) {
				errorMsg = "Could not check credentials";
				throw new Exception(errorMsg);
			}
			
			if (user == null) {
				errorMsg = "Incorrect username or password";
				throw new Exception(errorMsg);
			} else {
				request.getSession().setAttribute("user", user);
				
				if(user.isAdmin()) {
					path = getServletContext().getContextPath() + "/Admin/CreateProduct";
					response.sendRedirect(path);
				} else if(!user.isAdmin()) {
					path = getServletContext().getContextPath() + "/GoToHome";
					response.sendRedirect(path);
				}
				
				return;
			}
			
		} catch (Exception e) {
			ctx.setVariable("errorMsg", (errorMsg.length() > 0) ? errorMsg : "Wrong request");
		}
		
		templateEngine.process(path, ctx, response.getWriter());
	}

	public void destroy() {
	}
}