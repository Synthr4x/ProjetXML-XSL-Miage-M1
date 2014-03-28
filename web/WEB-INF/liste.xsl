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

                       
                        <h2>Liste des hôtels :</h2>
                        <h5 >Cliquez sur le nom d'un hôtel pour avoir sa description</h5>
                        <br/>
                        <br/>
                        
                        <p>
                            <b>Filtrer les résultats :</b>
                        </p>
                        
                        <div class="form-group">
                            <label for="max" class="col-sm-3 control-label">Prix maximum pour une chambre :</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control input-sm" id="max" placeholder=""></input>
                                <span class="glyphicon glyphicon-euro" id="positionTrash"></span>
                            </div>
                        </div>

                    
                        <br/>     
                        <br/>     

                        <table class="table table-bordered table-hover table-striped" id="tableListe">
                            <thead>
                                <tr>
                                    <th>Nom</th>
                                    <th width='380'>Adresse</th>
                                    <th>Site Web</th>
                                    <th width='220'>Prix chambre simple</th>
                                    <th width='220'>Prix chambre double</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="entries/entry">
                                    <tr>
                                        <td>
                                            <xsl:element name="a">
                                                <xsl:attribute name="href">/ProjetMiage/detail?id=<xsl:value-of select="ID"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="target">detail?<xsl:value-of select="ID"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="name_fr"/>
                                            </xsl:element>
                                        </td>
                                        <td>
                                            <xsl:value-of select="address"/>
                                        </td> 
                                        <td>
                                            <xsl:element name="a">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="website"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="target">
                                                    blank
                                                </xsl:attribute>
                                                <xsl:value-of select="website"/>
                                            </xsl:element>
                                        </td> 
                                        <td>
                                            <xsl:value-of select="tariffs/tariff[name='Chambre simple']/min"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="tariffs/tariff[name='Chambre double']/min"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        

                    </div><!-- /.container -->
                </div>
                <xsl:call-template name="footer" />
                <script src="ressources/js/scriptListe.js"></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
