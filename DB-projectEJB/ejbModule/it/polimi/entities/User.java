package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;

import java.util.List;



@Entity
@Table(name = "user", schema = "DB_project")
@NamedQuery(name = "User.checkId", query = "SELECT r FROM User r  WHERE r.id = ?1")
@NamedQuery(name = "User.checkCredentials", query = "SELECT r FROM User r  WHERE r.username = ?1 and r.password = ?2")
@NamedQuery(name = "User.checkUsernames", query = "SELECT r FROM User r  WHERE r.username = ?1")
@NamedQuery(name = "User.checkEmails", query = "SELECT r FROM User r  WHERE r.email = ?1")
@NamedQuery(name = "User.findScore", query = "SELECT r FROM User r ORDER BY r.score DESC")
public class User implements Serializable {


	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	private String password;
	private String email;
	private Boolean isBanned;
	private Boolean isAdmin;
	private int score;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Log> logs;
	
	@OneToMany(mappedBy = "user")
	private List<Review> reviews;
	

	@OneToMany(mappedBy="user", fetch = FetchType.EAGER)
	private List<Questionnaire> Questionnaires;
	
	

	public List<Log> getLogs() {
		return logs;
	}

	public void setLogs(List<Log> logs) {
		this.logs = logs;
	}




	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public List<Questionnaire> getQuestionnaires() {
		return Questionnaires;
	}

	public void setQuestionnaires(List<Questionnaire> questionnaires) {
		Questionnaires = questionnaires;
	}

	public User() {
	
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}


	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public Boolean isAdmin() {
		return this.isAdmin;
	}

	public Boolean isBanned() {
		return this.isBanned;
	}

	public void setIsBanned(Boolean isBanned) {
		this.isBanned = isBanned;
	}
	
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}


}