package model;

import java.util.ArrayList;
import java.util.Date;

public class Ordine {
	private int id;
	private Date data;
	private double totale;
	private int userId;
	private int stato;
	private int spedizione;
	private int idIndirizzo;
	private ArrayList<OrdineSingolo> singoli = new ArrayList<>();
	
	public Ordine(int id, Date data, double totale, int userId, int stato, int spedizione, int idIndirizzo) {
		super();
		this.id = id;
		this.data = data;
		this.totale = totale;
		this.userId = userId;
		this.stato = stato;
		this.spedizione = spedizione;
		this.idIndirizzo = idIndirizzo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public double getTotale() {
		return totale;
	}

	public void setTotale(double totale) {
		this.totale = totale;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getStato() {
		return stato;
	}

	public void setStato(int stato) {
		this.stato = stato;
	}

	public int getSpedizione() {
		return spedizione;
	}

	public void setSpedizione(int spedizione) {
		this.spedizione = spedizione;
	}

	public int getIdIndirizzo() {
		return idIndirizzo;
	}

	public void setIdIndirizzo(int idIndirizzo) {
		this.idIndirizzo = idIndirizzo;
	}

	public ArrayList<OrdineSingolo> getSingoli() {
		return singoli;
	}

	public void setSingoli(ArrayList<OrdineSingolo> singoli) {
		this.singoli = singoli;
	}
	
	public void add(OrdineSingolo o) {
		singoli.add(o);
	}
	
	
	
}
