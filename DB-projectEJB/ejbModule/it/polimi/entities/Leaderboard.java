package it.polimi.entities;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name = "leaderboard", schema = "DB_project")
@NamedQuery(name = "Leaderboard.findAll", query = "SELECT r FROM Leaderboard r ORDER BY r.score")
@NamedQuery(name = "Leaderboard.getUserPoints", query = "SELECT r FROM Leaderboard r  WHERE r.user.id = ?1")
public class Leaderboard implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idUser;
	private int score;

	
	@OneToOne(mappedBy="leaderboard")
	private User user;
	
	
	public Leaderboard() {
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int id) {
		this.idUser = id;
	}

	
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}



}
