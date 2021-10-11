program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  NavigatorFrm in '..\..\Lib\NavigatorFrm.pas' {Navigator};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TNavigator, Navigator);
  Application.Run;
end.
