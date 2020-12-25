package it.polimi.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.NonUniqueResultException;
//import javax.persistence.NonUniqueValueException;
import it.polimi.entities.User;
import it.polimi.exceptions.*;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] encodedhash = digest.digest(
					pwd.getBytes(StandardCharsets.UTF_8));
			
			uList = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, usrn).setParameter(2, bytesToHex(encodedhash))
					.getResultList();
		} catch (NoSuchAlgorithmException | PersistenceException e) {
			throw new CredentialsException("Could not verify credentals");
		}
		if (uList.isEmpty())
			return null;
		else if (uList.size() == 1)
			return uList.get(0);
		throw new NonUniqueResultException("More than one user registered with same credentials");

	}
	
	public User RegisterUser(String usrn, String email, String pwd) throws CredentialsException {
		List<User> usernamesList = null;
		List<User> emailsList = null;
		try {
			usernamesList = em.createNamedQuery("User.checkUsernames", User.class)
					.setParameter(1, usrn)
					.getResultList();
			emailsList = em.createNamedQuery("User.checkEmails", User.class)
					.setParameter(1, email)
					.getResultList();
		} catch (PersistenceException e) {
			throw new CredentialsException("Could not verify credentals");
		}
		if (usernamesList.size() >= 1) {
			throw new CredentialsException("More than one user registered with same credentials");			
		}
		if (usernamesList.size() >= 1) {
			throw new CredentialsException("More than one user registered with same credentials");			
		}
		else if (usernamesList.isEmpty() && emailsList.isEmpty())
			return em.createNamedQuery("User.RegisterUser", User.class)
					.setParameter(1, usrn)
					.setParameter(2, pwd)
					.setParameter(3, email)
					.getResultList()
					.get(0);
		return null;
			
	}
	
	private String bytesToHex(byte[] hash) {
	    StringBuilder hexString = new StringBuilder(2 * hash.length);
	    for (int i = 0; i < hash.length; i++) {
	        String hex = Integer.toHexString(0xff & hash[i]);
	        if(hex.length() == 1) {
	            hexString.append('0');
	        }
	        hexString.append(hex);
	    }
	    return hexString.toString();
	}
}