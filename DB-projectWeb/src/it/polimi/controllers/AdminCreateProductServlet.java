package it.polimi.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.lang.StringEscapeUtils;

import org.thymeleaf.context.WebContext;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import it.polimi.utils.ImageUtils;
import it.polimi.services.AdminService;

@WebServlet("/Admin/CreateProduct")
@MultipartConfig
public class AdminCreateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TemplateEngine templateEngine;
	@EJB(name = "it.polimi.services/AdminService")
	private AdminService adminService;

	public AdminCreateProductServlet() {
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
		String path = "/WEB-INF/AdminCreateProduct.html";
		ServletContext servletContext = getServletContext();
		final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
		templateEngine.process(path, ctx, response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String prodName  = null;
		String prodDate = null;
		int idProd = -1;
		
		try {
			
			prodName = StringEscapeUtils.escapeJava(request.getParameter("prodName"));
			prodDate = request.getParameter("prodDate");
			Part imgFile = request.getPart("prodImageFile");
			System.out.println(imgFile);
			InputStream imgContent = imgFile.getInputStream();
			System.out.println(imgContent);
			byte[] imgByteArray = ImageUtils.readImage(imgContent);
			
			if (prodName == null || prodName.isEmpty()) {
				throw new Exception("You must insert product name and question");
			}
			
			
			
			idProd = adminService.CreateProduct(prodName, prodDate, imgByteArray);
			
			String redirectPath;
			redirectPath = getServletContext().getContextPath() + "/Admin/AddQuestion?idProd=" + Integer.toString(idProd);
			response.sendRedirect(redirectPath);
			
		} catch (Exception e) {
			e.printStackTrace();
					
			
			ServletContext servletContext = getServletContext();
			final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
			ctx.setVariable("errorMsg", e.toString());
			String path = "/WEB-INF/AdminCreateProduct.html";
			templateEngine.process(path, ctx, response.getWriter());
		}
		
		
	}

	public void destroy() {
	}
}