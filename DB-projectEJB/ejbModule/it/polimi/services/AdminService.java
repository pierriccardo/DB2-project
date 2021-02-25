package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.NonUniqueResultException;

import it.polimi.entities.User;
import it.polimi.entities.Answer;
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
			
		
        LocalDate parsed = LocalDate.parse(prodDate);
		LocalDate today = LocalDate.now();
		
		java.sql.Date sqlDate = java.sql.Date.valueOf(parsed);
		
		
		if (parsed.isBefore(today)) {
			throw new Exception("Date must be today or in the future!");	
		}
        
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
	
	public List<Product> findAllProductsToDelete() {
		LocalDate today = LocalDate.now();
		List<Product> prods = em.createNamedQuery("Product.findAllToDelete", Product.class)
				.setParameter(1, java.sql.Date.valueOf(today))
				.getResultList();		
		return prods;
	}
	
	
	
	public Product findProduct(int idProd) {
		return em.find(Product.class, idProd);
	}
	
	public Questionnaire findQuestionnaire(int idQuestionnaire) {
		Questionnaire q = em.find(Questionnaire.class, idQuestionnaire);
		em.refresh(q);
		return q;
	}
	
	public User findUser(int idUser) {
		User u = em.find(User.class, idUser);
		em.refresh(u);
		return u;
	}
	
	public void deleteProduct(int idQ) throws Exception {
		Product p = this.findProduct(idQ);
		if (p == null)
			return;
		
		LocalDate todelete = p.getDate().toLocalDate();
		LocalDate today = LocalDate.now();
		
		if (!todelete.isBefore(today)) {
			throw new Exception("you can delete only past questionnaires!");	
		}
		em.remove(p);
		em.flush();
	}
	
	public List<Questionnaire> findAllQuestionnaires(int idProd) {
		Product product = this.findProduct(idProd);
		em.refresh(product);
		List<Questionnaire> q = product.getQuestionnaires();
		for (Questionnaire 	questionnaire:q)
			em.refresh(questionnaire);
		return q;
	}
	
	public List<Question> findAllQuestions(int idProd) {
		Product p = em.find(Product.class, idProd);
		em.refresh(p);
		return p.getQuestions();
	}
	
	public Product findProdFromQuestionnaire(int idQuestionnaire) {
		Product p = em.find(Questionnaire.class, idQuestionnaire).getProduct();
		em.refresh(p);
		return p;
	}
	
	public User findUserOfQuestionnaire(int idQuestionnaire) {
		User u = em.find(Questionnaire.class, idQuestionnaire).getUser();
		em.refresh(u);
		return u;
	}
	
	public List<Answer> findAllAnswers(int idQuestionnaire) {
		List<Answer> a = em.find(Questionnaire.class, idQuestionnaire).getAnswers();
		for (Answer answer:a)
			em.refresh(answer);
		return a;
	}
}