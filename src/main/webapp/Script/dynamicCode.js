function dynamicIndex(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHtml = "";

		for (const prodotto of response) {
			contenutoHtml += "<div class=\"scheda\">";
			contenutoHtml += "<a href=\"ProductServlet?isbn=" + prodotto.isbn + "\"><img src=\"" + prodotto.img + "\"> </a>";
			contenutoHtml += "<div class=\"info\">";
			contenutoHtml += "<h4>" + prodotto.nome + "</h4>";
			contenutoHtml += "<p>&#8364 " + prodotto.prezzo + "</p>";
			contenutoHtml += "<a href=\"CartServlet?isbn=" + prodotto.isbn + "\"> Carrello</a>";
			contenutoHtml += "</div> </div>";
		}

		$("#schedeProdotto").append(contenutoHtml);
	});
}

function dynamicNews(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHtml = "";

		for (const articolo of response) {
			contenutoHtml += "<div class=\"scheda\"> <article>";
			contenutoHtml += "<h2>" + articolo.titolo + "</h2>";
			contenutoHtml += "<h1>" + articolo.sottotitolo + "</h1>";
			contenutoHtml += "<p> Data Pubblicazione: " + articolo.data + "</p>";
			if (articolo.immagine != null) {
				contenutoHtml += "<img src=\"" + articolo.immagine + "\">";
			}
			if (articolo.video != null) {
				contenutoHtml += "<div class=\"video-container\">";
				contenutoHtml += "<iframe width=560 height=315 src = \"" + articolo.video + "\" frameborder=0 allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen> </iframe>";
				contenutoHtml += "</div>";
			}

			contenutoHtml += "<p>" + articolo.corpo + "</p>";
			contenutoHtml += "</article> </div>";
		}

		$("#scheda-news").append(contenutoHtml);
	});
}

function dynamicCatalog(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHtml = "";

		for (const p of response) {
			contenutoHtml += "<div class=\"scheda\" data-categoria=\"" + p.categoria + "\" data-genere=\"" + p.genere + "\">";
			contenutoHtml += "<a href=\"ProductServlet?isbn=" + p.isbn + "\"><img src=\"" + p.img + "\" class=\"trash\"></a>" + "\n";
			contenutoHtml += "<div class=\"info\">" + "\n";
			contenutoHtml += "<h4 class=\"pname\">" + p.nome + "</h4>" + "\n";
			contenutoHtml += "<p> &#8364 " + p.prezzo + "</p>" + "\n";
			contenutoHtml += "<a href=\"CartServlet?isbn=" + p.isbn + "\">Carrello</a>" + "\n";
			contenutoHtml += "</div>" + "\n";
			contenutoHtml += "</div>" + "\n";
		}
		$("#schedeProdotto").append(contenutoHtml);
	});
}

function dynamicCategorie(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);

		let filtriCategoria = "<tr> <td> <h4> Categoria </h4> </td> </tr>";
		for (const categoria of response) {
			filtriCategoria += "<tr> <td>";
			filtriCategoria += "<input type=\"checkbox\" class=\"cat\"  value=\"" + categoria + "\"name=\"categoria\" onchange=\"searchAndFilter()\">";
			filtriCategoria += "<label class=\"secondset\">" + categoria + "</label>";
			filtriCategoria += "</td> </tr>";
		}
		$("#categorie").append(filtriCategoria);
	});
}

function dynamicGeneri(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);

		let filtriGenere = "<tr> <td> <h4> Genere </h4> </td> </tr>";
		for (const genere of response) {
			filtriGenere += "<tr> <td>";
			filtriGenere += "<input type=\"checkbox\" class=\"gen\" name=\"genere\" value=\"" + genere + "\" onchange=\"searchAndFilter()\">";
			filtriGenere += "<label class=\"firstset\">" + genere + "</label>";
			filtriGenere += "</td> </tr>";
		}
		$("#generi").append(filtriGenere);
	});
}

function dynamicConsigliati(url) {
	$.ajax({
		url: url,
		type: 'GET',
		contentType: 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHtml = "";

		for (const prodotto of response) {
			contenutoHtml += "<div class=\"scheda\">";
			contenutoHtml += "<a href=\"ProductServlet?isbn=" + prodotto.isbn + "\"><img src=\"" + prodotto.img + "\"> </a>";
			contenutoHtml += "<div class=\"info\">";
			contenutoHtml += "<h4>" + prodotto.nome + "</h4>";
			contenutoHtml += "<p>&#8364 " + prodotto.prezzo + "</p>";
			contenutoHtml += "<a href=\"CartServlet?isbn=" + prodotto.isbn + "\"> Carrello</a>";
			contenutoHtml += "</div> </div>";
		}

		$("#consigliati").append(contenutoHtml);
	});
}