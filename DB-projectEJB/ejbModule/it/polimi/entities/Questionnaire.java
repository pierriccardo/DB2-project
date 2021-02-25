package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;	

@Entity
@Table(name = "questionnaire", schema = "DB_project")
@NamedQuery(name = "Questionnaire.getUserQuestionnaires", query = "SELECT q FROM Questionnaire q  WHERE q.id = ?1")
@NamedQuery(name = "Questionnaire.getQuestionnaireByUserAndProduct", query = "SELECT q FROM Questionnaire q  WHERE q.user = ?1 AND q.product = ?2")
public class Questionnaire implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private int sex;
	private int age;
	private int expertise_level;
	private boolean isSubmitted;

	@OneToMany(mappedBy = "questionnaire")
	private List<Answer> answers;
	

	@ManyToOne
	@JoinColumn(name="idProduct")
	private Product product;
	
	@ManyToOne
	@JoinColumn(name = "idUser")
	private User user;
	
	
	public boolean isSubmitted() {
		return isSubmitted;
	}

	public void setSubmitted(boolean isSubmitted) {
		this.isSubmitted = isSubmitted;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public List<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}

	public Questionnaire() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getExpertise_level() {
		return expertise_level;
	}

	public void setExpertise_level(int expertise_level) {
		this.expertise_level = expertise_level;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}