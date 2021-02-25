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

import org.apache.commons.lang.StringEscapeUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import it.polimi.entities.Product;
import it.polimi.services.AdminService;
import it.polimi.services.QuestionnaireService;


@WebServlet("/Admin/DeleteQuestionnaire")
public class AdminDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(name = "it.polimi.services/adminService")
	private AdminService adminService;
	private TemplateEngine templateEngine;


	public AdminDeleteServlet() {
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
		
		List<Product> products = adminService.findAllProductsToDelete();		
		
		String path = "/WEB-INF/AdminDeleteQuestionnaire.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		ctx.setVariable("products", products);
		templateEngine.process(path, ctx, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = "/WEB-INF/AdminDeleteQuestionnaire.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		
		int idProd = -1;
		
		try {
			idProd = Integer.parseInt(request.getParameter("idProd"));
			adminService.deleteProduct(idProd);
		} catch (Exception e) {
			ctx.setVariable("errorMsg", "Invalid product parameters " + idProd);
			templateEngine.process(path, ctx, response.getWriter());
			return;
		}
		
		String ctxpath = getServletContext().getContextPath();
		path = ctxpath + "/Admin/DeleteQuestionnaire";
		response.sendRedirect(path);
	}

}
