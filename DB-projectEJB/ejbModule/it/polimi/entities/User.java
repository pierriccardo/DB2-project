package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;

import java.util.List;



@Entity
@Table(name = "user", schema = "DB_project")
@NamedQuery(name = "User.checkCredentials", query = "SELECT r FROM User r  WHERE r.username = ?1 and r.password = ?2")
@NamedQuery(name = "User.checkUsernames", query = "SELECT r FROM User r  WHERE r.username = ?1")
@NamedQuery(name = "User.checkEmails", query = "SELECT r FROM User r  WHERE r.email = ?1")
//@NamedQuery(name = "User.RegisterUser", query = "INSERT INTO User (username, password, email) VALUES (?1, ?2, ?3)")
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
	
	/*
	@OneToMany(mappedBy="idUser", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE, orphanRemoval = true )
	private List<Log> Logs;
	*/
	
	/*
	@ManyToOne(mappedBy="user", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE, orphanRemoval = true )
	private List<Questionnaire> Questionnaires;
	
	@ManyToOne(mappedBy="user", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE, orphanRemoval = true )
	private List<Review> Reviews;
	
	
	@ManyToOne(mappedBy="user", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE, orphanRemoval = true )
	private List<Leaderboard> Leaderboards;
	*/
	
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