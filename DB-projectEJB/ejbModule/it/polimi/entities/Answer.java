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

	private int idQuestion;
	private String text;
	private int idQuestionnaire;

}