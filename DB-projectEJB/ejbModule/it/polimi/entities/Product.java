package it.polimi.entities;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.*;


@Entity
@Table(name = "product", schema = "DB_project")
@NamedQuery(name = "Product.searchProduct", query = "SELECT p FROM Product p WHERE p.name = ?1")

public class Product implements Serializable {
	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String imageFileName;
	private Date date;
	
	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}
	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
	public Review getReview() {
		return review;
	}
	public void setReview(Review review) {
		this.review = review;
	}
	@OneToOne
	private Questionnaire questionnaire;
	
	@ManyToOne
	@JoinColumn(name = "id")
	private Question question;
	
	@ManyToOne
	@JoinColumn(name = "product")
	private Review review;
	

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	private static final long serialVersionUID = 1L;

	

}