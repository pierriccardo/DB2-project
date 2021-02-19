package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.NonUniqueResultException;

import it.polimi.entities.User;
import it.polimi.entities.Product;
import it.polimi.entities.Questionnaire;
import it.polimi.entities.Question;
//import javax.persistence.NonUniqueValueException;
import it.polimi.exceptions.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class AdminService {
	@PersistenceContext(unitName = "DB-projectEJB")
	private EntityManager em;

	public AdminService() {
	}
	
	//TODO: add throws
	/*
	 * @param prodName name of the product related to questionnaire
	 * @param prodDate String date in which the product become the product of the day
	 */
	public int CreateProduct(String prodName, String prodDate, String prodImageFileName) throws Exception {
		
		Product product = null;
		
		//TODO: check if is a bad practice cast integer to null
		int idProd = -1;
			
		try {
			//TODO: do we have to check if a product with the same name already exists?
			/*
			List<Product> products = null;
			products = em.createNamedQuery("Product.searchProduct", Product.class)
					.setParameter(1, productName)
					.getResultList();
				if (products == null || products.isEmpty()) {
					throw new Exception("The product insert doens't exist");
				}
			*/
			product = new Product();
			product.setName(prodName);
			product.setImageFileName(prodImageFileName);
			
			//TODO: check if the date is already busy by another product
			//TODO: add check that date must be > current date
			// convert data string to sql Date
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        Date parsed = format.parse(prodDate);
	        java.sql.Date sqlDate = new java.sql.Date(parsed.getTime());
	        
			product.setDate(sqlDate);
			
			// save id for sending to add questions page
			
			em.persist(product);
			
			//TODO: ask if it correct this procedure
			
			// retrieve the inserted product to take the id
			List<Product> plist = null;
			plist = em.createNamedQuery("Product.searchProduct", Product.class)
					.setParameter(1, prodName)
					.getResultList();
			
			Product newProd = new Product();
			newProd = plist.get(0);
			idProd = newProd.getId();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error in creating the product");
		}
			
		return idProd;
	}
	
	public Boolean AddQuestion(int idProd, String questionText) throws Exception {
			
		Question question = null;		
			
		try {
			question = new Question();
			question.setIdProduct(idProd);
			question.setText(questionText);
			
			em.persist(question);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error adding the question");
		}
			
		return true;
	}
}