unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GraphMois, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, ComCtrls,
  AppEvnts, Buttons, XPMan;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    Button4: TButton;
    Button3: TButton;
    ApplicationEvents1: TApplicationEvents;
    GraphMois1: TGraphMois;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Button5: TButton;
    ColorDialog1: TColorDialog;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure GraphMois1ScaleChange(Sender: TObject; NewScale: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    SL : TStringList;
    FS : TFormatSettings;
    procedure FirstC(Slowly : Boolean);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Math;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FirstC(False);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GraphMois1.Navigator := not GraphMois1.Navigator;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SL := TStringList.Create;
  FS.DecimalSeparator := '.';

  SL.LoadFromFile('ht_02.htl');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SL.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  I, J: integer;
begin
  GraphMois1.Curves[0].ClearPoints;
  GraphMois1.Scale := 100;
  for i := 0 to 100 do begin
    GraphMois1.Curves[1].AddPoint(I, sqr(i));
    Application.ProcessMessages;
    sleep(50);
  end
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GraphMois1.Scale := 100;
end;

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  if Msg.message=WM_MOUSEWHEEL then begin
    Msg.hwnd:=WindowFromPoint(SmallPointToPoint(TSmallPoint(Msg.lParam)));
    SendMessage(Msg.hwnd, WM_MOUSEWHEEL, Msg.WParam, Msg.LParam);
    Handled := True;
  end;
end;

procedure TForm1.GraphMois1ScaleChange(Sender: TObject; NewScale: Integer);
begin
  Label1.Caption := 'Масштаб: '+IntToStr(NewScale)+'%';
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  GraphMois1.Details := not GraphMois1.Details;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  GraphMois1.Curves[0].ClearPoints;
  FirstC(True);
end;

procedure TForm1.FirstC(Slowly: Boolean);
var I, K, K2 : Integer; Y, Y2, X : Extended;
  S, S1 : String;
begin
  GraphMois1.MinXValue := 0;
  GraphMois1.MaxXValue := 100;
  GraphMois1.MinYValue := 0;
  GraphMois1.MaxYValue := 100;
  GraphMois1.Scale := 100;
  for I := 0 to SL.Count - 1 do begin
    S := SL[I];
    K := Pos(';', S);              //33.141;100.000;99.750;27.000
    S1 := Copy(S, 1, K-1);
    X := StrToFloatDef(S1, 0, FS);
    S := Copy(S, K + 1, 255);      //100.000;99.750;27.000

    K := Pos(';', S);
    S1 := Copy(S, 1, K-1);
    Y2 := StrToFloat(S1, FS);
    S := Copy(S, K + 1, 255);      //99.750;27.000

    K := Pos(';', S);
    S1 := Copy(S, 1, K-1);
    Y := StrToFloat(S1, FS);
    S := Copy(S, K + 1, 255);      //27.000

    Y := StrToFloat(S, FS);
    GraphMois1.Curves[0].AddPoint(X, Y);
    if Slowly then begin
      Application.ProcessMessages;
      sleep(10);
    end;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  GraphMois1.Curves[0].ColorGraph := ColorDialog1.Color;
end;

end.


