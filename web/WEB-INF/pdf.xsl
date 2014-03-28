<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match='/'>

        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="my-page">
                    <fo:region-body margin="1in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


            <fo:page-sequence master-reference="my-page">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="14pt" font-family="verdana" color="red"
                              space-before="5mm" space-after="5mm">
                        Projet Miage
                    </fo:block>

                    <fo:block text-indent="5mm" font-family="verdana" font-size="12pt">
                        Ceci est un exemple d'export pdf fait avec une feuille de style XSLFO
                    </fo:block>
                    
                    <fo:block space-before="10mm">
                        Prix minimum d'une chambre simple (en €) dans chaque hotel.
                        <fo:instream-foreign-object xmlns:svg="http://www.w3.org/2000/svg">
                            <svg:svg class="chart" width="500" height="500">
                                <xsl:for-each select="entries/entry/tariffs/tariff[name='Chambre simple']">
                                    <svg:g transform="translate(0,{5*(position()-1)})">
                                        <svg:rect width="{min}" height="4" fill="steelblue"></svg:rect>   
                                        <svg:text x="{min}" y="2" dy=".35em" fill="black" font-size="5px"><xsl:value-of select="min"/>€</svg:text>
                                   </svg:g>
                                 </xsl:for-each>
                            </svg:svg>
                        </fo:instream-foreign-object>
                    </fo:block>
                    
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="my-page">
                <fo:flow flow-name="xsl-region-body">   
                    <fo:table>
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">name</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">ID</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>

                        
                        <xsl:for-each select="entries/entry">
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="name_fr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="ID"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </xsl:for-each>
                    </fo:table>
                  
                </fo:flow>
            </fo:page-sequence>




        </fo:root>
    </xsl:template>


</xsl:stylesheet>