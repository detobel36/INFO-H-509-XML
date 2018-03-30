<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="”http://www.w3.org/1999/xhtml”">

	<xsl:template match="/">
		<xsl:for-each select="distinct-values(//author|//editor)">
 			<xsl:result-document href="{replace(., ' ' ,'_')}.html">
 				<!-- Start of the html document -->
  				<html>

					<head>
						<title>Publication of <xsl:value-of select="."/></title> 
					</head>

					<!-- For each page, generate a body -->
					<body>
						<!-- Title section -->
						<h1> <xsl:value-of select="."/> </h1>

					</body>
					<!-- Enf of the body part -->

				</html>
				<!-- End of the html document -->

 			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

</xsl:transform>
