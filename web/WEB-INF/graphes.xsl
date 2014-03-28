<?xml version="1.0"?>


<xsl:stylesheet version="2.0"
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="../include/template.xsl" />

    <xsl:template match="/">
        <html lang="en">

            <xsl:call-template name="header" />
            <link rel="stylesheet" href="/ProjetMiage/ressources/css/nv.d3.css"></link>
            <body onload="drawGraph()">
                <xsl:call-template name="barreMenu" />
                <div id="wrap">
                    <div class="container">
                        
                        <!--
                        <table class="table table-bordered table-hover table-striped" id="tableTest">
                            <thead>
                                <tr>
                                    <th>Label</th>
                                    <th>Count</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each-group select="entries/entry/standings_levels/standings_level" group-by=".">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="current-grouping-key()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="count(current-group())"/>
                                        </td>
                                    </tr>
                                </xsl:for-each-group>
                            </tbody>
                        </table>
                         -->   
                         
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        
                        <div class = "row" style="position:relative;left:-200px;">
                            <div class="col-md-8">
                                <svg class="chart1" style="height:500px;width:500px"></svg>
                            </div>
                            <div class="col-md-4">
                                <svg class="chart2" style="height:500px;width:800px"></svg>
                            </div>
                        </div>

                    </div><!-- /.container -->
                </div>
                <xsl:call-template name="footer" />
                <script src="ressources/js/nv.d3.js"></script>
                <script>
                    function drawGraph(){
                    
                        var data = [
                            <xsl:for-each select="entries/entry">
                                <xsl:if test="name_fr != '' and tariffs/tariff[name='Chambre simple']/min != '' and tariffs/tariff[name='Chambre simple']/max != ''">
                                    <xsl:if test="position() > 1">,</xsl:if>
                                    {
                                        "simpleMin":<xsl:value-of select="tariffs/tariff[name='Chambre simple']/min"/>,
                                        "simpleMax":<xsl:value-of select="tariffs/tariff[name='Chambre simple']/max"/>,
                                        "idHotel":<xsl:value-of select="ID"/>,
                                        "nomHotel":"<xsl:value-of select="name_fr" />",
                                        "standing":"<xsl:value-of select="standings_levels/standings_level" />"
                                     }
                                </xsl:if>
                            </xsl:for-each>
                            ];

                        var rollup = d3.nest()
                            .key(function(d) { return d.standing; }).sortKeys(d3.ascending)
                            .rollup(function(leaves) { return leaves.length; })
                            .entries(data);
                            
                        nv.addGraph(function() {
                            var chart = nv.models.pieChart()
                                .x(function(d) { return d.key })
                                .y(function(d) { return d.values })
                                .showLabels(true);

                            d3.select(".chart1")
                                .datum(rollup)
                              .transition().duration(1200)
                                .call(chart);

                            return chart;
                            
                        });
                        
                        var rollup2 = d3.nest()
                            .key(function(d) { return d.standing; }).sortKeys(d3.ascending)
                            .rollup(function(d) { return d3.mean(d, function(g) { return g.simpleMin; });})
                            .entries(data);
                        
                        var rollup2 = [{key: "standings", values: rollup2}];

                        nv.addGraph(function() {
                            var chart = nv.models.discreteBarChart()
                                .x(function(d) { return d.key })
                                .y(function(d) { return d.values })
                                .staggerLabels(true)
                                .tooltips(false)
                                .showValues(true)

                            d3.select(".chart2")
                                .datum(rollup2)
                              .transition().duration(500)
                                .call(chart);

                            nv.utils.windowResize(chart.update);

                            return chart;
                        });
                        
                       d3.select(".chart1")
                          .append("text")
                          .attr("x", 150)
                          .attr("y", 8)
                          .style("fill", "black") 
                          .text("Répartition des hotels selon leurs étoiles");
                        
                        d3.select(".chart2")
                          .append("text")
                          .attr("x", 280)
                          .attr("y", 10)
                          .style("fill", "black") 
                          .text("Prix minimum moyen d'une chambre (en euro) en fonction du standing");
                    }
                </script>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

