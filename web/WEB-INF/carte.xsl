<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="../include/template.xsl" />
    <xsl:template match="/">
        <html lang="en">
            
            <xsl:call-template name="header" />
            <body onload="initialiser()">
                
                <xsl:call-template name="barreMenu" />
                <div id="wrap">
                    <div class="container">

                        <h2>Carte des hôtels :</h2>
                        <br/>
                        
                        <div class="row" style="position:relative;left:-300px;">
                            <div id="carte" align="center" style="height:80%; text-align:center" class="col-md-8"></div>
                            <div class="col-md-4">
                                <svg class="chart"></svg>
                            </div>
                        </div>

                        
                    </div><!-- /.container -->
                </div>
                <xsl:call-template name="footer" />
                
                <script type="text/javascript">
                    function initialiser() {
                    var latlng = new google.maps.LatLng(43.700, 7.267);
                    //objet contenant des propriétés avec des identificateurs prédéfinis dans Google Maps permettant
                    //de définir des options d'affichage de notre carte
                    var options = {
                    center: latlng,
                    zoom: 14,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                    };

                    //constructeur de la carte qui prend en paramêtre le conteneur HTML
                    //dans lequel la carte doit s'afficher et les options
                    var carte = new google.maps.Map(document.getElementById("carte"), options);

                    
                    <xsl:for-each select="entries/entry">
                        <xsl:if test="latitude != '' and longitude != ''">
                            var str<xsl:value-of select="ID"/> = "<xsl:value-of select="name_fr"/>";
                            str<xsl:value-of select="ID"/> = str<xsl:value-of select="ID"/>.replace(/'/g, '');
                            
                            //création du marqueur
                            var marqueur<xsl:value-of select="ID"/> = new google.maps.Marker({
                            position: new google.maps.LatLng(<xsl:value-of select="latitude"/>, <xsl:value-of select="longitude"/>),
                            map: carte,
                            title: str<xsl:value-of select="ID"/>,
                            animation: google.maps.Animation.DROP,
                            });
                            
                            google.maps.event.addListener(marqueur<xsl:value-of select="ID"/>, 'click',  function() {
                            if (marqueur<xsl:value-of select="ID"/>.getAnimation() != null) {
                            marqueur<xsl:value-of select="ID"/>.setAnimation(null);
                            } else {
                            marqueur<xsl:value-of select="ID"/>.setAnimation(google.maps.Animation.BOUNCE);
                            var win=window.open('/ProjetMiage/detail?id=<xsl:value-of select="ID"/>', 'blank');
                            win.focus();
                            }

                            });
                        </xsl:if>
                    </xsl:for-each>

                    <!-- 
                        'idle' peut remplacer l'evenement "bounds_changed" pour résoudre un bug du drag :
                        http://code.google.com/p/gmaps-api-issues/issues/detail?id=1371
                        'idle' semble toutefois moins dynamique que 'bounds_changed'
                    -->
                    
                    google.maps.event.addListener(carte, 'bounds_changed', function() {
                    
                        <!-- Variables -->
                        var prixMinMoy = 0;
                        var prixMaxMoy = 0;
                        var cpt = 0;
                        var yMin = carte.getBounds().getSouthWest().lat();
                        var xMin = carte.getBounds().getSouthWest().lng();
                        var yMax = carte.getBounds().getNorthEast().lat();
                        var xMax = carte.getBounds().getNorthEast().lng();
                        
                        <!-- Enregistrement des données dans un document json -->
                        var data = [
                        <xsl:for-each select="entries/entry">
                            <xsl:if test="name_fr != '' and latitude != '' and longitude != '' and tariffs/tariff[name='Chambre simple']/min != '' and tariffs/tariff[name='Chambre simple']/max != ''">
                                <xsl:if test="position() > 1">,</xsl:if>
                                {
                                    "lat":<xsl:value-of select="latitude" />,
                                    "long":<xsl:value-of select="longitude" />,
                                    "simpleMin":<xsl:value-of select="tariffs/tariff[name='Chambre simple']/min"/>,
                                    "simpleMax":<xsl:value-of select="tariffs/tariff[name='Chambre simple']/max"/>,
                                    "idHotel":<xsl:value-of select="ID"/>,
                                    "nomHotel":"<xsl:value-of select="name_fr" />"
                                 }
                            </xsl:if>
                        </xsl:for-each>
                        ];
                        
                        
                        <!-- Tableaux simples. au lieu de jquery.grep ... -->
                        var idHotels = new Array();
                        var nomHotels = new Array();
                        var prixSimpleMinDf = new Array();
                        
                        <!-- Tri par latitude et longitude à l'intérieur de la map -->
                        <!--  If succéssif car syntaxe du && introuvable ("and" ne fonctionnant pas) -->
                        for (var i = 0; i &lt; data.length; i++)
                        {
                            if (yMin &lt;= data[i].lat){
                                if (data[i].lat &lt;= yMax){
                                    if (xMin &lt;= data[i].long){
                                        if (data[i].long &lt;= xMax){
                                            cpt++;
                                            prixMinMoy += data[i].simpleMin;
                                            prixMaxMoy += data[i].simpleMax;
                                            
                                            var idHotel = data[i].idHotel;
                                            idHotels[i] = idHotel;
                                            
                                            var nomHotel = data[i].nomHotel;
                                            nomHotels[i] = nomHotel;
                                            
                                            var prixSimpleMin = data[i].simpleMin;
                                            prixSimpleMinDf[i] = prixSimpleMin;
                                        }
                                    }
                                }
                            }
                        }
                        
                        <!-- On vide les array des valeurs nulles -->
                        idHotels = idHotels.filter(function() { return true; });
                        nomHotels = nomHotels.filter(function() { return true; });
                        prixSimpleMinDf = prixSimpleMinDf.filter(function() { return true; });
                        
                        <!-- d3 code -->
                        
                        <!-- Supprime tous les élements du graphique précedent. -->
                        d3.selectAll('g')
                            .data([])
                            .order()
                            .exit()
                            .remove();
                            
                        <!-- Le data frame à tracer -->
                        var df = prixSimpleMinDf;
                        
                        <!-- Valeur min et max du jeu de données -->
                        var maxDf = d3.max(df, function(d) { return d; });
                        var minDf = d3.min(df, function(d) { return d; });
                        
                        <!-- Tooltip pour le mouseover bar -->
                        var tooltipNom = d3.select("body")
                            .append("div")
                            .style("position", "absolute")
                            .style("z-index", "10")
                            .style("visibility", "hidden")
                            
                       <!-- Palette de couleur des rect -->
                       var colors = ['#0099FF', '#0073E6', '#004DCC', '#0026B3', '#000099']
                        
                        <!-- Marge, largueur et hauteur de la fenêtre graphique -->
                        var margin = {top: 20, right: 30, bottom: 30, left: 40},
                            width = 1000 - margin.left - margin.right,
                            height = 500 - margin.top - margin.bottom;

                        var y = d3.scale.linear()
                            .range([height, 0]);

                        <!-- Format de l'axe des ordonnées -->
                        var yAxis = d3.svg.axis()
                            .scale(y)
                            .orient("left");

                        <!-- Fenêtre graphique -->
                        var chart = d3.select(".chart")
                            .attr("width", width + margin.left + margin.right)
                            .attr("height", height + margin.top + margin.bottom)
                          .append("g")
                            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                        <!--  Domaine de l'axe des y -->
                        y.domain([0, d3.max(df, function(d) { return d; })]);
                        
                        <!-- Largueur des barres -->
                        var barWidth = width / df.length;
                        
                        <!-- Initialisation -->
                        var bar = chart.selectAll("g")
                            .data(df)
                          .enter().append("g")
                            .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; });

                        <!-- ajout des barres -->
                        bar.append("rect")
                            .attr("y", function(d) { return y(d); })
                            .attr("height", function(d) { return height - y(d); })
                            .attr("width", barWidth - 1)
                            .style("fill", function(d, i) {
                                    if (d &lt;= maxDf - ((maxDf/colors.length) * 4)){
                                        return colors[0];
                                    } else if (d &lt;= maxDf - ((maxDf/colors.length) * 3)) {
                                        return colors[1];
                                    } else if (d &lt;= maxDf - ((maxDf/colors.length) * 2)) {
                                        return colors[2];
                                    } else if (d &lt;= maxDf - (maxDf/colors.length)) {
                                        return colors[3];
                                    } else if (d &lt;= maxDf) {
                                        return colors[4];
                                    };
                            })
                            .on("click", function(d, i) { 
                                var win=window.open('/ProjetMiage/detail?id=' + idHotels[i], 'blank');
                                win.focus();
                            })
                            .on("mouseover", function(d, i) {
                                if (typeof previousAnimation != "undefined") {
                                    previousAnimation.setAnimation(null);
                                };
                                d3.select(this).style("fill", "brown");
                                eval("marqueur" + idHotels[i]).setAnimation(google.maps.Animation.BOUNCE);
                                previousAnimation = eval("marqueur" + idHotels[i]);
                                return tooltipNom.style("top",(d3.event.pageY-20)+"px").style("left",(d3.event.pageX+10)+"px").style("visibility", "visible").text(nomHotels[i]);
                            })
                            .on("mouseout", function() {
                                d3.select(this).style("fill", function(d, i) {
                                    if (d &lt;= maxDf - ((maxDf/colors.length) * 4)){
                                        return colors[0];
                                    } else if (d &lt;= maxDf - ((maxDf/colors.length) * 3)) {
                                        return colors[1];
                                    } else if (d &lt;= maxDf - ((maxDf/colors.length) * 2)) {
                                        return colors[2];
                                    } else if (d &lt;= maxDf - (maxDf/colors.length)) {
                                        return colors[3];
                                    } else if (d &lt;= maxDf) {
                                        return colors[4];
                                    };
                                });
                                return tooltipNom.style("visibility", "hidden");
                            });
                            
                        <!-- Ajout des valeurs dans les barres -->
                        bar.append("text")
                            .attr("x", (barWidth / 2) + 5)
                            .attr("y", function(d) { return y(d) + 3; })
                            .attr("dy", ".75em")
                            .text(function(d) { return d; });

                        <!-- Ajout de l'axe des ordonnées et de l'intitulé -->
                        chart.append("g")
                            .attr("class", "y axis")
                            .call(yAxis)
                          .append("text")
                            .attr("transform", "rotate(-90)")
                            .attr("y", 6)
                            .attr("dy", ".71em")
                            .style("text-anchor", "end")
                            .text("Prix en Euro");
                         
                        <!-- Ajout du titre -->
                        chart.append("text")
                            .attr("x", (width / 2))
                            .attr("y", 0 - (margin.top / 2.5))
                            .attr("text-anchor", "middle")
                            .style("font-size", "16px")
                            .style("text-decoration", "underline") 
                            .style("fill", "black") 
                            .text("Prix minimum d'une chambre dans les hotels visibles sur la carte");
                            
                        <!--
                            Tracé des lignes des prix moyens
                        -->
                        
                        var lineData = [{"x": 0, "y": y(Math.round(prixMinMoy/cpt*100)/100)}, {"x": 1000, "y": y(Math.round(prixMinMoy/cpt*100)/100)}];
                        
                        var tooltipPrix = d3.select("body")
                            .append("div")
                            .style("position", "absolute")
                            .style("z-index", "10")
                            .style("visibility", "hidden")
                            .text("Prix minimum moyen : " + Math.round(prixMinMoy/cpt*100)/100 + " EUR");
                        
                        var lineFunction = d3.svg.line()
                            .x(function(d) { return d.x; })
                            .y(function(d) { return d.y; })
                            .interpolate("linear");
                        
                        var lineGraph = bar.append("path")
                            .attr("d", lineFunction(lineData))
                            .attr("stroke", "black")
                            .attr("stroke-width", 2)
                            .attr("fill", "none")
                            .on("mouseover", function() {
                                return tooltipPrix.style("top",(d3.event.pageY-20)+"px").style("left",(d3.event.pageX+10)+"px").style("visibility", "visible");
                            })
                            .on("mouseout", function() {
                                return tooltipPrix.style("visibility", "hidden");
                            });
                    });
               
                    }
                </script>
  
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>