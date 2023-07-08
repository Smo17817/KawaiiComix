package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.Carrello;
import model.Prodotto;
import model.User;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		String isbn = request.getParameter("isbn");
		User user = (User) session.getAttribute("user");
		Connection connection = null;
		Gson json = new Gson();
		PrintWriter out = response.getWriter();

		if(isbn == null) {
			HashMap<String , String> hashMap = new HashMap<>();
			hashMap.put("url", "carrello.jsp");
			out.write(json.toJson(hashMap));
			return;
		}
		try {
			connection = DbManager.getConnection();
			if (user == null) 
				response.sendRedirect("login.jsp");
			else {
				String query = "SELECT * FROM prodotti WHERE isbn = ?";
				PreparedStatement ps = connection.prepareStatement(query);
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
					Prodotto prodotto = new Prodotto(isbn, nome, descrizione, img, genere, categoria, quantita, prezzo);

					/* controlla che ci sia solo una ripetizione per ogni prodotto */
					int flag = 0;
					for (Prodotto p : carrello.getCarrello()) {
						if (prodotto.getIsbn().equals(p.getIsbn()))
							flag = 1;
					}

					if (flag == 0) {
						carrello.add(prodotto);
						session.setAttribute("carrello", carrello);
					}
				}

				rs.close();
				out.write(json.toJson(carrello.getCarrello()));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}