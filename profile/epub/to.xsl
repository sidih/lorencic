<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../sistory/epub3/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
   
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <xsl:param name="coverimage">cover-page.jpg</xsl:param>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodatno za kolofon: procesiranje idno</desc>
   </doc>
   <xsl:template match="tei:publicationStmt" mode="kolofon">
      <xsl:apply-templates select="tei:publisher" mode="kolofon"/>
      <xsl:apply-templates select="tei:date" mode="kolofon"/>
      <xsl:apply-templates select="tei:pubPlace" mode="kolofon"/>
      <xsl:apply-templates select="tei:availability" mode="kolofon"/>
      <xsl:apply-templates select="tei:idno" mode="kolofon"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:idno" mode="kolofon">
      <p>
         <xsl:choose>
            <xsl:when test="matches(.,'https?://')">
               <a href="{.}">
                  <xsl:value-of select="."/>
               </a>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(@type,' ',.)"/>
            </xsl:otherwise>
         </xsl:choose>
      </p>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodam ceno za licenco in pred CIP</desc>
   </doc>
   <xsl:template match="tei:availability" mode="kolofon">
      <xsl:apply-templates select="tei:licence" mode="kolofon"/>
      <p>Cena: brezplačna publikacija</p>
      <xsl:if test="tei:p[@rend='ciptitle']">
         <div class="CIP-obroba">
            <xsl:apply-templates select="tei:p[@rend='ciptitle']"/>
            <xsl:apply-templates select="tei:p[@rend='cip']"/>
            <xsl:for-each select="ancestor::tei:publicationStmt/tei:idno[@type='ISBN']">
               <p>
                  <!-- ista publikacija ima lahko več ISBN številk, vsako za svoj format -->
                  <!-- različne ISBN številke zapisem kot nove elemente idno, ki so childreni glavnega elementa idno -->
                  <xsl:for-each select="tei:idno">
                     <span itemprop="isbn"><xsl:value-of select="."/></span>
                     <xsl:choose>
                        <xsl:when test="position() eq last()"><!-- ne dam praznega prostora --></xsl:when>
                        <xsl:otherwise>
                           <br />
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
               </p>
            </xsl:for-each>
            <xsl:apply-templates select="tei:p[@rend='cip-editor']"/>
            <xsl:for-each select="ancestor::tei:publicationStmt/tei:idno[@type='cobiss']">
               <p>
                  <xsl:value-of select="."/>
               </p>
            </xsl:for-each>
         </div>
      </xsl:if>
      <!-- vstavljena HTML koda za CIP -->
      <xsl:if test="tei:p[@rend='CIP']">
         <div class="CIP-obroba">
            <p>
               <xsl:value-of select="tei:p[@rend='CIP']" disable-output-escaping="yes"/>
            </p>
         </div>
      </xsl:if>
   </xsl:template>
   
   
   
</xsl:stylesheet>
