package it.polimi.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "review", schema = "DB_project")
//@NamedQuery(name = "Questionnaire.check", query = "SELECT * FROM Questionnaire")
public class Review implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String text;	
	
	
	@OneToMany(mappedBy = "review")
	private List<User> users;
	
	@OneToMany(mappedBy = "review")
	private List<Product> products;

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

}