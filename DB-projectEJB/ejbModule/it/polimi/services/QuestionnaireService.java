package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import it.polimi.entities.*;

@Stateless
public class QuestionnaireService {
	@PersistenceContext(unitName = "DB-projectEJB")
	private EntityManager em;

	public QuestionnaireService() {
		// TODO Auto-generated constructor stub
	}

	public Questionnaire findById(int idQ) {
		return em.find(Questionnaire.class, idQ);
	}


	public int createQuestionnaire() {
		return 0;
	}

}
