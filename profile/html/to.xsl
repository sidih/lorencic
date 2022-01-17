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

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>
   
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
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   
   
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>
   
   <xsl:param name="homeLabel">SI-DIH</xsl:param>
   <xsl:param name="homeURL">https://sidih.si/20.500.12325/1874</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <xsl:param name="documentationLanguage">en</xsl:param>
   
   <xsl:param name="languages-locale">true</xsl:param>
   <xsl:param name="languages-locale-primary">en</xsl:param>
      
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">FROM DREAMS OF A SECOND SWITZERLAND' TO CAPITALISM WITHOUT A HUMAN FACE</xsl:param>
   <xsl:param name="keywords">Economic systems, transition, Slovenia, Economy, 1990-, Economic history, Proceedings</xsl:param>
   <xsl:param name="title">FROM DREAMS OF A SECOND SWITZERLAND' TO CAPITALISM WITHOUT A HUMAN FACE The Path of Economic Independence and Slovenian Economic Transition</xsl:param>
               
   <!-- KAZALO SLIK -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Odstranil procesiranje tei:figure[@type='table']</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="images">
      <xsl:param name="thisLanguage"/>
      <!-- izpiše vse slike -->
      <ul class="circel">
         <xsl:for-each select="//tei:figure[if ($languages-locale='true') then ancestor::tei:div[@xml:id][@xml:lang=$thisLanguage] else @xml:id][tei:graphic][not(@type='chart')][not(@type='table')]">
            <xsl:variable name="figure-id" select="@xml:id"/>
            <xsl:variable name="image-chapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>
            <xsl:variable name="sistoryPath">
               <xsl:if test="$chapterAsSIstoryPublications='true'">
                  <xsl:call-template name="sistoryPath">
                     <xsl:with-param name="chapterID" select="$image-chapter-id"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:variable>
            <li>
               <a href="{concat($sistoryPath,$image-chapter-id,'.html#',$figure-id)}">
                  <!-- V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe -->
                  <xsl:apply-templates select="tei:head" mode="slika"/>
               </a>
            </li>
         </xsl:for-each>
      </ul><!-- konec procesiranja slik -->
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe</desc>
   </doc>
   <xsl:template match="tei:head" mode="slika">
      <xsl:apply-templates mode="slika"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe</desc>
   </doc>
   <xsl:template match="tei:note" mode="slika">
      
   </xsl:template>
   
   <!-- KAZALO TABEL -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Namesto tei:table procesira tei:figure[@type='table']</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="tables">
      <xsl:param name="thisLanguage"/>
      <!-- izpiše vse tabele, ki imajo naslov (s tem filtriramo tiste tabele, ki so v okviru grafikonov) -->
      <ul class="circel">
         <xsl:for-each select="//tei:table[@type='table'][if ($languages-locale='true') then ancestor::tei:div[@xml:id][@xml:lang=$thisLanguage] else @xml:id][tei:head]">
            <xsl:variable name="table-id" select="@xml:id"/>
            <xsl:variable name="table-chapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>
            <xsl:variable name="sistoryPath">
               <xsl:if test="$chapterAsSIstoryPublications='true'">
                  <xsl:call-template name="sistoryPath">
                     <xsl:with-param name="chapterID" select="$table-chapter-id"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:variable>
            <li>
               <a href="{concat($sistoryPath,$table-chapter-id,'.html#',$table-id)}">
                  <!-- V kazalih slik pri naslovih slik prikažem le besediilo naslova, brez besedila opombe -->
                  <xsl:apply-templates select="tei:head" mode="slika"/>
               </a>
            </li>
         </xsl:for-each>
      </ul><!-- konec procesiranja slik -->
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> NASLOVNA STRAN </xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <xsl:if test="tei:graphic">
         <div class="text-center">
            <p>
               <img src="{tei:graphic/@url}" alt="naslovna slika" style="max-height: 800px;"/>
            </p>
         </div>
      </xsl:if>
   </xsl:template>
   
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
   
   <!-- odstranim pri spodnji param true zaradi oštevilčenja naslovov-->
   <xsl:param name="numberHeadings"></xsl:param>
   
</xsl:stylesheet>
