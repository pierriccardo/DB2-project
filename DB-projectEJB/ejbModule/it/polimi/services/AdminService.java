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
	 * @param productName name of the product related to questionnaire
	 * @param question 
	 */
	public Boolean CreateQuestionnaire(String productName, String inputQuestions) throws Exception {
		
		
		Product product = null; // product of the questionnaire
		List<String> questions = null; 
		Questionnaire questionnaire = null;
		
		
		try {
			System.out.println(productName);
			System.out.println(inputQuestions);
			
			// retrieve the product from db
			try {
				List<Product> products = null;
				products = em.createNamedQuery("Product.searchProduct", Product.class)
						.setParameter(1, productName)
						.getResultList();
					if (products == null || products.isEmpty()) {
						throw new Exception("The product insert doens't exist");
					}
				product = products.get(0);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("Error in retrieving the product");
			}
			
			// store questionnaire in db
			try {
				questionnaire = new Questionnaire();
				questionnaire.setIdProduct(product.getId());		
				em.persist(questionnaire);
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("Failed creating new questionnaire");
			}
			
			// questions creation
			try {
				// TODO: problem, how to connect question to questionnaire without idQuestionnare in question table?
				// TODO: retrieve the questionnaire ID
				// TODO: create a foreach cycle to add all the question in question list
				Question question = new Question();
				question.setIdProduct(product.getId());
				question.setText(inputQuestions);
				em.persist(question);
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("Error on insert questions");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error the questionnaire");
		}
		return false;
	}
}