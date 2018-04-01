<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:func="http://example.com"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:function name="func:nameToPath" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of separator="">
            <xsl:value-of select="func:firstLetter($input)"/>
            <xsl:value-of select="'/'"/>
            <xsl:value-of select="func:firstName($input)"/>
            <xsl:value-of select="':'"/>
            <xsl:value-of select="func:lastName($input)"/>
        </xsl:value-of>
    </xsl:function>

    <xsl:function name="func:firstLetter" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="lower-case(substring(substring-after($input, ' '), 0, 2))"/>
    </xsl:function>

    <xsl:function name="func:firstName" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="replace(substring-before($input, ' '), ' ' ,'_')"/>
    </xsl:function>

    <xsl:function name="func:lastName" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="replace(substring-after($input, ' '), ' ' ,'_')"/>
    </xsl:function>

    <xsl:template match="/">
        <xsl:variable name="root" select="." />

        <xsl:for-each select="distinct-values(//author|//editor)">
            <xsl:result-document href="{func:nameToPath(.)}.html">
                <!-- Start of the html document -->
                <html>
                    <head>
                        <title>Publication of <xsl:value-of select="."/></title>
                    </head>
                    
                    <!-- For each page, generate a body -->
                    <body>
                        <xsl:variable name="author" select="." />

                        <!-- Title section -->
                        <h1> <xsl:value-of select="."/> </h1>
                        <p>

                        <!-- Table section -->
                        <table border="1">
                        <xsl:for-each select="$root//*[./author=$author]">
                        <xsl:sort select="year" order="descending"/>
                            
                            <xsl:if test="not(preceding-sibling::*[1]/year=./year) or position()=1">
                                <tr><th colspan="3" bgcolor="#FFFFCC"><xsl:value-of select="./year" /></th></tr>
                            </xsl:if>


                            <tr>
                                <!-- T0D0 : retourner l'ordre -->
                                <td align="right" valign="top">
                                    <a name="p5"><xsl:value-of select="position()" /></a>
                                </td>

                                <td valign="top">
                                    <a href="http://www.informatik.uni-trier.de/~ley/{./url}">
                                        <img alt="Electronic Edition" title="Electronic Edition"
                                            src="http://www.informatik.uni-trier.de/~ley/db/ee.gif"
                                            border="0" height="16" width="16"/>
                                    </a>
                                </td>

                                <td>
                                    <xsl:for-each select="author">
                                        <xsl:if test="not(.=$author)" >
                                            <a href="../{func:nameToPath(.)}.html">
                                                <xsl:value-of select="." />
                                            </a>
                                        </xsl:if>
                                        <xsl:if test=".=$author" >
                                            <xsl:value-of select="." />
                                        </xsl:if>

                                        <xsl:choose>
                                            <xsl:when test="position()=last()"> : </xsl:when>
                                            <xsl:otherwise>, </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <xsl:value-of select="title" /> :
                                    <xsl:value-of select="pages" />
                                </td>

                            </tr>

                        </xsl:for-each>
                        </table>
                        <!-- End table -->

                        <!-- Co-hautor index -->
                        </p>
                        <h2> Co-author index </h2>
                        <p>

                        </p>

                    </body>
                    <!-- Enf of the body part -->

                </html>
                <!-- End of the html document -->

            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:transform>
