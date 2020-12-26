package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.NonUniqueResultException;
//import javax.persistence.NonUniqueValueException;
import it.polimi.entities.User;
import it.polimi.exceptions.*;
import java.util.List;

@Stateless
public class UserService {
	@PersistenceContext(unitName = "DB-projectEJB")
	private EntityManager em;

	public UserService() {
	}

	public User checkCredentials(String usrn, String pwd) throws CredentialsException, NonUniqueResultException {
		List<User> uList = null;
		try {
			uList = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, usrn).setParameter(2, pwd)
					.getResultList();
		} catch (PersistenceException e) {
			throw new CredentialsException("Could not verify credentals");
		}
		if (uList.isEmpty())
			return null;
		else if (uList.size() == 1)
			return uList.get(0);
		throw new NonUniqueResultException("More than one user registered with same credentials");

	}
	
	public Boolean Register(String usrn, String email, String pwd) throws CredentialsException {
		List<User> usernamesList = null;
		List<User> emailsList = null;
		User newUser = null;
		Boolean success = false;
		
		try {
			usernamesList = em.createNamedQuery("User.checkUsernames", User.class)
					.setParameter(1, usrn)
					.getResultList();
			emailsList = em.createNamedQuery("User.checkEmails", User.class)
					.setParameter(1, email)
					.getResultList();
			if (usernamesList.size() >= 1) {
				throw new CredentialsException("Username already in use!");			
			}
			if (emailsList.size() >= 1) {
				throw new CredentialsException("Email already in use!");			
			}
			else if (usernamesList.isEmpty() && emailsList.isEmpty())
				newUser = new User();
				newUser.setUsername(usrn);
				newUser.setPassword(pwd);
				newUser.setEmail(email);
				em.persist(newUser);
				
				success = true;
				
		} catch (PersistenceException e) {
			e.printStackTrace();
			throw new CredentialsException("Could not verify credentals");
		}
		
		return success;
	}
}