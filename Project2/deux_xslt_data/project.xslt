<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="”http://www.w3.org/1999/xhtml”">

	<xsl:template match="/">
		<xsl:variable name="root" select="." />

		<xsl:for-each select="distinct-values(//author|//editor)">
 			<xsl:result-document href="{lower-case(substring(substring-after(., ' '), 0, 2))}/{replace(substring-before(., ' '), ' ' ,'_')}.{replace(substring-after(., ' '), ' ' ,'_')}.html">
 				<!-- Start of the html document -->
  				<html>
					<head>
						<title>Publication of <xsl:value-of select="."/></title> 
					</head>
					
					<!-- For each page, generate a body -->
					<body>
						<xsl:variable name="author" select="." />

						<!-- Title section -->
						<p>
						<h1> <xsl:value-of select="."/> </h1>
						</p>

						<!-- Table section -->
						<table border="1">
						<xsl:for-each select="$root//*[./author=$author]">
						<xsl:sort select="year" order="descending"/>
							
							<xsl:if test="not(preceding-sibling::*[1]/year=./year) or position()=1">
								<tr><th colspan="3" bgcolor="#FFFFCC"><xsl:value-of select="./year" /></th></tr>
							</xsl:if>


							<tr>
							  	<!-- T0D0 : retourner l'ordre -->
							  	<td align="right" valign="top"><a name="p5"/><xsl:value-of select="position()" /></td>

							  	<td valign="top">
							    	<a href="http://www.informatik.uni-trier.de/~ley/{./url}">
							      	<img alt="Electronic Edition" title="Electronic Edition"
							  				src="http://www.informatik.uni-trier.de/~ley/db/ee.gif"
							  				border="0" height="16" width="16"/>
							    	</a>
							  	</td>

							  	<td>
							  		<xsl:for-each select="author">
							  			<xsl:value-of select="." />
							  			<xsl:if test="position()=last()" > : </xsl:if>
							  			<xsl:if test="not(position()=last())" >, </xsl:if>
							  		</xsl:for-each>
							  		<xsl:value-of select="title" />
							  		<xsl:value-of select="pages" />
							  	</td>

							</tr>

						</xsl:for-each>
						</table>
						<!-- End table -->

						<!-- Co-hautor index -->
						<p/>
    					<h2> Co-author index </h2>


					</body>
					<!-- Enf of the body part -->

				</html>
				<!-- End of the html document -->

 			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

</xsl:transform>
