package it.polimi.entities;

import java.io.Serializable;
<<<<<<< HEAD
import javax.persistence.*;
import java.util.List;
=======

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
>>>>>>> 6fadb62987b19f619b02d181c2444cda0eda7dc0


@Entity
@Table(name = "questionnaire", schema = "DB_project")
<<<<<<< HEAD
//@NamedQuery(name = "Questionnaire.check", query = "SELECT * FROM Questionnaire")

=======
@NamedQuery(name = "Questionnaire.getUserQuestionnaires", query = "SELECT q FROM Questionnaire q  WHERE q.id = ?1")
@NamedQuery(name="Questionnaire.insertUserQuestionnaire", query="INSERT INTO Questionnaire (idProduct, idUser, sex, age, expertise_level) VALUES (?1, ?2, ?3, ?4, ?5)")
>>>>>>> 6fadb62987b19f619b02d181c2444cda0eda7dc0
public class Questionnaire implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
<<<<<<< HEAD

=======
	
>>>>>>> 6fadb62987b19f619b02d181c2444cda0eda7dc0
	private int idProduct;
	private int idUser;
	private int sex;
	private int age;
	private int expertise_level;
<<<<<<< HEAD

}
=======
	
	public Questionnaire() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
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
>>>>>>> 6fadb62987b19f619b02d181c2444cda0eda7dc0