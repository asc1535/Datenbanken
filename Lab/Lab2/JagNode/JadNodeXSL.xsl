<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" />

	<xsl:template match="/">
		<html>
			<head>
				<title> Jag-Node</title>
				<style type="text/css">
					body {
					font-family: Arial;
					}
					img {
					width: 240px;
					float: left;
					}
					div>ul {
					float: left;
					font-size: 80%;
					}
					div {
					clear: both;
					display: table;
					}
					.em {
					background-color: yellow;
					font-size: 80%;
					}
					table, td, th {
					border: 1px
					solid #ddd;
					border-collapse: collapse;
					}
					th
					{
					font-size: 80%;
					}
				</style>
			</head>
			<body>
				<h1>JAG-Node</h1>
				<h2>Orders</h2>
				<ul>
					<xsl:apply-templates select="DBJagNode/Order"
						mode="toc" />
					<h2> Rolls</h2>
					<xsl:apply-templates select="DBJagNode/Roll"
						mode="toc" />
					<h2>Machines</h2>
					<xsl:apply-templates select="DBJagNode/Machine"
						mode="toc" />
				</ul>
				<xsl:apply-templates select="DBJagNode/Order"
					mode="content" />

				<xsl:apply-templates select="DBJagNode/Roll"
					mode="content" />

				<xsl:apply-templates select="DBJagNode/Machine"
					mode="content" />

				<h2>Fabric Types</h2>
				<table>
					<thead>
						<tr>
							<th>FabricType</th>
							<th>Order</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="DBJagNode/Order">
							<xsl:sort select="@FabricType" />
							<tr>
								<td>
									<xsl:value-of select="@FabricType" />
								</td>
								<td>
									<a href="#{@OrderID}">
										<xsl:value-of select="id(@OrderID)/@OrderID" />
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>

			</body>
		</html>
	</xsl:template>



	<xsl:template match="Order" mode="toc">
		<li xml:space="preserve">
			<a href="#{@OrderID}">
				<xsl:value-of select="id(@OrderID)" />
				<xsl:value-of select="@OrderID" /> - 
				<xsl:value-of select="@CreationTime" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Order" mode="content">

		<h2 id="{@OrderID}">
			<xsl:value-of select="id(@OrderID)" />

			<xsl:value-of select="@OrderID" />
		</h2>

		<div>
			<ul>
				<li>
					Position:
					<xsl:value-of select="@PositionID" />
				</li>
				<li>
					Fabric Type:
					<xsl:value-of select="@FabricType" />
				</li>
				<li>
					Maße:
					<table border="1">
						<tr>
							<td>Length</td>
							<td>
								<xsl:value-of select="@Length" />
							</td>
						</tr>
						<tr>
							<td>Width</td>
							<td>
								<xsl:value-of select="@Width" />
							</td>
						</tr>
					</table>
				</li>
				<li>
					Time:
					<table border="1">
						<tr>
							<td>Creation Time</td>
							<td>
								<xsl:choose>
									<xsl:when test="not(string(@CreationTime))">
										---
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@CreationTime" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<td>Cut Start Time</td>
							<td>
								<xsl:choose>
									<xsl:when test="not(string(@CutStartTime))">
										---
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@CutStartTime" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<td>Process Start Time</td>
							<td>
								<xsl:choose>
									<xsl:when test="not(string(@ProcessStartTime))">
										---
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@ProcessStartTime" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<th>Finish Time</th>
							<td>
								<xsl:choose>
									<xsl:when test="not(string(@FinishTime))">
										---
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@FinishTime" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</li>
				<li>
					<xsl:value-of select="@IdentityLevel" />
				</li>
				<li>
					Order Status:
					<xsl:value-of select="id(@OrderStatus)/@Status" />
					<xsl:value-of select="@Status" />
				</li>
				<li>
					Custom Data:
					<xsl:value-of select="@CustomData" />
				</li>
				<li>
					Stripe:
					<table border="1">
						<tr>
							<th>StripeID</th>
							<th>Width</th>
							<th>CustomData</th>
							<th>CutType</th>
							<th>Status</th>
							<th>RollenID</th>
							<th>MachineID</th>
						</tr>

						<xsl:for-each select="Stripe">
							<tr>

								<xsl:value-of select="id(@StripeID)" />

								<td>
									<xsl:value-of select="@StripeID" />
								</td>
								<td>
									<xsl:value-of select="@Width" />
								</td>
								<td>
									<xsl:value-of select="@CustomData" />
								</td>
								<td>
									<xsl:value-of select="@CutType" />
								</td>
								<td>
									<xsl:value-of select="@Status" />
								</td>
								<td>
									<a href="#{CutDefinition/@RollenID}"><xsl:value-of select="CutDefinition/@RollenID" /></a>
								</td>
								<td>
									<a href="#{CutDefinition/@MachineID}"><xsl:value-of select="CutDefinition/@MachineID" /></a>
								</td>
							</tr>
						</xsl:for-each>

					</table>

				</li>
			</ul>
		</div>
	</xsl:template>

	<xsl:template match="Roll" mode="toc">
		<li xml:space="preserve">
			<a href="#{@RollID}">
				<xsl:value-of select="id(RollID)" />
				<xsl:value-of select="@RollID" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Roll" mode="content">

		<h2 id="{@RollID}">
			<xsl:value-of select="id(@RollID)" />
			<xsl:value-of select="@RollID" /> - <xsl:value-of select="ArticleNo/FabricType/@Name" />
		</h2>
		<div>
			<table border="1">
				<tr>
					<td>RollId</td>
					<td><xsl:value-of select="@RollID" /></td>
				</tr>
				<tr>
					<td>Length</td>
					<td><xsl:value-of select="@Length" /></td>
				</tr>
				<tr>
					<td>ChargenID</td>
					<td><xsl:value-of select="@ChargenID" /></td>
				</tr>
				<tr>
					<td>CustomData</td>
					<td><xsl:value-of select="@CustomData" /></td>
				</tr>
				<tr>
					<td>ArticleNo</td>
					<td><xsl:value-of select="@ArticleNo" /></td>
				</tr>
				<tr>
					<td>RollStatus</td>
					<td><xsl:value-of select="@RollStatus" /></td>
				</tr>
				<tr>
					<td>ArticleNo</td>
					<td><xsl:value-of select="ArticleNo/@ArticleNo" /></td>
				</tr>
				<tr>
					<td>FabricType</td>
					<td><xsl:value-of select="ArticleNo/@FabricType" /></td>
				</tr>
				<tr>
					<td>FabricTypeName</td>
					<td><xsl:value-of select="ArticleNo/FabricType/@Name" /></td>
				</tr>
				<tr>
					<td>Width</td>
					<td><xsl:value-of select="ArticleNo/@Width" /></td>
					
				</tr>
			</table>
		</div>

	</xsl:template>

	<xsl:template match="Machine" mode="toc">
		<li xml:space="preserve">
			<a href="#{@MachineID}">
				<xsl:value-of select="id(MachineID)" />
				<xsl:value-of select="@Name" /> - 
				<xsl:value-of select="@MachineID" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="Machine" mode="content">

		<h2 id="{@MachineID}">
			<xsl:value-of select="id(@MachineID)" />
			<xsl:value-of select="@Name" />
		</h2>
		<div>
			<table border="1">
				<tr>
					<td>MachineID</td>
					<td>
						<xsl:value-of select="@MachineID" />
					</td>
				</tr>
				<tr>
					<td>Name</td>
					<td>
						<xsl:value-of select="@Name" />
					</td>
				</tr>
				<tr>
					<td>Type</td>
					<td>
						<xsl:value-of select="@Type" />
					</td>
				</tr>
			</table>
		</div>

	</xsl:template>

</xsl:stylesheet>