package it.polimi.base;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Index() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final String DB_URL = "jdbc:mysql://localhost:3306/DB_project";
		final String USER = "root";
		final String PASS = "ian";
		String result = "Connection worked";
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(DB_URL, USER, PASS);
		} catch (Exception e) {
			result = "Connection failed";
			e.printStackTrace();
		}
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM user";
 
			ResultSet rs = stmt.executeQuery(query);
			System.out.println("Received results:");
			// mostra i risultati
			// rs.next() = "false" se non ci sono più righe risultato
			while (rs.next()) {
				 String id = rs.getString(1);
				 System.out.print("id= " + id);
				 System.out.print("\n");
			 }
			 // chiude ResultSet e Statement
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println("Error");
		}
 
 
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
