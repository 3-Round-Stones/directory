<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:res="http://www.w3.org/2005/sparql-results#"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:xhtml="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="res xsl rdf xhtml">

  <xsl:template match="/res:sparql">
    <c:data content-type="text/javascript">
{
"items" : [
	<xsl:apply-templates select="res:results" />
]
}
    </c:data>
  </xsl:template>


<xsl:template match="/res:sparql/res:results">
    <xsl:for-each select="res:result">
<!-- apostrophes need escaping for JSON
     probably not needed for link, date -->
<xsl:variable name="org">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='org']/*"/>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="url">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='url']/*"/>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="organization">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='organization']/*"/>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="category">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='category']/*"/>
	</xsl:call-template>	
</xsl:variable>
<xsl:variable name="country">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='country']/*"/>
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="orgtype">
  <xsl:call-template name="escape">
  <xsl:with-param name="text" select="res:binding[@name='orgtype']/*"/>
	</xsl:call-template>
</xsl:variable>
        {"id": "<xsl:value-of select="$org" />",
				"url": "<xsl:value-of select="$url" />",
				"label": "<xsl:value-of select="$organization" />",
				"country": "<xsl:value-of select="$country" />",
				"category": "<xsl:value-of select="$category" />",
				"orgtype": "<xsl:value-of select="$orgtype" />"
        }<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template name="globalReplace">
  <xsl:param name="outputString"/>
  <xsl:param name="target"/>
  <xsl:param name="replacement"/>
  <xsl:choose>
    <xsl:when test="contains($outputString,$target)">
   
      <xsl:value-of select=
        "concat(substring-before($outputString,$target),
               $replacement)"/>
      <xsl:call-template name="globalReplace">
        <xsl:with-param name="outputString" 
             select="substring-after($outputString,$target)"/>
        <xsl:with-param name="target" select="$target"/>
        <xsl:with-param name="replacement" 
             select="$replacement"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$outputString"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="escape">
  <xsl:param name="text"/>
  <xsl:call-template name="globalReplace">
  <xsl:with-param name="outputString" select="$text"/>
  <xsl:with-param name="target">'</xsl:with-param>
  <xsl:with-param name="replacement">\'</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="text()"/>
</xsl:stylesheet>

