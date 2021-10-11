Unit U_Moteur;

//
//------------------------------------------------------------------------------
// LANGAGE           : DELPHI 3.0
//------------------------------------------------------------------------------
// NOM DU PROGRAMME  : PacMummy
// VERSION           : 1.01
//------------------------------------------------------------------------------
// DATE CREATION     : 04/04/2005
// DATE MODIFICATION : 05/04/2005
//------------------------------------------------------------------------------
// AUTEUR            : Anuviror
//------------------------------------------------------------------------------
// DESCRIPTION       : Beta jeu de labyrinthe pour utilisation abusive des bitmap
//
//------------------------------------------------------------------------------
// MODIFICATION Ver 1.0
// -le 05/04/2004 [Ver 1.01] : - amélioration de la gestion de la souris
//                               et du clavier
//------------------------------------------------------------------------------
//

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, MMSystem;

Type
  TypeSens = (Nord, Est, Sud, Ouest); // Pour connaître le sens des personnages
                                      // dans le labyrinthe
  TForm1 = Class(TForm)
    TimerCarte: TTimer;
    Commande: TGroupBox;
    TrackBar1: TTrackBar;
    CheckSombre: TCheckBox;
    EditSombre: TEdit;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckCacheCarte: TCheckBox;
    PaintBox2: TPaintBox;
    BoutonJoueurPivoterGauche: TBitBtn;
    BoutonJoueurGauche: TBitBtn;
    BoutonJoueurHaut: TBitBtn;
    BoutonJoueurPivoterDroite: TBitBtn;
    BoutonJoueurBas: TBitBtn;
    BoutonJoueurDroite: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TimerJoueurMort: TTimer;
    TimerJoueurGagne: TTimer;
    Procedure ChargerBloc;
    Procedure ChargerCarteSprite;
    Procedure ChargerEnnemiSprite;
    Procedure ChargerFlecheSouris;
    Procedure ChargerBousole;
    Procedure ChargerGagnePerdu;
    Procedure InitNiveau;
    Procedure InitJeu;
    Procedure FormCreate(Sender: TObject);
    Procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure AfficherEnnemiSprite(XPos, YPos, Zoom : Integer; Sens : TypeSens);
    Procedure AfficherCacheCarte;
    Procedure TimerCarteTimer(Sender: TObject);
    Procedure DeplacementJoueurHaut;
    Procedure DeplacementJoueurBas;
    Procedure DeplacementJoueurGauche;
    Procedure DeplacementJoueurDroite;
    Procedure DeplacementJoueurPivoterGauche;
    Procedure DeplacementJoueurPivoterDroite;
    Procedure BoutonJoueurHautClick(Sender: TObject);
    Procedure BoutonJoueurPivoterDroiteClick(Sender: TObject);
    Procedure BoutonJoueurPivoterGaucheClick(Sender: TObject);
    Procedure BoutonJoueurBasClick(Sender: TObject);
    Procedure BoutonJoueurGaucheClick(Sender: TObject);
    Procedure BoutonJoueurDroiteClick(Sender: TObject);
    procedure CheckSombreClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure CheckCacheCarteClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerJoueurMortTimer(Sender: TObject);
    procedure TimerJoueurGagneTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  Private
    { Déclarations privées }
  Public
    { Déclarations publiques }
  End;

Const NomProgramme     = 'PacMummy';
      VersionProgramme = '1.01';

      CrMouseOff = 1;

      CoordBloc : Array [1..8] Of Record // Coordonnées d'affichage des blocs
                                        Gauche,
                                        Centre,
                                        Droite,
                                        Plafond,
                                        Sol       : Record
                                                          X1, Y1, X2, Y2 : Integer;
                                                    End;
                                  End = ((Gauche   : (X1 : 268; Y1 : 91;  X2 : 278; Y2 : 104);
                                          Centre   : (X1 : 274; Y1 : 91;  X2 : 292; Y2 : 104);
                                          Droite   : (X1 : 288; Y1 : 91;  X2 : 298; Y2 : 104);
                                          Plafond  : (X1 : 274; Y1 : 91;  X2 : 292; Y2 : 92);
                                          Sol      : (X1 : 274; Y1 : 101; X2 : 292; Y2 : 104)),

                                         (Gauche   : (X1 : 259; Y1 : 88;  X2 : 274; Y2 : 110);
                                          Centre   : (X1 : 268; Y1 : 88;  X2 : 298; Y2 : 110);
                                          Droite   : (X1 : 292; Y1 : 88;  X2 : 307; Y2 : 110);
                                          Plafond  : (X1 : 268; Y1 : 88;  X2 : 298; Y2 : 90);
                                          Sol      : (X1 : 268; Y1 : 105; X2 : 298; Y2 : 110)),

                                         (Gauche   : (X1 : 246; Y1 : 84;  X2 : 268; Y2 : 119);
                                          Centre   : (X1 : 259; Y1 : 84;  X2 : 307; Y2 : 119);
                                          Droite   : (X1 : 298; Y1 : 84;  X2 : 320; Y2 : 119);
                                          Plafond  : (X1 : 259; Y1 : 84;  X2 : 307; Y2 : 87);
                                          Sol      : (X1 : 259; Y1 : 111; X2 : 307; Y2 : 119)),

                                         (Gauche   : (X1 : 227; Y1 : 77;  X2 : 259; Y2 : 132);
                                          Centre   : (X1 : 246; Y1 : 77;  X2 : 320; Y2 : 132);
                                          Droite   : (X1 : 307; Y1 : 77;  X2 : 339; Y2 : 132);
                                          Plafond  : (X1 : 246; Y1 : 77;  X2 : 320; Y2 : 83);
                                          Sol      : (X1 : 246; Y1 : 120; X2 : 320; Y2 : 132)),

                                         (Gauche   : (X1 : 199; Y1 : 68;  X2 : 246; Y2 : 151);
                                          Centre   : (X1 : 227; Y1 : 68;  X2 : 339; Y2 : 151);
                                          Droite   : (X1 : 320; Y1 : 68;  X2 : 367; Y2 : 151);
                                          Plafond  : (X1 : 227; Y1 : 68;  X2 : 339; Y2 : 76);
                                          Sol      : (X1 : 227; Y1 : 133; X2 : 339; Y2 : 151)),

                                         (Gauche   : (X1 : 157; Y1 : 54;  X2 : 227; Y2 : 179);
                                          Centre   : (X1 : 199; Y1 : 54;  X2 : 367; Y2 : 179);
                                          Droite   : (X1 : 339; Y1 : 54;  X2 : 409; Y2 : 179);
                                          Plafond  : (X1 : 199; Y1 : 54;  X2 : 367; Y2 : 67);
                                          Sol      : (X1 : 199; Y1 : 152; X2 : 367; Y2 : 179)),

                                         (Gauche   : (X1 : 094; Y1 : 33;  X2 : 199; Y2 : 221);
                                          Centre   : (X1 : 157; Y1 : 33;  X2 : 409; Y2 : 221);
                                          Droite   : (X1 : 367; Y1 : 33;  X2 : 472; Y2 : 221);
                                          Plafond  : (X1 : 157; Y1 : 33;  X2 : 409; Y2 : 53);
                                          Sol      : (X1 : 157; Y1 : 180; X2 : 409; Y2 : 221)),

                                         (Gauche   : (X1 : 000; Y1 : 1;   X2 : 157; Y2 : 284);
                                          Centre   : (X1 : 094; Y1 : 1;   X2 : 472; Y2 : 284);
                                          Droite   : (X1 : 409; Y1 : 1;   X2 : 566; Y2 : 284);
                                          Plafond  : (X1 : 094; Y1 : 1;   X2 : 472; Y2 : 32);
                                          Sol      : (X1 : 094; Y1 : 222; X2 : 472; Y2 : 284)));
      // Coord d'affichage en Y des ennemis, X est constant
      YPosEnnemi : Array [1..8] Of Integer = (252, 200, 165, 141, 125, 114, 110, 102);

Type TypeBMPBloc   = Record // Stock des bitmap du labyrinthe
                           SolPlafond : TBitmap;
                           SolPlafondWidth, SolPlafondHeight : Integer;

                           Sortie : TBitmap;
                           SortieWidth, SortieHeight : Integer;

                           Cube : Array [1..3] Of Record
                                                        Gauche, Centre, Droite    : TBitmap;
                                                        GaucheWidth, GaucheHeight : Integer;
                                                        CentreWidth, CentreHeight : Integer;
                                                        DroiteWidth, DroiteHeight : Integer;
                                                  End;
                     End;
     TypeBMPCarteSprite  = Record // Stock les sprites à afficher sur la carte
                                 Joueur : Array [TypeSens] Of TBitmap;
                                 Ennemi : Array [TypeSens] Of TBitmap;
                           End;
     TypeBMPEnnemiSprite = Array [TypeSens] Of Record // Stock les ennemis
                                                     Pixel : TBitmap;
                                                     PixelWidth, PixelHeight : Integer;
                                               End;
     TypeBMPFlecheSouris = Array [1..6] Of TBitmap;
     TypeBMPBousole      = Array [TypeSens] Of TBitmap;
     TypeLaby        = Record // Tous les blocs du niveau
                             XTaille, YTaille   : Byte;     // Taille du labyrinthe
                             XDebut, YDebut     : Byte;     // Position du joueur au début
                             SensDebut          : TypeSens; // Sens du joueur au début
                             XSortie, YSortie   : Byte;     // Coordonnées de la sortie
                             Bloc               : Array [1..20, 1..20] Of Byte;
                       End;
     TypeGuideBloc   = Array [1..8] Of Record // Va contenir les numéros des blocs à afficher
                                             Gauche, Centre, Droite : Byte;  // Bloc à gauche, au centre et à droite
                                             SwSortie               : Boolean;
                                             SwCentre               : Boolean; // Vrai si un ennemi se trouve dans cette case. On ne s'occupe pas des ennemis qui se trouvent à gauche ou à droite puisque qu'ils seront cachés par les blocs
                                             SensCentre             : TypeSens; // Le sens de l'ennemi
                                       End;
     TypePersonnage  = Record
                             XPos, YPos : Integer;
                             Sens       : TypeSens;
                       End;
     TypeRGB         = Record
                             Bleu, Vert, Rouge : Byte;
                       End;
     TypeTRGBArray   = Array [0..570] Of TypeRGB;
     TypePRGBArray   = ^TypeTRGBArray;
     TypeEnnemi      = Array [1..7] Of TypePersonnage;
     TypeEnnemiSensPossible = Record
                                    Combien : Byte;
                                    Sens    : Array [1..4] Of TypeSens;
                              End;

Const Deplacement : Array [TypeSens] Of Record
                                              X, Y, XGauche, YGauche, XDroite, YDroite : Integer;
                                        End = ((X :  0; Y : -1; XGauche : -1; YGauche :  0; XDroite :  1; YDroite :  0),
                                               (X :  1; Y :  0; XGauche :  0; YGauche : -1; XDroite :  0; YDroite :  1),
                                               (X :  0; Y :  1; XGauche :  1; YGauche :  0; XDroite : -1; YDroite :  0),
                                               (X : -1; Y :  0; XGauche :  0; YGauche :  1; XDroite :  0; YDroite : -1));

Var Form1    : TForm1;
    BMPForm1 : TBitmap;

    BMPBuffer : TBitmap;
    BMPZoom   : TBitmap;

    BMPFlecheSouris : TypeBMPFlecheSouris;
    BMPBousole      : TypeBMPBousole;

    BMPGagne, BMPPerdu : TBitmap;

    BMPBloc     : TypeBMPBloc;
    Laby        : TypeLaby;
    GuideBloc   : TypeGuideBloc;

    BMPCarte       : TBitmap;
    BMPCarteSprite : TypeBMPCarteSprite;
    BMPCacheCarte  : TBitmap;
    BMPBufferCarte : TBitmap;
    CarteZoom      : Byte;

    Joueur             : TypePersonnage;
    SwJoueurMort       : Boolean;
    SwAnimJoueurMort   : Boolean;
    CptAnimMort        : Byte;
    CptAnimGagne       : Byte;
    Ennemi             : TypeEnnemi;
    EnnemiMax          : Byte;
    EnnemiSensPossible : TypeEnnemiSensPossible;
    EnnemiPause        : Integer;
    BMPEnnemiSprite    : TypeBMPEnnemiSprite;

    WavePause, CodeWave : Integer;

    crCurseur : Byte;

// Variables utilisées dans Timer. Si elles sont déclarer dans Timer, elles seront
// crées puis effacée sans cesse et donc perte de temps
// Sauf Cpt, CptEnnemi, X, Y qui apparement doit être une variable locale simple
    TCode                            : Byte;
    TXPos, TYPos, TXTaille, TYTaille : Integer;
    TCouleur                         : TColor;
    TRouge, TVert, TBleu             : Integer;
    TScanLine                        : TypePRGBArray;
    TSensInverse                     : TypeSens;
    TSwBlocCentre                    : Boolean;
    TCoordSouris                     : TPoint;

// Commandes pour le programmeur en phase de test
    SwSombre       : Boolean; // Obscurcir le labyrinthe
    SombrePourCent : Byte;
    MaxW, MaxH     : Integer;
    SwCacheCarte   : Boolean; // Masquer ou non le passage du joueur sur la carte
// Fin commandes

Implementation

{$R *.DFM}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Chargement des graphismes                                                  *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.ChargerBloc;
Var Cpt    : Byte;
    StrCpt : String;
Begin
// Le fond : sol et plafond
     BMPBloc.SolPlafond := TBitmap.Create;
     BMPBloc.SolPlafond.LoadFromFile('Bloc\SolPlafond.BMP');
     BMPBloc.SolPlafond.PixelFormat := pf24Bit;
     BMPBloc.SolPlafondWidth := BMPBloc.SolPlafond.Width;
     BMPBloc.SolPlafondHeight := BMPBloc.SolPlafond.Height;

// La sortie
     BMPBloc.Sortie := TBitmap.Create;
     BMPBloc.Sortie.LoadFromFile('Bloc\Sortie.BMP');
     BMPBloc.Sortie.PixelFormat := pf24Bit;
     BMPBloc.SortieWidth := BMPBloc.Sortie.Width;
     BMPBloc.SortieHeight := BMPBloc.Sortie.Height;

// Les 7 styles de cubes (gauche - centre - droite)
     For Cpt := 1 To 3 Do
         Begin
              StrCpt := IntToStr(Cpt);

              BMPBloc.Cube[Cpt].Gauche := TBitmap.Create;
              BMPBloc.Cube[Cpt].Gauche.LoadFromFile('Bloc\Cube' + StrCpt + 'Gauche.BMP');
              BMPBloc.Cube[Cpt].Gauche.PixelFormat := pf24Bit;
              BMPBloc.Cube[Cpt].GaucheWidth := BMPBloc.Cube[Cpt].Gauche.Width;
              BMPBloc.Cube[Cpt].GaucheHeight := BMPBloc.Cube[Cpt].Gauche.Height;

              BMPBloc.Cube[Cpt].Centre := TBitmap.Create;
              BMPBloc.Cube[Cpt].Centre.LoadFromFile('Bloc\Cube' + StrCpt + 'Centre.BMP');
              BMPBloc.Cube[Cpt].Centre.PixelFormat := pf24Bit;
              BMPBloc.Cube[Cpt].CentreWidth := BMPBloc.Cube[Cpt].Centre.Width;
              BMPBloc.Cube[Cpt].CentreHeight := BMPBloc.Cube[Cpt].Centre.Height;

              BMPBloc.Cube[Cpt].Droite := TBitmap.Create;
              BMPBloc.Cube[Cpt].Droite.LoadFromFile('Bloc\Cube' + StrCpt + 'Droite.BMP');
              BMPBloc.Cube[Cpt].Droite.PixelFormat := pf24Bit;
              BMPBloc.Cube[Cpt].DroiteWidth := BMPBloc.Cube[Cpt].Droite.Width;
              BMPBloc.Cube[Cpt].DroiteHeight := BMPBloc.Cube[Cpt].Droite.Height;
         End;
End; {TForm1.ChargerBloc}

Procedure TForm1.ChargerCarteSprite;
Var CptSens : TypeSens;
Begin
     For CptSens := Nord To Ouest Do
         Begin
              BMPCarteSprite.Joueur[CptSens] := TBitmap.Create;
              BMPCarteSprite.Ennemi[CptSens] := TBitmap.Create;
         End;

     BMPCarteSprite.Joueur[Nord].LoadFromFile('CarteSprites\CarteJoueurNord.BMP');
     BMPCarteSprite.Joueur[Est].LoadFromFile('CarteSprites\CarteJoueurEst.BMP');
     BMPCarteSprite.Joueur[Sud].LoadFromFile('CarteSprites\CarteJoueurSud.BMP');
     BMPCarteSprite.Joueur[Ouest].LoadFromFile('CarteSprites\CarteJoueurOuest.BMP');

     BMPCarteSprite.Ennemi[Nord].LoadFromFile('CarteSprites\CarteEnnemiNord.BMP');
     BMPCarteSprite.Ennemi[Est].LoadFromFile('CarteSprites\CarteEnnemiEst.BMP');
     BMPCarteSprite.Ennemi[Sud].LoadFromFile('CarteSprites\CarteEnnemiSud.BMP');
     BMPCarteSprite.Ennemi[Ouest].LoadFromFile('CarteSprites\CarteEnnemiOuest.BMP');

     For CptSens := Nord To Ouest Do
         Begin
              BMPCarteSprite.Joueur[CptSens].PixelFormat := pf24Bit;
              BMPCarteSprite.Ennemi[CptSens].PixelFormat := pf24Bit;
         End;
End; {TForm1.ChargerCarteSprite}

Procedure TForm1.ChargerEnnemiSprite;
Var CptSens : TypeSens;
Begin
     For CptSens := Nord To Ouest Do
         BMPEnnemiSprite[CptSens].Pixel := TBitmap.Create;

     BMPEnnemiSprite[Nord].Pixel.LoadFromFile('EnnemiSprites\EnnemiNord.BMP');
     BMPEnnemiSprite[Est].Pixel.LoadFromFile('EnnemiSprites\EnnemiEst.BMP');
     BMPEnnemiSprite[Sud].Pixel.LoadFromFile('EnnemiSprites\EnnemiSud.BMP');
     BMPEnnemiSprite[Ouest].Pixel.LoadFromFile('EnnemiSprites\EnnemiOuest.BMP');

     For CptSens := Nord To Ouest Do
         Begin
              BMPEnnemiSprite[CptSens].Pixel.PixelFormat := pf24Bit;
              BMPEnnemiSprite[CptSens].PixelWidth := BMPEnnemiSprite[CptSens].Pixel.Width;
              BMPEnnemiSprite[CptSens].PixelHeight := BMPEnnemiSprite[CptSens].Pixel.Height;
         End;
End; {TForm1.ChargerEnnemiSprite}

Procedure TForm1.ChargerFlecheSouris;
Var Cpt : Byte;
Begin
     For Cpt := 1 To 6 Do
         BMPFlecheSouris[Cpt] := TBitmap.Create;

     BMPFlecheSouris[1].LoadFromFile('Fleches\FlecheSourisPivoteGauche.BMP');
     BMPFlecheSouris[2].LoadFromFile('Fleches\FlecheSourisAvant.BMP');
     BMPFlecheSouris[3].LoadFromFile('Fleches\FlecheSourisPivoteDroite.BMP');
     BMPFlecheSouris[4].LoadFromFile('Fleches\FlecheSourisGauche.BMP');
     BMPFlecheSouris[5].LoadFromFile('Fleches\FlecheSourisArriere.BMP');
     BMPFlecheSouris[6].LoadFromFile('Fleches\FlecheSourisDroite.BMP');

     For Cpt := 1 To 6 Do
         Begin
              BMPFlecheSouris[Cpt].PixelFormat := pf24Bit;
              BMPFlecheSouris[Cpt].Transparent := True;
              BMPFlecheSouris[Cpt].TransparentColor := BMPFlecheSouris[Cpt].Canvas.Pixels[0, 0];
         End;
End; {TForm1.ChargerFlecheSouris}

Procedure TForm1.ChargerBousole;
Var Cpt : TypeSens;
Begin
     For Cpt := Nord To Ouest Do
         BMPBousole[Cpt] := TBitmap.Create;

     BMPBousole[Nord].LoadFromFile('Bousole\Nord.BMP');
     BMPBousole[Est].LoadFromFile('Bousole\Est.BMP');
     BMPBousole[Sud].LoadFromFile('Bousole\Sud.BMP');
     BMPBousole[Ouest].LoadFromFile('Bousole\Ouest.BMP');

     For Cpt := Nord To Ouest Do
         Begin
              BMPBousole[Cpt].PixelFormat := pf24Bit;
              BMPBousole[Cpt].Transparent := True;
              BMPBousole[Cpt].TransparentColor := BMPBousole[Cpt].Canvas.Pixels[0, 0];
         End;
End; {TForm1.ChargerBousole}

Procedure TForm1.ChargerGagnePerdu;
Begin
     BMPGagne := TBitmap.Create;
     BMPGagne.LoadFromFile('Divers\Gagne.BMP');
     BMPGagne.PixelFormat := pf24Bit;
     BMPGagne.Transparent := True;
     BMPGagne.TransparentColor := BMPGagne.Canvas.Pixels[0, 0];

     BMPPerdu := TBitmap.Create;
     BMPPerdu.LoadFromFile('Divers\Perdu.BMP');
     BMPPerdu.PixelFormat := pf24Bit;
     BMPPerdu.Transparent := True;
     BMPPerdu.TransparentColor := BMPPerdu.Canvas.Pixels[0, 0];
End; {TForm1.ChargerGagnePerdu}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* CLOSE                                                                      *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
Var Cpt     : Byte;
    CptSens : TypeSens;
Begin
     TimerCarte.Enabled := False;

// Libérer la mémoire
     BMPBuffer.Free;

     With BMPBloc Do
          Begin
               SolPlafond.Free;
               Sortie.Free;
               For Cpt := 1 To 3 Do
                   With Cube[Cpt] Do
                        Begin
                             Gauche.Free;
                             Centre.Free;
                             Droite.Free;
                        End;
          End;

     BMPCarte.Free;
     BMPCacheCarte.Free;
     BMPBufferCarte.Free;

     For CptSens := Nord To Ouest Do
         Begin
              BMPCarteSprite.Joueur[CptSens].Free;
              BMPCarteSprite.Ennemi[CptSens].Free;

              BMPEnnemiSprite[CptSens].Pixel.Free;
         End;

     For Cpt := 1 To 6 Do
         BMPFlecheSouris[Cpt].Free;

     For CptSens := Nord To Ouest Do
         BMPBousole[CptSens].Free;

     BMPGagne.Free;
     BMPPerdu.Free;

     BMPForm1.Free;
End; {TForm1.FormClose}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Initialisations                                                            *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.InitNiveau;
Const Buffer : Array [1..20] Of String = ('13212332212212323321',
                                          '30000000210000130131',
                                          '10123210230130020133',
                                          '20003120000133000121',
                                          '12201232102323020001',
                                          '10000002101200003201',
                                          '20313102200003202303',
                                          '10231203322101100002',
                                          '10032200002300003301',
                                          '33031232201201012103',
                                          '32000322202201000001',
                                          '23130000003201103212',
                                          '11230232100002100002',
                                          '32320322123032322011',
                                          '20000321000000022013',
                                          '10320000021213000021',
                                          '10311232012210010123',
                                          '30200000002310200312',
                                          '30220120300000001323',
                                          '13212313211223322123');
Var X, Y    : Byte;
    Couleur : TColor;
Begin
     With Laby Do
          Begin
               XTaille := 20;
               YTaille := 20;

               XDebut := 2;
               YDebut := 19;
               SensDebut := Nord;

               XSortie := 17;
               YSortie := 2;

               BMPCarte := TBitmap.Create;
               BMPCarte.PixelFormat := pf24Bit;
               BMPCarte.Width := XTaille;
               BMPCarte.Height := YTaille;
               CarteZoom := 5;

               BMPCacheCarte := TBitmap.Create;      // A plaquer sur la carte
               BMPCacheCarte.PixelFormat := pf24Bit; // Le noir cachera une partie de la carte
               BMPCacheCarte.Width := XTaille;       // Le blanc révèlera le chemin déjà pris par le joueur
               BMPCacheCarte.Height := YTaille;

               BMPBufferCarte := TBitmap.Create; // Pour pas que la carte clignote
               BMPBufferCarte.PixelFormat := pf24Bit;
               BMPBufferCarte.Width := XTaille * CarteZoom;
               BMPBufferCarte.Height := YTaille * CarteZoom;

               For Y := 1 To YTaille Do
                   For X := 1 To XTaille Do
                       Begin
                            Bloc[X, Y] := Ord(Buffer[Y, X]) - 48;

                            Case Bloc[X, Y] Of
                                 0    : Couleur := RGB(215, 171, 83);
                                 1..3 : Couleur := RGB(127, 83, 0);
                            Else Couleur := RGB(255, 0, 0);
                            End;

                            BMPCarte.Canvas.Pixels[X-1, Y-1] := Couleur;
                            // Cacher les zones de la carte où le joueur n'est pas encore passé
                            BMPCacheCarte.Canvas.Pixels[X-1, Y-1] := RGB(0, 0, 0);
                       End;
          End;

     EnnemiMax := 7;
     For X := 1 To EnnemiMax Do
         Begin
              Ennemi[X].XPos := X +1;
              Ennemi[X].YPos := 2;
              Ennemi[X].Sens := Nord;
         End;
     EnnemiPause := 0;
End; {TForm1.InitNiveau}

Procedure TForm1.InitJeu;
Begin
     Joueur.XPos := Laby.XDebut;
     Joueur.YPos := Laby.YDebut;
     Joueur.Sens := Laby.SensDebut;
End; {TForm1.InitJeu}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* PROCEDURE FORM_CREATE                                                      *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.FormCreate(Sender: TObject);
Begin
     TimerCarte.Enabled := False;
     TimerJoueurGagne.Enabled := False;
     TimerJoueurMort.Enabled := False;

     Randomize;

     Form1.Caption := NomProgramme + ' ver ' + VersionProgramme;

// Créer l'écran caché
     BMPBuffer := TBitmap.Create;
     BMPBuffer.PixelFormat := pf24Bit;
     BMPBuffer.Width := 567;
     BMPBuffer.Height := 286;

// Chargement des graphiques
     ChargerBloc;
     ChargerCarteSprite;
     ChargerEnnemiSprite;
     ChargerFlecheSouris;
     ChargerBousole;
     ChargerGagnePerdu;

// Initialisations
     InitNiveau;
     InitJeu;

     WavePause := Random(100) + 50; // Le prochaine son dans x temps

     SwJoueurMort := False;
     SwAnimJoueurMort := False;
     CptAnimMort := 0;
     CptAnimGagne := 200;

// Cacher la souris lorsqu'elle est sur le PaintBox1
     PaintBox1.Cursor := crNone;

// Commandes pour le programmeur en phase de test
     SwSombre := True;
     CheckSombre.Checked := SwSombre;
     SombrePourCent := 30;
     TrackBar1.Position := SombrePourCent;
     EditSombre.Text := IntToStr(SombrePourCent);

     ScrollBar1.Position := 100;
     Label1.Caption := 'Vitesse timer : ' + IntToStr(ScrollBar1.Position);
     TimerCarte.Interval := ScrollBar1.Position;

     MaxW := 0; MaxH := 0;
     Label3.Caption := 'Largeur max.: ' + IntToStr(MaxW);
     Label4.Caption := 'Hauteur max.: ' + IntToStr(MaxH);

     SwCacheCarte := True;
     CheckCacheCarte.Checked := SwCacheCarte;
// Fin commandes

     BMPForm1 := TBitmap.Create;
     BMPForm1.LoadFromFile('Divers\EcranDeFond.BMP');
     BMPForm1.PixelFormat := pf24Bit;

     TimerCarte.Enabled := True;
End; {TForm1.FormCreate}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Pour afficher les ennemis avec transparent et zoom                         *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.AfficherEnnemiSprite(XPos, YPos, Zoom : Integer;
                                      Sens             : TypeSens);
Var W, H : Integer;
    Z    : Real;
Begin
// Calculer le zoom pour la largeur et la hauteur
     Z := (Zoom / BMPEnnemiSprite[Sens].PixelHeight) * 0.82;
     W := Trunc(BMPEnnemiSprite[Sens].PixelWidth * Z);
     H := Trunc(BMPEnnemiSprite[Sens].PixelHeight * Z);

     XPos := XPos - (W Div 2); // Centrer l'ennemi
     YPos := YPos - H;

// Va servir pour zoomer les ennemis
     BMPZoom := TBitmap.Create;
     BMPZoom.PixelFormat := pf24Bit;
     BMPZoom.Width := W;
     BMPZoom.Height := H;

     BMPZoom.Canvas.CopyRect(Bounds(0, 0, W, H),
                             BMPEnnemiSprite[Sens].Pixel.Canvas,
                             Bounds(0, 0, BMPEnnemiSprite[Sens].PixelWidth, BMPEnnemiSprite[Sens].PixelHeight));

     BMPZoom.Transparent := True;
     BMPZoom.TransparentColor := BMPZoom.Canvas.Pixels[0, 0];

     BMPBuffer.canvas.Draw(XPos, YPos, BMPZoom);

     BMPZoom.Free;

// Commandes pour le programmeur en phase de test
     If W > MaxW Then MaxW := W;
     If H > MaxH Then MaxH := H;
     Label3.Caption := 'Largeur max.: ' + IntToStr(MaxW);
     Label4.Caption := 'Hauteur max.: ' + IntToStr(MaxH);
// Fin commandes
End; {TForm1.AfficherEnnemiSprite}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Pour afficher la petite carte avec le cache noir                           *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.AfficherCacheCarte;
Begin
     BMPZoom := TBitmap.Create;  // Créer le cache carte à la taille de la carte
     BMPZoom.PixelFormat := pf24Bit;
     BMPZoom.Width := BMPCacheCarte.Width * CarteZoom;
     BMPZoom.Height := BMPCacheCarte.Width * CarteZoom;

     BMPZoom.Canvas.CopyRect(Bounds(0, 0, BMPZoom.Width, BMPZoom.Height),
                             BMPCacheCarte.Canvas,
                             Bounds(0, 0, BMPCacheCarte.Width, BMPCacheCarte.Height));

     BMPZoom.Transparent := True;
     BMPZoom.TransparentColor := RGB(255, 255, 255);

     BMPBufferCarte.Canvas.Draw(0, 0, BMPZoom);

     BMPZoom.Free;
End; {TForm1.AfficherCacheCarte}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Les Timers                                                                 *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)

(*----------------------------------------------------------------------------*)
(* Partie principale du jeu                                                   *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.TimerCarteTimer(Sender: TObject);
Var Cpt, CptEnnemi, X, Y : Integer;
    CptSens              : TypeSens;
Begin
//     GetCursorPos(TCoordSouris); // Coordonnée de la souris par rapport à l'écran
//     TCoordSouris.X := TCoordSouris.X - Left - 24; // Positionnement sur la fenêtre de jeu
//     TCoordSouris.Y := TCoordSouris.Y - Top - 49;

// On arrête d'appeler le Timer au cas où la routine serait trop longue à exécuter
     TimerCarte.Enabled := False;

// Un petit son d'ambiance
     Dec(WavePause);
     If WavePause = 0 Then
        Begin
             CodeWave := Random(4); // Lequel?
             Case CodeWave Of
                  0 : sndPlaySound('Wav\Tombe1.WAV', snd_Async);
                  1 : sndPlaySound('Wav\Tombe2.WAV', snd_Async);
                  2 : sndPlaySound('Wav\Goutte1.WAV', snd_Async);
                  3 : sndPlaySound('Wav\Goutte2.WAV', snd_Async);
             End;
             WavePause := Random(100) + 50; // Le prochaine son dans x temps
        End;

// Changer le sens des ennemis
     Inc(EnnemiPause);
     If EnnemiPause = 10 Then
        Begin
             EnnemiPause := 0;
             For CptEnnemi := 1 To EnnemiMax Do
                 Begin
                      Laby.Bloc[Ennemi[CptEnnemi].XPos, Ennemi[CptEnnemi].YPos] := 0;

                      EnnemiSensPossible.Combien := 0;
                      For CptSens := Nord To Ouest Do // Tester les directions possibles
                          Begin
(*0 1 2 3*)                    TSensInverse := TypeSens((Ord(Ennemi[CptEnnemi].Sens) + 2) Mod 4);
(*N E S O => CptSens*)
(*S O N E => TSensInverse*)    If CptSens <> TSensInverse  Then // Mais pas revenir en arrière, ça fait un effet ping pong désagréable
(*2 3 0 1*)                       If Laby.Bloc[Ennemi[CptEnnemi].XPos + Deplacement[CptSens].X,
                                               Ennemi[CptEnnemi].YPos + Deplacement[CptSens].Y] = 0 Then
                                     Begin // Si possible ...
                                          Inc(EnnemiSensPossible.Combien); // ... 1 sens de plus ...
                                          EnnemiSensPossible.Sens[EnnemiSensPossible.Combien] := CptSens; // ... On le stock pour un tirage au sort
                                     End;
                          End;
                      If EnnemiSensPossible.Combien = 0 Then // Si = 0 => l'ennemi est bloqué soit par un autre ennemi, soit dans en cul-de-sac
                         Begin // Dans ce cas l'ennemi à le droit de revenir en arrière
                              Inc(EnnemiSensPossible.Combien); // ... 1 sens de plus ...
                              EnnemiSensPossible.Sens[EnnemiSensPossible.Combien] := TSensInverse; // ... celui du retour
                         End;

                      Ennemi[CptEnnemi].Sens := EnnemiSensPossible.Sens[Random(EnnemiSensPossible.Combien) + 1];

                      // Calculer la nouvelle position de l'ennemi
                      Ennemi[CptEnnemi].XPos := Ennemi[CptEnnemi].XPos + Deplacement[Ennemi[CptEnnemi].Sens].X;
                      Ennemi[CptEnnemi].YPos := Ennemi[CptEnnemi].YPos + Deplacement[Ennemi[CptEnnemi].Sens].Y;

                      // Définir le sens de l'ennemi dans le labyrinthe.
                      // Cela va servir pour l'affichage de l'ennemi par rapport au sens du joueur
                      Case Ennemi[CptEnnemi].Sens Of
                           Nord  : Laby.Bloc[Ennemi[CptEnnemi].XPos, Ennemi[CptEnnemi].YPos] := 8;
                           Est   : Laby.Bloc[Ennemi[CptEnnemi].XPos, Ennemi[CptEnnemi].YPos] := 9;
                           Sud   : Laby.Bloc[Ennemi[CptEnnemi].XPos, Ennemi[CptEnnemi].YPos] := 10;
                           Ouest : Laby.Bloc[Ennemi[CptEnnemi].XPos, Ennemi[CptEnnemi].YPos] := 11;
                      End;
                 End;
         End;

// Calculer les blocs à afficher
      For Cpt := 1 To 8 Do // Tout initialiser maintenant car dans la 2ème boucle, on ne va peut-être pas jusqu'à Cpt=8
          Begin            // Cette initialisation va éviter les plantage dans la partie "Afficher les blocs 3d"
               GuideBloc[Cpt].Gauche := 0; // Rien à gauche
               GuideBloc[Cpt].Centre := 0; // Rien au centre
               GuideBloc[Cpt].Droite := 0; // Rien à droite
               GuideBloc[Cpt].SwSortie := False; // Pas de sortie visible

               GuideBloc[Cpt].SwCentre := False; // Pas d'ennemi sur la case
               GuideBloc[Cpt].SensCentre := Nord; // Sens de l'ennemi par defaut
          End;

      TXPos := Joueur.XPos; TYPos := Joueur.YPos; // Position du joueur dans le labyrinthe
      TSwBlocCentre := False;
      Cpt := 0;
    Repeat
          Inc(Cpt);

{ +---> } If Not TSwBlocCentre Then // Pour pas afficher la carte derrière un bloc
{ I }        Begin // Révéler les zones de la carte où le joueur est passé
{ I }             BMPCacheCarte.Canvas.Pixels[TXPos-1, TYPos-1] := RGB(255, 255, 255);
{ I }             BMPCacheCarte.Canvas.Pixels[TXPos+Deplacement[Joueur.Sens].XGauche-1, TYPos+Deplacement[Joueur.Sens].YGauche-1] := RGB(255, 255, 255);
{ I }             BMPCacheCarte.Canvas.Pixels[TXPos+Deplacement[Joueur.Sens].XDroite-1, TYPos+Deplacement[Joueur.Sens].YDroite-1] := RGB(255, 255, 255);
{ I }        End;
{ I }
{ I }     If (TXPos = Laby.XSortie) And (TYPos = Laby.YSortie) Then GuideBloc[Cpt].SwSortie := True;
{ I }     TCode := Laby.Bloc[TXPos, TYPos];
{ I }     Case TCode Of // Tester au centre
{ I }          1..3  : Begin
{ I }                       GuideBloc[Cpt].Centre := Laby.Bloc[TXPos, TYPos]; // Un bloc ...
{ +-----------------------} TSwBlocCentre := True;
                       End;
               8..11 : Begin
                            GuideBloc[Cpt].SwCentre := True; // ... ou un ennemi
                            Case TCode Of // C'est assez lourd mais c'est pour définir le sens de l'ennemi par rapport à celui du joueur
{ 8 : si l'ennemi va au Nord ...}8  : Case Joueur.Sens Of // mais comme se sont des CASE OF, tout ne s'exécute pas
                                           Nord  : GuideBloc[Cpt].SensCentre := Nord;
                                           Est   : GuideBloc[Cpt].SensCentre := Ouest;
                                           Sud   : GuideBloc[Cpt].SensCentre := Sud;
                                           Ouest : GuideBloc[Cpt].SensCentre := Est;
                                      End;
                                 9  : Case Joueur.Sens Of { 9 : si l'ennemi va à l'Est ...}
                                           Nord  : GuideBloc[Cpt].SensCentre := Est;
                                           Est   : GuideBloc[Cpt].SensCentre := Nord;
                                           Sud   : GuideBloc[Cpt].SensCentre := Ouest;
                                           Ouest : GuideBloc[Cpt].SensCentre := Sud;
                                      End;
                                 10 : Case Joueur.Sens Of { 10 : si l'ennemi va au Sud ...}
                                           Nord  : GuideBloc[Cpt].SensCentre := Sud;
                                           Est   : GuideBloc[Cpt].SensCentre := Est;
                                           Sud   : GuideBloc[Cpt].SensCentre := Nord;
                                           Ouest : GuideBloc[Cpt].SensCentre := Ouest;
                                      End;
                                 11 : Case Joueur.Sens Of { 11 : si l'ennemi va à l'Ouest...}
                                           Nord  : GuideBloc[Cpt].SensCentre := Ouest;
                                           Est   : GuideBloc[Cpt].SensCentre := Sud;
                                           Sud   : GuideBloc[Cpt].SensCentre := Est;
                                           Ouest : GuideBloc[Cpt].SensCentre := Nord;
                                      End;
                            End;
                       End;
          End;

          If Laby.Bloc[TXPos+Deplacement[Joueur.Sens].XGauche, TYPos+Deplacement[Joueur.Sens].YGauche] In [1..3] Then // Tester à gauche
              GuideBloc[Cpt].Gauche := Laby.Bloc[TXPos+Deplacement[Joueur.Sens].XGauche, TYPos+Deplacement[Joueur.Sens].YGauche];

          If Laby.Bloc[TXPos+Deplacement[Joueur.Sens].XDroite, TYPos+Deplacement[Joueur.Sens].YDroite] In [1..3] Then // Tester à droite
             GuideBloc[Cpt].Droite := Laby.Bloc[TXPos+Deplacement[Joueur.Sens].XDroite, TYPos+Deplacement[Joueur.Sens].YDroite];

          TXPos := TXPos + Deplacement[Joueur.Sens].X;
          TYPos := TYPos + Deplacement[Joueur.Sens].Y;
    Until (Cpt = 8) Or (TXPos < 1) Or (TXpos > Laby.XTaille) Or (TYPos < 1) Or (TYPos > Laby.YTaille); // Si en dehors du labyrinthe

// Afficher les blocs 3D
     BMPBuffer.Canvas.CopyRect(Bounds(94, 0, BMPBloc.SolPlafondWidth, BMPBloc.SolPlafondHeight),
                               BMPBloc.SolPlafond.Canvas,
                               Bounds(0, 0, BMPBloc.SolPlafondWidth, BMPBloc.SolPlafondHeight));
     For Cpt := 8 DownTo 1 Do
         Begin
              If GuideBloc[Cpt].SwSortie Then
              BMPBuffer.Canvas.CopyRect(Rect(CoordBloc[9-Cpt].Sol.X1, CoordBloc[9-Cpt].Sol.Y1, CoordBloc[9-Cpt].Sol.X2, CoordBloc[9-Cpt].Sol.Y2),
                                        BMPBloc.Sortie.Canvas,
                                        Bounds(0, 0, BMPBloc.SortieWidth, BMPBloc.SortieHeight));

              If GuideBloc[Cpt].Gauche <> 0 Then
              BMPBuffer.Canvas.CopyRect(Rect(CoordBloc[9-Cpt].Gauche.X1, CoordBloc[9-Cpt].Gauche.Y1, CoordBloc[9-Cpt].Gauche.X2, CoordBloc[9-Cpt].Gauche.Y2),
                                        BMPBloc.Cube[GuideBloc[Cpt].Gauche].Gauche.Canvas,
                                        Bounds(0, 0, BMPBloc.Cube[GuideBloc[Cpt].Gauche].GaucheWidth, BMPBloc.Cube[GuideBloc[Cpt].Gauche].GaucheHeight));

              If GuideBloc[Cpt].Droite <> 0 Then
              BMPBuffer.Canvas.CopyRect(Rect(CoordBloc[9-Cpt].Droite.X1, CoordBloc[9-Cpt].Droite.Y1, CoordBloc[9-Cpt].Droite.X2, CoordBloc[9-Cpt].Droite.Y2),
                                        BMPBloc.Cube[GuideBloc[Cpt].Droite].Droite.Canvas,
                                        Bounds(0, 0, BMPBloc.Cube[GuideBloc[Cpt].Droite].DroiteWidth, BMPBloc.Cube[GuideBloc[Cpt].Droite].DroiteHeight));

              If GuideBloc[Cpt].Centre <> 0 Then
              BMPBuffer.Canvas.CopyRect(Rect(CoordBloc[9-Cpt].Centre.X1, CoordBloc[9-Cpt].Centre.Y1, CoordBloc[9-Cpt].Centre.X2, CoordBloc[9-Cpt].Centre.Y2),
                                        BMPBloc.Cube[GuideBloc[Cpt].Centre].Centre.Canvas,
                                        Bounds(0, 0, BMPBloc.Cube[GuideBloc[Cpt].Centre].CentreWidth, BMPBloc.Cube[GuideBloc[Cpt].Centre].CentreHeight));

// Afficher les ennemis sur l'écran 3D
              If GuideBloc[Cpt].SwCentre Then
                 Begin
                      TXPos := 283;
                      TYPos := YPosEnnemi[Cpt];
                      AfficherEnnemiSprite(TXPos, TYPos, CoordBloc[9-Cpt].Centre.Y2 - CoordBloc[9-Cpt].Centre.Y1, GuideBloc[Cpt].SensCentre);
                 End;

// Assombrir le labyrinthe
              If SwSombre Then
                 Begin
                      For Y := CoordBloc[9-Cpt].Centre.Y1 To CoordBloc[9-Cpt].Centre.Y2 Do
                          Begin
                               TScanLine := BMPBuffer.ScanLine[Y];
                               For X := 0 To 566 Do
                                   Begin
                                        TRouge := TScanLine[X].Rouge;
                                        TVert  := TScanLine[X].Vert;
                                        TBleu  := TScanLine[X].Bleu;

                                        TRouge := TRouge - SombrePourCent; If TRouge < 0 Then TRouge := 0;
                                        TVert  := TVert  - SombrePourCent; If TVert  < 0 Then TVert  := 0;
                                        TBleu  := TBleu  - SombrePourCent; If TBleu  < 0 Then TBleu  := 0;

                                        TScanLine[X].Rouge := TRouge;
                                        TScanLine[X].Vert  := TVert;
                                        TScanLine[X].Bleu  := TBleu;
                                   End;
                          End;
                 End;
         End;

// Afficher la bousole
     BMPBuffer.Canvas.Draw(267, 14, BMPBousole[Joueur.Sens]);

// Afficher le buffer dans le PaintBox1
     PaintBox1.Canvas.CopyRect(Bounds(0, 0, 316, 237),
                               BmpBuffer.Canvas, Bounds(125, 16, 316, 237));

// Afficher flêche souris
     If ((TCoordSouris.X >= 16) And (TCoordSouris.X <= 94)) And ((TCoordSouris.Y >= 16) And (TCoordSouris.Y <= 102)) Then
        PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[1])
     Else If ((TCoordSouris.X >= 95) And (TCoordSouris.X <= 189)) And ((TCoordSouris.Y >= 16) And (TCoordSouris.Y <= 102)) Then
             PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[2])
          Else If ((TCoordSouris.X >= 190) And (TCoordSouris.X <= 299)) And ((TCoordSouris.Y >= 16) And (TCoordSouris.Y <= 102)) Then
                  PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[3])
               Else If ((TCoordSouris.X >= 16) And (TCoordSouris.X <= 94)) And ((TCoordSouris.Y >= 103) And (TCoordSouris.Y <= 220)) Then
                       PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[4])
                    Else If ((TCoordSouris.X >= 95) And (TCoordSouris.X <= 189)) And ((TCoordSouris.Y >= 103) And (TCoordSouris.Y <= 220)) Then
                            PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[5])
                         Else If ((TCoordSouris.X >= 190) And (TCoordSouris.X <= 299)) And ((TCoordSouris.Y >= 103) And (TCoordSouris.Y <= 220)) Then
                                 PaintBox1.Canvas.Draw(TCoordSouris.X-16, TCoordSouris.Y-16, BMPFlecheSouris[6]);

// Afficher la carte
     BMPCarte.Canvas.Pixels[Laby.XSortie-1, Laby.YSortie-1] := RGB(255, 255, 0); // Symboliser la sortie sur la carte par un point jaune
     BMPBufferCarte.Canvas.CopyRect(Bounds(0, 0, BMPCarte.Width*CarteZoom, BMPCarte.Height*CarteZoom),
                                    BMPCarte.Canvas,
                                    Bounds(0, 0, BMPCarte.Width, BMPCarte.Height));

// Positionner le joueur sur la carte
     TXPos := (Joueur.XPos-1) * CarteZoom; // Position du joueur sur la carte
     TYPos := (Joueur.YPos-1) * CarteZoom;

     TXTaille := Trunc((BMPCarteSprite.Joueur[Joueur.Sens].Width / 14) * CarteZoom); // Zoomer Joueur pour correspondre à la taille de la carte
     TYTaille := Trunc((BMPCarteSprite.Joueur[Joueur.Sens].Height / 14) * CarteZoom); // Zoomer Joueur pour correspondre à la taille de la carte

     BMPBufferCarte.Canvas.CopyRect(Bounds(TXPos, TYPos, TXTaille, TYTaille),
                                    BMPCarteSprite.Joueur[Joueur.Sens].Canvas,
                                    Bounds(0, 0, BMPCarteSprite.Joueur[Joueur.Sens].Width, BMPCarteSprite.Joueur[Joueur.Sens].Height));

// Positionner les ennemis sur la carte
     For CptEnnemi := 1 To EnnemiMax Do
         Begin
              TXPos := (Ennemi[CptEnnemi].XPos-1) * CarteZoom; // Position de l'ennemi sur la carte
              TYPos := (Ennemi[CptEnnemi].YPos-1) * CarteZoom;

// On récupère les TXTaille et TYTaille du joueur
              BMPBufferCarte.Canvas.CopyRect(Bounds(TXPos, TYPos, TXTaille, TYTaille),
                                             BMPCarteSprite.Ennemi[Ennemi[CptEnnemi].Sens].Canvas,
                                             Bounds(0, 0, BMPCarteSprite.Ennemi[Ennemi[CptEnnemi].Sens].Width, BMPCarteSprite.Ennemi[Ennemi[CptEnnemi].Sens].Height));
         End;

     If SwCacheCarte Then AfficherCacheCarte;

     PaintBox2.Canvas.Draw(0, 0, BMPBufferCarte);

// Le joueur est-il mort?
     For Cpt := 1 To EnnemiMax Do
         If (Ennemi[Cpt].XPos = Joueur.XPos) And (Ennemi[Cpt].YPos = Joueur.YPos) Then SwJoueurMort := True;

// Commande pour phase de test
     Label2.Caption := 'Sens joueur : ' + IntToStr(Ord(Joueur.Sens));
     Label5.Caption := 'SourisX = ' + IntToStr(TCoordSouris.X);
     Label6.Caption := 'SourisY = ' + IntToStr(TCoordSouris.Y);
     Label7.Caption := 'Prochaine wave à 0 : ' + IntToStr(WavePause);
     If SwJoueurMort Then Label8.Caption := 'Joueur est mort'
                     Else Label8.Caption := 'Joueur pas mort';
// Fin commande pour phase de test

     If (Joueur.XPos = Laby.XSortie) And (Joueur.YPos = Laby.YSortie) Then
        Begin // Si le joueur est sur la sortie
             TimerJoueurGagne.Enabled := True;
             BMPBuffer.Canvas.Draw(150, 90, BMPGagne);
        End
     Else If Not SwJoueurMort Then TimerCarte.Enabled := True // Si le joueur n'est pas mort, on recommence
          Else Begin // sinon ...
                    TimerJoueurMort.Enabled := True;
                    BMPBuffer.Canvas.Draw(210, 35, BMPPerdu);
               End;
End; {TForm1.TimerCarteTimer}

(*----------------------------------------------------------------------------*)
(* Animation lorsque le joueur a gagné                                        *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.TimerJoueurGagneTimer(Sender: TObject);
Var X, Y : Integer;
Begin
     For Y := 16 To 285 Do
         Begin
              TScanLine := BMPBuffer.ScanLine[Y];
              For X := 125 To 440 Do
                  Begin
                       TRouge := (TScanLine[X-1].Rouge + TScanLine[X+0].Rouge + TScanLine[X+1].Rouge) Div 3;
                       TVert  := (TScanLine[X-1].Vert  + TScanLine[X+0].Vert  + TScanLine[X+1].Vert) Div 3;
                       TBleu  := (TScanLine[X-1].Bleu  + TScanLine[X+0].Bleu  + TScanLine[X+1].Bleu) Div 3;

                       TScanLine[X].Rouge := (TRouge);
                       TScanLine[X].Vert  := (TVert);
                       TScanLine[X].Bleu  := (TBleu);
                  End;
         End;

     BMPBuffer.Canvas.Draw(150, 90, BMPGagne);

     PaintBox1.Canvas.CopyRect(Bounds(0, 0, 316, 237),
                               BmpBuffer.Canvas, Bounds(125, 16, 316, 237));

     Dec(CptAnimGagne);
     If CptAnimGagne = 0 Then Close; // Appel de TForm1.FormClose et puis quitte le programme
End; {TForm1.TimerGagneTimer}

(*----------------------------------------------------------------------------*)
(* Animation lorsque le joueur a perdu                                        *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.TimerJoueurMortTimer(Sender: TObject);
Var X, Y : Integer;
Begin
     For Y := 16 To 285 Do
         Begin
              TScanLine := BMPBuffer.ScanLine[Y];
              For X := 125 To 440 Do
                  Begin
                       TRouge := TScanLine[X].Rouge;
                       TVert  := TScanLine[X].Vert;
                       TBleu  := TScanLine[X].Bleu;

                       If TRouge < 255 Then Inc(TRouge);
                       If TVert > 0 Then Dec(TVert);
                       If TBleu > 0 Then Dec(TBleu);

                       TScanLine[X].Rouge := TRouge;
                       TScanLine[X].Vert  := TVert;
                       TScanLine[X].Bleu  := TBleu;
                  End;
         End;

     PaintBox1.Canvas.CopyRect(Bounds(0, 0, 316, 237),
                               BmpBuffer.Canvas, Bounds(125, 16, 316, 237-CptAnimMort));

     Inc(CptAnimMort, 1);
     If CptAnimMort >= 236 Then
        Begin
             CptAnimMort := 236;
             SwAnimJoueurMort := True;
        End;

     If SwAnimJoueurMort Then Close; // Appel de TForm1.FormClose et puis quitte le programme
End; {TForm1.TimerJoueurMortTimer}

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Déplacement du joueur                                                      *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)

(*----------------------------------------------------------------------------*)
(* Procédures pour calculer les déplacements                                   *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.DeplacementJoueurHaut;
Var XPos, YPos : Integer;
Begin
// Calculer la nouvelle position du joueur
     XPos := Joueur.XPos + Deplacement[Joueur.Sens].X;
     YPos := Joueur.YPos + Deplacement[Joueur.Sens].Y;

// Le joueur peut-il y aller?
     Case Laby.Bloc[XPos, YPos] Of
              0 : Begin // Oui, on confirme les nouvelles coordonnées
                       Joueur.XPos := XPos;
                       Joueur.YPos := YPos;
                  End;
          8..11 : SwJoueurMort := True; // Un ennemi
     End;
End; {TForm1.DeplacementJoueurHaut}

Procedure TForm1.DeplacementJoueurBas;
Var XPos, YPos : Integer;
Begin
// Calculer la nouvelle position du joueur
     XPos := Joueur.XPos - Deplacement[Joueur.Sens].X;
     YPos := Joueur.YPos - Deplacement[Joueur.Sens].Y;

// Le joueur peut-il y aller?
     Case Laby.Bloc[XPos, YPos] Of
              0 : Begin // Oui, on confirme les nouvelles coordonnées
                       Joueur.XPos := XPos;
                       Joueur.YPos := YPos;
                  End;
          8..11 : SwJoueurMort := True; // Un ennemi
     End;
End; {TForm1.DeplacementJoueurBas}

Procedure TForm1.DeplacementJoueurGauche;
Var XPos, YPos : Integer;
Begin
// Calculer la nouvelle position du joueur
     XPos := Joueur.XPos + Deplacement[Joueur.Sens].Y;
     YPos := Joueur.YPos - Deplacement[Joueur.Sens].X;

// Le joueur peut-il y aller?
     Case Laby.Bloc[XPos, YPos] Of
              0 : Begin // Oui, on confirme les nouvelles coordonnées
                       Joueur.XPos := XPos;
                       Joueur.YPos := YPos;
                  End;
          8..11 : SwJoueurMort := True; // Un ennemi
     End;
End; {TForm1.DeplacementJoueurGauche}

Procedure TForm1.DeplacementJoueurDroite;
Var XPos, YPos : Integer;
Begin
// Calculer la nouvelle position du joueur
     XPos := Joueur.XPos - Deplacement[Joueur.Sens].Y;
     YPos := Joueur.YPos + Deplacement[Joueur.Sens].X;

// Le joueur peut-il y aller?
     Case Laby.Bloc[XPos, YPos] Of
              0 : Begin // Oui, on confirme les nouvelles coordonnées
                       Joueur.XPos := XPos;
                       Joueur.YPos := YPos;
                  End;
          8..11 : SwJoueurMort := True; // Un ennemi
     End;
End; {TForm1.DeplacementJoueurDroite}

Procedure TForm1.DeplacementJoueurPivoterGauche;
Begin
     If Joueur.Sens = Nord Then Joueur.Sens := Ouest
                           Else Dec(Joueur.Sens, 1);
End; {TForm1.DeplacementJoueurPivoterGauche}

Procedure TForm1.DeplacementJoueurPivoterDroite;
Begin
     If Joueur.Sens = Ouest Then Joueur.Sens := Nord
                            Else Inc(Joueur.Sens, 1);
End; {TForm1.DeplacementJoueurPivoterDroite}

(*----------------------------------------------------------------------------*)
(* Déplacement par boutons                                                    *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.BoutonJoueurHautClick(Sender: TObject);
Begin
     DeplacementJoueurHaut;
End; {TForm1.BoutonJoueurHautClick}

Procedure TForm1.BoutonJoueurBasClick(Sender: TObject);
Begin
     DeplacementJoueurBas;
End; {TForm1.BoutonJoueurBasClick}

Procedure TForm1.BoutonJoueurGaucheClick(Sender: TObject);
Begin
     DeplacementJoueurGauche;
End; {TForm1.BoutonJoueurGaucheClick}

Procedure TForm1.BoutonJoueurDroiteClick(Sender: TObject);
Begin
     DeplacementJoueurDroite;
End; {TForm1.BoutonJoueurDroiteClick}

Procedure TForm1.BoutonJoueurPivoterDroiteClick(Sender: TObject);
Begin
     DeplacementJoueurPivoterDroite;
End; {TForm1.BoutonJoueurPivoterDroiteClick}

Procedure TForm1.BoutonJoueurPivoterGaucheClick(Sender: TObject);
Begin
     DeplacementJoueurPivoterGauche;
End; {TForm1.BoutonJoueurPivoterGaucheClick}

(*----------------------------------------------------------------------------*)
(* Déplacement par souris sur la zone du jeu                                  *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
Begin
     TCoordSouris := Point(X, Y);
End;

Procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
     If ((X >= 16) And (X <= 94)) And ((Y >= 16) And (Y <= 102)) Then DeplacementJoueurPivoterGauche
     Else If ((X >= 95) And (X <= 189)) And ((Y >= 16) And (Y <= 102)) Then DeplacementJoueurHaut
          Else If ((X >= 190) And (X <= 299)) And ((Y >= 16) And (Y <= 102)) Then DeplacementJoueurPivoterDroite
               Else If ((X >= 16) And (X <= 94)) And ((Y >= 103) And (Y <= 220)) Then DeplacementJoueurGauche
                    Else If ((X >= 95) And (X <= 189)) And ((Y >= 103) And (Y <= 220)) Then DeplacementJoueurBas
                         Else If ((X >= 190) And (X <= 299)) And ((Y >= 103) And (Y <= 220)) Then DeplacementJoueurDroite;
End;

(*----------------------------------------------------------------------------*)
(* Déplacement par clavier                                                    *)
(*----------------------------------------------------------------------------*)
Procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
     Case Key Of
          VK_NUMPAD4 : DeplacementJoueurGauche;
          VK_NUMPAD5 : DeplacementJoueurBas;
          VK_NUMPAD6 : DeplacementJoueurDroite;
          VK_NUMPAD7 : DeplacementJoueurPivoterGauche;
          VK_NUMPAD8 : DeplacementJoueurHaut;
          VK_NUMPAD9 : DeplacementJoueurPivoterDroite;
     End;
End;

(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
(*----------------------------------------------------------------------------*)
(* Les commandes pour le programmeur                                          *)
(*----------------------------------------------------------------------------*)
(*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*)
Procedure TForm1.CheckSombreClick(Sender: TObject);
Begin
     SwSombre := CheckSombre.Checked;
End;

Procedure TForm1.TrackBar1Change(Sender: TObject);
Begin
     SombrePourCent := TrackBar1.Position;
     EditSombre.Text := IntToStr(SombrePourCent);
End;

Procedure TForm1.ScrollBar1Change(Sender: TObject);
Begin
     Label1.Caption := 'Vitesse timer : ' + IntToStr(ScrollBar1.Position);
     TimerCarte.Interval := ScrollBar1.Position;
End;

Procedure TForm1.CheckCacheCarteClick(Sender: TObject);
Begin
     SwCacheCarte := CheckCacheCarte.Checked;
End;
// Fin commandes

Procedure TForm1.FormPaint(Sender: TObject);
Begin
     Canvas.CopyRect(Bounds(0, 0, BMPForm1.Width, BMPForm1.Height),
                     BMPForm1.Canvas, Bounds(0, 0, BMPForm1.Width, BMPForm1.Height));
End;

End.

