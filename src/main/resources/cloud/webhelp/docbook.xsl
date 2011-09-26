<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="d"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns="http://www.w3.org/1999/xhtml"
                version="1.1">

  <!-- <xsl:import href="urn:docbkx:stylesheet-orig/xsl/webhelp.xsl" /> -->
  <xsl:import href="webhelp.xsl" />
  <xsl:import href="titlepage.templates.xsl"/>
  <xsl:import href="changebars.xsl"/>

  <xsl:param name="admon.graphics" select="1"></xsl:param>
  <xsl:param name="admon.graphics.path">../common/images/admon/</xsl:param>
  <xsl:param name="callout.graphics.path">../common/images/callouts/</xsl:param>

  <xsl:param name="use.extensions">1</xsl:param>
  <xsl:param name="callouts.extension">1</xsl:param>

  <xsl:param name="pdf.url">
    <xsl:call-template name="pi-attribute">
      <xsl:with-param name="pis" select="/*/processing-instruction('rax')"/>
      <xsl:with-param name="attribute" select="'pdf.url'"/>
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="branding">not set</xsl:param>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="chapter.autolabel" select="1"/>
  <xsl:param name="appendix.autolabel" select="1"/>
  <xsl:param name="part.autolabel" select="1"/>
  <xsl:param name="reference.autolabel" select="1"/>
  <xsl:param name="qandadiv.autolabel" select="1"/>
  <xsl:param name="webhelp.autolabel" select="1"/>
  <xsl:param name="section.autolabel.max.depth" select="3"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="component.label.includes.part.label" select="1"/>
  <xsl:param name="ignore.image.scaling" select="1"/>
  <xsl:param name="suppress.footer.navigation">1</xsl:param>
  <xsl:param name="enable.google.analytics">
    <xsl:choose>
      <xsl:when test="$branding = 'rackspace'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="google.analytics.id">
    <xsl:choose>
      <xsl:when test="$branding = 'rackspace'">UA-23102455-4</xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="security">external</xsl:param>
  <xsl:param name="root.attr.status"><xsl:if test="/*[@status = 'draft']">draft;</xsl:if></xsl:param>
  <xsl:param name="profile.security">
    <xsl:choose>
      <xsl:when test="$security = 'external'"><xsl:value-of select="$root.attr.status"/>external</xsl:when>
      <xsl:when test="$security = 'internal'"><xsl:value-of select="$root.attr.status"/>internal;external</xsl:when>
      <xsl:when test="$security = 'reviewer'"><xsl:value-of select="$root.attr.status"/>reviewer;internal;external</xsl:when>
      <xsl:when test="$security = 'writeronly'"><xsl:value-of select="$root.attr.status"/>reviewer;internal;external;writeronly</xsl:when>
      <xsl:when test="$security = 'external'"><xsl:value-of select="$root.attr.status"/>external</xsl:when>
      <xsl:otherwise>
	<xsl:message terminate="yes"> 
	  ERROR: The value "<xsl:value-of select="$security"/>" is not valid for the security paramter. 
	         Valid values are: external, internal, reviewer, and writeronly. 
	</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="show.comments">
    <xsl:choose>
      <xsl:when test="$security = 'reviewer' or $security = 'writeronly'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
<xsl:param name="generate.toc">
appendix  toc,title
article/appendix  nop
article   toc,title
book      title,figure,table,example,equation
chapter   toc,title
part      toc,title
preface   toc,title
qandadiv  toc
qandaset  toc
reference toc,title
sect1     toc
sect2     toc
sect3     toc
sect4     toc
sect5     toc
section   toc
set       toc,title
</xsl:param>

  <xsl:param name="enable.disqus">0</xsl:param>

  <xsl:param name="disqus.shortname">
    <xsl:choose>
      <xsl:when test="$branding = 'test'">jonathan-test-dns</xsl:when>
      <xsl:when test="$branding = 'rackspace'">rc-api-docs</xsl:when>
      <xsl:when test="$branding = 'openstack'">openstackdocs</xsl:when>
      <xsl:when test="$branding = 'openstackextension'">openstackdocs</xsl:when>
    </xsl:choose>
      
  </xsl:param>
    
  <xsl:param name="brandname">
    <xsl:choose>
      <xsl:when test="$branding = 'openstack'">OpenStack</xsl:when>
      <xsl:when test="$branding = 'openstackextension'">OpenStack Extension</xsl:when>
      <xsl:otherwise>Rackspace</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="main.docs.url">
    <xsl:choose>
      <xsl:when test="$branding = 'openstack'">http://docs.openstack.org/</xsl:when>
      <xsl:when test="$branding = 'openstackextension'">http://docs-beta.rackspace.com/test/jonathan/OpenstackExtDocs/</xsl:when>
      <xsl:otherwise>http://docs.rackspace.com/api/</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
    
  <xsl:param name="use.version.for.disqus">0</xsl:param>
    <xsl:variable name="version.for.disqus">
        <xsl:choose>
            <xsl:when test="$use.version.for.disqus!='0'">
              <xsl:value-of select="translate(//d:releaseinfo[1],' ','')"/>
            </xsl:when>
        <xsl:otherwise></xsl:otherwise>
        </xsl:choose>       
    </xsl:variable>
    
    <xsl:param name="use.disqus.id">1</xsl:param>
    
    <xsl:param name="glossary.uri">http://docs-beta.rackspace.com/test/jonathan/glossary</xsl:param>
    <xsl:param name="glossary.xml.uri"><xsl:value-of select="$glossary.uri"/>/glossary.xml</xsl:param>
    <xsl:template name="user.footer.content">
        <xsl:if test="$enable.disqus!='0' and (//d:section[not(@xml:id)] or //d:chapter[not(@xml:id)] or //d:part[not(@xml:id)] or //d:appendix[not(@xml:id)] or //d:preface[not(@xml:id)] or /*[not(@xml:id)])">
            <xsl:message terminate="yes"> 
                <xsl:for-each select="//d:section[not(@xml:id)]|//d:chapter[not(@xml:id)]|//d:part[not(@xml:id)]|//d:appendix[not(@xml:id)]|//d:preface[not(@xml:id)]|/*[not(@xml:id)]">
                    ERROR: The <xsl:value-of select="local-name()"/> "<xsl:value-of select=".//d:title[1]"/>" is missing an id.
                </xsl:for-each>
                     When Disqus comments are enabled, the root element and every part, chapter, appendix, preface, and section must have an xml:id attribute.
            </xsl:message>
        </xsl:if>
        
        <script type="text/javascript" src="../common/main.js">
            <xsl:comment></xsl:comment>
        </script>
	
	<xsl:if test="$enable.disqus != '0'">
	  <hr />
	  <div id="disqus_thread">
	    <script type="text/javascript">
	      <xsl:if test="$enable.disqus = 'intranet'">
              var disqus_developer = 1;
	      </xsl:if>
	      var disqus_shortname = '<xsl:value-of select="$disqus.shortname"/>';
	        <xsl:if test="$use.disqus.id != '0'">
	      var disqus_identifier = '<xsl:value-of select="/*/@xml:id"/><xsl:value-of select="$version.for.disqus"/><xsl:value-of select="@xml:id"/>';
	        </xsl:if>
	    </script>
	    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>

	    <script type="text/javascript" src="../common/comments.js">
	      <xsl:comment></xsl:comment>
	    </script>
	  </div>
	</xsl:if>    

	<hr/>
	<div class="legal"><a href="index.html">Legal notices</a></div>

    </xsl:template>

    <xsl:template name="breadcrumbs">
      <xsl:param name="home"/>
      <p class="breadcrumbs"><a href="{$main.docs.url}"><xsl:value-of select="$brandname"/> Manuals</a>  <a><xsl:attribute name="href">
      <xsl:call-template name="href.target">
	<xsl:with-param name="object" select="$home"/>
      </xsl:call-template>
      </xsl:attribute><xsl:value-of select="normalize-space(//d:title[1])"/><xsl:apply-templates select="//d:releaseinfo[1]" mode="rackspace-title"/></a> 
      </p> 
      <xsl:if test="normalize-space($pdf.url) != ''">
	<a onclick="_gaq.push(['_trackEvent', 'Header', 'pdfDownload', 'click', 1]);" class="pdficon" href="{normalize-space($pdf.url)}"><img src="../common/images/pdf.png"/></a>	  
      </xsl:if>
    </xsl:template>

      <xsl:template name="webhelpheader">
        <xsl:param name="prev"/>
        <xsl:param name="next"/>
        <xsl:param name="nav.context"/>
        
        <xsl:variable name="home" select="/*[1]"/>
        <xsl:variable name="up" select="parent::*"/>
        
        <div id="header">
	  <a onclick="_gaq.push(['_trackEvent', 'Header', 'logo', 'click', 1]);" target="_blank">
	    <xsl:attribute name="href">
	    <xsl:choose>
		<xsl:when test="$branding = 'openstack'">http://www.openstack.org</xsl:when>
	    <xsl:when test="$branding = 'openstackextension'">http://docs-beta.rackspace.com/test/jonathan/OpenStackExtDocs/</xsl:when>
		<xsl:otherwise>http://www.rackspace.com</xsl:otherwise>
	      </xsl:choose>
	    </xsl:attribute>
	    <img src='../common/images/{$branding}-logo.png' alt="{$brandname} Documentation" width="157" height="47" />
	  </a>
	  <xsl:if test="$branding = 'openstack'">
	    <xsl:call-template name="breadcrumbs">
	      <xsl:with-param name="home" select="$home"/>
	    </xsl:call-template>
	  </xsl:if>
	  <xsl:if test="$branding = 'openstackextension'">
	    <xsl:call-template name="breadcrumbs">
	      <xsl:with-param name="home" select="$home"/>
	    </xsl:call-template>
	  </xsl:if>
            <!-- Display the page title and the main heading(parent) of it-->
            <h1>
                <xsl:apply-templates select="." mode="object.title.markup"/>
             </h1>
            
            <!-- Prev and Next links generation-->
            <div id="navheader" align="right">
                <xsl:comment>
                    <!-- KEEP this code. In case of neither prev nor next links are available, this will help to
                        keep the integrity of the DOM tree-->
                </xsl:comment>
                <!--xsl:with-param name="prev" select="$prev"/>
                    <xsl:with-param name="next" select="$next"/>
                    <xsl:with-param name="nav.context" select="$nav.context"/-->
                <table class="navLinks">
                    <tr>
                        <td>
                            <a id="showHideButton" onclick="showHideToc(); _gaq.push(['_trackEvent', 'Header', 'show/hide', 'click', 1]);"
                                class="pointLeft" title="Hide TOC tree">Sidebar
                            </a>
                        </td>
                        <xsl:if test="count($prev) &gt; 0
                            or (count($up) &gt; 0
                            and generate-id($up) != generate-id($home)
                            and $navig.showtitles != 0)
                            or count($next) &gt; 0">
                            <td>
                                <xsl:if test="count($prev)>0">
                                    <a accesskey="p" class="navLinkPrevious" onclick="_gaq.push(['_trackEvent', 'Header', 'prevLink', 'click', 1]);" tabindex="5">
                                        <xsl:attribute name="href">
                                            <xsl:call-template name="href.target">
                                                <xsl:with-param name="object" select="$prev"/>
                                            </xsl:call-template>
                                        </xsl:attribute>
                                        <xsl:call-template name="navig.content">
                                            <xsl:with-param name="direction" select="'prev'"/>
                                        </xsl:call-template>
                                    </a>
                                </xsl:if>
                                
                                <!-- "Up" link-->
                                <xsl:choose>
                                    <xsl:when test="count($up)&gt;0
                                        and generate-id($up) != generate-id($home)">
				      |
                                        <a accesskey="u" class="navLinkUp" onclick="_gaq.push(['_trackEvent', 'Header', 'upLink', 'click', 1]);" tabindex="5">
                                            <xsl:attribute name="href">
                                                <xsl:call-template name="href.target">
                                                    <xsl:with-param name="object" select="$up"/>
                                                </xsl:call-template>
                                            </xsl:attribute>
                                            <xsl:call-template name="navig.content">
                                                <xsl:with-param name="direction" select="'up'"/>
                                            </xsl:call-template>
                                        </a>
                                    </xsl:when>
                                    <xsl:otherwise>&#160;</xsl:otherwise>
                                </xsl:choose>
                                
                                <xsl:if test="count($next)>0">
				  |
                                    <a accesskey="n" class="navLinkNext" onclick="_gaq.push(['_trackEvent', 'Header', 'nextLink', 'click', 1]);" tabindex="5">
                                        <xsl:attribute name="href">
                                            <xsl:call-template name="href.target">
                                                <xsl:with-param name="object" select="$next"/>
                                            </xsl:call-template>
                                        </xsl:attribute>
                                        <xsl:call-template name="navig.content">
                                            <xsl:with-param name="direction" select="'next'"/>
                                        </xsl:call-template>
                                    </a>
                                </xsl:if>
                            </td>
                        </xsl:if>
                        
                    </tr>
                </table>                
            </div>            
        </div>

	<xsl:if test="$branding = 'rackspace'">
	  <div id="toolbar" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
	    <div id="toolbar-left">
	      <xsl:call-template name="breadcrumbs">
		<xsl:with-param name="home" select="$home"/>
	      </xsl:call-template>
	    </div>
	  </div>
	</xsl:if>
	<xsl:if test="$branding = 'openstackextension'">
	  <div id="toolbar" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
	    <div id="toolbar-left">
	      <xsl:call-template name="breadcrumbs">
		<xsl:with-param name="home" select="$home"/>
	      </xsl:call-template>
	    </div>
	  </div>
	</xsl:if>
    </xsl:template>
    
    <xsl:template name="webhelptoc">
        <xsl:param name="currentid"/>
        <xsl:choose>
            <xsl:when test="$rootid != ''">
                <xsl:variable name="title">
                    <xsl:if test="$webhelp.autolabel=1">
                        <xsl:variable name="label.markup">
                            <xsl:apply-templates select="key('id',$rootid)" mode="label.markup"/>
                        </xsl:variable>
                        <xsl:if test="normalize-space($label.markup)">
                            <xsl:value-of select="concat($label.markup,$autotoc.label.separator)"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:apply-templates select="key('id',$rootid)" mode="title.markup"/>
                </xsl:variable>
                <xsl:variable name="href">
                    <xsl:choose>
                        <xsl:when test="$manifest.in.base.dir != 0">
                            <xsl:call-template name="href.target">
                                <xsl:with-param name="object" select="key('id',$rootid)"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="href.target.with.base.dir">
                                <xsl:with-param name="object" select="key('id',$rootid)"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:variable name="title">
                    <xsl:if test="$webhelp.autolabel=1">
                        <xsl:variable name="label.markup">
                            <xsl:apply-templates select="/*" mode="label.markup"/>
                        </xsl:variable>
                        <xsl:if test="normalize-space($label.markup)">
                            <xsl:value-of select="concat($label.markup,$autotoc.label.separator)"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:apply-templates select="/*" mode="title.markup"/>
                </xsl:variable>
                <xsl:variable name="href">
                    <xsl:choose>
                        <xsl:when test="$manifest.in.base.dir != 0">
                            <xsl:call-template name="href.target">
                                <xsl:with-param name="object" select="/"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="href.target.with.base.dir">
                                <xsl:with-param name="object" select="/"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <div>
                    <div id="leftnavigation" style="padding-top:3px; background-color:white;">
                        <div id="tabs">
                            <ul>
                                <li>
                                    <a href="#treeDiv" tabindex="1">
                                        <span class="contentsTab">
                                            <xsl:call-template name="gentext">
                                                <xsl:with-param name="key" select="'TableofContents'"/>
                                            </xsl:call-template>
                                        </span>
                                    </a>
                                </li>
                                <xsl:if test="$webhelp.include.search.tab != 'false'">
                                    <li>
                                        <a href="#searchDiv" tabindex="1">
                                            <span class="searchTab">
                                                <xsl:call-template name="gentext">
                                                    <xsl:with-param name="key" select="'Search'"/>
                                                </xsl:call-template>
                                            </span>
                                        </a>
                                    </li>
                                </xsl:if>
                            </ul>
                            <div id="treeDiv">
                                <img src="../common/images/loading.gif" alt="loading table of contents..."
                                    id="tocLoading" style="display:block;"/>
                                <div id="ulTreeDiv" style="display:none" class="thisisthat">
                                    <ul id="tree" class="filetree">
                                        <xsl:apply-templates select="/*/*" mode="webhelptoc">
                                            <xsl:with-param name="currentid" select="$currentid"/>
                                        </xsl:apply-templates>
                                    </ul>
                                </div>
                                
                            </div>
                            <xsl:if test="$webhelp.include.search.tab != 'false'">
                                <div id="searchDiv">
                                    <div id="search">
                                        <form onsubmit="Verifie(ditaSearch_Form);return false"
                                            name="ditaSearch_Form"
                                            class="searchForm">
                                            <fieldset class="searchFieldSet">
                                                <legend>
                                                    <xsl:call-template name="gentext">
                                                        <xsl:with-param name="key" select="'Search'"/>
                                                    </xsl:call-template>
                                                </legend>
                                                <center>
                                                    <input id="textToSearch" name="textToSearch" type="text"
                                                        class="searchText"/>
                                                    <xsl:text disable-output-escaping="yes"> <![CDATA[&nbsp;]]> </xsl:text>
                                                    <input onclick="Verifie(ditaSearch_Form)" type="button"
                                                        class="searchButton"
                                                        value="Go" id="doSearch"/>
                                                </center>
                                            </fieldset>
                                        </form>
                                    </div>
                                    <div id="searchResults">
                                        <center> </center>
                                    </div>
                                    <p class="searchHighlight"><a href="#" onclick="toggleHighlight()">Search Highlighter (On/Off)</a></p>
                                </div>
                            </xsl:if>
                            
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//d:para/d:glossterm">
        <xsl:variable name="term"><xsl:value-of select="."/></xsl:variable>
        <xsl:variable name="definition"><xsl:value-of select="normalize-space(//d:glossentry[d:glossterm=$term]/d:glossdef)"/></xsl:variable>
        <xsl:variable name="displayDefinition">
          <xsl:choose>
            <xsl:when test="$definition=''"><strong><xsl:value-of select="$term"/>:</strong><xsl:text> </xsl:text> No definition found. </xsl:when>
            <xsl:otherwise>
                   <strong><xsl:value-of select="$term"/>:</strong><xsl:text> </xsl:text> <xsl:value-of select="$definition"/>
            </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
             <script>
             $(document).ready(function(){
               $("a.gloss#<xsl:value-of select="$term"/>").qtip({
               content: '<xsl:copy-of select='$displayDefinition'/>',
               show: {event:'mouseover',delay:500},
               hide: {event:'mouseout',delay:500, fixed:true},
               style: { 
                        width: 200,
                        padding: 5,
                        background: '#FFFFCC',
                        color: 'black',
                        textAlign: 'left',
                        border: {
                                    width: 1,
                                    radius: 4,
                                    color: '#EEEEBB'
                        },
                        tip: true,
                        name: 'cream' // Inherit the rest of the attributes from the preset cream style
                },
                position: {
                    corner: {
                            target: 'topMiddle',
                            tooltip: 'bottomLeft'
                    }
                }
               });
             });
             </script>
    
        <a class="gloss" href="#"><xsl:attribute name="id"><xsl:value-of select="$term"></xsl:value-of></xsl:attribute> <xsl:value-of select="."/></a>
    </xsl:template>
    
    
    <!-- The following templates change the color of text flagged as reviewer, internal, or writeronly -->    
    <xsl:template match="text()[ contains(concat(';',ancestor::*/@security,';'),';internal;') ] | xref[ contains(concat(';',ancestor::*/@security,';'),';internal;') ]"><span class="internal"><xsl:apply-imports/></span></xsl:template>
    <xsl:template match="text()[ contains(concat(';',ancestor::*/@security,';'),';writeronly;') ] | xref[ contains(concat(';',ancestor::*/@security,';'),';writeronly;') ]"><span class="writeronly"><xsl:apply-imports/></span></xsl:template>
    <xsl:template match="text()[ contains(concat(';',ancestor::*/@security,';'),';reviewer;') ] | xref[ contains(concat(';',ancestor::*/@security,';'),';reviewer;') ]"><span class="remark"><xsl:apply-imports/></span></xsl:template>
    <xsl:template match="text()[ ancestor::*/@role = 'highlight' ] | xref[ ancestor::*/@role = 'highlight' ]" priority="10"><span class="remark"><xsl:apply-imports/></span></xsl:template>

    <xsl:template match="d:parameter[@role = 'template']">
      <xsl:param name="content">
	<xsl:call-template name="anchor"/>
	<xsl:call-template name="simple.xlink">
	  <xsl:with-param name="content">
	    <xsl:apply-templates/>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:param>
      <em><xsl:call-template name="common.html.attributes"/><code><xsl:call-template name="generate.html.title"/><xsl:call-template name="dir"/>{<xsl:copy-of select="$content"/>}<xsl:call-template name="apply-annotations"/></code></em>
    </xsl:template>
    
</xsl:stylesheet>
