<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,model.Prodotto,model.Carrello"%>
 <% if(session.getAttribute("user")==null)
		response.sendRedirect("login.jsp");
 %>
 
<jsp:include page="./header.jsp" flush="true"/>
<body>
	<jsp:include page="./Nav.jsp" flush="true"/>
	<script src="./Script/carrello.js"></script>
	<script>
		<% 
			Carrello carrello = (Carrello) session.getAttribute("carrello");
			ArrayList<Prodotto> list = (ArrayList<Prodotto>) carrello.getCarrello();
			
			String contenutoHtml = "";
			for(Prodotto p : list){
				contenutoHtml += "<tr>";
				contenutoHtml += "<td> <button onclick=eliminaRiga(this)><img src=\"./icons/trash.ico\" class=trash></button>";
				contenutoHtml += "<td> <img class=thumbnail src=\"" + p.getImg() + "\"></td>";
				contenutoHtml += "<td>" + p.getNome() + "</td>";
				contenutoHtml += "<td> <p class=costo>&#8364 " + p.getPrezzo() + "</p> </td>";
				contenutoHtml += "<td> <h5> <input type=number min=1 class=quantita onchange=totaleParziale() value=\"1\"> </h5> </td>";
				contenutoHtml += "<td> <h5 class=totProd> totale </h5> </td>";
				contenutoHtml += "</tr>";
			}			
		%>
		
		const content = '<%=contenutoHtml.replace("'", "\\'").replace("\n", "\\n")%>';
		
		$(document).ready(function(){
			document.getElementById("dinamico").innerHTML = content;
		});
		document.addEventListener("DOMContentLoaded", function() {
		    totaleParziale();
		});
	</script>
	
	<main>
		<section id="container">
			<h2>Carrello</h2>
			<table id="table">
				<thead>
					<tr>
					<td>Elimina</td>
					<td>Immagine</td>
					<td>Prodotto</td>
					<td>Prezzo</td>
					<td>Quantità</td>
					<td>Totale</td>
					</tr>
				</thead>
				<tbody id="dinamico">
					
					
				</tbody>
			</table>
		</section>
		
		<section id="bottom">
				<div id="cassa">
					<h5>TOTALE</h5>
					<div class="totale">
						<h6>Prodotti: </h6>
						<p class="tot">&#8364 totale</p>
					</div>
					<div class="totale">
						<h6>Spedizione: </h6>
						<p>&#8364 10</p>
					</div>
					<hr>
					<div class="totale">
					<h6>Totale: </h6>
					
						<p class="totCumul">&#8364 totale</p>
					</div>
					<button onclick="checkout()"> Procedi al Pagamento</button>
				</div>
		
		</section>
	</main>
<jsp:include page="./footer.jsp" flush="true"/>	
</body>
</html>