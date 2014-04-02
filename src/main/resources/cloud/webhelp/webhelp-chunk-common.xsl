<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="d"              
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:d="http://docbook.org/ns/docbook"
	xmlns:exsl="http://exslt.org/common"
        xmlns:ng="http://docbook.org/docbook-ng" 
        xmlns:db="http://docbook.org/ns/docbook"
        xmlns:fb="http://ogp.me/ns/fb#"
        version="1.0" xmlns="http://www.w3.org/1999/xhtml">
  
  
    <!--<xsl:import href="/home/dcramer/.m2/repository/net/sf/docbook/docbook-xsl/1.76.1/unzipped/docbook/xhtml/chunk-common.xsl" />-->
    
  <xsl:import href="urn:docbkx:stylesheet-base/xhtml/chunk-common.xsl" />

    <xsl:template name="chunk-element-content">
        <xsl:param name="prev"/>
        <xsl:param name="next"/>
        <xsl:param name="nav.context"/>
        <xsl:param name="content">
            <xsl:apply-imports/>
        </xsl:param>

        <xsl:call-template name="user.preroot"/>

        <html>
            <xsl:call-template name="html.head">
                <xsl:with-param name="prev" select="$prev"/>
                <xsl:with-param name="next" select="$next"/>
            </xsl:call-template>

            <body>
                <xsl:call-template name="body.attributes"/>

                <xsl:call-template name="user.header.navigation">
                    <xsl:with-param name="prev" select="$prev"/>
                    <xsl:with-param name="next" select="$next"/>
                    <xsl:with-param name="nav.context" select="$nav.context"/>
                </xsl:call-template>

                <div id="content-wrapper">
                <div id="content">

                    <xsl:copy-of select="$content"/>
                    
                    <xsl:call-template name="user.header.content"/>

                    <xsl:call-template name="user.footer.content"/>

                    <xsl:call-template name="footer.navigation">
                        <xsl:with-param name="prev" select="$prev"/>
                        <xsl:with-param name="next" select="$next"/>
                        <xsl:with-param name="nav.context" select="$nav.context"/>
                    </xsl:call-template>
                </div>

                <xsl:call-template name="user.footer.navigation"/>
                </div>
                <div id="raxheaderfooterservice-footercontent"><xsl:comment/></div>
                <script type="text/javascript" src="{$webhelp.common.dir}jquery/jquery.qtip-1.0.0-rc3/jquery.qtip-1.0.0-rc3.min.js">
                   <xsl:comment>jQuery plugin for glossary popups. </xsl:comment>
                   $('a[title]').qtip({ style: { name: 'cream', tip: true } })
		</script>
                <xsl:if test="$webhelp.war != '0' and $webhelp.war != '' and ($branding = 'rackspace' or $branding = 'rackspace-private-cloud')">
                  <script type="text/javascript">
                     var s = document.createElement( 'script' );
                     if ( location.hostname == "docs.rackspace.com") {
                       s.setAttribute('src', "https://tags.tiqcdn.com/utag/rackspace/docs/prod/utag.js");
                       document.body.appendChild( s ); }
                     else if ( location.hostname == "docs-staging.rackspace.com") {
                       s.setAttribute('src', "https://tags.tiqcdn.com/utag/rackspace/docs/qa/utag.js");
                       document.body.appendChild( s ); }
                  </script>
                </xsl:if>
            </body>
        </html>
        <xsl:value-of select="$chunk.append"/>
    </xsl:template>

</xsl:stylesheet>
