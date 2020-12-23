package it.polimi.controllers;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import org.apache.commons.lang.StringEscapeUtils;

/*import org.thymeleaf.context.WebContext;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;*/

import it.polimi.services.UserService;
import it.polimi.entities.User;
import it.polimi.exceptions.CredentialsException;
import javax.persistence.NonUniqueResultException;

import javax.naming.*;

@WebServlet("/test")
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/UserService")
	private UserService usrService;

	public RegisterUser() {
		super();
	}

	public void init() throws ServletException {
		ServletContext servletContext = getServletContext();
		System.out.println("ciao");
		/*ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
		templateResolver.setTemplateMode(TemplateMode.HTML);
		this.templateEngine = new TemplateEngine();
		this.templateEngine.setTemplateResolver(templateResolver);
		templateResolver.setSuffix(".html");*/
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("BELLA!!!");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// obtain and escape params
		String usrn = "Piero";
		String pwd = "Fraternali";
		String email = "piero.fraternali@polimi.it";
	
		User user;
		try {
			// query db to authenticate for user
			user = usrService.RegisterUser(usrn, pwd, email);
		} catch (CredentialsException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Username or Email are already used");
			return;
		}

		// If the user exists, add info to the session and go to home page, otherwise
		// show login page with error message

		String path;
		if (user == null) {
			System.out.println("User is null");
			//ServletContext servletContext = getServletContext();
			//final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			//ctx.setVariable("errorMsg", "Username or Email are already used");
			//path = "/index.html";
			//templateEngine.process(path, ctx, response.getWriter());
		} else {
			System.out.println("ok");
			/*
			QueryService qService = null;
			try {
				// Get the Initial Context for the JNDI lookup for a local EJB
				InitialContext ic = new InitialContext();
				// Retrieve the EJB using JNDI lookup
				qService = (QueryService) ic.lookup("java:/openejb/local/QueryServiceLocalBean");
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("queryService", qService);
			path = getServletContext().getContextPath() + "/GoToHomePage";
			response.sendRedirect(path);*/
		}

	}

	public void destroy() {
	}
}