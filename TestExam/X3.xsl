<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:key name="airport-index" match="/timetable/airport" use="@id"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>Vienna International Airport - Timetables</title>
      </head>
      <body>
        <h1>Departures</h1>
        <table border="1px">
          <tr><th>Sched.</th><th>Flight</th><th>to</th></tr>
          <xsl:apply-templates select="timetable/flight[departure/@airport-id='vie']" mode="departure"/>
        </table>
        
        <h1>Arrivals</h1>
        <table border="1px">
          <tr><th>Sched.</th><th>Flight</th><th>from</th></tr>
          <xsl:apply-templates select="timetable/flight[arrival/@airport-id='vie']" mode="arrival"/>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <!-- here comes your work -->
  <xsl:template match='flight' mode='departure'>
  	<xsl:call-template name="table-row">
  		<xsl:with-param name="deptArr" select="departure"/>
  		<xsl:with-param name="flight" select="."/>
  		<xsl:with-param name="airport-id" select="arrival/@airport-id"/>
  	</xsl:call-template>
  </xsl:template>
  
  <xsl:template match='flight' mode='arrival'>
  	<xsl:call-template name="table-row">
  		<xsl:with-param name="deptArr" select="arrival"/>
  		<xsl:with-param name="flight" select="."/>
  		<xsl:with-param name="airport-id" select="departure/@airport-id"/>
  	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="table-row">
  	<xsl:param name="deptArr"/>
  	<xsl:param name="flight"/>
  	<xsl:param name="airport-id"></xsl:param>
  	<tr>
  		<td><xsl:value-of select="$deptArr/time[@zone='local']/@time"/></td>
  		<td><xsl:value-of select="concat($flight/@operator-id, ' ', $flight/@nr)"/></td>
  		<td><xsl:value-of select="id($airport-id)/name[@lang='en']"/></td>
  	</tr>  	
  </xsl:template>

  <xsl:template match='flight' mode='departure-alt'>
	 <tr>
  		<td><xsl:value-of select="departure/time[@zone='local']/@time"/></td>
  		<td><xsl:value-of select="concat(@operator-id, ' ', @nr)"/></td>
  		<td><xsl:value-of select="id(arrival/@airport-id)/name[@lang='en']"/></td>
  	</tr>  	
  </xsl:template>
    
  <xsl:template match='flight' mode='arrival-alt'>
	 <tr>
  		<td><xsl:value-of select="arrival/time[@zone='local']/@time"/></td>
  		<td><xsl:value-of select="concat(@operator-id, ' ', @nr)"/></td>
  		<td><xsl:value-of select="id(departure/@airport-id)/name[@lang='en']"/></td>
  	</tr>  	
  </xsl:template>

</xsl:stylesheet>
