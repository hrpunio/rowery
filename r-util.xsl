<?xml version="1.0" encoding="iso-8859-2"?>
<!-- $Id: r-util.xsl,v 1.1 2007/01/02 12:01:59 tomek Exp $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- (c) t. przechlewski, 2004,2005 (tomasz@gnu.univ.gda.pl)
  .. Zezwala sie na wykorzystanie na warunkach licencji GPL
  .. patrz: http://www.gnu.org/licenses/gpl.html
  -->

  <xsl:template name='drukuj-do-mc'>
   <!-- Drukuje łączny dystans i liczbę wyjazdów od początku roku -->
    <xsl:param name='mc'/>
    <xsl:text> [od początku roku: </xsl:text>
    <xsl:value-of select="sum(//item[not(../@no &gt; $mc)]/@dist)"/>
    <xsl:text> km/ </xsl:text>
    <xsl:value-of select="count(//item[not(../@no &gt; $mc)]/@dist)"/>
    <xsl:text> razy]</xsl:text>
  </xsl:template>

  <xsl:template name='drukuj-mc'>
    <xsl:param name='mc'/>

    <xsl:choose>
      <xsl:when test='$mc = 1'>
        <xsl:value-of select="'Styczeń'"/>
      </xsl:when>
      <xsl:when test='$mc = 2'>
        <xsl:value-of select="'Luty'"/>
      </xsl:when>
      <xsl:when test='$mc = 3'>
        <xsl:value-of select="'Marzec'"/>
      </xsl:when>
      <xsl:when test='$mc = 4'>
        <xsl:value-of select="'Kwiecień'"/>
      </xsl:when>
      <xsl:when test='$mc = 5'>
        <xsl:value-of select="'Maj'"/>
      </xsl:when>
      <xsl:when test='$mc = 6'>
        <xsl:value-of select="'Czerwiec'"/>
      </xsl:when>
      <xsl:when test='$mc = 7'>
        <xsl:value-of select="'Lipiec'"/>
      </xsl:when>
      <xsl:when test='$mc = 8'>
        <xsl:value-of select="'Sierpień'"/>
      </xsl:when>
      <xsl:when test='$mc = 9'>
        <xsl:value-of select="'Wrzesień'"/>
      </xsl:when>
      <xsl:when test='$mc = 10'>
        <xsl:value-of select="'Październik'"/>
      </xsl:when>
      <xsl:when test='$mc = 11'>
        <xsl:value-of select="'Listopad'"/>
      </xsl:when>
      <xsl:when test='$mc = 12'>
        <xsl:value-of select="'Grudzień'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'** błąd **'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
