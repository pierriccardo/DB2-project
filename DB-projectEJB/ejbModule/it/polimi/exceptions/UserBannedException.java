package it.polimi.exceptions;

public class UserBannedException extends Exception {
	private static final long serialVersionUID = 1L;

	public UserBannedException(String message) {
		super(message);
	}
}
