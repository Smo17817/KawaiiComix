<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="ISO-8859-1">
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name=" description" content="Vendita Manga al Dettaglio" />
<meta name="robots" content="index,follow" />
<title>Kawaii Comix</title>
</head>
<body>
	<jsp:include page="./Nav.jsp" flush="true"/>
	<main>
		<section class=""></section>
	</main>
	<div>
		<h2>I tuoi dati</h2>
		<form action="" name="login" method="get">
			<fieldset>					
				<p>Nome <input type="text" placeholder="ex"> </p>
				<p>Cognome <input type="text" placeholder="ex"> </p>
				<p>Indirizzo <input type="text" placeholder="ex"> </p>
				<p>Citt� <input type="text" placeholder="ex"> </p>
				<p>Provincia <input type="text" placeholder="ex"> </p>
				<p>CAP <input type="text"> </p>
				<p>Nazione 
					<select>
						<option>-effettua una scelta-</option>
						<option>Italia<option>
					</select>	
				<input type="button" value="Salva"> 
			</fieldset>
		</form>
	</div>
</body>
</html>