package it.polimi.entities;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "product", schema = "DB_project")
//@NamedQuery(name = "Product.check", query = "SELECT * FROM Product")

public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id 	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String imageFileName;
	private Date date;

}