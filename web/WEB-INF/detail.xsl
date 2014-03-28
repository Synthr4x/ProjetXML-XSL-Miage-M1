<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="../include/template.xsl" /> 

    <xsl:template match="/">
        <html lang="en">
            <xsl:call-template name="header" />
            <body>
                <xsl:call-template name="barreMenu" />
                <div id="wrap">
                    <div class="container">

                        <div class="starter-template">
                            <h2>Détail de l'hotel : <xsl:value-of select="entry/name_fr"/></h2>
                            <h3>
                                <span class="stars">
                                    <xsl:value-of select="entry/standings_levels/standings_level"/>
                                </span>
                            </h3>
                            
                            <br/>
                        
                       
                            <hr></hr>
                            <div id="sync1" class="owl-carousel">
                            
                                <xsl:for-each select="entry/images/image">
                                    <div class="item">
                                        <xsl:element name="img">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="."/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">Image</xsl:attribute>
                                            <xsl:attribute name="class">img-thumbnail</xsl:attribute>
                                        </xsl:element>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <hr></hr>
                            <div id="sync2" class="owl-carousel">
                            
                                <xsl:for-each select="entry/images/image">
                                    <div class="item">
                                        <xsl:element name="img">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="."/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">Image</xsl:attribute>
                                            <xsl:attribute name="class">img-thumbnail</xsl:attribute>
                                        </xsl:element>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <hr></hr>

                                
                            <br/>
                            <br/>
                            <div class="panel-group" id="accordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                <b>Addresse</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <xsl:value-of select="entry/address/address_line1"/>&#160;
                                    
                                            <xsl:value-of select="entry/address/address_line2"/>&#160;
                                    
                                            <xsl:value-of select="entry/address/address_line3"/>
                                            <br/>
                                            <xsl:value-of select="entry/address/zip"/>
                                            <br/>
                                            <xsl:value-of select="entry/address/city"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                                <b>Contact</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <b>Site Web : </b> 
                                            <xsl:element name="a">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="entry/website"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="target">
                                                    hotelSite
                                                </xsl:attribute>
                                                <xsl:value-of select="entry/website"/>
                                            </xsl:element>
                                            <br/>
                                            <b>Email : </b>
                                            <xsl:value-of select="entry/email"/>
                                            <br/>
                                            <b>Téléphone : </b>
                                            <xsl:value-of select="entry/phone"/>
                                            <br/>
                                            <b>Fax : </b>
                                            <xsl:value-of select="entry/fax"/>
                                            <br/>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
                                                <b>Méthodes de paiement</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                            
                                                <xsl:for-each select="entry/payments/payment">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                           
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
                                                <b>Langues</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseFour" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/languages/language">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
                                                <b>Aménagements</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseFive" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/amenities/amenity">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseSix">
                                                <b>Profils acceptés</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseSix" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/profiles/profile">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">
                                                <b>Localisations</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseSeven" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/locations/location">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseEight">
                                                <b>Catégories</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseEight" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/categories/category">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseNine">
                                                <b>Stations de transport en commun</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseNine" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/stations/station">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTen">
                                                <b>Options</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseTen" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/options/option">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseEleven">
                                                <b>Publications</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseEleven" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/publications/publication">
                                                    <li class="list-group-item">
                                                        <xsl:value-of select="."/>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwelve">
                                                <b>Tarifs</b>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwelve" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul class="list-group">
                                                <xsl:for-each select="entry/tariffs/tariff">
                                                    <li class="list-group-item">
                                                        <b>
                                                            <xsl:value-of select="name"/>
                                                        </b>
                                                        <br/>
                                                        Prix entre <xsl:value-of select="min"/> et <xsl:value-of select="max"/> euros
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            
                            </div>
                        
                        </div>

                    </div><!-- /.container -->
                </div>
                <xsl:call-template name="footer" />
                <script src="ressources/js/scriptDetail.js"></script>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
