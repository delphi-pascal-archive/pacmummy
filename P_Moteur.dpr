program P_Moteur;

uses
  Forms,
  U_Moteur in 'U_Moteur.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
