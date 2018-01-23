<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	<xsl:template match="/">
		<html>
				<head>
					<title>DT</title>
					<link rel="stylesheet" type="text/css" href="css/style.css"/>
				</head>
				<body>
					<h1>Digitale Turnierleitung</h1>
					<xsl:apply-templates select="/digitale_turnierleitung/tournament/round" mode="matches"></xsl:apply-templates>
					
					<h1>Teams</h1>
					<xsl:apply-templates select="/digitale_turnierleitung/tournament/team" mode="teams"/>
					
					<h1><u>Spieler Index</u></h1>
					<table>
						<thead>
							<tr><th>Nachname</th><th>Vorname</th></tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="/digitale_turnierleitung/tournament/team" mode="player"/>
						</tbody>
					</table>
				</body> 
			
			</html>
		
		
	</xsl:template>
	<xsl:template match="round" mode="matches">
		<h2>Runde: <xsl:value-of select="@round-number"/></h2>
		<xsl:for-each select="play-group">
			<h2>Gruppe: <xsl:value-of select="@group-name"/></h2>
			<xsl:call-template name="matches">
				<xsl:with-param name="play-group" select="."></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		
		
		
	</xsl:template>
	
	<xsl:template name="matches">
		<xsl:param name="play-group"/>
		
		
		<table>
			<thead>
				<tr><th>Zeit</th><th>Team 1</th><th>Team 2</th><th>Bahn</th></tr>
			</thead>
			<tbody>
					<xsl:for-each select="$play-group/match">
						<xsl:sort select="@start-time"/>
						<tr>
							<td><xsl:value-of select="@start-time"/></td>
							<td><a href="#{@team-1-id}"><xsl:value-of select="id(@team-1-id)/@teamname"/></a></td>
							<td><a href="#{@team-2-id}"><xsl:value-of select="id(@team-2-id)/@teamname"/></a></td>
							<td><xsl:value-of select="@lane"/></td>
						</tr>
					</xsl:for-each>
				
			</tbody>
		</table>
		
	</xsl:template>
	
	<xsl:template match="team" mode="teams">
		<h3 id="{@id}"><u><xsl:value-of select="@teamname"/></u></h3>
		<table>
			<thead>
				<tr><th>Nachname</th><th>Vorname</th></tr>
			</thead>
			<tbody>
					<xsl:for-each select="player">
						<xsl:sort select="@lastname"/>
						<tr>
							<td><xsl:value-of select="@lastname"/></td>
							<td><xsl:value-of select="@firstname"/></td>
						</tr>
					</xsl:for-each>
				
			</tbody>
		</table>
	</xsl:template>
	
	<xsl:template match="team" mode="player">
		
					<xsl:for-each select="player">
						<xsl:sort select="@lastname"/>
						<a href="#{../@id}">
						<tr>
							<td><xsl:value-of select="@lastname"/></td>
							<td><xsl:value-of select="@firstname"/></td>
						</tr>
						</a>
					</xsl:for-each>
				
	
	
	</xsl:template>
</xsl:stylesheet>