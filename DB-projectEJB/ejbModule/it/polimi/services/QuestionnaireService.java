package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import it.polimi.entities.*;

@Stateless
public class QuestionnaireService {
	@PersistenceContext(unitName = "DB-projectEJB")
	private EntityManager em;

	public QuestionnaireService() {
	}

	public Product findProductById(int idProduct) {
		return em.find(Product.class, idProduct);
	}
	
	public Questionnaire findQuestionnaireById(int idQuest) {
		return em.find(Questionnaire.class, idQuest);
	}
	
	public Question findQuestionById(int idQuestion) {
		return em.find(Question.class, idQuestion);
	}
	
	public Questionnaire getOrCreateQuestionnaire(User user, Product product) {
		Questionnaire questionnaire;
		try {
			questionnaire = em.createNamedQuery("Questionnaire.getQuestionnaireByUserAndProduct", Questionnaire.class)
											.setParameter(1, user)
											.setParameter(2, product)
											.getSingleResult();
		} catch (NoResultException e) {
			questionnaire = new Questionnaire();
			questionnaire.setSubmitted(false);
			questionnaire.setUser(user);
			questionnaire.setProduct(product);
			
			em.persist(questionnaire);
			em.flush();
		}
		
		return questionnaire;
	}
	
	public void persistQuestionnaire(Questionnaire questionnaire) {
		em.persist(questionnaire);
		em.flush();
	}
}
