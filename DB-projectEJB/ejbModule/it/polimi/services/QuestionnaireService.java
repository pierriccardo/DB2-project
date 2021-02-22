package it.polimi.services;

import java.util.Date;
import java.util.List;

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

	public Product findByDate(Date date) {
		return em.createNamedQuery("Product.findByDate", Product.class).setParameter(1, date).getSingleResult();
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
	
	public void fillQuestionnaire(int idQuestionnaire, List<Integer> idQuestions, List<String> answers, Boolean isSubmitted, int age, int sex, int expertise_level) {
		Questionnaire questionnaire = this.findQuestionnaireById(idQuestionnaire);
		
		for (int i=0; i < idQuestions.size(); i++) {
			Question quest = this.findQuestionById(idQuestions.get(i));
			
			Answer answer = new Answer();
			answer.setQuestionnaire(questionnaire);
			answer.setText(answers.get(i));
			answer.setQuestion(quest);
			
			em.persist(answer);
		}
		
		if (age != 0)
			questionnaire.setAge(age);
		
		if (sex != -1)
			questionnaire.setSex(sex);
		
		if (expertise_level != -1)
			questionnaire.setExpertise_level(expertise_level);
		
		questionnaire.setSubmitted(isSubmitted);
		
		em.flush();
	}
}
