package it.polimi.entities;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "product", schema = "DB_project")
@NamedQuery(name = "Product.searchProduct", query = "SELECT p FROM Product p WHERE p.name = ?1")

public class Product implements Serializable {
	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String imageFileName;
	private Date date;
	
	@OneToMany(mappedBy="product", fetch = FetchType.EAGER)
	private List<Review> Reviews;
	
	@OneToMany(mappedBy="product", fetch = FetchType.EAGER)
	private List<Question> Questions;
	
	@OneToOne(mappedBy="product", fetch = FetchType.EAGER)
	private Questionnaire QuestionnaireProd;
	
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
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	private static final long serialVersionUID = 1L;

	

}