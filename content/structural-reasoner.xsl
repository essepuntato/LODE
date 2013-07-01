<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2010-2013, Silvio Peroni <essepuntato@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0"
    xmlns:f="http://www.essepuntato.it/xslt/function"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:owl="http://www.w3.org/2002/07/owl#">
    
    <!-- DISJOINT: begin -->
    <xsl:variable name="disjoints">
        <xsl:variable name="temp">
                <xsl:for-each select="/rdf:RDF/(owl:Class|owl:ObjectProperty|owl:DatatypeProperty|owl:AnnotationProperty|owl:NamedIndividual)[owl:disjointWith[@rdf:resource]]">
                    <xsl:variable name="id" select="@rdf:about|@rdf:ID" />
                    <xsl:for-each select="owl:disjointWith/@rdf:resource">
                        <disjoint rdf:about="{$id}" rdf:resource="{.}" />
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="/rdf:RDF/rdf:Description[exists(rdf:type[@rdf:resource = 'http://www.w3.org/2002/07/owl#AllDisjointClasses'])]">
                    <xsl:variable name="descriptions" select="(owl:members/rdf:Description/(@rdf:about|@rdf:ID))" as="attribute()+" />
                    <xsl:variable name="last" select="count($descriptions) - 1" as="xs:integer" />
                    <xsl:for-each select="1 to $last">
                        <xsl:variable name="pos" select="." />
                        <xsl:variable name="id" select="$descriptions[$pos]" />
                        <xsl:for-each select="$pos to $last">
                            <xsl:variable name="current" select=". + 1" as="xs:integer" />
                            <disjoint rdf:about="{$id}" rdf:resource="{$descriptions[$current]}" />
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="removeDuplicates">
            <xsl:with-param name="temp" select="$temp" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:function name="f:getDisjoints" as="attribute()*">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:getSomething($disjoints,$element)" />
    </xsl:function>
    
    <xsl:function name="f:hasDisjoints" as="xs:boolean">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:hasSomething($disjoints,$element)" />
    </xsl:function>
    <!-- DISJOINT: end -->
    
    <!-- SAME AS: begin -->
    <xsl:variable name="sameas">
        <xsl:variable name="temp">
            <xsl:for-each select="/rdf:RDF/(owl:Class|owl:ObjectProperty|owl:DatatypeProperty|owl:AnnotationProperty|owl:NamedIndividual)[owl:sameAs[@rdf:resource]]">
                <xsl:variable name="id" select="@rdf:about|@rdf:ID" />
                <xsl:for-each select="owl:sameAs/@rdf:resource">
                    <sameas rdf:about="{$id}" rdf:resource="{.}" />
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="removeDuplicates">
            <xsl:with-param name="temp" select="$temp" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:function name="f:getSameAs" as="attribute()*">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:getSomething($sameas,$element)" />
    </xsl:function>
    
    <xsl:function name="f:hasSameAs" as="xs:boolean">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:hasSomething($sameas,$element)" />
    </xsl:function>
    <!-- SAME AS: end -->
    
    <!-- EQUIVALENT ENTITY: begin -->
    <xsl:variable name="equivalent">
        <xsl:variable name="temp">
            <xsl:for-each select="/rdf:RDF/(owl:Class|owl:ObjectProperty|owl:DatatypeProperty)[(owl:equivalentClass|owl:equivalentProperty)[@rdf:resource]]">
                <xsl:variable name="id" select="@rdf:about|@rdf:ID" />
                <xsl:for-each select="(owl:equivalentClass|owl:equivalentProperty)/@rdf:resource">
                    <equivalent rdf:about="{$id}" rdf:resource="{.}" />
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="removeDuplicates">
            <xsl:with-param name="temp" select="$temp" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:function name="f:getEquivalent" as="attribute()*">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:getSomething($equivalent,$element)" />
    </xsl:function>
    
    <xsl:function name="f:hasEquivalent" as="xs:boolean">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="exists($element/(owl:equivalentClass | owl:equivalentProperty)) or f:hasSomething($equivalent,$element)" />
    </xsl:function>
    <!-- EQUIVALENT ENTITY: end -->
    
    <!-- INVERSE PROPERTY: begin -->
    <xsl:variable name="inverseproperty">
        <xsl:variable name="temp">
            <xsl:for-each select="/rdf:RDF/(owl:ObjectProperty|owl:DatatypeProperty|owl:AnnotationProperty)[owl:inverseOf]">
                <xsl:variable name="id" select="@rdf:about|@rdf:ID" />
                <xsl:for-each select="owl:inverseOf[@rdf:resource]">
                    <inverseproperty rdf:about="{$id}" rdf:resource="{@rdf:resource}" />
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="removeDuplicates">
            <xsl:with-param name="temp" select="$temp" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:function name="f:getInverseOf" as="attribute()*">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:getSomething($inverseproperty,$element)" />
    </xsl:function>
    
    <xsl:function name="f:hasInverseOf" as="xs:boolean">
        <xsl:param name="element" as="element()" />
        <xsl:sequence select="f:hasSomething($inverseproperty,$element)" />
    </xsl:function>
    <!-- INVERSE PROPERTY: end -->
    
    <!-- GENERAL FUNCTIONS AND TEMPLATES: begin -->
    <xsl:function name="f:getSomething" as="attribute()*">
        <xsl:param name="doc" />
        <xsl:param name="element" as="element()" />
        <xsl:variable name="uri" select="$element/(@rdf:about|@rdf:ID)" as="attribute()"/>
        <xsl:sequence select="$doc//((element()[$uri = @rdf:resource]/@rdf:about)|(element()[$uri = @rdf:about]/@rdf:resource))" />
    </xsl:function>
    
    <xsl:function name="f:hasSomething" as="xs:boolean">
        <xsl:param name="doc" />
        <xsl:param name="element" as="element()" />
        <xsl:variable name="uri" select="$element/(@rdf:about|@rdf:ID)" as="attribute()"/>
        <xsl:value-of select="exists($doc//element()[$uri = @rdf:resource or $uri = @rdf:about])" />
    </xsl:function>
    
    <xsl:template name="removeDuplicates">
        <xsl:param name="temp" />
        <xsl:for-each select="$temp//element()">
            <xsl:variable name="currentAbout" select="@rdf:about" as="attribute()" />
            <xsl:variable name="currentResource" select="@rdf:resource" as="attribute()" />
            
            <xsl:if test="not(some $prec in preceding-sibling::element() satisfies $prec/@rdf:about = $currentResource and $prec/@rdf:resource = $currentAbout)">
                <xsl:copy>
                    <xsl:copy-of select="@*" />
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- GENERAL FUNCTIONS AND TEMPLATES: end -->
</xsl:stylesheet>