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
		//constructor
	}

	public int CreateProduct(String prodName, String prodDate, String prodImageFileName) throws Exception {
		
		Product product = new Product();
		product.setName(prodName);
		product.setImageFileName(prodImageFileName);
			
		//TODO: check if the date is already busy by another product
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date parsed = format.parse(prodDate);
		Date today = new Date();
		java.sql.Date sqlDate = new java.sql.Date(parsed.getTime());
		
		if (parsed.compareTo(today) < 0) {
			throw new Exception("Date must be today or in the future!");	
		}
		
		System.out.println(prodDate);
		System.out.println(prodImageFileName);
		System.out.println(prodName);
        
		product.setDate(sqlDate);
		em.persist(product);
		em.flush();
		return product.getId();
	}
	
	public Boolean AddQuestion(int idProd, String questionText) throws Exception {
		System.out.println(idProd);
		Question question = new Question();
		Product product = em.find(Product.class, idProd);
		question.setProduct(product);
		question.setText(questionText);
		em.persist(question);
			
		return true;
	}
	
	public List<Product> findAllProducts() {
		return em.createNamedQuery("Product.findAll", Product.class)
				.getResultList();
	}
	
	public Product findProduct(int idProd) {
		return em.find(Product.class, idProd);
	}
	
	public Questionnaire findQuestionnaire(int idQuestionnaire) {
		return em.find(Questionnaire.class, idQuestionnaire);
	}
	
	public User findUser(int idUser) {
		return em.find(User.class, idUser);
	}
	
}