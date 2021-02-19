package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;	


@Entity
@Table(name = "questionnaire", schema = "DB_project")
@NamedQuery(name = "Questionnaire.getUserQuestionnaires", query = "SELECT q FROM Questionnaire q  WHERE q.id = ?1")
public class Questionnaire implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int sex;
	private int age;
	private int expertise_level;
	private boolean isSubmitted;
	
	public boolean isSubmitted() {
		return isSubmitted;
	}

	public void setSubmitted(boolean isSubmitted) {
		this.isSubmitted = isSubmitted;
	}

	@OneToOne(mappedBy = "questionnaire")
	private Product product;
	
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(
		name="fill",
		joinColumns={@JoinColumn(name="userid")},
		inverseJoinColumns={@JoinColumn(name="questionnaireid")}
	)
	private List<User> users;

	
	@ManyToOne
	@JoinColumn(name="questionnaire")
	private Answer answer;
	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
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

}