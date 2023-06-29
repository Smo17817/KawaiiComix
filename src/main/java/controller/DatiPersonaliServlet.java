package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

@WebServlet("/DatiPersonaliServlet")
public class DatiPersonaliServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection connection = null;
		RequestDispatcher dispatcher = null;
		User user = (User) session.getAttribute("user");
		String email = request.getParameter("email");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		int rowCount = 0;

		try {
			if (nome.equals(null) || nome.equals("")) {
				request.setAttribute("status", "Invalid_nome");
				dispatcher = request.getRequestDispatcher("datipersonali.jsp");
				dispatcher.forward(request, response);
				return;
			}
			if (cognome.equals(null) || cognome.equals("")) {
				request.setAttribute("status", "Invalid_cognome");
				dispatcher = request.getRequestDispatcher("datipersonali.jsp");
				dispatcher.forward(request, response);
				return;
			}
			if (email.equals(null) || email.equals("")) {
				request.setAttribute("status", "Invalid_email");
				dispatcher = request.getRequestDispatcher("datipersonali.jsp");
				dispatcher.forward(request, response);
				return;
			}
			if (password1.equals(null) || password1.equals("")) {
				request.setAttribute("status", "Invalid_password");
				dispatcher = request.getRequestDispatcher("datipersonali.jsp");
				dispatcher.forward(request, response);
				return;
			}
			if (!(password1.equals(password2))) {
				request.setAttribute("status", "Invalid_password2");
				dispatcher = request.getRequestDispatcher("datipersonali.jsp");
				dispatcher.forward(request, response);
				return;
			}

			connection = DbManager.getConnection();
			String query = "UPDATE site_user SET email_address = ?, password = ?, nome = ?, cognome = ? WHERE id = ?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password1);
			ps.setString(3, nome);
			ps.setString(4, cognome);
			ps.setInt(5, user.getId());
			rowCount = ps.executeUpdate();
			ps.close();

			user.setEmail(email);
			user.setNome(nome);
			user.setCognome(cognome);

			session.setAttribute("user", user);

			if (rowCount > 0)
				request.setAttribute("status", "success");
			else
				request.setAttribute("status", "failed");

			dispatcher = request.getRequestDispatcher("datipersonali.jsp");
			dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (!connection.equals(null))
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
