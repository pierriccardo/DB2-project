package it.polimi.entities;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "question", schema = "DB_project")
@NamedQuery(name = "Question.getProductQuestions", query = "SELECT q FROM Question q  WHERE q.product.id = ?1")
public class Question implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinTable(name="product_questions")
	private Product product;
	private String text;
	
	public Question() {
		
	}

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

}
