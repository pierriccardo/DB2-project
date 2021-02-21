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

import it.polimi.services.UserService;
import it.polimi.entities.User;
import it.polimi.exceptions.CredentialsException;
import javax.persistence.NonUniqueResultException;

import javax.naming.*;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/UserService")
	private UserService usrService;

	public RegisterServlet() {
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
		String path = "/WEB-INF/Register.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		templateEngine.process(path, ctx, response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// obtain and escape params
		String usrn  = null;
		String pwd   = null;
		String email = null;
		
		try {
			try {
				usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
				pwd = StringEscapeUtils.escapeJava(request.getParameter("password"));
				email = StringEscapeUtils.escapeJava(request.getParameter("email"));
				if (usrn == null || pwd == null || usrn.isEmpty() || pwd.isEmpty() || email == null || email.isEmpty()) {
					throw new Exception("Missing or empty credential value");
				}

			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("Missing or empty credential value");
			}
			
			try {
				// query db to authenticate for user
				usrService.Register(usrn, email, pwd);
			} catch (CredentialsException e) {
				e.printStackTrace();
				throw new Exception("Username or Email are already used");
			}
		} catch (Exception e) {
			ServletContext servletContext = getServletContext();
			final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			ctx.setVariable("errorMsg", e.toString());
			String path = "/WEB-INF/Register.html";
			templateEngine.process(path, ctx, response.getWriter());
		}
	}

	public void destroy() {
	}
}