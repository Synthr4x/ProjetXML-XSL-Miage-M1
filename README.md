ProjetXML-XSL---Miage-M1
========================

Projet Web réalisé en trinôme dans le cadre du cours d'XML/XSL à Miage Sophia-Antipolis.

Développement d'un site web de consultation des hotels de Nice, avec visualisation de tous les hotels sur Google Maps, de statistiques faits en SVG avec Raphael.js (prix moyens).
Consultation des hotels au cas par cas avec un caroussel Owl Carousel (JQuery).
Visualisation de l'ensemble des hotels avec un tableau DataTables (JQuery) pour la pagination et le filtrage sans rechargement de la page.
Exemple d'export en PDF de graphes SVG.

L'ensemble des données relatives aux hotels se trouve dans entries_hotels.xml, les données sont récupérées avec XQuery sur un serveur géré par BaseX.
Ces données sont mise en forme sur des feuilles de style XSL.
Back-end géré en JEE avec des servlets Java et un serveur Tomcat (lien avec BaseX avec l'api java de BaseX)
