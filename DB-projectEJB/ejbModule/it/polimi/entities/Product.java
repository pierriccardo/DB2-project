package it.polimi.entities;

import java.io.Serializable;
import java.sql.Date;
import java.util.Base64;
import java.util.List;

import javax.persistence.*;


@Entity
@Table(name = "product", schema = "DB_project")
@NamedQuery(name = "Product.findProduct", query = "SELECT p FROM Product p WHERE p.name = ?1")
@NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p")
@NamedQuery(name = "Product.findByDate", query = "SELECT p FROM Product p WHERE p.date = ?1")
@NamedQuery(name = "Product.findAllToDelete", query = "SELECT p FROM Product p WHERE p.date < ?1")
public class Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	
	@Basic(fetch = FetchType.LAZY)
	@Lob
	private byte[] imageFile;
	
	private Date date;
	
	@OneToMany(mappedBy="product", fetch = FetchType.LAZY)
	private List<Questionnaire> questionnaires;
	
	@OneToMany(mappedBy="product", fetch = FetchType.EAGER)
	private List<Question> questions;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
	private List<Review> reviews;


	public List<Questionnaire> getQuestionnaires() {
		return questionnaires;
	}
	public void setQuestionnaires(List<Questionnaire> questionnaires) {
		this.questionnaires = questionnaires;
	}
	
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
	
	public byte[] getImageFile() {
		return imageFile;
	}
	public void setImageFile(byte[] imageFile) {
		this.imageFile = imageFile;
	}
	
	public String getImageFileData() {
		return Base64.getMimeEncoder().encodeToString(imageFile);
	}

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
}