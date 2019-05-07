---
title: '<a name="top"></a><img src="https://raw.githubusercontent.com/samWieczorek/Prostar/master/inst/ProstarApp/www/images/LogoProstarComplet.png"    width="135"/> 
		**p r o s t a r - p r o t e o m i c s .org**'
output:
  html_document:
   toc: true
   toc_float: true
   theme: united
   toc_depth: 2  # upto three depths of headings (specified by #, ## and ###)
   highlight: tango  # specifies the syntax highlighting style
   #css: my.css   # you can add your custom css, should be in same folder 
---
<style>
body {
text-align: justify}
</style>



------

# Generalites

Prostar fonctionne à base de modules le plus possible
Plusieurs groupes de fonctionnalites existent: 


Ces fonctionnalites sont generalement représentees par des menus deroulants


# Pipelines


# Architecture d'un module de process

Un module de process doit avoir une entre et une sortie, instanciees par des variables reactives (dataIn et dataOut).
Chaque module a ses propres variables reactives, de ce fait il est tres indépendant du reste du logiciel.
La variable reactive porte le nom du module prefixé par 'rv.'. PAr exemple, pour le module Filtering, la variable s'appelle rv.Filtering. Dans cette liste, on trouve toutes les variables 'globales' nécessaires au fonctionnement du module.

## Paramètres d'entrée

## Nomenclature

Les modules de process sont stockés dans le répertoire modules/process. Le code d'un module (ui et server) est dans un seul fichier qui ^porte le nom du module préfixé par 'module'.


## Squelette d'un module

```R
chooseCRANmirror()
install.packages("BiocManager")
```

