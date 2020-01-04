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
       encoding="iso-8859-2"
       indent="yes"
       saxon:character-representation="native;decimal"
       xmlns:saxon="http://icl.com/saxon" />

  <xsl:template match="/" >
     <xsl:variable name='razem' select='count(//item)'/>
     <xsl:variable name='dystans' select='sum(//item/@dist)'/>

     <xsl:call-template name='print.head'/>

     <xsl:for-each select='//year/month'>
        <xsl:text>% MONTH: </xsl:text>
        <xsl:call-template name='drukuj-mc'>
         <xsl:with-param name='mc' select='@no'/>
        </xsl:call-template>
        <xsl:text> =======================================&#10;</xsl:text>
        <xsl:for-each select='day[ride] | comment'>
          <xsl:choose>
           <xsl:when test='local-name() = "comment"'>
             <xsl:text>%# </xsl:text>
              <xsl:value-of select='@date' />
              <xsl:text>: </xsl:text>
              <xsl:value-of select='translate(., "&#10;", " ")' />
             <xsl:text>&#10;</xsl:text>
           </xsl:when>
           <xsl:otherwise>
             <xsl:value-of select='@date' />
             <xsl:text> | </xsl:text>
             <xsl:value-of select='ride/@dist' />
             <xsl:text> | </xsl:text>
             <xsl:value-of select='ride/@dist' />
             <xsl:text> | </xsl:text>
             <xsl:value-of select='ride/@exdist' />
             <xsl:text> | </xsl:text>
             <xsl:call-template name='wypisz-gdzie-to-bylo' />
             <xsl:text> ;; </xsl:text>
             <xsl:call-template name='dist-on-bike'>
               <xsl:with-param name='curr.bike' select='ride/@bike' />
             </xsl:call-template>
             <xsl:if test='ride/@mean'>
                <xsl:text> ;; m=</xsl:text>
                <xsl:value-of select='ride/@mean' />
             </xsl:if>
             <xsl:if test='comment | ride/comment'>
               <xsl:text> ;; </xsl:text>
               <xsl:if test='comment'>
                 <xsl:value-of select='comment' />
                 <xsl:text> ; </xsl:text>
               </xsl:if>
               <xsl:value-of select='ride/comment' />
             </xsl:if>
             <!-- ;;; -->
             <xsl:text>&#10;</xsl:text>
           </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
     </xsl:for-each>

     <xsl:call-template name='print.foot'/>

  </xsl:template>

  <xsl:template match='comment' />

  <xsl:template name='dist-on-bike'>
   <xsl:param name='curr.bike'/>
      <xsl:value-of select='$curr.bike'/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select='sum(preceding::ride[@bike=$curr.bike]/@dist) + ride/@dist'/>
      <!--
      <xsl:text> ;; </xsl:text>
       -->
  </xsl:template>

  <xsl:template name='wypisz-gdzie-to-bylo'>
    <xsl:for-each select='ride/by'>
      <xsl:value-of select="@name"/>
      <!-- nie ma przecinka po ostatnim -->
      <xsl:if test='position() != last()'>
        <xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test='@mean'>
     <xsl:text> (śr.&#160;</xsl:text>
     <xsl:value-of select='@mean'/>
     <xsl:text>&#160;km/h)</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="print.foot">
   <xsl:text>% MONTH: Lastmonth =========================================&#10;</xsl:text>
   <xsl:text>% DATAEND ==================================================&#10;</xsl:text>

  </xsl:template>

  <xsl:template name="print.head">
   <xsl:text>% GENERATED FILE DO NOT EDIT !!!! ===========================&#10;</xsl:text>
   <xsl:text>% TARGETDIST = 5001 =========================================&#10;</xsl:text>
   <xsl:text>% DATASTART </xsl:text>
     <xsl:value-of select="year/@no"/>
   <xsl:text> ======================================&#10;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
