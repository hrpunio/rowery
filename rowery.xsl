<?xml version="1.0" encoding="iso-8859-2"?>
<!-- $Id: rowery.xsl,v 1.1 2007/01/02 12:02:00 tomek Exp $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<!-- (c) t. przechlewski, 2004,2005 (tomasz@gnu.univ.gda.pl) 
  .. Zezwala sie na wykorzystanie na warunkach licencji GPL
  .. patrz: http://www.gnu.org/licenses/gpl.html
  -->


<xsl:import href='r-util.xsl' />

<!-- http://www.sagehill.net/docbookxsl/OtherOutputForms.html -->
<!-- ten plik przetwarzamy za pomocą xsltproc                 -->
<!-- The nice thing about using xsltproc is that it detects that the DOCTYPE is XHTML and adjusts 
     the serialization of the output so it follows most of the HTML compatibility guidelines.
     This enables more browsers to be able the read the XHTML 
  -->
  <xsl:output method="xml"
       encoding="iso-8859-2"
       doctype-public="-//W3C//DTD XHTML 1.1//EN"
       doctype-system='http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd' 
       indent="yes"
       saxon:character-representation="native;decimal"
       xmlns:saxon="http://icl.com/saxon" />

  <xsl:param name='last-year' select='2015'/>
  <xsl:param name='first-year' select='"1993"'/>

  <!-- set RootDir/TopDir for another site -->
  <xsl:param name='RootDir' select="'http://gnu.univ.gda.pl/~tomasz'"/>
  <xsl:param name='TopDir' select="'http://gnu.univ.gda.pl/~tomasz'"/>

  <xsl:variable name='GPXMSDir' select="concat($RootDir,'/Geo/gpx/speed.html?t=')"/>
  <xsl:variable name='GPXDir' select="concat($RootDir,'/Geo/trasa.php?trasa=')"/>
  <xsl:variable name='KMLDir' select="concat($RootDir,'/Geo/kml/')"/>
  <xsl:variable name='GPXIconDir' select="concat($RootDir,'/icons')"/>
  <xsl:variable name='MyStravaDir' select="'http://www.strava.com/activities/365587664'"/>

 <xsl:variable name='GPXIcon' select="'50px-Gnome-globe-svg.png'"/> <!-- PNG files -->

 <xsl:variable name='stat-color' select='"#e4ffd0"'/>

  <xsl:variable name="miejsca" select="//by[not(@name=preceding::by/@name)]" />
  <!--
  <xsl:variable name='geoserv' select='"http://wayhoo.com/index.php"'/>
  -->


  <xsl:variable name='styleDir' select='concat($TopDir, "/style")'/>
  <xsl:variable name='scriptDir' select='concat($TopDir, "/script")'/>

  <xsl:variable name='trasyURL' select="concat($RootDir,'/rowery/trasy-pl.html')"/>


  <xsl:variable name='geoserv' 
   select="'http://www.mapquest.com/maps/map.adp?formtype=address&amp;searchtype=address&amp;'"/>
  
  <xsl:variable name='rok' select='/year/@no'/> 

 <xsl:template match="/" >
    <html>
      <head>
        <title>
          <xsl:text>Statystyka rowerowa Tomasza Przechlewskiego za rok </xsl:text>
          <xsl:value-of select='$rok' />
          <xsl:text> razem: </xsl:text>
          <xsl:value-of select='sum(//item/@dist)'/>
        </title>
        <meta name='DC.title' content='Statystyka rowerowa Tomasza Przechlewskiego za rok {$rok}'/>
        <meta name="DC.creator" content="Tomasz Przechlewski" />
        <meta name='DC.date' content='{$rok}'/>
        <meta name='DC.rights' content='(c) Tomasz Przechlewski'/>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-2"/>
        <!-- <link rel='stylesheet' type="text/css" href="../../tpstyle.css" /> -->
        <!-- style fancy, bw, big:             -->
        <link rel="stylesheet" type="text/css" href="{$styleDir}/tp-base.css" title='ES'/>        
        <!-- por. http://groups.google.pl/group/alt.html/browse_thread/thread/18c0694c1801700f/8fe385409f42a651 
        -->
        <script type="text/javascript" src="{$scriptDir}/sss.js"><xsl:text> </xsl:text></script>
      </head>
      <body>

        <xsl:variable name='razem' select='count(//item)'/>
        <xsl:variable name='dystans' select='sum(//item/@dist)'/>
        <xsl:variable name='razemMTB' select='count(//item[(@bike="g") or (@bike="mtb") or (@bike="traction")])'/>
        <xsl:variable name='dystansMTB' select='sum(//item[(@bike="g") or (@bike="mtb") or (@bike="traction")]/@dist)'/>

        <h3 class='main'>Statystyka rowerowa za rok <xsl:value-of select="year/@no"/></h3>

        <xsl:call-template name='print-header-footer'>
          <xsl:with-param name='total' select='$razem'/>
          <xsl:with-param name='dist' select='$dystans'/>
          <xsl:with-param name='totalmtb' select='$razemMTB'/>
          <xsl:with-param name='distmtb' select='$dystansMTB'/>
          <xsl:with-param name='pos' select='"top"'/>
        </xsl:call-template>
 
        <table class='cycstat'
          border='1' cellspacing='3' cellpadding='3' width='100%'>
          <tr class='main'>
            <td>Data
            </td>
            <td>Dystans
            </td>
            <td>Szczegóły trasy
            </td>
          </tr>

          <xsl:for-each select='//year/month '>
            <xsl:choose>
              <xsl:when test='local-name() = "comment"'>
                <!-- napotkano komentarz -->
                <xsl:call-template name='format-comment'/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select='item | comment'>
                  <xsl:choose>
                    <xsl:when test='local-name() = "comment"'>
                      <xsl:call-template name='format-comment'/>
                    </xsl:when>
                    <xsl:otherwise>
                     <tr>
                        <xsl:attribute name='class'>
                          <xsl:choose>
                            <xsl:when test='../@no mod 2 = 0'>
                              <xsl:text>even-m</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:text>odd-m</xsl:text>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                      <td>
                       <xsl:value-of select='@data' />
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test='@gpx'>
			    <!-- not working properly after google changed license 2018/9 -->
                            <!-- <a href='{$GPXMSDir}{@gpx}'> -->
                               <xsl:value-of select='@dist' />
                            <!-- </a> -->
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select='@dist' />
                          </xsl:otherwise>
                        </xsl:choose>
                        <!-- ;;;; -->
                        <xsl:if test='@typ = "w"'> 
                          <xsl:text>&#160;!</xsl:text>
                        </xsl:if>
                        <!-- jezeli rower gorski to zaznacz: -->
                        <xsl:if test='(@bike = "g") or (@bike = "mtb") or (@bike="traction")'>
                          <xsl:text>&#160;</xsl:text>
                          <img src='{$RootDir}/icons/icon_mountain.jpg'  
                            width='15px' alt='trasa: teren/mtb' title='trasa: teren/mtb' longdesc='[[icon_mountain.jpg' /> 
                        </xsl:if>
			<!-- -->
                        <xsl:if test='(@bike = "cx")'>
                          <xsl:text>&#160;</xsl:text>
                          <img src='{$RootDir}/icons/cxbike_icon.jpg'  
                            width='15px' alt='rower: cx' title='rower: cx' longdesc='[[cxbike_icon.jpg' />
                        </xsl:if>
                        <xsl:choose>
                        <xsl:when test='@strava'><!--Dodane sierpien 2015-->
                          <xsl:text>&#160;</xsl:text>
                          <!-- <a href='{$MyStravaDir}?utm_content={@strava}&amp;utm_medium=email&amp;utm_source=ride_share'>-->
                          <a href='{$MyStravaDir}?utm_content={@strava}&amp;utm_source=ride_share'>
                          <img src='{$RootDir}/icons/strava_icon.jpg'
                            width='15px' alt='strava' title='strava' longdesc='[[strava_icon.jpg' />
                          </a>
                        </xsl:when>
                        </xsl:choose>
                        <!-- -->
                      </td>
                      <td>
                       <xsl:call-template name='wypisz-gdzie-to-bylo' />
                      </td>
                     </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>

                <!-- podsumowanie m-ca, drukowane tylko wtedy,
                     jeżeli występuje co najmniej jeden `item':
                  -->
                <xsl:if test='item'>
                 <tr class='main'>
                  <td colspan='3'>
                    <xsl:call-template name='drukuj-mc'>
                      <xsl:with-param name='mc' select='@no'/>
                    </xsl:call-template>
                    <xsl:text> ogółem: </xsl:text>
                    <xsl:value-of select="count(item)"/>
                    <xsl:text> razy, </xsl:text>
                    <xsl:value-of select="sum(item/@dist)"/>

                    <xsl:text> km, średnio: </xsl:text>
                    <xsl:value-of select="sum(item/@dist) div count(item)"/>
                    <xsl:text> km</xsl:text>
                    <!-- jeżeli wartością @bike jest g lub mtb to jazda była w terenie -->
                    <xsl:if test="item[(@bike='g') or (@bike='mtb')]"> 
                      <xsl:text> [w&#160;tym MTB:&#160;</xsl:text>
		      <xsl:value-of select="count(item[(@bike='g') or (@bike='mtb')]/@dist)"/>
		      <xsl:text>/</xsl:text>
                      <xsl:value-of select="sum(item[(@bike='g') or (@bike='mtb')]/@dist)"/>
                      <xsl:text>&#160;km]</xsl:text>
                    </xsl:if> 

                    <xsl:call-template name='drukuj-do-mc'>
                      <xsl:with-param name='mc' select='@no'/>
                    </xsl:call-template>

                  </td>
                 </tr>
                </xsl:if>
              </xsl:otherwise>
           </xsl:choose>
          </xsl:for-each>
        </table>

        <xsl:if test='//year/comment'>
          <p>
            <xsl:for-each select='//year/comment'>
              <xsl:value-of select='.'/>
            </xsl:for-each>
          </p>
        </xsl:if>

        <xsl:call-template name='print-header-footer'>
          <xsl:with-param name='total' select='$razem'/>
          <xsl:with-param name='dist' select='$dystans'/>
          <xsl:with-param name='totalmtb' select='$razemMTB'/>
          <xsl:with-param name='distmtb' select='$dystansMTB'/>
          <xsl:with-param name='pos' select='"bot"'/>
        </xsl:call-template>
 

        <!-- Wykaz miejscowosci z linkiem na wayhoo.com; wayhoo zamknęli
             robimy link na mapquest -->
        <hr/>
        <p><strong>Wykaz wszystkich miejscowości</strong> 
             [uwaga: nie wszystkie linki są prawidłowe]:
        <xsl:for-each select='$miejsca'>
          <xsl:sort select='@name'/>
          <a>
          <xsl:attribute name='href'>
            <!--
            <xsl:value-of select="concat($geoserv, '?country=PL&amp;full_name_nd=')"/>
            -->
            <xsl:value-of select="$geoserv"/>
            <xsl:call-template name='display-name-of-place'>
              <xsl:with-param name='place-name' select='@name'/>
              <xsl:with-param name='place-country' select='@country'/>
            </xsl:call-template>
          <!--
          <xsl:value-of select="'&amp;submit=Search&amp;a=sgns&amp;results=1&amp;newsrch=1'"/>
          -->
          </xsl:attribute>
          <!--
          <a href="{concat($geoserv, 
                   '?country=PL&amp;full_name_nd=', 
                   @name,
                   '&amp;submit=Search&amp;a=sgns&amp;results=1&amp;newsrch=1')}">
            -->
           <xsl:value-of select='@name'/>
          </a>
          <xsl:text>&#160;(</xsl:text>
          <xsl:value-of select='count(//by[@name=current()/@name])'/>
          <xsl:text>) </xsl:text>
          <!-- <xsl:if test='position() != last()'>
             <xsl:text>, </xsl:text>             
           </xsl:if> -->
           <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
        <xsl:text>==&#160;razem&#160;:&#160;</xsl:text>
        <xsl:value-of select='count($miejsca)'/>
        <xsl:text>&#160;==</xsl:text>
        </p>

	<p><strong>
	  <xsl:text>Łączny przebieg od roku 1990: </xsl:text>
	  <xsl:value-of select='sum(//year/@done) + sum(//item/@dist)'/>
	  <xsl:text>&#160;km</xsl:text>
	  </strong>
	</p>

        <xsl:call-template name="foot"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name='display-name-of-place'>
    <xsl:param name='place-name'/>
    <xsl:param name='place-country'/>

    <!-- na wszelki wypadek sprawdzenie -->
    <xsl:choose>
      <xsl:when test='$place-country'>
        <xsl:variable name='place-country-code' select='$place-country'/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name='place-country-code' select='"PL"'/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text>country=</xsl:text>
    <xsl:value-of select='translate($place-country, 
        "abcdefghijklmnopqrstuvwxyz", 
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ")'/>
    <xsl:text>&amp;addtohistory=&amp;city=</xsl:text>
    <xsl:choose>
      <xsl:when test='$place-name="Wiczlińska"'>
        <xsl:value-of select='"Wiczlino"'/>
      </xsl:when>
      <xsl:when test='$place-name="Czymanowo.GZE"'>
        <xsl:value-of select='"Czymanowo"'/>
      </xsl:when>
      <xsl:when test='$place-name="Osowa.Rondo"'>
        <xsl:value-of select='"Osowa"'/>
      </xsl:when>
      <xsl:when test='$place-name="OravskyPodzamok"'>
        <xsl:value-of select='"Oravsky Podzamok"'/>
      </xsl:when>
      <xsl:when test='$place-name="NowyDwórWejherowski"'>
        <xsl:value-of select='"Nowy%20Dwor%20Wejherowski"'/>
      </xsl:when>
      <xsl:when test='$place-name="SanCarlo"'>
        <xsl:value-of select='"San%20Carlo"'/>
      </xsl:when>
      <xsl:otherwise>
        <!-- bez polskich, bo amerykanie uzywaja 7 bitow -->
        <xsl:value-of select='translate($place-name, "ąćęłńóśźżĆŁŃÓŚŹŻ", "acelnoszzCLNOSZZ")'/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match='comment' />

  <xsl:template name='format-comment'>
    <tr class='comment'>
     <td>
     <xsl:value-of select='@data'/>
    </td>
    <td colspan='2'>
     <xsl:apply-templates/>
    </td>
   </tr>
  </xsl:template>

  <xsl:template name='wypisz-gdzie-to-bylo'>
    <!-- dodane 14.10.2006 -->
    <!-- dodaj id trasy -->
    <xsl:if test='@id'>
      <a href="{$trasyURL}#{@id}">
        <xsl:value-of select='@id'/>
      </a>
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:for-each select='by'>
      <xsl:value-of select="@name"/>
      <!-- nie ma przecinka po ostatnim -->
      <xsl:if test='position() != last()'>
        <!-- <xsl:text>, </xsl:text> -->
        <!-- tak chyba jest ładniej: -->
        <xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test='@mean'>
     <xsl:text> (śr.&#160;</xsl:text>
     <xsl:value-of select='@mean'/>
     <xsl:text>&#160;km/h)</xsl:text>
    </xsl:if>

  <xsl:if test='@gpx'>
     <a href='{$GPXDir}{@gpx}'>
        <img alt="[Google Maps]" title="[Google Maps]" width="20" longdesc="[[{$GPXIcon}" src='{$GPXIconDir}/{$GPXIcon}'/>
     </a>
     <!-- plik źródłowy -->
     <a href='{$RootDir}/Geo/gpx/{@gpx}.xml'>
        <img alt="[GPX File]" title="[GPX File]" width="33" longdesc="[[xml-icon.gif" src='{$GPXIconDir}/xml-icon.gif'/>
     </a>
   </xsl:if>

   <xsl:if test='@kml'>
     <xsl:text>&#160;</xsl:text>
     <a href='{$KMLDir}{@kml}.kml'><!-- nazwa bez rozszerzenia -->
        <img alt="[Google Earth]" title="[Google Earth file]" width="25" longdesc="[[ge_icon.jpg" 
             src='{$GPXIconDir}/ge_icon.jpg'/>
     </a>
   </xsl:if>

  </xsl:template>

  <xsl:template name="foot">
    <hr/>

    <p><a href="../rowery-pl.html"><img src="../../icons/back.png" longdesc="##back.png"
      alt="Powrót"/>Powrót</a>
    </p>

    <hr/>
    <p>(c) T.Przechlewski <xsl:value-of select="/year/@no" /></p>
  </xsl:template>

<xsl:template name='print-header-footer'>
  <!-- liczba wyjazdów łącznie: -->
  <xsl:param name='total'/>
  <!-- dystans łącznie: -->
  <xsl:param name='dist'/>
  <!-- dystans mtb łącznie: -->
  <xsl:param name='totalmtb'/>
  <xsl:param name='distmtb'/>
  <!-- pozycja: góra/dół tabeli z wynikami szczegółowymi -->
  <xsl:param name='pos'/>
 
  <table style='font-weight: bold' width='100%' id='{$pos}'><tr>
  <td style='text-align: left'>
    <xsl:if test='year/@no > $first-year'> 
      <a href="./c{year/@no - 1}.html#{$pos}">[[poprz]]</a>
    </xsl:if>
  </td><td style='text-align: center'>
  [[Ogółem:
  <xsl:value-of select='$total' />
    <xsl:text> razy, </xsl:text> 
    Dystans:
    <xsl:value-of select='$dist' />
      <xsl:text> km</xsl:text>
      <xsl:if test="$distmtb &gt; 0"> 
        <xsl:text> [w&#160;tym MTB:&#160;</xsl:text>
         <xsl:value-of select="$totalmtb"/>
	 <xsl:text>/</xsl:text>
         <xsl:value-of select="$distmtb"/>
        <xsl:text>&#160;km]</xsl:text>
      </xsl:if> 
      <xsl:text>. </xsl:text>
      Średnio:
      <xsl:value-of select='$dist div $total' />
        km.]]
      </td><td style='text-align: right'>
      <xsl:if test='year/@no &lt; $last-year'> 
      <a href="./c{year/@no + 1}.html#{$pos}">[[nast]]</a>
    </xsl:if>
  </td></tr>
</table>

</xsl:template>

</xsl:stylesheet>
