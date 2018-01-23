<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" />

	<xsl:template match="/">
		<html>
			<head>
				<title>ProJack</title>
			</head>

			<body>
				<h1>ProJack</h1>

				<h2>Athleten</h2>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>ID</th>
							<th>Verein</th>
							<th>Geschlecht</th>
							<th>Geburtsdatum</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="/projack/athlet">
							<xsl:sort select="@vereins_name_ID" />
							<tr>
								<td>
									<a xml:space="preserve" href="#{@id}">
										<xsl:value-of select="nachname" /> 
										<xsl:value-of select="vorname" />
									</a>
								</td>
								<td>
									<xsl:value-of select="@id" />
								</td>
								<td>
									<xsl:value-of select="id(@vereins_name_ID)/@name" />
								</td>
								<td>
									<xsl:value-of select="geschlecht"/>
								</td>
								<td>
									<xsl:value-of select="geburtstag"/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>

				<h2>Leistungen pro Athlet</h2>
				<xsl:apply-templates select="/projack/athlet" />

				<h2>Leistungen pro Disziplin</h2>
				<xsl:apply-templates select="/projack/disziplin" />

			</body>
		</html>
		<!-- TODO: Auto-generated template -->
	</xsl:template>

	<xsl:template match="athlet">
		<h3 id="{@id}" xml:space="preserve">
						<xsl:value-of select="nachname" />
						<xsl:value-of select="vorname" />
					</h3>
		<table>
			<thead>
				<tr>
					<th>Disziplin</th>
					<th>Leistung</th>
					<th>Maßeinheit</th>
					<th>Ort</th>
					<th>Datum</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="a_ID" select="@id" />
				<xsl:for-each select="/projack/leistungAthlet[@athlet_ID = $a_ID]">
					<xsl:sort select="@athlet_ID" />
					<tr>
						<td>
							<xsl:value-of select="id(@disziplin_ID)/disziplinName"></xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="athlet_leistung" />
						</td>
						<td>
							<xsl:value-of select="id(@disziplin_ID)/masseinheit" />
						</td>
						<td>
							<xsl:value-of select="ort" />
						</td>
						<td>
							<xsl:value-of select="datum" />
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="disziplin">
		<xsl:variable name="d_ID" select="@id" />
		<xsl:if test="/projack/leistungAthlet[@disziplin_ID = $d_ID]">
			<h4 xml:space="preserve">
			<xsl:value-of select="disziplinName" /> - <xsl:value-of
				select="id(@altersklasse_ID)/@altersklasse_name" /> 
		</h4>

			<table>
				<thead>
					<tr>
						<th>Nachname</th>
						<th>Vorname</th>
						<th>Leistung</th>
						<th>Maßeinheit</th>
						<th>Ort</th>
						<th>Datum</th>
					</tr>
				</thead>

				<tbody>

					<xsl:for-each select="/projack/leistungAthlet[@disziplin_ID = $d_ID]">
						<xsl:sort select="athlet_leistung" order="descending" />
						<tr>


							<td>
								<a xml:space="preserve" href="#{@id}">
								<xsl:value-of select="id(@athlet_ID)/nachname" />
								</a>
							</td>

							<td>
								<a xml:space="preserve" href="#{@id}">
								<xsl:value-of select="id(@athlet_ID)/vorname" />
								</a>
							</td>

							<td>
								<xsl:value-of select="athlet_leistung" />
							</td>
							<td>
								<xsl:value-of select="id(@disziplin_ID)/masseinheit" />
							</td>

							<td>
								<xsl:value-of select="ort" />
							</td>
							<td>
								<xsl:value-of select="datum" />
							</td>
						</tr>
					</xsl:for-each>


				</tbody>
			</table>


		</xsl:if>
	</xsl:template>



</xsl:stylesheet>