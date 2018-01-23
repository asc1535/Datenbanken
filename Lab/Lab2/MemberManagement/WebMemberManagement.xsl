<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
	
	<head>
		<title>FC Sulzberg - Mitgliederverwaltung</title>
	</head>
	<body>
		<img height="100px" src="http://fcsulzberg.at.host24.profi-server.at/wp-content/uploads/2016/06/Header_allgemein.jpg"/>
		
		<h2>Offene Beiträge</h2>
		
		<ul>
			<!-- not received_date = True wenn Attribut received_date leer/nicht vorhanden -->
			<xsl:apply-templates select="//subscription[not(@received_date)]"/>
		</ul>
		
		<h2>Inhaltsverzeichnis Mitglieder</h2>
		<ul>
			<xsl:apply-templates select="member-management/member" mode="toc"/>
		</ul>
	
		<xsl:apply-templates select="member-management/member" mode="content"/>
		
		
	</body>
	</xsl:template>
	
	
	<xsl:template match="member" mode="toc">
		<li>
		<a href="#{@member_id}">
			<xsl:call-template name="memberBaseInfo">
				<xsl:with-param name="member" select="."/>
			</xsl:call-template>	
		</a>	
		</li>
	</xsl:template>
	<xsl:template match="member" mode="content">
		<h2 id="{@member_id}"> 
			<xsl:call-template name="memberBaseInfo">
				<xsl:with-param name="member" select="."/>	
			</xsl:call-template>
		</h2>
		<dl>
			<dt>Adresse: </dt>
			<dd><xsl:value-of select="@street"/></dd>
			<dd><xsl:value-of select="@postal_code"/> - <xsl:value-of select="@residence"/></dd>
			<dd><xsl:value-of select="@country"/></dd>

			
			<dt>Rolle: </dt>
				<xsl:for-each select="member-role">
				<dd>
					<xsl:value-of select="id(@role-id)/@role_name"/>
				</dd>	
			</xsl:for-each>
			<!-- IF: Wenn kein Child vorhanden wird auch nichts ausgeführt -->
			<xsl:if test="team-role">
			<dt>Teamrolle: </dt>
				<xsl:for-each select="team-role">
				<dd>
					<xsl:value-of select="id(@role-id)/@role_name"/> - <xsl:value-of select="id(@team-id)/@team_name"/>
				</dd>	
				</xsl:for-each>
			</xsl:if>
			<xsl:for-each select="subscription">
				<dt>Mitgliedsbeitrag: </dt>
				<dd>
					<xsl:value-of select="@due_date"/> - <xsl:value-of select="@amount"/>
				</dd>	
			</xsl:for-each>
		</dl>
		
	</xsl:template>
	
	<xsl:template match="subscription">
		<li>
			<a href="#{../@member_id}">
				<xsl:value-of select="../@member_name"/>
			</a>, 
				<xsl:value-of select="@due_date"/>, <xsl:value-of select="@amount"/>	
		</li>	
	</xsl:template>
	
	
	<xsl:template name="memberBaseInfo">
		<xsl:param name="member"/>
			<xsl:value-of select="$member/@member_id"/>: 
			<xsl:value-of select="$member/@member_name"/>
	</xsl:template>
</xsl:stylesheet>