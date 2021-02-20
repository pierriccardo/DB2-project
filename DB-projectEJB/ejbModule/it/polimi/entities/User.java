package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;

import java.util.List;



@Entity
@Table(name = "user", schema = "DB_project")
@NamedQuery(name = "User.checkCredentials", query = "SELECT r FROM User r  WHERE r.username = ?1 and r.password = ?2")
@NamedQuery(name = "User.checkUsernames", query = "SELECT r FROM User r  WHERE r.username = ?1")
@NamedQuery(name = "User.checkEmails", query = "SELECT r FROM User r  WHERE r.email = ?1")
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
	
	
	@OneToMany(mappedBy = "user")
	private List<Log> logs;
	
	@ManyToOne
	@JoinColumn(name = "user")
	private Review review;
	
	@OneToMany(mappedBy = "user")
	private List<Leaderboard> leaderboards;
	
	@ManyToMany(mappedBy="users", fetch = FetchType.EAGER)
	private List<Questionnaire> Questionnaires;
	
	

	public List<Log> getLogs() {
		return logs;
	}

	public void setLogs(List<Log> logs) {
		this.logs = logs;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public List<Leaderboard> getLeaderboards() {
		return leaderboards;
	}

	public void setLeaderboards(List<Leaderboard> leaderboards) {
		this.leaderboards = leaderboards;
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
	
	public Boolean getIsAdmin() {
		return this.isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public Boolean getIsBanned() {
		return this.isBanned;
	}

	public void setIsBanned(Boolean isBanned) {
		this.isBanned = isBanned;
	}
	/*
	public List<Quesitonnaire> getQuestionnaires() {
		return Questionnaires;
	}

	public void setQuestionnaires(List<Quesitonnaire> questionnaires) {
		Questionnaires = questionnaires;
	}

	public List<Review> getReviews() {
		return Reviews;
	}

	public void setReviews(List<Review> reviews) {
		Reviews = reviews;
	}

	public List<Log> getLogs() {
		return Logs;
	}

	public void setLogs(List<Log> logs) {
		Logs = logs;
	}

	public List<Leaderboard> getLeaderboards() {
		return Leaderboards;
	}

	public void setLeaderboards(List<Leaderboard> leaderboards) {
		Leaderboards = leaderboards;
	}
	*/

}