unit NavigatorFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GraphMois;

type
  TNavigator = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Cur: TCurves;
    MaxX, MinX, MaxY, MinY,
    scMaxX, scMinX, scMaxY, scMinY : Double;
    Sh : Boolean;
    RN, sRN : TRect;
    Pt : TPoint;
    MDown : Boolean;
    KY, KX : Double;
    procedure WMNCHitTest (var M: TWMNCHitTest); message wm_NCHitTest;
  public
    constructor Create(AOwner : TComponent); override;
    procedure UpdateWin(aCur : TCurves; aMaxX, aMinX, aMaxY, aMinY,
                        aScMaxX, aScMinX, aScMaxY, aScMinY : Double; aSh : Boolean);
  end;

var
  Navigator: TNavigator;

implementation

{$R *.dfm}

{ TSmallPanoram }

procedure TNavigator.WMNCHitTest(var M: TWMNCHitTest);
begin
 inherited;
 if (M.Result = htClient) and
     not PtInRect(RN, ScreenToClient(Point(M.XPos, M.YPos))) then
   M.Result := htCaption;
end;

procedure TNavigator.FormPaint(Sender: TObject);
var
  BC : TColor;
  I, J : Integer;
  BM : TBitmap;
  GP : TGraphPoint;
begin
  with Canvas do begin
    BC := Brush.Color;
    Brush.Color := clGray;
    FrameRect(ClientRect);
    Brush.Color := BC;
  end;
  if Cur = nil then Exit;

  BM := TBitmap.Create;
  BM.Width := ClientWidth;
  BM.Height := ClientHeight;

  with BM.Canvas do begin
    BC := Brush.Color;
    Brush.Color := clGray;
    FrameRect(ClientRect);
    Brush.Color := BC;

    Pen.Width := 1;
    if Cur.Count > 0 then begin
      IntersectClipRect(BM.Canvas.Handle, 1, 1, Width-1, Height-1);
      KY := (ClientHeight-2) / (MaxY - MinY);
      KX := (ClientWidth-2) / (MaxX - MinX);

      for J := 0 to Cur.Count - 1 do begin
        if Cur.Items[J].GetLen <=1  then continue;
        Pen.Color := Cur.Items[J].ColorGraph;

        GP := Cur.Items[J].GetPoint(0);
        MoveTo(Round(KX * (GP.X - MinX)), BM.Height - Round(KY * (GP.Y - MinY)));
        for I := 1 to Cur.Items[J].GetLen do begin
          GP := Cur.Items[J].GetPoint(I);
          LineTo(Round(KX * (GP.X - MinX)), BM.Height - Round(KY * (GP.Y - MinX)));
        end;
      end;
      if Sh then begin
        BC := Brush.Color;
        Brush.Color := clRed;

        if not MDown then begin
          RN := Rect(Round(KX * (scMinX - MinX)), BM.Height - Round(KY * (scMaxY - MinY)),
                     Round(KX * (scMaxX - MinX)), BM.Height - Round(KY * (scMinY - MinY)));
          if RN.Right-RN.Left < 8 then
            RN.Right := RN.Left + 8;
          if RN.Bottom - RN.Top < 8 then
            RN.Bottom := RN.Top + 8;
        end{ else
          RN := ClientRect};
        FrameRect(RN);
        Brush.Color := BC;
      end;
    end;
  end;
  Canvas.CopyRect(ClientRect, BM.Canvas, ClientRect);
  BM.Free;
end;

procedure TNavigator.UpdateWin(aCur: TCurves; aMaxX, aMinX, aMaxY, aMinY,
                        aScMaxX, aScMinX, aScMaxY, aScMinY: Double; aSh : Boolean);
begin
  Cur:=aCur;
  MaxX := aMaxX; MinX := aMinX; MaxY := aMaxY; MinY := aMinY;
  ScMaxX := aScMaxX; ScMinX := aScMinX; ScMaxY := aScMaxY; ScMinY := aScMinY;
  Sh := aSh;
  Invalidate;
end;

constructor TNavigator.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
end;

procedure TNavigator.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var AX, AY : Integer;
begin
  if (ssLeft in Shift) and PtInRect(RN, Point(X, Y)) then begin
    OffsetRect(RN, X-Pt.X, Y-Pt.Y);
    if RN.Left < 1 then OffsetRect(RN, -RN.Left+1, 0);
    if RN.Right > ClientWidth then OffsetRect(RN, ClientWidth-RN.Right, 0);
    if RN.Top < 1 then OffsetRect(Rn, 0, -RN.Top+1);
    if RN.Bottom > ClientHeight then OffsetRect(RN, 0, ClientHeight-RN.Bottom);
    Pt := Point(X, Y);
    Invalidate;
  end;
end;

procedure TNavigator.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if PtInRect(RN, Point(X, Y)) then begin
    Pt := Point(X, Y);
    MDown := True;
  end;
end;

procedure TNavigator.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if MDown and not EqualRect(RN, sRN) then begin
    sRN := RN;
    TGraphMois(Owner).ShiftFromNavigator((RN.Left + KX*MinX)/KX,
                                         (Height-RN.Top - KY*MinY)/KY);
  end;
  MDown := False;
end;

end.
