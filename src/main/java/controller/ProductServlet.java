package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Prodotto;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(ProductServlet.class.getName());
	private static final String error = "Errore";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String isbn = request.getParameter("isbn");
		HttpSession session = request.getSession();

		try (Connection connection = DbManager.getConnection();
			PreparedStatement ps = connection.prepareStatement("SELECT * FROM prodotti WHERE isbn = ?");){	
			ps.setString(1, isbn);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				String nome = rs.getString("nome");
				String descrizione = rs.getString("descrizione");
				String img = rs.getString("immagine_prod");
				String genere = rs.getString("genere_nome");
				String categoria = rs.getString("categoria_nome");
				int quantita = rs.getInt("quantita");
				double prezzo = rs.getDouble("prezzo");
				Prodotto p = new Prodotto(isbn, nome, descrizione, img, genere, categoria, quantita, prezzo);

				request.setAttribute("prodotto", p);
				session.setAttribute("prodotto", p); // velocizza le cose in caso di acquisto
				RequestDispatcher dispatcher = request.getRequestDispatcher("prodotto.jsp");
				dispatcher.forward(request, response);
			}
			rs.close();
		} catch (SQLException e) {
			logger.log(Level.ALL, error, e);
		} catch (ServletException e) {
			logger.log(Level.ALL, error, e);
		} catch (IOException e) {
			logger.log(Level.ALL, error, e);
		}
	}

}
