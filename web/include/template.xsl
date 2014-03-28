<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : header.xsl
    Created on : 22 novembre 2013, 13:21
    Author     : Christian
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="header">
        <head>
            <meta charset="utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <meta name="description" content=""/>
            <meta name="author" content=""/>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
            <!-- Elément Google Maps indiquant que la carte doit être affiché en plein écran et
            qu'elle ne peut pas être redimensionnée par l'utilisateur -->
            <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

            <title>Projet Miage</title>

            <!-- Bootstrap core CSS -->
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/bootstrap.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
            
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/owl.theme.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
        
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/owl.carousel.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
            
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/demo_table.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
            
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/TableTools_JUI.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
            
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/TableTools.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>
            
            <xsl:element name="link">
                <xsl:attribute name="href">/ProjetMiage/ressources/css/style.css</xsl:attribute>
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
            </xsl:element>

        </head>
    </xsl:template>
    
    <xsl:template name="footer">
  
        <br/>
       
        <div id="footer">
            <div class="container">
               
                <br/>
                <a href="http://www.hristu.net/">Da groove</a>
                
            </div>
        </div>
        
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="ressources/js/jquery-1.10.2.min.js"></script>
        <script src="ressources/js/bootstrap.min.js"></script>
        <script src="ressources/js/jquery.dataTables.min.js"></script>
        <script src="ressources/js/holder.js"></script>
        <!-- Include js plugin -->
        <script src="ressources/js/owl.carousel.js"></script>
        <script src="ressources/js/TableTools.min.js"></script>
        <script src="ressources/js/ZeroClipboard.js"></script>
        <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script src="http://d3js.org/d3.v3.min.js"></script>
    </xsl:template>
    
    <xsl:template name="barreMenu">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/ProjetMiage/">Projet Miage</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="/ProjetMiage/liste">Liste des hôtels</a>
                        </li>
                        <li>
                            <a href="/ProjetMiage/carte">Voir la Carte</a>
                        </li>
                        <li>
                            <a href="/ProjetMiage/graphes">Graphes</a>
                        </li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>
        
        
    </xsl:template>
</xsl:stylesheet>
