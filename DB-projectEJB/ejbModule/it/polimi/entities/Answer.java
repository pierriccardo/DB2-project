package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "answer", schema = "DB_project")
//@NamedQuery(name = "Questionnaire.check", query = "SELECT * FROM Questionnaire")

public class Answer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<Questionnaire> getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(List<Questionnaire> questionnaire) {
		this.questionnaire = questionnaire;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	private String text;
	
	@OneToMany(mappedBy = "answer")
	private List<Questionnaire> questionnaire;
	
	@OneToOne
	private Question question;
	

}