<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="SKL">
	<html>
 	<body>
 	<h1>SKL</h1>
 	<h2>Inhalt</h2>
		<ul>
			<li><a href="#tarif">Tarife</a></li>
			<li><a href="#leistung">Leistungen</a></li>
			<li><a href="#benutzer">Benutzer</a></li>
			<li><a href="#gruppe">Gruppen</a></li>
			<li><a href="#kunde">Kunden</a></li>
			<li><a href="#kilometereintrag">Kilometereinträge</a></li>
		</ul> 	
 	
  		<h2 id="tarif">Tarife</h2>
   		<ul>
 			<xsl:for-each select="tarif">
       			<li><xsl:value-of select="@type"/></li>
      		</xsl:for-each>
   		</ul>
   		
   		<h2 id="leistung">Leistungen</h2>
   		<ul>
 			<xsl:for-each select="leistung">
       			<li><xsl:value-of select="@type"/></li>
      		</xsl:for-each>
   		</ul>
   		
   		<h2 id="benutzer">Benutzer</h2>
		<xsl:for-each select="benutzer">
 			<table border="1">
 				<h3><xsl:value-of select="@vorname"/></h3>
				<xsl:for-each select="stundenerfassung">
					<tr>
						<td><xsl:value-of select="@id_kunde"/></td>
						<td><xsl:value-of select="@id_leistung"/></td>
						<td><xsl:value-of select="@startzeit"/></td>
						<td><xsl:value-of select="@dauer"/></td>
					</tr>
				</xsl:for-each>
			</table>			
      	</xsl:for-each>
   		
   		
   		<h2 id="gruppe">Gruppen</h2>
   		<ul>
   			<xsl:for-each select="gruppe">
   				<li><xsl:value-of select="@type"/></li>
   			</xsl:for-each>
   		</ul>
   		
   		<h2 id="kunde">Kunden</h2>
   		<ul>
   			<xsl:for-each select="kunde">
   				<li><xsl:value-of select="@vorname"/>_<xsl:value-of select="@nachname"/></li>
   			</xsl:for-each>
   		</ul>

   		<h2 id="kilometereintrag">Kilometereinträge</h2>
   		<table border="1">
 			<xsl:for-each select="kilometereintrag">
				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="@id_benutzer"/></td>
					<td><xsl:value-of select="@datum"/></td>
					<td><xsl:value-of select="@kilometer"/></td>
				</tr>		
      		</xsl:for-each>
   		</table>
   		
        <hr/>
        <table>
            <tr>
                <td><a href="#benutzer">Benutzer</a></td>
                <td><a href="#gruppe">Gruppen</a></td>
                <td><a href="#kilometereintrag">Kilometereinträge</a></td>
                <td><a href="#kunde">Kunden</a></td>
                <td><a href="#leistung">Leistungen</a></td>
                <td><a href="#tarif">Tarife</a></td>
            </tr>
        </table>
   
   		
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>