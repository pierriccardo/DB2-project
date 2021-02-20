package it.polimi.entities;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.persistence.*;


@Entity
@Table(name = "product", schema = "DB_project")
@NamedQuery(name = "Product.searchProduct", query = "SELECT p FROM Product p WHERE p.name = ?1")
@NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p")
public class Product implements Serializable {
	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String imageFileName;
	private Date date;
	
	@OneToOne(mappedBy="product")
	private Questionnaire questionnaire;
	
	@OneToMany(mappedBy="product")
	private List<Question> questions;
	
	@OneToMany(mappedBy = "product")
	private List<Review> reviews;

	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	
	public List<Review> getReviews() {
		return reviews;
	}
	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}
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