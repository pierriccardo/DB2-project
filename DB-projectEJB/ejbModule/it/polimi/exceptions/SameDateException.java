package it.polimi.exceptions;

public class SameDateException extends Exception {
	private static final long serialVersionUID = 1L;

	public SameDateException(String message) {
		super(message);
	}
}
