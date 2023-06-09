<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, model.User"%> 
<%	
	User user = (User) session.getAttribute("user");
  	if(user == null)
		response.sendRedirect("login.jsp");
 %>
<jsp:include page="./header.jsp" flush="true" />
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js
"></script>
<link href="
https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css
" rel="stylesheet">
<script>
function confermaModifica(event) {
    event.preventDefault(); // Impedisce l'invio automatico del modulo

    Swal.fire({
        title: 'Sei sicuro di voler effettuare i cambiamenti?',
        showDenyButton: true,
        confirmButtonText: 'Salva',
        denyButtonText: 'Non Salvare',
    }).then((result) => {
        if (result.isConfirmed) {
            var risposta = result.isConfirmed ? "conferma" : "annulla";
            var prodotto = document.getElementById('chooseProduct').value;
            var nome = document.getElementById('nome').value
            var descrizione = document.getElementById('descrizione').value
            var immagine =  document.getElementById('immagine').value
            var prezzo = document.getElementById('prezzo').value
            var quantita = document.getElementById('quantita').value
            var genere = document.getElementById('genere').value
            var categoria = document.getElementById('categoria').value

            // Esegui la chiamata AJAX per inviare i dati al server
            $.ajax({
                url: '<%=request.getContextPath()%>/EditProductServlet',
                type: 'POST',
                data: {
                    risposta: risposta,
                    scelta: prodotto,
                    nome: nome,
                    descrizione: descrizione ,
                    immagine : immagine,
                    prezzo: prezzo,
                    quantita: quantita,
                    genere : genere,
                    categoria : categoria
                },
                }).done(function (response) {
                    var status = response.status;
                    if (typeof status !== 'undefined') {
                    	  status = status.trim();
                    }
                    else{
                    	Swal.fire('errore falliti del cazzo','','error');
                    }
                    status = status.replace(/[\u0000-\u001F]+/g, '');
                    
                    if(status == 'Invalid_prodotto'){
                    	Swal.fire('Scegliere un prodotto da modificare','','error')
                    }
                    else if(status =='Invalid_nome'){
                    	Swal.fire('Scegliere un nome!','','error')
              		}else if(status =='Invalid_nome_caratteri_speciali'){
                    	Swal.fire('Scegliere un nome senza caratteri speciali!','','error')
              		}else if(status =='Invalid_descrizione'){
                    	Swal.fire('Descrivere il prodotto!','','error')
                    }else if(status =='Invalid_path'){
                    	Swal.fire('Inserire un path valido!','','error')
                    }else if(status =='Invalid_prezzo'){
                    	Swal.fire('Inserire un prezzo!','','error')
                    }else if(status =='Invalid_quantita'){
                    	Swal.fire('Inserire almeno una quantit�!','','error')
                    }else if(status =='Invalid_genere'){
                    	Swal.fire('Scegliere genere prodotto!','','error')
                    }else if(status =='Invalid_categoria'){
                    	Swal.fire('Scegliere categoria!','','error')
                    }else if(status =='success'){
                    	Swal.fire('Prodotto aggiornato correttamente!','','success')
                    	 setTimeout(function() {
							    window.location.assign(response.url);
						}, 2000); // Ritardo di 2 secondi (2000 millisecondi)
                    }
                    else{
                    	Swal.fire('Errore!','Il prodotto potrebbe non essere pi� presente sul sito','error')
                    }
                })
        } else if (result.isDenied) {
            Swal.fire('Modifiche non salvate', '', 'info');
        }
    });
}
</script>
<body>
<jsp:include page="./Nav.jsp" flush="true"/>
<script src="./Script/dynamicCode.js"></script>
<script>

	document.addEventListener("DOMContentLoaded", dynamicModificaProdotto("<%=request.getContextPath()%>/NameServlet")); 	

</script>
	<section id="new_product">
		<div class="form-wrapper">
			<form onsubmit="confermaModifica(event)" method="POST">
				<h2>Modifica un Prodotto</h2>
				<div class="form-row">
					<label for="scelta">Prodotto: </label>
					<select id="chooseProduct" name="scelta">
						
					</select>
				</div>
				<div class="form-row">
					<label for="nome">Nome: </label>
					<input type="text" name="nome" id="nome">
				</div>
				<div class="form-row">
					<label for="descrizione">Descrizione: </label>
					<textarea id ="descrizione" name="descrizione" ></textarea>
				</div>
				<div class="form-row">
					<label for="immagine">Immagine: </label>
					<input type="text" id="immagine" name="immagine" placeholder="./images/nome_img.formato">
				</div>
				<div class="form-row">
					<label for="prezzo">Prezzo: </label>
					<input type="number" step="0.01" min="0"  id="prezzo"name="prezzo">
				</div>
				<div class="form-row">
					<label for="quantita">Quantit�: </label>
					<input type="number" min="0" name="quantita" id ="quantita">
				</div>
				<div class="form-row">
					<label for="genere">Genere: </label>
					<select name="genere" id ="genere">
						<option>-scegliere genere-</option>
						<option>Avventura</option>
						<option>Azione</option>
						<option>Combattimento</option>
						<option>Commedia</option>
						<option>Crimine</option>
						<option>Drammatico</option>
						<option>Fantascienza</option>
						<option>Fantastico</option>
						<option>Fantasy</option>
						<option>Gang Giovanili</option>
						<option>Giallo</option>
						<option>Guerra</option>
						<option>Horror</option>
						<option>Magia</option>
						<option>Mecha</option>
						<option>Mistero</option>
						<option>Musicale</option>
						<option>Poliziesco</option>
						<option>Psicologico</option>
						<option>Scolastico</option>
						<option>Sentimentale</option>
						<option>Sportivo</option>
						<option>Storico</option>
						<option>Supereroi</option>
						<option>Thriller</option>					
					</select>
				</div>
				<div class="form-row">
					<label for="categoria">Categoria: </label>
						<select name="categoria" id ="categoria">
							<option>-scegliere categoria-</option>
							<option>Art Book</option>
							<option>Character Book</option>
							<option>Josei</option>
							<option>Kodomo</option>
							<option>Manga</option>
							<option>Manga Italiani</option>
							<option>Manhwa</option>
							<option>Novel</option>
							<option>Seinen</option>
							<option>Shoujo</option>
							<option>Shoujo-Ai</option>
							<option>Shonen</option>
							<option>Web Comic</option>	
							<option>Manga Magazine</option>			
					</select>
				</div>
				<div class="sub-class"> 
					<button type="submit">Modifica</button>
				</div>
			</form>
		</div>
	</section>
<jsp:include page="./footer.jsp" flush="true" />
</body>
</html>