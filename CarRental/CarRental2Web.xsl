<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>CarRental</title>
			</head>
			<body>
				<h1>CarRental</h1>
				
				<h2>Unser Angebot</h2>
				<ul>
					<xsl:apply-templates select="/car-rental/auto" mode="toc"/>
				</ul>
				
				<xsl:apply-templates select="/car-rental/auto" mode="content"/>
				
				<h2>Kennzeichenverzeichnis</h2>
				<table>
					<thead>
						<tr><th>Kennzeichen</th><th>PKW</th></tr>
					</thead>
					<tbody>
						<xsl:for-each select="/car-rental/auto">
							<xsl:sort select="@kennzeichen"/>
							<tr>
								<td colspan="2">
									<xsl:value-of select="@kennzeichen"/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="auto" mode="content">
		<h2 id="{@kennzeichen}">
			<xsl:call-template name="car-title">
				<xsl:with-param name="car" select="."/>
			</xsl:call-template>
		</h2>
		<img src="{@image}" width="240 px"/>
		<ul>
			<li>Mietpreis: € <xsl:value-of select="id(@autotyp-id)/../@grundtarif"/></li>
			<li>Standort: </li>
			<li>Kennzeichen: <xsl:value-of select="@kennzeichen"/></li>
			<li>km Stand: <xsl:value-of select="@km_stand"/></li>
			<xsl:for-each select="verfuegt_ueber">
				<li>Extra: <xsl:value-of select="id(@extraausstattung-id)/@extras_bezeichnung"/></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="auto" mode="toc">
		<li><a href="#{@kennzeichen}">
				<xsl:call-template name="car-title">
					<xsl:with-param name="car" select="."/>
				</xsl:call-template>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template name="car-title">
		<xsl:param name="car"/>
		
		<xsl:value-of select="id($car/@autotyp-id)/@typ_bezeichnung"/> -
		<xsl:value-of select="$car/@farbe"/>
	</xsl:template>

</xsl:stylesheet>














