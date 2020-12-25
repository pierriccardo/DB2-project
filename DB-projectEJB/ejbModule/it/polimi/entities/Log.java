package it.polimi.entities;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@Table(name = "log", schema = "DB_project")
@NamedQuery(name = "Log.list", query = "SELECT l FROM Log l  WHERE l.idUser = ?1")
@NamedQuery(name="Log.insert", query="INSERT INTO Log (idUser, timestamp_login) VALUES (?1, ?2)")
public class Log implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/*
	@ManyToOne
	@JoinColumn(name = "idUser")
	*/
	private int idUser;
	private Timestamp timestamp_login;
	
	public Log() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public Timestamp getTimestamp_login() {
		return timestamp_login;
	}

	public void setTimestamp_login(Timestamp timestamp_login) {
		this.timestamp_login = timestamp_login;
	}

}
