<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" />
	<xsl:template match="/">
		<html>
			<head>
				<title>MusicPete</title>
				<link rel="stylesheet"
					href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
					integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy"
					crossorigin="anonymous" />
				<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
					integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
					crossorigin="anonymous"></script>
				<script
					src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
					integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
					crossorigin="anonymous"></script>
				<script
					src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
					integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
					crossorigin="anonymous"></script>
			</head>

			<body>
				<main role="main">
					<div class="jumbotron">
						<div class="container">
							<h1 class="display-3" id="instruments">MusicPete - Instrumentenübersicht</h1>
							<p>
								<a class="btn btn-primary btn-lg" href="#persons" role="button">Persons
									»</a>
							</p>
						</div>
					</div>

					<div class="container">
						<xsl:apply-templates select="/musicpete/InstrumentCategory" />
						<hr />
					</div>
					
					<div class="jumbotron">
						<div class="container">
							<h1 class="display-3" id="persons">MusicPete - Personenübersicht</h1>
							<p>
								<a class="btn btn-primary btn-lg" href="#instruments" role="button">Instrumente
									»</a>
							</p>
						</div>
					</div>

					<div class="container">
						<div class="row">
							<xsl:apply-templates select="/musicpete/Person" />
						</div>
						<hr />
					</div>
				</main>
				
				<footer class="container">
					<p>Bildstein Lukas, Bischof Martin, Bolter Raphael, Herbek Stefan,
						Koinegg Bianca</p>
				</footer>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="InstrumentCategory">
		<div class="container-fluid">
			<div class="alert alert-info" role="alert">
				<h4 class="alert-heading">
					<xsl:value-of select="@name" />
				</h4>
			</div>

			<div class="row">
				<xsl:apply-templates select="InstrumentFamily" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="InstrumentFamily">

		<div class="container-fluid">
			<div class="alert alert-warning" role="alert">
				<h4 class="alert-heading">
					<xsl:value-of select="@name" />
				</h4>
			</div>

			<xsl:apply-templates select="InstrumentType" />
		</div>

	</xsl:template>

	<xsl:template match="InstrumentType">

		<div class="container-fluid">
			<div class="alert alert-secondary" role="alert">
				<h4 class="alert-heading" id="{@ID}">
					<xsl:value-of select="@name" />
				</h4>
			</div>

			<div class="row">
				<xsl:apply-templates select="Instrument" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="Instrument">

		<div class="col-md-4">
			<div class="card bg-light mb-3" style="max-width: 18rem;">
				<div class="card-header">
					Name:
					<xsl:value-of select="@instrumentName" />
				</div>
				<div class="card-body">
					<ul>
						<li>
							Color:
							<xsl:value-of select="@color" />
						</li>
						<li>
							Buy Date:
							<xsl:value-of select="@buyDate" />
						</li>
						<li>
							Price:
							<xsl:value-of select="@price" />
						</li>
						<xsl:choose>
							<xsl:when test="@accessories !=''">
								<li>
									Accessories:
									<xsl:value-of select="@accessories" />
								</li>
							</xsl:when>
						</xsl:choose>
					</ul>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="Person">

		<div class="col-12 col-sm-6 col-lg-4">
			<div class="card bg-light mb-3" style="max-width: 25rem;">
				<div class="card-header">
					Vorname:
					<b>
						<xsl:value-of select="@fName" />
					</b>
					<br />
					Nachname:
					<b>
						<xsl:value-of select="@lName" />
					</b>
				</div>
				<div class="card-body">
					<ul>
						<li>
							Instrument Type:
							<xsl:value-of select="id(PersonInstrumentType/@instrumentTypeID)/@name" />
						</li>

						<li>
							Date of Birth:
							<xsl:value-of select="@dateOfBirth" />
						</li>
						<li>
							eMail:
							<xsl:value-of select="@eMailAddress" />
						</li>
						<li>
							Telefon:
							<xsl:value-of select="@phoneNumber" />
						</li>

						<xsl:choose>
							<xsl:when test="@isActive ='false'">
								<li>
									State: inaktiv
								</li>
							</xsl:when>
							<xsl:otherwise>
								<li>
									State: aktiv
								</li>
							</xsl:otherwise>
						</xsl:choose>
					</ul>
					<p>
						<a class="btn btn-primary" href="#{PersonInstrumentType/@instrumentTypeID}"
							role="button">View Instrument Type »</a>
					</p>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>