<?xml version="1.0" encoding="iso-8859-2"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<!-- (c) t. przechlewski, 2004 (tomasz@gnu.univ.gda.pl)                 -->
<!-- Zezwala sie na wykorzystanie na warunkach licencji GPL             -->
<!-- patrz: http://www.gnu.org/licenses/gpl.html                        -->

  <xsl:output method="xml"
       encoding="iso-8859-2"
       indent="yes"
       saxon:character-representation="native;decimal"
       xmlns:saxon="http://icl.com/saxon" />

  <xsl:template match="year" >
    <xsl:text>&#10;</xsl:text>
    <xsl:processing-instruction name='xml-stylesheet'>
     <xsl:text>href='rowery.xsl' type='text/xsl'</xsl:text>
    </xsl:processing-instruction>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>Generated file *** do not edit ***</xsl:comment>
    <year no='{@no}' done='{@done}'>
      <xsl:apply-templates />
    </year>
  </xsl:template>

  <xsl:template match="month" >
    <month no='{@no}'>
      <xsl:apply-templates />
    </month>
  </xsl:template>

  <xsl:template match="year/comment | month/comment" >
    <xsl:choose>
      <xsl:when test='@date'>
      <comment data='{@date}'>
        <xsl:apply-templates />
      </comment>
    </xsl:when>
    <xsl:otherwise>
      <comment>
        <xsl:apply-templates />
      </comment>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

  <!-- komentarzy dziennych nie publikujemy: -->
  <xsl:template match="day/comment" />

  <xsl:template match="ride" >
    <item data='{../@date}' >
      <xsl:for-each select='@*'>
        <xsl:attribute name='{local-name()}'>
          <xsl:value-of select='.'/>
        </xsl:attribute>
      </xsl:for-each>
      <xsl:for-each select='by'>
        <by>
        <!-- <by name='{@name}'/>-->
        <xsl:for-each select='@*'>
          <xsl:attribute name='{local-name()}'>
            <xsl:value-of select='.'/>
          </xsl:attribute>
        </xsl:for-each>
        </by>
      </xsl:for-each>
    </item>
  </xsl:template>

</xsl:stylesheet>
