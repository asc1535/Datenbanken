<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>ET-Management</title>
				<style type="text/css">
					table, td, th {
						border: 1px solid #ddd;
						border-collapse: collapse;
					}
					th {
						font-size: 80%;
					}
				</style>
			</head>
			<body>
				<h1>ET-Mangament</h1>
				<h2>Unser Team</h2>
				
				<ul><xsl:apply-templates select="management/employee" mode="overview"/></ul>
				<br></br><br></br>
				<ul><xsl:apply-templates select="management/employee" mode="details"/></ul>
				<br></br><br></br>
				
				<h2>ID-Verzeichnis (nach alphabetischer Reihenfolge der Vornamen)</h2>
				<table>
					<thead><tr><th>ID</th><th>Vor-/Nachname</th><th>Beruf</th></tr></thead>
					<tbody>
						<xsl:apply-templates select="management/employee" mode="register">
							<xsl:sort select="@fname"/>
						</xsl:apply-templates>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="employee" mode="overview">
				<li>
					<a href="#{@employee_id}">
						<xsl:value-of select="@fname"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="@lname"/>
					</a>
				</li>
	</xsl:template>
	
	<xsl:template match="employee" mode="details">
		<div id="{@employee_id}">
			<h4>
				<xsl:value-of select="@fname"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="@lname"/>
			</h4>
		</div>
		<xsl:apply-templates select="address"/>
		<xsl:apply-templates select="phone"/>
		<xsl:apply-templates select="email"/>
		<xsl:apply-templates select="@comment" mode="employee"/>
		<xsl:apply-templates select="employment"/>
		<br></br>
	</xsl:template>
	
	<xsl:template match="employee" mode="register">
			<tr>
				<td><xsl:value-of select="@employee_id"/></td>
				<td><a href="#{@employee_id}">
					<xsl:value-of select="@fname"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="@lname"/>
				</a></td>
				<td><xsl:apply-templates match="employment" mode="register"/></td>
			</tr>
	</xsl:template>
	
	<xsl:template match="employment" mode="register">
		<xsl:value-of select="id(@prof_id)/@profession"/><br></br>
	</xsl:template>
	
	<xsl:template match="address">
		<li>Adresse: 
			<xsl:value-of select="@street_name" />, 
			<xsl:value-of select="@zip_code"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@city_name" />, 
			<xsl:value-of select="id(@country_id)/@country_name"/>
		</li>
	</xsl:template>
	
	<xsl:template match="phone">
		<li>Telefon:
			<xsl:value-of select="@phone_no"/>
		</li>
	</xsl:template>
	
	<xsl:template match="email">
		<li>E-Mail:
			<xsl:value-of select="@email_addr"/>
		</li>
	</xsl:template>
	
	<xsl:template match="@comment" mode="employee">
		<li>Kommentar: <xsl:value-of select="."/></li>
	</xsl:template>
	
	<xsl:template match="employment">
		<li>Employment:
			<ul>
				<li>Beruf: <xsl:value-of select="id(@prof_id)/@profession" /></li>
				<li>Anstellungsdatum: <xsl:value-of select="@start_date"/></li>
				<xsl:apply-templates select="@end_date"/>
				<xsl:apply-templates select="time_record"/>
			</ul>
		</li>
	</xsl:template>
	
	<xsl:template match="@end_date">
		<li>Kündigungsdatum: <xsl:value-of select="."/></li>
	</xsl:template>
	
	<xsl:template match="time_record">
		<li>Zeitstempel: von <xsl:value-of select="@f_timestamp"/> bis <xsl:value-of select="@l_timestamp"/> <xsl:apply-templates select="@comment" mode="timestamp"/></li>
	</xsl:template>
	
	<xsl:template match="@comment" mode="timestamp">
		<text> Kommentar: </text><xsl:value-of select="."/>
	</xsl:template>
</xsl:stylesheet>