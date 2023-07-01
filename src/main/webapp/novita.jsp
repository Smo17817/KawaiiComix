<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,model.Articolo,model.Novita"%>
<jsp:include page="./header.jsp" flush="true"/>
<body>
	<script>
		<% 
			Novita novita = (Novita) session.getAttribute("novita");
			ArrayList<Articolo> list = (ArrayList<Articolo>) novita.getNovita();
			
			String contenutoHtml = "";
			for(Articolo a : list){
				contenutoHtml += "<div class=\"scheda\"> <article>";
				contenutoHtml += "<h1>" + a.getTitolo() + "</h1>";
				if(a.getImmagine() != null){
					contenutoHtml += "<img src=\"" + a.getImmagine() + "\">";	
				}
				if(a.getVideo() != null)
					contenutoHtml += "<video> <source src = \"" + a.getVideo() + "\"> </video>";
				
				contenutoHtml += "<p>" + a.getCorpo() + "</p>";
				contenutoHtml += "</article> </div>";	
			}
		%>
		const content = '<%=contenutoHtml.replace("'", "\\'").replace("\n", "\\n")%>';
		$(document).ready(function(){
			document.getElementById("scheda-news").innerHTML = content;
		});	
	</script>
	<jsp:include page="./Nav.jsp" flush="true"/>
	<section id="articles">
		<h2>Novit�</h2>
		<div id="scheda-news">
		</div>
	</section>
<jsp:include page="./footer.jsp" flush="true"/>	
</body>
</html>