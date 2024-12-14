function gestoreLoad(){

   try{

    /* associare al menù scorrevole la visualizzazione del menù completo deli eventi da evidenziare */
    var menu=document.getElementById("menu_scorr");

    menu.addEventListener("mouseover", function() {
       var menu_nascosto=document.getElementById("menu_nascosto");
       menu_nascosto.style.display="initial";
    }, false);

    menu.addEventListener("mouseout", function() {
        var menu_nascosto=document.getElementById("menu_nascosto");
        menu_nascosto.style.display="none";
     }, false);



    /* associare ai pulsanti del menu per evidenziare i relativi eventi da evidenziare */
    var nodopulsante_evi= document.querySelectorAll('.bottoni_evi');

    for (var i = 0; i < nodopulsante_evi.length; i++) {
        nodopulsante_evi[i].addEventListener("click", function() {
            evidenziare(this);
     }, false);
    }

    

    /* visualizzare le informazioni relative all'elemento selezionato  */
    var nodoelemento= document.querySelectorAll('.elemento');

    for (var i = 0; i < nodoelemento.length; i++) {
        nodoelemento[i].addEventListener("mouseover", function() {
            informazioni_elementi(this);
     }, false);

     nodoelemento[i].addEventListener("mouseout", function() {
        no_informazioni_elementi(this);
    }, false);
    }


    /* associare ai pulsanti per la visualizzazione degli eventi per articoli la funzione per visualizzare l'evento */
	 var nodopulsante_eventi_articoli= document.querySelectorAll('.bottoni_eventi_articoli');

     for (var i = 0; i < nodopulsante_eventi_articoli.length; i++) {
         nodopulsante_eventi_articoli[i].addEventListener("click", function() {
             eventi_articoli(this);
      }, false);
     }


    /* associare ai pulsanti per la visualizzazione degli eventi per articoli la funzione per visualizzare l'evento */
    var nodopulsante_glossario_articolo= document.querySelectorAll('.bottoni_glossario_art');

     for (var i = 0; i < nodopulsante_glossario_articolo.length; i++) {
        nodopulsante_glossario_articolo[i].addEventListener("click", function() {
             eventi_tipo_glossario(this);
      }, false);
     }
  


	
	} catch (e) {
	
	alert ("gestoreLoad" + e);

	}

}


window.onload = gestoreLoad;





/* funzione per evidenziare le parti di testo realitive al bottone cliccato dal menu per evidenziare */
function evidenziare(element){

    try {
 
     //alert("bottone");

     switch(element.id) {

        case "bottone_persone_reali":

            var evidenziare = document.getElementsByClassName("persona");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(161, 200, 234)";
            }
            break;


            case "bottone_personaggi":

            var evidenziare = document.getElementsByClassName("personaggio");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(109, 223, 255)";
            }
            break;


            case "bottone_bibl":

            var evidenziare = document.getElementsByClassName("bibliografia");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(223, 132, 132)";
            }
            break;

            case "bottone_luoghi":

            var evidenziare = document.getElementsByClassName("luogo");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(144, 236, 111)";
            }
            break;


            case "bottone_gloss":

            var evidenziare = document.getElementsByClassName("termine");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(146, 88, 255)";
            }
            break;

            
            case "bottone_org":

            var evidenziare = document.getElementsByClassName("organizzazione");
        
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(254, 171, 82)";
            }
            break;


            case "bottone_citazioni":

            var evidenziare = document.getElementsByClassName("quote");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(255, 152, 152)";
            }
            break;



            case "bottone_lessico":

            var evidenziare = document.getElementsByClassName("lessico");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(255, 245, 64)";
            }
            break;

            
            case "bottone_discorso":

            var evidenziare = document.getElementsByClassName("discorso");
            
            for (var i = 0; i < evidenziare.length; i++) {
                evidenziare[i].style.background="rgb(239, 222, 222)";
            }
            break;


        default:
        alert("nessun evento selezionato");
      }

   
    } catch (e) {
 
     alert ("evidenziare" + e );
 
    }
 
 }





/* funzione per visualizzare le informazioni realitive a un elemento quando si passa con il mouse su esso */
function informazioni_elementi(element){

    try {
 
     //alert("bottone");

     var informazioni = element.querySelector('span.informazioni');
     
     informazioni.style.display="block";

    
    var elemento = element.firstChild;

    stile = window.getComputedStyle(elemento);
    
    // alert(stile.getPropertyValue('background-color'));

    informazioni.style.background=stile.getPropertyValue('background-color');

    informazioni.style.border="2px solid black";
    

   
    } catch (e) {
 
     alert ("eventi_articoli" + e );
 
    }
 
 }


 function no_informazioni_elementi(element){

    try {
 
     //alert("bottone");

    var element = element.querySelector('span.informazioni')
     
    element.style.display="none";


   
    } catch (e) {
 
     alert ("eventi_articoli" + e );
 
    }
 
 }



/* funzione visualizazzione eventi per articoli*/

function eventi_articoli(element){

   try {

	//alert("bottone");

    //alert("id bottone "+element.id);

    var element=element.id;

    var pre='bottone_';

    var sezione = element.substring(pre.length);

    
    //alert("sezione", sezione);

    var div=document.querySelectorAll("#info_articoli>div");
    
    for (var i = 0; i < div.length; i++) {
        div[i].style.display = "none";
    }
    

    document.getElementById(sezione).style.display = "inline";
    
  
   } catch (e) {

	alert ("eventi_articoli" + e );

   }

}


/* funzione per visulizzare gli elementi relativi al tipo di glossario selezionato per articoli */
function eventi_tipo_glossario(element){

    try {
 
     //alert("bottone");
 
     alert("id bottone "+element.id);
 

     var elemento=element.id;
 
     var pre='bottone_glossario_art_';
 
     var tipo_glossario = elemento.substring(pre.length);
 
     
     //alert(tipo_glossario);
 
     
     var padre=element.parentNode;

     //alert(element.parentNode.getElementsByClassName(".lista_info"));
     var lista_completa=padre.querySelectorAll('.lista_info');
    
     //alert(div.length);
    
     if (tipo_glossario=="tutto"){
        for (var i = 0; i < lista_completa.length; i++) {
            lista_completa[i].style.display = "block";}
     }

     else{
        var lista_tipo=padre.querySelectorAll('.'+tipo_glossario);

        for (var i = 0; i < lista_completa.length; i++) {
            lista_completa[i].style.display = "none";}

        //alert(lista_tipo.length);

        for (var i = 0; i < lista_tipo.length; i++) {
            lista_tipo[i].style.display = "block";}
     }
    
    
    
    } catch (e) {
 
     alert ("eventi_tipo_glossario" + e );
 
    }
 
 }




 


























