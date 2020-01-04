<?xml version="1.0" encoding="iso-8859-2"?>
<!-- $Id: r2txt.xsl,v 1.1 2007/01/02 12:02:00 tomek Exp $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- (c) t. przechlewski, 2004,2005 (tomasz@gnu.univ.gda.pl)
  ..  Zezwala sie na wykorzystanie na warunkach licencji GPL
  ..  patrz: http://www.gnu.org/licenses/gpl.html 
  ..  Konwersja do starego formatu, na którym działa skrypt awk 
  -->

<xsl:import href="r-util.xsl"/>

  <xsl:output method="text"
       encoding="utf-8"
       indent="yes"/>

<xsl:strip-space elements="item year month"/>

  <xsl:template match="//item" >


    <xsl:value-of select='@data'/>
    <xsl:text>;</xsl:text>
    <xsl:value-of select='@dist'/>
    <xsl:text>;</xsl:text>
    <xsl:choose>
      <xsl:when test='@gpx'>
      <xsl:value-of select='@gpx'/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>?</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
      
    <xsl:text>;</xsl:text>

    <xsl:choose>
      <xsl:when test='@bike'>
      <xsl:value-of select='@bike'/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>?</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text>;</xsl:text>
    <xsl:for-each select='by'>
      <xsl:value-of select='@name'/>
      <xsl:if test='@country != "pl"'>
	<xsl:text>[</xsl:text>
	<xsl:value-of select='@country'/>
	<xsl:text>]</xsl:text>
      </xsl:if>
      
      <xsl:if test='position() != last()'>
	<xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:for-each>
    
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

<xsl:template match="comment" >
</xsl:template>

</xsl:stylesheet>
