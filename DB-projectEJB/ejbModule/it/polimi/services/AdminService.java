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
import java.time.*;


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

	public int CreateProduct(String prodName, String prodDate, byte[] prodImageFile) throws Exception {
		Product product = new Product();
		product.setName(prodName);
		product.setImageFile(prodImageFile);
			
		//TODO: check if the date is already busy by another product
        LocalDate parsed = LocalDate.parse(prodDate);
		LocalDate today = LocalDate.now();
		
		java.sql.Date sqlDate = java.sql.Date.valueOf(parsed);
		
		
		if (parsed.isBefore(today)) {
			System.out.println(parsed.compareTo(today));
			System.out.println(parsed);
			System.out.println(today);
			throw new Exception("Date must be today or in the future!");	
		}
		
		System.out.println(prodDate);
		System.out.println(prodImageFile);
		System.out.println(prodName);
        
		product.setDate(sqlDate);
		
		try {
			em.persist(product);
			em.flush();
		} catch (PersistenceException e) {
			if(e.getMessage().split("\n")[1].trim().split(":")[2].trim().equals("There can be only one product for a day!"))
				throw new SameDateException("The user is banned because he has used a banned word!");
			throw e;
		}
		
		return product.getId();
	}
	
	public List<Question> AddQuestion(int idProd, String questionText) throws Exception {
		System.out.println(idProd);
		Question question = new Question();
		Product product = em.find(Product.class, idProd);
		question.setProduct(product);
		question.setText(questionText);
		em.persist(question);
		em.flush();
		em.refresh(product);
		return product.getQuestions();
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
	
	public void deleteProduct(int idQ) {
		Product q = this.findProduct(idQ);
		if (q == null)
			return;
		em.remove(q);
		em.flush();
	}
	
	public List<Question> findQuestions(int idProd) {
		return em.find(Product.class, idProd).getQuestions();
	}
}