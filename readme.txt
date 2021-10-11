Pacmummy : jeu dans un labyrinthe---------------------------------
Url     : http://codes-sources.commentcamarche.net/source/30551-pacmummy-jeu-dans-un-labyrintheAuteur  : EddiTheHeadDate    : 03/08/2013
Licence :
=========

Ce document intitulé « Pacmummy : jeu dans un labyrinthe » issu de CommentCaMarche
(codes-sources.commentcamarche.net) est mis à disposition sous les termes de
la licence Creative Commons. Vous pouvez copier, modifier des copies de cette
source, dans les conditions fixées par la licence, tant que cette note
apparaît clairement.

Description :
=============

Beta jeu utilisant abusivement les bitmaps
<br /><a name='conclusion'></a><h2> 
Conclusion : </h2>
<br />Voici mon 2&egrave;me programme en Delphi.
<br />Je 
crois que le code ressemble plus &agrave; du Turbo Pascal.
<br />C'est pourquoi
, j'aimerais avoir vos avis sur ce qu'il aurait fallu faire.
<br />Etant donn&e
acute; que ce petit jeu sert avant tout &agrave; utiliser des bitmaps, j'ai lais
s&eacute; les commandes qui m'ont servis &agrave; la mise au point.
<br />
<br
 />Il y a trois choses que je n'ai pas su g&eacute;rer comme je le voulais :
<b
r />
<br />1/ Faire dispara&icirc;tre le pointeur de la souris. J'ai bien essay
&eacute; &laquo; ShowCursor &raquo; mais je n'ai pas trouv&eacute; d'endroit app
ropri&eacute; (avec tous ces &eacute;v&eacute;nements, je m'y perds). J'ai donc 
cr&eacute;&eacute; un pointeur vide et forc&eacute;ment il donne l'impression d'
avoir disparu.
<br />
<br />2/ Idem pour le clavier. J'ai essay&eacute; l'&eac
ute;v&eacute;nement &laquo; OnKeyPress &raquo; et &laquo; OnKeyDown &raquo; mais
 il faut se trouver au bon endroit sur la fiche pour qu'il fonctionne.  J'ai don
c utilis&eacute; un &laquo; GetAsyncKeyState &raquo; dans en Timer. Le probl&egr
ave;me c'est qu'il reste toujours actif lorsqu'une autre application passe devan
t.
<br />
<br />3/ La position de la souris, &laquo; GetCursorPos &raquo; me d
onne les coordonn&eacute;es par rapport &agrave; l'&eacute;cran. Ce qui m'oblige
 &agrave; calculer sa position sur la fiche.
<br />
<br />J'attends vos critiq
ues constructives car j'ai d'autres projets en t&ecirc;te et j'aimerais bien pro
gresser.
