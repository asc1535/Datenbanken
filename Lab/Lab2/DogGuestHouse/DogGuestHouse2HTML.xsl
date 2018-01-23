<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" href="style.css"/>
				<title>Dog Guest House</title>
			</head>
			<body>
				<h1>Dog Guest House</h1>
					
				<xsl:call-template name="CustomersTable"/>
				
				<xsl:call-template name="SingleCustomerTable"/>
				
			    <xsl:call-template name="Dogs"/> 
			    
			    <xsl:call-template name="Reservations" />
			    
			    <xsl:call-template name="Stock"/> 
		
			</body>
		</html>
	</xsl:template>
	

<!-- Customer Information -->
	<xsl:template name="CustomersTable">
	<div class="block">
		<h2>Customer Table</h2>
		<table id="customerTable">
			<thead>
				<tr>
					<th colspan="2">First Name</th>
					<th colspan="2">Last Name</th>
					<th colspan="2">Telephone Number</th>
					<th colspan="2">Address</th>
					<th colspan="2">City</th>
					<th colspan="2">Postal Code</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="/dogguesthouse/customer" mode="table" />
			</tbody>
		</table>
	</div>
	</xsl:template>
	
	<xsl:template match="customer" mode="table">
		<tr onclick="location.href='#{@id}'" >
			<td colspan="2"><xsl:value-of select="@fname" /></td>
			<td colspan="2"><xsl:value-of select="@lname" /></td>
			<td colspan="2"><xsl:value-of select="@telephone_nr" /></td>
			<td colspan="2"><xsl:value-of select="@address" /></td>
			<td colspan="2"><xsl:value-of select="@city" /></td>
			<td colspan="2"><xsl:value-of select="@postal_code" /></td>
		</tr>	
	
	</xsl:template>
	
<!-- Customer Dogs relation -->
	<xsl:template name="SingleCustomerTable">
	<div class="block">
		<h2>Customers</h2>
			<xsl:apply-templates select="/dogguesthouse/customer" mode="list" />
	</div>
	</xsl:template>
	
	<xsl:template match="customer" mode="list">
		<div class="customerEntry">
			<h3 id="{@id}" xml:space="preserve">
				<xsl:value-of select="@fname " /> <xsl:value-of select="@lname" />
			</h3>
			<table class="customer">
				<thead>
					<tr>
						<th>Information</th>
						<th>Dogs</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<p>
								Telephone Number: <xsl:value-of select="@telephone_nr" /><br/>
								Address: <xsl:value-of select="@address" /><br/>
								City: <xsl:value-of select="@city" /> <br/>
								Postal Code: <xsl:value-of select="@postal_code" />
							</p>
						</td>
						<td>
							<ul>
								<xsl:apply-templates select="dog" mode="DogName" />
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</xsl:template>
	
	<xsl:template match="dog" mode="DogName">
	<li><a href="#{@id}">
		<xsl:value-of select="@name" /> - <xsl:value-of select="@breed_name" />
	</a></li>
	</xsl:template>
	
<!-- Dog Information -->
	<xsl:template name="Dogs">
	<div class="block">
		<h2>Dog Information</h2>
		<xsl:apply-templates select="/dogguesthouse/customer/dog" mode="DogInfo" />
	</div>		
	</xsl:template>
	
	<xsl:template match="dog" mode="DogInfo">
	<div class="dog">
		<h3 id="{@id}"><xsl:value-of select="@name" /></h3>
		<p>Information:</p>
		<ul>
			<li >Owner:<a href="#{../@id}" xml:space="preserve">
				<xsl:value-of select="../@fname " /> <xsl:value-of select="../@lname" />
			 </a></li>
			<li>Size: <xsl:value-of select="@size" /></li>
			<li>Gender: <xsl:value-of select="@gender" /></li>
			<li>Breed: <xsl:value-of select="@breed_name" /></li>
		</ul>
		<table>
			<thead>
				<tr>
					<th>Needs</th>
					<th>Medical Support</th>
					<th>Feedingroutine</th>
					<th>Food</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<ul>
							<xsl:for-each select="need">
								<li><xsl:value-of select="@description" /></li>
							</xsl:for-each>
						</ul>
					</td>
					<td>
						<ul>
							<xsl:for-each select="medical_support">
								<li>
									<p>
										<xsl:value-of select="@name" /><br/>
										<xsl:value-of select="@description" /><br/>
										Start Date: <xsl:value-of select="@start_date" /><br/>
										End Date: <xsl:value-of select="@end_date" />
										
									</p>
								</li>
							</xsl:for-each>
						</ul>
					</td>					
					<td>
						<table>
							<thead>
								<tr>
									<th>Time</th>
									<th>Food</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="feedingroutine" />
							</tbody>
						</table>
					</td>
					<td>
						<ul>
							<xsl:for-each select="is_fed">
								<li>
									<a href="#{@food_id}">
									<xsl:value-of select="id(@food_id)/@brand" /> - 
									<xsl:value-of select="id(@food_id)/@product_name" />
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</xsl:template>
	
	<xsl:template match="feedingroutine">
		<tr>
			<td><p>
				<xsl:for-each select="takes_place">
					<xsl:value-of select="id(@feedingtime_id)/@daytime" /><br/>
				</xsl:for-each>
			</p></td>
			<td><p>
				<xsl:for-each select="serves">
					<xsl:value-of select="id(@food_id)/@product_name" /><br/>
				</xsl:for-each>
			</p></td>
		</tr>
	</xsl:template>
	
<!-- Stock  -->

	<xsl:template name="Stock">
		<div class="block">
			<h2>Stock</h2>
			<table>
				<thead>
					<tr>
						<th>Brand</th>
						<th>Name</th>
						<th>Size</th>
						<th>On Stock</th>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="/dogguesthouse/food" />
				</tbody>
			</table>
			
		</div>
	</xsl:template>
	
	<xsl:template match="food">
		<tr>
			<td id="{@id}"><xsl:value-of select="@brand" /></td>
			<td><xsl:value-of select="@product_name" /></td>
			<td><xsl:value-of select="@size" /></td>
			<td><xsl:value-of select="@stock" /> Stk.</td>
		</tr>
	</xsl:template>
	
	
<!-- Reservations -->
		<xsl:template name="Reservations">
		<div class="block">
			<h2>Reservations</h2>	
			<table>
				<thead>
					<tr>
						<th>Begin</th>
						<th>End</th>
						<th>Customer</th>
						<th>Dog</th>
						<th>Sleep Space</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="/dogguesthouse/reservation">
						<xsl:sort select="@start_date_time"/>
						<tr>
							<td><xsl:value-of select="@start_date_time" /></td>
							<td><xsl:value-of select="@end_date_time" /></td>
							<td><a href="#{@customer_id}" xml:space="preserve">
								<xsl:value-of select="id(@customer_id)/@fname" /> 
								<xsl:value-of select="id(@customer_id)/@lname" />
							</a></td>
							<td><a href="#{@dog_id}">
								<xsl:value-of select="id(@dog_id)/@name" />
							</a></td>
							<td xml:space="preserve">
								<xsl:value-of select="@sleep_space_number" /> 
								<xsl:value-of select="id(@sleep_space_number)/@size" />
							</td>
						</tr>
					</xsl:for-each>	
				</tbody>
			</table>	
		</div>
		</xsl:template>
</xsl:stylesheet>