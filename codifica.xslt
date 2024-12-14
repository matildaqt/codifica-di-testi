<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" />


	<xsl:template match="/">

	<html>

		<head>
			<title>Codifica di testi anno accademico 2023-2024</title>
			<meta name="author" content="Matilda Cuttitta" />
  			<link rel="stylesheet" href="stile.css" />
            <script type="text/javascript" src="codifica.js"></script>
			

		</head>



		<body>

		
  		<header>
			<h1 id="titolo_pagina"> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/> </h1>
  		</header>


		<!-- spazio informazioni generali -->
		<div id="descirzione_informazioni">


			<!-- informazioni bibliografiche sul testo originale-->
			<div id="desc_originale" class="informazioni_generali">

				<h1> Informazioni bibliografiche sul testo originale </h1>
				
				<xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr"/>
			
			</div>
			


			<!-- informazioni di codifica e circa il testo codificato-->

			<div id="desc_codificato" class="informazioni_generali">
			
				<h1> Informazioni sul testo codificato </h1>

				<xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc"/>

			</div>

		</div>

		
		<!-- menù sezioni di testo codificate -->

  		<nav id="menu">

   			 <ul>
				
				<xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic">
						
					<xsl:variable name="voce">
						<xsl:apply-templates select="tei:title"/>
					</xsl:variable>

								
					<xsl:variable name="voce_id">
						<xsl:apply-templates select="@corresp"/>
					</xsl:variable>


					<li>
					<a class="menu">					
						<xsl:attribute name="href"><xsl:value-of select="$voce_id"/></xsl:attribute>
						<xsl:value-of select="$voce"/>
					</a></li>

				</xsl:for-each>

   			 </ul>
  		</nav>


		<!-- menù evidenziare eventi -->
		
		<div id="menu_scorr">

			<ul>
				<li> &#128396; </li>
			</ul>

			<ul id="menu_nascosto">
				<li> <button class="bottoni_evi" id="bottone_persone_reali"> persone reali </button> </li>
				<li> <button class="bottoni_evi" id="bottone_personaggi"> personaggi </button> </li>
				<li> <button class="bottoni_evi" id="bottone_bibl"> opere </button> </li>
				<li> <button class="bottoni_evi" id="bottone_luoghi"> luoghi </button> </li>
				<li> <button class="bottoni_evi" id="bottone_gloss"> glossario </button> </li>
				<li> <button class="bottoni_evi" id="bottone_org"> organizzazioni </button> </li>
				<li> <button class="bottoni_evi" id="bottone_citazioni"> citazioni </button> </li>
				<li> <button class="bottoni_evi" id="bottone_lessico"> lessico 
				<br/> attualizzato </button> </li>
				<li> <button class="bottoni_evi" id="bottone_discorso"> discorsi diretti </button> </li>
			</ul>

		</div>


		<!-- spazio articoli-->

		<div class="spazio_articoli">

			<xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div1/tei:div2">
   		
  			
			<article class="articoli">


			<xsl:variable name="articolo">
            <xsl:value-of select="@xml:id" />
            </xsl:variable>


			<xsl:attribute name="id"><xsl:value-of select="$articolo" /></xsl:attribute>
			

			<h1 class="titolo_articolo"><xsl:value-of select="tei:head"/></h1>

			
			<xsl:for-each-group select="descendant::node()" group-starting-with="tei:pb">
                <page n="{@n}">
				
                <xsl:variable name="pagina">
                <xsl:value-of select="@xml:id" />
                </xsl:variable>

				
                <xsl:variable name="pagina_facs">
                <xsl:value-of select="substring-after(@facs, '#')" />
                </xsl:variable>


                	<xsl:apply-templates select="//tei:surface[@xml:id=$pagina_facs]" />
					
					<table class="tabella_pagine">

					<tr>
					 
					<th class="colonna_pagine">
					<xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$pagina) and @n=1]"/>
					</th>

					 
					<th class="colonna_pagine">
					<xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$pagina) and @n=2]"/>
					</th>


					</tr>
					
					</table>


				  </page>

            </xsl:for-each-group>


			<!-- serie di if per controllare quali eventi esistono nei rispettivi articoli e creare i rispettivi bottoni e div solo nel caso esistessero -->
			
			<div>
				<xsl:attribute name="id"><xsl:value-of select="concat('sezione_informazioni_', $articolo)" /></xsl:attribute>
				<xsl:attribute name="class">informazioni_articoli</xsl:attribute>

				<h2 id="lista_eventi"> lista eventi presenti nell'articolo</h2>


				<xsl:if test="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[not(@role)]">
			
					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_persone_reali_', $articolo)" /></xsl:attribute>
					persone</button>

				</xsl:if>
				

				<xsl:if test="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[@role='character']">

					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_personaggi_', $articolo)" /></xsl:attribute>
					personaggi immaginari</button>

				</xsl:if>


				<xsl:if test="//tei:listBibl[@xml:id=concat('bibl_', $articolo)]">

					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_bibl_', $articolo)" /></xsl:attribute>
					opere</button>

				</xsl:if>


				<xsl:if test="//tei:listPlace[@xml:id=concat('luoghi_', $articolo)]">

					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_luoghi_', $articolo)" /></xsl:attribute>
					luoghi</button>

				</xsl:if>


				<xsl:if test="//tei:list[@type='gloss' and @xml:id=concat('gloss_', $articolo)]">

					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_gloss_', $articolo)" /></xsl:attribute>
					glossario</button>

				</xsl:if>


				<xsl:if test="//tei:listOrg[@xml:id=concat('org_', $articolo)]">
					<button type="button" class="bottoni_eventi_articoli">
					<xsl:attribute name="id"><xsl:value-of select="concat('bottone_org_', $articolo)" /></xsl:attribute>
					organizzazioni</button>
				</xsl:if>


				
				<div id="info_articoli">
				
				<xsl:if test="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[not(@role)]">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('persone_reali_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">persone_reali_articoli</xsl:attribute>
			
					<h4> persone reali </h4>

					<xsl:apply-templates select="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[not(@role)]" />
					<br/>
				</div>		
				</xsl:if>


				<xsl:if test="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[@role='character']">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('personaggi_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">personaggi_articoli</xsl:attribute>
			
					<h4> personaggi immaginari</h4>

					<xsl:apply-templates select="//tei:listPerson[@xml:id=concat('persone_', $articolo)]/tei:person[@role='character']" />
					<br/>
				</div>	
				</xsl:if>	


				<xsl:if test="//tei:listBibl[@xml:id=concat('bibl_', $articolo)]">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('bibl_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">bibliografie_articoli</xsl:attribute>
			
					<h4> opere </h4>

					<xsl:apply-templates select="//tei:listBibl[@xml:id=concat('bibl_', $articolo)]/tei:bibl" />
					<xsl:apply-templates select="//tei:listBibl[@xml:id=concat('bibl_', $articolo)]/tei:biblStruct" />
					<br/>
				</div>
				</xsl:if>



				<xsl:if test="//tei:listPlace[@xml:id=concat('luoghi_', $articolo)]">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('luoghi_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">luoghi_articoli</xsl:attribute>
				
					<h4> luoghi </h4>

					<xsl:apply-templates select="//tei:listPlace[@xml:id=concat('luoghi_', $articolo)]/tei:place" />
					<br/>
				</div>
				</xsl:if>

				

				<xsl:if test="//tei:list[@type='gloss' and @xml:id=concat('gloss_', $articolo)]">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('gloss_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">glossario_articoli</xsl:attribute>
					
					<h4> glossario</h4>
					<xsl:apply-templates select="//tei:list[@type='gloss' and @xml:id=concat('gloss_', $articolo)]" />
					<br/>
					
				</div>
				</xsl:if>



				<xsl:if test="//tei:listOrg[@xml:id=concat('org_', $articolo)]">
				<div>
					<xsl:attribute name="id"><xsl:value-of select="concat('org_', $articolo)" /></xsl:attribute>
					<xsl:attribute name="class">organizzazioni_articoli</xsl:attribute>

					<h4> organizzazioni </h4>

					<xsl:apply-templates select="//tei:listOrg[@xml:id=concat('org_', $articolo)]" />
					<br/>
				</div>
				</xsl:if>

				</div>
			
			</div>

  			</article>

		</xsl:for-each>

	</div>


	</body>
 </html>


</xsl:template>
			

	<!-- template menu articoli codificati-->
	<xsl:template match="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic">
		<h5><xsl:apply-templates select="tei:title"/></h5>
		<br/>
	</xsl:template>


	<!-- template informazioni testo originale  -->
	<xsl:template match="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr">
	
				<p> <h2 class="titoli_desc"> <xsl:value-of select="tei:title"/> </h2> </p>

				<p> <h2 class="titoli_desc">lingua testo:</h2>
				<xsl:value-of select="tei:textLang"/>
				</p>
				
				<p> <h2 class="titoli_desc"><xsl:value-of select="tei:respStmt/tei:resp"/>:</h2> 
				<xsl:value-of select="tei:respStmt/tei:name"/> 
				</p>
				
				<p> <h2 class="titoli_desc"> Pubblicato da:</h2>
				<xsl:value-of select="tei:imprint/tei:publisher"/>,
				<xsl:value-of select="tei:imprint/tei:pubPlace"/>-<xsl:value-of select="tei:imprint/tei:date"/>
				</p>
					
			
	</xsl:template>


	<!-- template informazioni testo codificato -->
	<xsl:template match="tei:TEI/tei:teiHeader/tei:fileDesc">
	
								
				<p> <h2 class="titoli_desc"> <xsl:value-of select="tei:seriesStmt/tei:title"/></h2> </p>

				<p> <h2 class="titoli_desc"> lavoro coordinato da</h2> 
				<xsl:value-of select="tei:seriesStmt/tei:respStmt/tei:name"/>
				</p>


				<p> <h2 class="titoli_desc"> standard di codifica:</h2> <xsl:value-of select="tei:titleStmt/tei:respStmt/tei:resp"/>
				<i><xsl:value-of select="tei:titleStmt/tei:respStmt/tei:name"/></i> </p>

				
				<p> <h2 class="titoli_desc"> lavoro di codifica pubblicato presso:</h2> 
				<xsl:value-of select="tei:publicationStmt/tei:publisher"/>,
				<xsl:value-of select="tei:publicationStmt/tei:pubPlace"/>-<xsl:value-of select="tei:publicationStmt/tei:date"/>
				</p>



				<p> <h2 class="titoli_desc"> sezioni codificate:</h2> 

				<ul id="lista_sezioni_codificate">
					<xsl:for-each select="tei:sourceDesc/tei:biblStruct/tei:analytic">
						<li><xsl:value-of select="preceding-sibling::comment()[1]"/></li>
					</xsl:for-each>
				</ul>

				</p>
	</xsl:template>



	<!-- template immagini pagine-->

	<xsl:template match="//tei:surface">
	
		<xsl:variable name="immagine">
		<xsl:value-of select="tei:graphic/@url"/>
		</xsl:variable>
			
		
		<xsl:element name="img">

		<xsl:attribute name="id">
		<xsl:value-of select="$immagine"/>		
		</xsl:attribute>


		<xsl:attribute name="src">
		<xsl:value-of select="$immagine"/>		
		</xsl:attribute>
		
		
		<xsl:attribute name="alt">
		<xsl:value-of select="$immagine"/>		
		</xsl:attribute>
		
		
		<xsl:attribute name="class">immagini_pagine</xsl:attribute>
		
		</xsl:element>


	</xsl:template>





	<!--template inizio pagina (pb)-->
	
	<xsl:template match="tei:pb">

		<xsl:apply-templates/>
		
	</xsl:template>



	<!--template inizio colonna (cb)-->
	
	<xsl:template match="tei:cb">

		<xsl:variable name="colonna">
			<xsl:value-of select="@xml:id"/>
		</xsl:variable>

		<xsl:apply-templates select="(following-sibling::tei:p[@corresp=concat('#', $colonna)])"/>
	
	</xsl:template>


	<!-- template inizio riga (lb) -->

	<xsl:template match="tei:lb">
	   	<br/>
 		<xsl:apply-templates/>
    </xsl:template>


	<!-- template paragrafi (p) -->

	<xsl:template match="tei:p">
		
 		<xsl:apply-templates/>
		
	</xsl:template>




	<!--template citazione (quote)-->
	
	<xsl:template match="tei:quote">

		
		
		<xsl:element name="span">

		<xsl:attribute name="class">elemento</xsl:attribute>


			<xsl:element name="span">

					<xsl:attribute name="class">quote</xsl:attribute>

					
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>


					<xsl:apply-templates/>
					

			</xsl:element>
						
						
		 	<xsl:variable name="quote_info" select="substring-after(@source, '#')" />
		
			
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>

					
				<xsl:apply-templates select="//tei:listBibl/tei:bibl[@xml:id=$quote_info]"/>
				<xsl:apply-templates select="//tei:listBibl/tei:biblStruct[@xml:id=$quote_info]"/>
		
		
			</xsl:element>
	
		</xsl:element>
		
	</xsl:template> 



	<!--template discorso diretto (q)-->
	
	<xsl:template match="tei:q">

		
		
		<xsl:element name="span">

		<xsl:attribute name="class">discorso</xsl:attribute>


			<xsl:if test="@style">

				<xsl:attribute name="style">
				<xsl:value-of select="@style"/>
				</xsl:attribute>

			</xsl:if>


			<xsl:apply-templates/>					

			
		</xsl:element>
			
	</xsl:template>



	<!--template bibliografia-->

	<xsl:template match="tei:bibl">

		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">bibliografia</xsl:attribute>

				
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>

					<xsl:apply-templates/>

				</xsl:element>

											
		 	<xsl:variable name="bibl_info" select="substring-after(@corresp, '#')" />
		
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>

				<xsl:apply-templates select="//tei:listBibl/tei:bibl[@xml:id=$bibl_info]"/>

			</xsl:element>
	
		</xsl:element>
		
	</xsl:template>



	<!--template bibliografia strutturata-->

	<xsl:template match="tei:biblStruct">

		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">bibliografia</xsl:attribute>

				
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>

					<xsl:apply-templates/>

				</xsl:element>

											
		 	<xsl:variable name="bibl_info" select="substring-after(@corresp, '#')" />
		
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>

				<xsl:apply-templates select="//tei:listBibl/tei:biblStruct[@xml:id=$bibl_info]"/>

			</xsl:element>
	
		</xsl:element>
		
	</xsl:template>


	
	<!--template persona (persName)-->

	<xsl:template match="tei:persName">

		
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		
						
		 		<xsl:variable name="persona" select="substring-after(@corresp, '#')" />
		
							
				<xsl:element name="span">
				
					<xsl:attribute name="class">persona</xsl:attribute>
					
					<xsl:if test="//tei:listPerson/tei:person[@xml:id=$persona and @role='character']">
						<xsl:attribute name="class">personaggio</xsl:attribute>
					</xsl:if>


					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>

									



					<xsl:apply-templates/>

				</xsl:element>

					
				<xsl:element name="span">
		
					<xsl:attribute name="class">informazioni</xsl:attribute>
 
						<xsl:apply-templates select="//tei:listPerson/tei:person[@xml:id=$persona]"/>
		
				</xsl:element>
	
		</xsl:element>

	</xsl:template>



	<!--template luogo (placeName)-->

	<xsl:template match="tei:placeName">

		
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">luogo</xsl:attribute>

							
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>


					<xsl:apply-templates/>

				</xsl:element>

											
		 	<xsl:variable name="luogo_info" select="substring-after(@corresp, '#')" />
		
			
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>
 
					<xsl:apply-templates select="//tei:listPlace/tei:place[@xml:id=$luogo_info]"/>
		
			</xsl:element>
	
		</xsl:element>

	</xsl:template>





	<!--template organizzazione (orgName)-->

	<xsl:template match="tei:orgName">

		
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">organizzazione</xsl:attribute>

							
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>


					<xsl:apply-templates/>

				</xsl:element>

											
		 	<xsl:variable name="organizzazione_info" select="substring-after(@corresp, '#')" />
		
			
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>
 
					<xsl:apply-templates select="//tei:listOrg/tei:org[@xml:id=$organizzazione_info]"/>
		
			</xsl:element>
	
		</xsl:element>

	</xsl:template>



	<!--template rs (rs)-->

	<xsl:template match="tei:rs">
						
							
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>


	 			<xsl:variable name="rs_info" select="substring-after(@corresp, '#')" />
				


					<xsl:choose>

						<xsl:when test="@type ='person'">

							<xsl:element name="span">
				
							<xsl:attribute name="class">persona</xsl:attribute>

							<xsl:if test="//tei:listPerson/tei:person[@xml:id=$rs_info and @role='character']">
								<xsl:attribute name="class">personaggio</xsl:attribute>
							</xsl:if>
							
										
							<xsl:if test="@style">

								<xsl:attribute name="style">
								<xsl:value-of select="@style"/>
								</xsl:attribute>

							</xsl:if>


							<xsl:apply-templates/>

							</xsl:element>
							
							<xsl:element name="span">
							<xsl:attribute name="class">informazioni</xsl:attribute>
                      	  	<xsl:apply-templates select="//tei:listPerson/tei:person[@xml:id=$rs_info]"/>
							</xsl:element>

						</xsl:when>


						<xsl:when test="@type ='book'">
						
							<xsl:element name="span">
				
							<xsl:attribute name="class">bibliografia</xsl:attribute>
							
										
							<xsl:if test="@style">

								<xsl:attribute name="style">
								<xsl:value-of select="@style"/>
								</xsl:attribute>

							</xsl:if>


							<xsl:apply-templates/>

							</xsl:element>
							
							<xsl:element name="span"> 
							<xsl:attribute name="class">informazioni</xsl:attribute>
							<xsl:apply-templates select="//tei:listBibl/tei:bibl[@xml:id=$rs_info]"/>
							<xsl:apply-templates select="//tei:listBibl/tei:biblStruct[@xml:id=$rs_info]"/>

							</xsl:element>
						</xsl:when>


						<xsl:when test="@type ='place'">
						
							<xsl:element name="span">
				
							<xsl:attribute name="class">luogo</xsl:attribute>
							
							
											
							<xsl:if test="@style">

								<xsl:attribute name="style">
								<xsl:value-of select="@style"/>
								</xsl:attribute>

							</xsl:if>


							<xsl:apply-templates/>

							</xsl:element>
							
							<xsl:element name="span">							
							<xsl:attribute name="class">informazioni</xsl:attribute>
							<xsl:apply-templates select="//tei:listPlace/tei:place[@xml:id=$rs_info]"/>
							</xsl:element>
						</xsl:when>


        			</xsl:choose>

		</xsl:element>
		
	</xsl:template>



	<!--template scelte lessicali (choice)-->

	<xsl:template match="tei:choice">

		
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">lessico</xsl:attribute>
					
									
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>

					<xsl:apply-templates select="tei:orig"/>

				</xsl:element>

											
			
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>
 
					<ul class="lista_info">

						<li>
							<u>termine originale</u>: <i> <b> <xsl:value-of select="normalize-space(tei:orig)"/> </b> </i>
						</li>

						<li>
							<u>termine attualizzato</u>: <i><xsl:value-of select="normalize-space(tei:reg)"/></i>
						</li>
						
						
					</ul>

			</xsl:element>
	
		</xsl:element>

	</xsl:template>



	<!--template termine originale scelte lessicali (orig)-->

	<xsl:template match="tei:orig">
		<xsl:apply-templates/>
	</xsl:template>


	<!--template termini (term)-->

	<xsl:template match="tei:term">

		
		<xsl:element name="span">

			<xsl:attribute name="class">elemento</xsl:attribute>
		

				<xsl:element name="span">
				
					<xsl:attribute name="class">termine</xsl:attribute>
							
								
					<xsl:if test="@style">

						<xsl:attribute name="style">
						<xsl:value-of select="@style"/>
						</xsl:attribute>

					</xsl:if>


					<xsl:apply-templates/>

				</xsl:element>

											
		 	<xsl:variable name="termine_info" select="substring-after(@corresp, '#')" />
		
			
			<xsl:element name="span">
		
				<xsl:attribute name="class">informazioni</xsl:attribute>
 
					<xsl:apply-templates select="//tei:list[@type='gloss']/tei:label/tei:term[@xml:id=$termine_info]"/>
		 			
			</xsl:element>
	
		</xsl:element>

	</xsl:template>



	<!--template testo enfatizzato (emph)-->

	<xsl:template match="tei:emph">

		
		<xsl:element name="span">

			<xsl:attribute name="class">enfatizzato</xsl:attribute>


			<xsl:attribute name="style">

				<xsl:value-of select="@style"/>
			
			</xsl:attribute>


				<xsl:apply-templates/>
	
		</xsl:element>

	</xsl:template>



	<!--template bibliografia glossario ()-->

	<xsl:template match="//tei:list[@type='gloss']/tei:label/tei:term">		

		<xsl:variable name="termine">
			<xsl:value-of select="@xml:id"/>
		</xsl:variable>



		<xsl:variable name="lista">lista_info </xsl:variable>
		
		<xsl:variable name="tipo">
		
			<xsl:choose>
						
			<xsl:when test="@type ='theatrical_genre'">
				genere teatrale
			</xsl:when>
		
			<xsl:when test="@type ='person'">
				persona
			</xsl:when>	

			<xsl:when test="@type ='science'">
				scienza
			</xsl:when>
		
			<xsl:when test="@type ='literary_genre'">
				genere letterario
			</xsl:when>

			<xsl:when test="@type ='literary_lang'">
				lingua letteraria
			</xsl:when>


			</xsl:choose>
		
		</xsl:variable>

					<ul>
					<xsl:attribute name="class">
						<xsl:value-of select="$lista"/>
						<xsl:value-of select="@type"/>
					</xsl:attribute>

						<li>
							<u>termine</u>: <i> <b> <xsl:value-of select="."/> </b> </i>
						</li>
						<li>
							<u>tipo</u>: <i> <xsl:value-of select="$tipo"/></i>
						</li>
						<li>
							<u>spiegazione</u>: <i> <xsl:value-of select="../following-sibling::tei:item/tei:gloss[@corresp=concat('#',$termine)]"/></i> 
						</li>

					</ul>

	</xsl:template>


	<!-- template per creare bottoni più specifici rispetto al glossario dell'articolo -->
	<xsl:template match="//tei:list[@type='gloss']">

		
			<button class="bottoni_glossario_art" id="bottone_glossario_art_tutto">completo</button>
			

			<xsl:if test="tei:label/tei:term/@type ='theatrical_genre'">
				<button class="bottoni_glossario_art" id="bottone_glossario_art_theatrical_genre">teatro</button>
			</xsl:if>


			<xsl:if test="tei:label/tei:term/@type ='person'">
				<button class="bottoni_glossario_art" id="bottone_glossario_art_person">persone</button>
			</xsl:if>

			
			<xsl:if test="tei:label/tei:term/@type ='science'">
				<button class="bottoni_glossario_art" id="bottone_glossario_art_science">scienza</button>
			</xsl:if>

			
			<xsl:if test="tei:label/tei:term/@type ='literary_genre'">
				<button class="bottoni_glossario_art" id="bottone_glossario_art_literary_genre">letteratura</button>
			</xsl:if>
		
			<xsl:if test="tei:label/tei:term/@type ='literary_lang'">
				<button class="bottoni_glossario_art" id="bottone_glossario_art_literary_lang">letteratura</button>
			</xsl:if>

			<xsl:apply-templates select="tei:label/tei:term"/>

	</xsl:template>


	<!--template bibliografia opere ()-->

	<xsl:template match="//tei:listBibl/tei:bibl">

					<ul class="lista_info">

						<li>
							<u>titolo</u>: <i> <b> <xsl:value-of select="tei:title"/> </b> </i>
						</li>
						
						
						<xsl:if test="tei:author">
						<li>
							<u>autore</u>: <i> <xsl:value-of select="tei:author"/></i>
						</li>
						</xsl:if>
			
			
						<xsl:if test="tei:date">
						<li>
							<u>anno pubblicazione</u>: <i> <xsl:value-of select="tei:date"/></i>
						</li>
						</xsl:if>

						
						<xsl:if test="tei:pubPlace">
						<li>
							<u>luogo pubblicazione</u>: <i> <xsl:value-of select="tei:pubPlace"/></i>
						</li>
						</xsl:if>

					</ul>
		
		
	</xsl:template>

	
	<!--template bibliografia opere strutturate (biblStruct)-->

	<xsl:template match="//tei:listBibl/tei:biblStruct">

					<ul class="lista_info">

						<li>
							<u>titolo volume</u>: <i> <b> <xsl:value-of select="tei:analytic/tei:title"/> </b> </i>
						</li>
						
						
						<xsl:if test="tei:analytic/tei:author">
						<li>
							<u>autore volume</u>: <i> <xsl:value-of select="tei:analytic/tei:author"/></i>
						</li>
						</xsl:if>
			
			
						<xsl:if test="tei:monogr/tei:title">
						<li>
							<u>titolo collana</u>: <i> <xsl:value-of select="tei:monogr/tei:title"/></i>
						</li>
						</xsl:if>


						<xsl:if test="tei:monogr/tei:editor">
						<li>
							<u>editore</u>: <i> <xsl:value-of select="tei:monogr/tei:editor"/></i>
						</li>
						</xsl:if>

						
						<xsl:if test="tei:monogr/tei:imprint/tei:pubPlace">
						<li>
							<u>luogo pubblicazione collana</u>: <i> <xsl:value-of select="tei:monogr/tei:imprint/tei:pubPlace"/></i>
						</li>
						</xsl:if>

							
						<xsl:if test="tei:monogr/tei:imprint/tei:date">
						<li>
							<u>anno pubblicazione collana</u>: <i> <xsl:value-of select="tei:monogr/tei:imprinti/tei:date"/></i>
						</li>
						</xsl:if>

					</ul>
		
		
	</xsl:template>



	<!--template bibliografia persone (listPerson)-->

	<xsl:template match="//tei:listPerson/tei:person">


					<ul class="lista_info">

						<xsl:if test="@role='character'" >
						<li><i>personaggio immaginario</i></li>
						</xsl:if>

						<li>
							<b> <xsl:value-of select="tei:persName"/> </b>
						</li>
						

						<xsl:if test="tei:birth">
						<li>
							<u>nascita</u>: <i> 
							<xsl:value-of select="tei:birth/tei:date"/> a 
							 <xsl:value-of select="tei:birth/tei:placeName"/>
							 (<xsl:value-of select="tei:birth/tei:country"/>)
							 </i>
						</li>
						</xsl:if>



						<xsl:if test="tei:death">
						<li>
							<u>morte</u>: <i>
							 <xsl:value-of select="tei:death/tei:date"/> a 
							 <xsl:value-of select="tei:death/tei:placeName"/>
							 (<xsl:value-of select="tei:death/tei:country"/>)
							 </i>
						</li>
						</xsl:if>


						<xsl:if test="tei:occupation">
						<li>
							<u>occupazione</u>: <i> <xsl:value-of select="tei:occupation"/></i>
						</li>
						</xsl:if>

					</ul>
		
		
	</xsl:template>



	<!--template bibliografia luogi (listPlace)-->

	<xsl:template match="//tei:listPlace/tei:place">

					<ul class="lista_info">

						<li>
							<u>luogo</u>: <i> 

							<xsl:choose>
								<xsl:when test="tei:placeName">
									<b> <xsl:value-of select="tei:placeName"/> </b>
										<xsl:if test="tei:country">
										(<xsl:value-of select="tei:country"/>)
										</xsl:if>
								</xsl:when>

								<xsl:when test="tei:country">
									<b> <xsl:value-of select="tei:country"/> </b>
								</xsl:when> 

							</xsl:choose>

							</i>
							
						</li>

					</ul>
		
	</xsl:template>



	<!--template bibliografia organizzazioni (listOrg)-->

	<xsl:template match="//tei:listOrg/tei:org">

					<ul class="lista_info">

						<li>
							<u>organizzazione</u>:
							<i> <b> <xsl:value-of select="tei:orgName"/> </b> </i>
						</li>

						<li>
							<u>descrizione</u>:   	
							<i><xsl:value-of select="tei:desc"/></i>
						</li>

					</ul>
		
	</xsl:template>


</xsl:stylesheet>
 
