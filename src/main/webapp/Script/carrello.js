function totaleParziale(){
	let product, elem1, elem2, costo, quantita, totParz, tot = 0;
		
	product = document.getElementById("dinamico");
	elem1 = product.getElementsByClassName("costo");
	elem2 = document.querySelectorAll('.quantita');
	
	for(let i = 0; i < elem1.length; i++){
		totParz = 0;
		costo = parseFloat(elem1[i].textContent.split(' ')[1]);
		quantita = parseInt(elem2[i].value)
		totParz += costo * quantita;
		tot += totParz;
		
		product.getElementsByClassName("totProd")[i].innerHTML = "&#8364 " + totParz;
	}
	
	let cassa, spedizione = 10;
	
	cassa = document.getElementById("cassa");
	cassa.getElementsByClassName("tot")[0].innerHTML = "&#8364 " + tot;
	if(tot == 0) // se non ci sono elementi nel carrello il totale è 0
		spedizione = 0;	
	cassa.getElementsByClassName("totCumul")[0].innerHTML = "&#8364 " + (tot + spedizione);
}

function eliminaRiga(button) {
	let row = button.parentNode.parentNode;
	row.parentNode.removeChild(row);
	totaleParziale();
}

function checkout(url) {
	let element = document.getElementsByClassName("totCumul")[0];
	let text = element.textContent;
	let numericValue = parseFloat(text.split(' ')[1]);
	
	let query = document.querySelectorAll('.quantita');
	let quantita = "";
	for(let i = 0; i < query.length; i++){
		quantita += query[i].value;
		if(query[i+1]!=null)
			quantita+=",";
	}
		
	if(numericValue > 0)
		window.location.href = "AddOrdineServlet?totale=" + numericValue + "&quantita=" + quantita;
}