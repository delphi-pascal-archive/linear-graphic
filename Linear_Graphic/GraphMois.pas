{Компонент выводит двумерные графики функций f(X,Y). Вид графиков - линейный.
 Альтернатива TChart - как примитивный и от того простой компонент без наворотов.
 Кривых на графике может быть более одной.
 Кривые выводяться только в run-time.
 В design-time - доступны нижеприведенные свойства.

свойства (могут устанавливаться и в run-time):
---
  Curves        - "список" кривых.
                  Каждый элемент в списке хранит точки одной кривой (серию точек).
                  Кривые в design-time добавляется через стандартный список,
                  вызываемый через кнопку в свойстве "Curves" в Object Inspector.
                  В run-time кривые добавляются вызовом: Graph1.Curves.Add;
      Свойства кривых:
    ColorGraph  - цвет линии (по умолч. clBlack).
    ThickLine   - толщина линии в точках (по умолч. 1)
    Details     - если True, вид кривой меняется на "детализированный" вид.
                  Точки отображаются квадратиками, соединенными линией в 1 пиксел.
                  Величина квадратов зависит от ThickLine, но, если ThickLine = 1,
                  то величина квадратов принудительно устанавливается в 5 пикселей.
                  Полезное свойство, наглядно показывающее точки кривых.
---
  Color         - цвет фона (поверхности) компонента
  ColorAxis     - цвет осей (обрамление графика)
  ColorGrid     - цвет линий сетки (нужен, если цвет линий совпадает с цветом фона)
  GridX, GridY  - включение/выключение видимости пунктирных линий графика (сетки)

  MaxXValue,    - миним. и максимальные значения графика по осям. X - гориз. и Y - верт.
  MaxYValue,      При добавлении точек в кривую и выходе их значений за установленный 
  MinXValue,      максимум или минимум происходит автомасштабирование.
  MinXValue 

  StepScale     - шаг увеличения (уменьшения) при каждом изменении масштаба
                  (по умолч. = 100, т.е изменение происходит каждый раз на 100%)
  ShowHint      - включает/отключает отображение значений точек на кривой
                  в виде хинта. Отображение появляется при условии, что курсор находится
                  на точке или близко рядом с ней. В хинте первое число - номер точки.
  DecimalHint   - определяет количество знаков после запятой при отображении значений
                  точек с помощью ShowHint (по умолч. = 1).
  ShowTextScale - включает/выключает текст, отображающий текущий масштаб графика.

  Details       - если установлено в False, то вид каждой кривой можно менять
                  отдельно в их собственных свойствах с таким же названием.
                  если установлено в  True, то свойства Details в кривых не будут иметь
                  эффекта, а вид ВСЕХ кривых на графике будет "детализированным".

  Precision     - точность отображения меток на осях (значение в диапазоне 0..3).
                  Вообще то компонент сам определяет какой точности должны быть метки
                  на шкалах осей, но если это свойство установлено в 0, а метки в текущем
                  масштабе нужно выводить с точностью до 2-знаков, то надписи
                  будут налезать друг на друга.
                  Это свойство надо менять и в том случае, если значения точек на
                  кривой должны быть с точностью 2-3 знака.

  OnScaleChange - событие на изменение масштаба. В параметре - изменненный масштаб.

свойства, которые можно менять из приложения:
  Scale         - (в run-time) масштаб графика - целочисленное значение в %.
                  Это значение не может быть < 100.
  Navigator     - (в run-time) показывает/скрывает небольшое полупрозрачное окно, в котором
                  кривые отображаются полностью, а при масштабе большем 100% и рамка
                  показывающая какой фрагмент графика виден в окне компонента.
                  Если двигать рамку мышкой с прижатой левой кнопкой, то, после того,
                  как отпущена кнопка мыши график в окне компонента тоже сдвигается.
                  При больших масштабах точность позиционирования с помощью рамки резко снижается.
                  "Панорама" графика - отдельное окно, которое можно таскать мышкой,
                  если курсор мыши вне рамки.

обращение к методам и свойствам компонента в run-tine:
     Вызов этих методов приводит к обновлению (перерисовке) графика.
  Graph1.Curves[0].AddPoint(X, Y) - добавление точки кривой (здесь в первую кривую)
  Graph1.Curves[0].ClearPoints    - удаление кривой - очистка графика от точек кривой (здесь первая кривая)
  GraphMois1.Details := True      - переводит вид всех кривых в "детализированный" вид.
  GraphMois1.Curves[1].Details := True
     - переводит вид указанной кривой в "детализированный" вид.
       Если GraphMois1.Details = True, то ничего не делается.

  GraphMois1.Navigator := True/False    
     - показывает/скрывает полупрозрачную форточку, отображающую панораму графика.

  Graph1.GetGraphPointByPoint(Pt : TPoint) : TGraphPoint;
       - функция возвращает значения точки на графике (X, Y - TGraphPoint)
         в зависимости от заданной пиксельной точки на компоненте (Pt - TPoint)
  GraphMois1.Curves[0].GetPoint(Index, var aX, aY : Double);
       - процедура в параметрах возвращает сохраненное значение точки по индексу (номеру точки)
  GraphMois1.Curves[0].GetPoint(Index : Integer) : TGraphPoint
       - функция - делает то же самое, что и процедура с одноименным наименованием,
         возвращая по индексу пару значений в структуре TGraphPoint.
         (индекс - номер точки, начинается с 0)
  Структура TGraphPoint объявлена в этом модуле.

управление графиком:
Мышь (при условии, что есть хотя бы одна кривая):
  клик левой - увеличение масштаба на StepScale (действие на отпускание кнопки, а не нажатие);
      по точке под курсором график пытается центрироваться;
  клик правой - уменьшение масштаба на величину StepScale;
  движение курсора мыши с прижатой левой кнопкой - панорамирование графика, при условии,
      что масштаб графика уже увеличен (> 100%);
  клик средней кнопки (колеса) - установка масштаба в начальные 100%.
  колесо на себя - увеличение масштаба на величину StepScale/2.
  колосо от себя - уменьшение масштаба.
Клавиатура:
  "+" на цифровой клавиатуре увеличивает масштаб (точка увеличения = центр графика);
  "-" там же, уменьшает масштаб графика.
  "*" там же, приводит масштаб к начальным 100%.
  клавиши-стрелки сдвигают (паранорамируют) график в соответствии с назначением клавиш.
    с нажатоой кл. Ctrl проворачивают график "постранично" - влево, вправо, вверх, вниз
    примерно на видимую часть графика.
          Клавиатурные команды действуют и без кривых на графике

особенности:
  - при формировании графика после момента ручного увеличения масштаба графика
    автомасштабирование отключается. Т.е. автомасштабирование работает только
    при масштабе 100%.
    Таким образом, для наглядности формирования кривых их вывод лучше делать при масштабе 100%.

  - т.к. графики линейный (кривые состоят из линий, соединяющих передаваемые точки),
    то наличие только одной точки в кривой ничего не отобразит.

ограничение:
  - график показывает точки кривой и метки засечек осей с предельной точностью до 0.001

----------- Пример применения компонента --------------
После добавления кривой в компонент (через свойство "Curves"),
в функцию, связанной с кнопкой на форме поместить такой код:

procedure TForm1.Button1Click(Sender: TObject);
var
  I: integer;
begin
  for i := 0 to 100 do begin
    GraphMois1.Curves[0].AddPoint(I, sqr(i));
//    Application.ProcessMessages;
//    sleep(50);
  end
end;

Формируется и выводиться график функции f = x**2.
Операторы в комментариях позволяют увидеть формирование кривой графика в замедленном темпе.

-------
Основное: при перерисовке (а это может происходить очень часто, например, при
панорамировании) график не дергается.
}

unit GraphMois;

interface

uses
  Windows, Messages, Types, SysUtils, Classes, Controls, ExtCtrls, Graphics, Forms;

type
  TGraphPoint = record
    X, Y : Double;
  end;

  TGraphMois = class;
  TCurveClass = class of TCurve;

  TCurve = class(TCollectionItem)
  private
    FThickLine: Integer;
    FColorGraph: TColor;
    FDetails: Boolean;
    procedure SetColorGraph(const Value: TColor);
    procedure SetThickLine(const Value: Integer);
    procedure SetDetails(const Value: Boolean);
  protected
    ArrayDX, ArrayDY : array of Double;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddPoint(aX, aY : Double);
    procedure GetPoint(Index: Integer; var aX, aY : Double); overload;
    function GetPoint(Index: Integer) : TGraphPoint; overload;
    procedure ClearPoints;
    function GetLen : Integer;
  published
    property ColorGraph : TColor read FColorGraph write SetColorGraph;
    property ThickLine : Integer read FThickLine write SetThickLine;
    property Details : Boolean read FDetails write SetDetails;
  end;

  TCurves = class(TCollection)
  private
    FGraphic: TGraphMois;
    function GetItem(Index: Integer): TCurve;
    procedure SetItem(Index: Integer; const Value: TCurve);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Graphic: TGraphMois);
    function Add: TCurve;
    property Items[Index: Integer]: TCurve read GetItem write SetItem; default;
  end;

  TScaleChangeEvent = procedure(Sender: TObject; NewScale : Integer) of object;

  TGraphMois = class(TCustomControl)
  private
    FColorAxis: TColor;
    FMinXValue: Double;
    FMaxXValue: Double;
    FMinYValue: Double;
    FMaxYValue: Double;
    FColor: TColor;
    FGridY: Boolean;
    FGridX: Boolean;
    FColorGrid: TColor;
    FCurves: TCurves;
    FScale: Integer;
    FStepScale: Integer;
    FDecimalHint: ShortInt;
    FOnScaleChange: TScaleChangeEvent;
    FShowTextScale: Boolean;
    FDetails: Boolean;
    FPrecision: ShortInt;
    FNavigator: Boolean;
    procedure SetColorAxis(const Value: TColor);
    procedure SetMaxXValue(const Value: Double);
    procedure SetMinXValue(const Value: Double);
    procedure SetMaxYValue(const Value: Double);
    procedure SetMinYValue(const Value: Double);
    procedure SetColor(const Value: TColor);
    procedure SetGridX(const Value: Boolean);
    procedure SetGridY(const Value: Boolean);
    procedure SetColorGrid(const Value: TColor);
    procedure SetCurves(const Value: TCurves);
    procedure SetScale(const Value: Integer);
    procedure SetStepScale(const Value: Integer);
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure SetDecimalHint(const Value: ShortInt);
    procedure SetShowTextScale(const Value: Boolean);
    procedure SetDetails(const Value: Boolean);
    procedure SetPrecision(const Value: ShortInt);
    procedure SetNavigator(const Value: Boolean);
  protected
    LenX, LenY : Integer;
    PHit : TPoint;
    MargX, MargY : Integer;
    VpDY, VpDX : Double;
    scMinY, scMaxY, scMinX, scMaxX : Double;
    SclK : Double;
    IsMDown, IsMMove : Boolean;
    KfZaX, KfZaY : Double;
    clTxtScale : TColor;
    RTextX, RTextY : TRect;
    SmPan : TForm;
    procedure DoPaint(Sender: TObject);
    function GetCurveClass: TCurveClass; virtual;
    function CreateCurves: TCurves; virtual;
    procedure ShiftGraph(NewP : TPoint);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function IsCurves : Boolean;
    procedure Paint; override;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    function GetPrecisionForShow(Step : Double) : ShortInt;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function GetGraphPointByPoint(P : TPoint) : TGraphPoint;
    function FindPointOnCurve(P : TPoint; var Ind : Integer; var GP : TGraphPoint) : Boolean;
    procedure ScaleChange(Source: TObject; NewScale : Integer);
    procedure ShiftFromNavigator(scX, scY : Double);
    property Scale : Integer read FScale write SetScale;
    property Navigator : Boolean read FNavigator write SetNavigator;
  published
    property ColorAxis: TColor read FColorAxis write SetColorAxis;
    property MinXValue: Double read FMinXValue write SetMinXValue;
    property MaxXValue: Double read FMaxXValue write SetMaxXValue;
    property MinYValue: Double read FMinYValue write SetMinYValue;
    property MaxYValue: Double read FMaxYValue write SetMaxYValue;
    property GridX : Boolean read FGridX write SetGridX;
    property GridY : Boolean read FGridY write SetGridY;
    property Color : TColor read FColor write SetColor;
    property ColorGrid : TColor read FColorGrid write SetColorGrid;
    property StepScale : Integer read FStepScale write SetStepScale;
    property Curves : TCurves read FCurves write SetCurves;
    property DecimalHint : ShortInt read FDecimalHint write SetDecimalHint;
    property ShowTextScale :Boolean read FShowTextScale write SetShowTextScale;
    property Precision : ShortInt read FPrecision write SetPrecision;
    property Details : Boolean read FDetails write SetDetails;
    property OnScaleChange :TScaleChangeEvent read FOnScaleChange write FOnScaleChange;
    //
    property OnKeyDown;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnDblClick;
    property Align;
    property Anchors;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Constraints;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property TabStop;
    property TabOrder;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
  end;

//{$R *.res}

procedure Register;

implementation

uses Math, NavigatorFrm;

procedure Register;
begin
  RegisterComponents('Samples', [TGraphMois]);
end;

  function _RectText(Can : TCanvas; Prec :ShortInt; MinV, MaxV : Double) : TRect;
  var R1, R2 : TRect;
  begin
    R1 := Rect(0, 0, 0, 0);
    Windows.DrawText(Can.Handle, PChar(FloatToStrF(MaxV, ffFixed, 10, Prec)), -1, R1, DT_CALCRECT);
    R2 := Rect(0, 0, 0, 0);
    Windows.DrawText(Can.Handle, PChar(FloatToStrF(MinV, ffFixed, 10, Prec)), -1, R2, DT_CALCRECT);
    Result := Rect(0, 0, Max(R1.Right, R2.Right), R1.Bottom);
  end;

{ TGraphMois }

procedure TGraphMois.CMHintShow(var Message: TMessage);
var
  GPHint : TGraphPoint;
  Ind : Integer;
begin
  Message.Result := 1;
  if not FindPointOnCurve(PHintInfo(Message.LParam).CursorPos, Ind, GPHint) then
    Exit;

  PHintInfo(Message.LParam).HintColor := clWhite;
  PHintInfo(Message.LParam).HintStr :=
                          IntToStr(Ind)+': ('+
                          'x:'+FloatToStrF(GPHint.X, ffFixed, 10, FDecimalHint)+', '+
                          'y:'+FloatToStrF(GPHint.Y, ffFixed, 10, FDecimalHint)+')';
  PHintInfo(Message.LParam).ReshowTimeout := 200;
  Message.Result := 0;

// PHintInfo locate into Forms
end;

constructor TGraphMois.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque] ;

  FCurves := CreateCurves;
  TabStop := True;
  MargY := 24;
  Width := 320;
  Height := 210;
  FMaxXValue := 100;
  FMaxYValue := 100;
  FColor := clWhite;
  FGridY := True;
  FGridX := True;
  FColorGrid := clSilver;
  FDecimalHint := 1;
  FScale := 100;     //in percent
  FStepScale := 100; //in percent
  FShowTextScale := True;
  ShowHint := True;
  FPrecision := 1;
  SclK := 1;
  clTxtScale := RGB(220, 220, 220);  //для увеличения яркости уменьшить значения
end;

function TGraphMois.CreateCurves: TCurves;
begin
  Result := TCurves.Create(Self);
end;

destructor TGraphMois.Destroy;
begin
  FCurves.Free;
  inherited;
end;

const
  Ar :array[0..12] of Double =
    (0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10);

procedure TGraphMois.DoPaint(Sender: TObject);
var
  I, J, PX, PY,
  Offs : Integer;
  {RX, RY,} RW : TRect;
  LegStepY, LegStepX : Double;
  KK, KX, KY, LegMinY, LegMinX : Double;
  BM : TBitMap;
  MinYV, MaxYV, MinXV, MaxXV : array of Double;
  Fnt : TFont;
  S : string;
  Det : Boolean;
  Pr : TPoint;

  function _StepY : Boolean;
  var I, K : Integer;
      Dlt, Ml, p10 : Double;
  begin
    Result := False;
    if scMaxY <= scMinY then Exit;
    Dlt := scMaxY - scMinY;
    LenY := BM.Height - MargY - 8;       //8 - top
    VpDY := Dlt / LenY;                  //value per dot
    Ml := VpDY * 14;                      //14 - мин. расстояние между надписями по вертикали
    K := Length(FloatToStrF(Ml, ffFixed, 10, 0))-1;
    p10 := Power(10, K);
    for I := 0 to High(Ar) do
      if Ar[I] * p10 >= Ml then begin
        LegStepY := Ar[I] * p10;
        break;
      end;

    LegMinY := Int(scMinY / (p10*10)) * (p10*10);
    if scMinY >= 0 then
      while LegMinY < scMinY do
        LegMinY := LegMinY + LegStepY
    else
      while LegMinY >= scMinY+LegStepY do
        LegMinY := LegMinY - LegStepY;

    RTextY := _RectText(BM.Canvas, FPrecision, scMinY, scMaxY);
    RTextX := _RectText(BM.Canvas, FPrecision, scMinX, scMaxX);
    MargX := RTextY.Right+8;
    LenX := BM.Width - MargX - RTextX.Right div 2 - 3;     //3 - right

    Result := True;
  end;

  function _StepX : Boolean;
  var I, K : Integer;
      Dlt, Ml, p10 : Double;
  begin
    Result := False;
    if scMaxX <= scMinX then Exit;

    Dlt := scMaxX - scMinX;
    VpDX := Dlt / LenX;                  //value per dot
    Ml := VpDX * (RTextX.Right+2);           //мин. расстояние между надписями по горизонтали
    K := Length(FloatToStrF(Ml, ffFixed, 10, 0))-1;
    p10 := Power(10, K);
    for I := 0 to High(Ar) do
      if Ar[I] * p10 >= Ml then begin
        LegStepX := Ar[I] * p10;
        break;
      end;

    LegMinX := Trunc(scMinX / (p10*10)) * (p10*10);
    if scMinX >= 0 then
      while LegMinX < scMinX do
        LegMinX := LegMinX + LegStepX
    else
      while LegMinX >= scMinX+LegStepX do
        LegMinX := LegMinX - LegStepX;

    Result := True;
  end;

begin
  BM := TBitMap.Create;
  BM.Width := Width;
  BM.Height := Height;

  Canvas.Brush.Color := Color;

  with BM.Canvas do begin
    Brush.Color := Color;
    FillRect(ClientRect);
    if Focused then
      DrawFocusRect(ClientRect);

    if ShowTextScale then begin
      Fnt := TFont.Create;
      Fnt.Assign(Font);
      Font.name := 'Arial';
      Font.Size := 20;
      Font.Color := clWhite;
      if Color = clWhite then
        Font.Color := clTxtScale;
      Font.Style := [fsBold];
      S := 'М: '+IntToStr(Scale)+'%';
      I := TextWidth(S);
      TextOut(Width - I - 30, 10, S);
      Font.Assign(Fnt);
      Fnt.Free;
    end;

    MargX := 20;

    Pen.Style := psSolid;
    Pen.Color := clBlack;
    Pen.Width := 1;

    if FCurves.Count > 0 then begin
      if Scale = 100 then begin
        SetLength(MinYV, FCurves.Count);
        SetLength(MaxYV, FCurves.Count);
        SetLength(MinXV, FCurves.Count);
        SetLength(MaxXV, FCurves.Count);

        for I := 0 to FCurves.Count - 1 do begin
          if High(FCurves.Items[I].ArrayDX) >= 0 then begin
            MinYV[I] := MinValue(FCurves.Items[I].ArrayDY);
            MaxYV[I] := MaxValue(FCurves.Items[I].ArrayDY);
            MinXV[I] := MinValue(FCurves.Items[I].ArrayDX);
            MaxXV[I] := MaxValue(FCurves.Items[I].ArrayDX);
          end;
        end;
        if IsCurves then begin
        KK := MaxValue(MaxYV); if KK > FMaxYValue then FMaxYValue := KK;
        KK := MinValue(MinYV); if KK < FMinYValue then FMinYValue := KK;
        KK := MaxValue(MaxXV); if KK > FMaxXValue then FMaxXValue := KK;
        KK := MinValue(MinXV); if KK < FMinXValue then FMinXValue := KK;
        end;
        MinYV := nil; MaxYV := nil; MinXV := nil; MaxXV := nil;

        scMinY := FMinYValue; scMaxY := FMaxYValue;
        scMinX := FMinXValue; scMaxX := FMaxXValue;
      end;
    end else begin
      scMinY := FMinYValue; scMaxY := FMaxYValue;
      scMinX := FMinXValue; scMaxX := FMaxXValue;
    end;

    if _StepY then begin
      Offs := 0;
      if LegMinY > FMinYValue then
        Offs := Abs(Round((LegMinY - scMinY) * 1/VpDY));

      I := 0;
      while LegMinY <= scMaxY do begin
        if GridY then begin
          Pen.Style := psDot; Pen.Color := ColorGrid;
          MoveTo(MargX + LenX, (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs);
          LineTo(MargX, (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs);
          Pen.Style := psSolid; Pen.Color := clBlack;
        end;

        MoveTo(MargX, (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs); //ticks
        LineTo(MargX-4, (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs);

        RW := Rect(MargX - 6 - RTextY.Right,
                   (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs - (RTextY.Bottom div 2),
                   MargX - 6,
                   (BM.Height - MargY) - Round(LegStepY * I * 1/VpDY) - Offs + (RTextY.Bottom div 2));
//        if (LegStepY > -1) and (LegStepY < 1) then
          Windows.DrawText(Handle, PChar(FloatToStrF(LegMinY, ffFixed, 10,
                           GetPrecisionForShow(LegStepY))), -1, RW, DT_RIGHT);
//        else
//          Windows.DrawText(Handle, PChar(FloatToStrF(LegMinY, ffFixed, 10, 0)), -1, RW, DT_RIGHT);
        Inc(I);
        LegMinY := LegMinY + LegStepY;
      end;
      Pen.Color := ColorAxis;
      MoveTo(MargX, BM.Height - MargY); //horz
      LineTo(MargX + LenX, BM.Height - MargY);
      MoveTo(MargX, BM.Height - MargY - LenY); //horz
      LineTo(MargX + LenX, BM.Height - MargY - LenY);
      Pen.Color := clBlack;

    end else begin             //if MaxYValue <= 0
      MoveTo(20, Height - 20);
      LineTo(20, 2);
    end;

    if _StepX then begin
      Offs := 0;
      if LegMinX > scMinX then
        Offs := Abs(Round((LegMinX - scMinX) * 1/VpDX));

      I := 0;
      while LegMinX <= scMaxX do begin
        if GridX then begin
          Pen.Style := psDot; Pen.Color := ColorGrid;
          MoveTo(MargX + Round(LegStepX * I * 1/VpDX) + Offs, (BM.Height - MargY) - LenY);
          LineTo(MargX + Round(LegStepX * I * 1/VpDX) + Offs, BM.Height - MargY);
          Pen.Style := psSolid; Pen.Color := clBlack;
        end;

        MoveTo(MargX + Round(LegStepX * I * 1/VpDX) + Offs, BM.Height - MargY); //засечки (ticks)
        LineTo(MargX + Round(LegStepX * I * 1/VpDX) + Offs, BM.Height - MargY + 4);

        RW := Rect(MargX + Round(LegStepX * I * 1/VpDX) + Offs - RTextX.Right div 2,
                   (BM.Height - MargY) + 8,
                   MargX + Round(LegStepX * I * 1/VpDX) + Offs + RTextX.Right div 2,
                   (BM.Height - MargY) + RTextX.Bottom + 8);
//        if (LegStepX > -1) and (LegStepX < 1) then
          Windows.DrawText(Handle, PChar(FloatToStrF(LegMinX, ffFixed, 10,
                           GetPrecisionForShow(LegStepX))), -1, RW, DT_CENTER);
//        else
//          Windows.DrawText(Handle, PChar(FloatToStrF(LegMinX, ffFixed, 10, 0)), -1, RW, DT_CENTER);

        Inc(I);
        LegMinX := LegMinX + LegStepX;
      end;
      Pen.Color := ColorAxis;
      MoveTo(MargX, BM.Height - MargY);               //axis vert
      LineTo(MargX, (BM.Height - MargY) - LenY);
      MoveTo(MargX+LenX, BM.Height - MargY);               //axis vert
      LineTo(MargX+LenX, (BM.Height - MargY) - LenY);
      Pen.Color := clBlack;
    end else begin
      MoveTo(20, Height - 20);
      LineTo(Width-2, Height - 20);
    end;

    if FCurves.Count > 0 then begin
      IntersectClipRect(BM.Canvas.Handle, MargX, 8, MargX+LenX, BM.Height - MargY+2);
      KY := (LenY * SclK) / (FMaxYValue - FMinYValue);
      KX := (LenX * SclK) / (FMaxXValue - FMinXValue);

      for J := 0 to FCurves.Count - 1 do begin
        if Length(FCurves.Items[J].ArrayDX) <=1  then continue;
        Pen.Color := FCurves.Items[J].ColorGraph;
        Brush.Color := FCurves.Items[J].ColorGraph;
        Det := False; Pr := Point(0, 0);

        if (FCurves.Items[J].FThickLine > 1) and (Details or FCurves.Items[J].FDetails) then begin
          Pr.X := FCurves.Items[J].FThickLine div 2;
          Pr.Y := FCurves.Items[J].FThickLine - Pr.X;
          Det := True;
          Pen.Width := 1;
        end else begin
          if Details or FCurves.Items[J].FDetails then begin
            Pr := Point(2, 3); Det := True;
          end;
          Pen.Width := FCurves.Items[J].FThickLine;
        end;

        MoveTo(Round(KX * (FCurves.Items[J].ArrayDX[0] - (scMinX - FMinXValue) - FMinXValue)) + MargX,
               BM.Height - MargY - Round(KY * (FCurves.Items[J].ArrayDY[0] - (scMinY - FMinYValue) - FMinYValue)));
        for I := 1 to High(FCurves.Items[J].ArrayDX) do begin
          PY := Round(KY * (FCurves.Items[J].ArrayDY[I] - (scMinY - FMinYValue) - FMinYValue));
          PX := Round(KX * (FCurves.Items[J].ArrayDX[I] - (scMinX - FMinXValue) - FMinXValue));
          if Det then
            Rectangle(PX+MargX-Pr.X, BM.Height - PY - MargY-Pr.X, PX+MargX+Pr.Y, BM.Height - PY - MargY+Pr.Y);
          LineTo(PX +MargX, BM.Height - PY - MargY);
        end;
      end;
    end;
    Brush.Color := Color;

  end;
  Canvas.CopyRect(ClientRect, BM.Canvas, ClientRect);
  if SmPan <> nil then
    TNavigator(SmPan).UpdateWin(Curves, FMaxXValue, FMinXValue, FMaxYValue, FMinYValue,
                                   ScMaxX, ScMinX, ScMaxY, ScMinY, Scale > 100);

  BM.Free;
end;

{ FindPointOnCurve }
//Если Р (пиксельные координаты на компоненте) указывают точку на кривой
//или находятся рядом с какой-то степенью приближения
//(приближение управляется параметром Epsilon в фунции SameValue),
//то в GP возвращается значение этой точки, а сама функция возвращает True;
//Эта функция применяется в реализации отображения хинта (см. сообщение CMHintShow).
//Реализовано так, что при движении мышки значения на кривой отображаются с помощью
//хинта только тогда, когда курсор находится на кривой около точки.

//Про Epsilon. Расширяет/уменьшает интервал значений, в котором ищется точка.
//Например. Координата Х точки кривой имеет значение "28".
//Указатель мыши находится на том месте графика, которое соответствует
//значению Х точки на графике "26". Значение интервала поиска (Epsilon) "3".
//Отсюда, диапазон поиска = 26±3 (23...29). Точка с координатой Х="28" будет найдена.

//В функции делители (Width div 2) подобраны экспериментально. Чем больше делитель,
//тем чувствительнее метод нахождения нужной точки (меньший интервал поиска),
//но ловля точки мышкой затрудняется.
//И наоборот, при меньшей чувствительность (большем интервале поиска) из близко
//лежащих точек одна может никогда не показываться,
//но хинт появляется при большем расстоянии курсора от точки.

function TGraphMois.FindPointOnCurve(P : TPoint; var Ind : Integer; var GP : TGraphPoint) : Boolean;
var G : TGraphPoint;
  I, J : Integer;
  EpX, EpY : Double;
begin
  Result := False;
  Ind := 0;
  G := GetGraphPointByPoint(P);
  EpX := (scMaxX - scMinX) / (Width div 2);
  EpY := (scMaxY - scMinY) / (Height div 6);
  for J := 0 to FCurves.Count - 1 do begin
    if Length(FCurves.Items[J].ArrayDX) <=1  then continue;
    for I := 0 to High(FCurves.Items[J].ArrayDX) do
      If SameValue(FCurves.Items[J].ArrayDX[I], G.X, EpX) then
        If SameValue(FCurves.Items[J].ArrayDY[I], G.Y, EpY) then begin
          GP.X := FCurves.Items[J].ArrayDX[I];
          GP.Y := FCurves.Items[J].ArrayDY[I];
          Ind := I;
          Result := True;
          break;
        end;
  end;
end;

function TGraphMois.GetCurveClass: TCurveClass;
begin
  Result := TCurve;
end;

function TGraphMois.GetGraphPointByPoint(P: TPoint): TGraphPoint;
var
  DpVX, DpVY : Double;
  RX, RY : TRect;
begin
  LenY := Height - MargY - 8;       //8 - top
  DpVY := (LenY * SclK) / (FMaxYValue - FMinYValue);    //dots per value

//  RY := _RectText(Canvas, FPrecision, scMinY, scMaxY);
//  RX := _RectText(Canvas, FPrecision, scMinX, scMaxX);
  RX := RTextX;
  RY := RTextY;
  MargX := RY.Right+8;
  LenX := Width - MargX - RX.Right div 2 - 3;          //3 - right
  DpVX := (LenX * SclK) / (FMaxXValue - FMinXValue);

  if P.X = -1 then
    P := Point(LenX div 2 + MargX, Height - MargY - LenY div 2);

  Result.X := ((P.X - MargX) + (scMinX - FMinXValue) * DpVX) / DpVX + FMinXValue;
  Result.Y := ((Height - MargY - P.Y) + (scMinY - FMinYValue) * DpVY) / DpVY + FMinYValue;
end;

function TGraphMois.GetPrecisionForShow(Step: Double): ShortInt;
begin
  Result := 0;
  if (Step > -0.01) and (Step < 0.01) then begin
    Result := 3; Exit;
  end;
  if (Step > -0.1) and (Step < 0.1) then begin
    Result := 2; Exit;
  end;
  if (Step > -1) and (Step < 1) then begin
    Result := 1; Exit;
  end;
end;

function TGraphMois.IsCurves: Boolean;
var I : Integer;
begin
  Result := False;
  for I := 0 to Curves.Count-1 do
    if Length(Curves[I].ArrayDX) > 1 then begin
      Result := True;
      Exit;
    end;
end;

procedure TGraphMois.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_ADD : begin
      PHit := Point(-1, 0);
      Scale := Scale + StepScale;
    end;
    VK_SUBTRACT : if Scale > 100 then begin
      PHit := Point(-1, 0);
      Scale := Scale - StepScale;
    end;
    VK_MULTIPLY : Scale := 100;
    VK_LEFT : if Scale > 100 then begin
      PHit := Point((Width-MargX) div 2 + MargX, (Height-MargY) div 2);
      if ssCtrl in Shift then
        ShiftGraph(Point(PHit.X - (Width-MargX-10), PHit.Y))
      else
        ShiftGraph(Point(PHit.X - 10, PHit.Y));
    end;
    VK_RIGHT : if Scale > 100 then begin
      PHit := Point((Width-MargX) div 2 + MargX, (Height-MargY) div 2);
      if ssCtrl in Shift then
        ShiftGraph(Point(PHit.X + (Width-MargX-10), PHit.Y))
      else
        ShiftGraph(Point(PHit.X + 10, PHit.Y));
    end;
    VK_UP : if Scale > 100 then begin
      PHit := Point((Width-MargX) div 2 + MargX, (Height-MargY) div 2);
      if ssCtrl in Shift then
        ShiftGraph(Point(PHit.X, PHit.Y - (Height-MargY-8)))
      else
        ShiftGraph(Point(PHit.X, PHit.Y - 10));
    end;
    VK_DOWN : if Scale > 100 then begin
      PHit := Point((Width-MargX) div 2 + MargX, (Height-MargY) div 2);
      if ssCtrl in Shift then
        ShiftGraph(Point(PHit.X, PHit.Y + (Height-MargY-8)))
      else
        ShiftGraph(Point(PHit.X, PHit.Y + 10));
    end;
  end;

end;

procedure TGraphMois.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (csDesigning in ComponentState) or not IsCurves then Exit;
  PHit := Point(X, Y);
  if Button = mbLeft then
    isMDown := True;

  //странная такая фигня: на сколько допускаем вылезание графика за пределы значений по всем
  //сторонам при масштабировании и панорамировании - здесь 1% от диапазона значений по осям
//  KfZaX := (FMaxXValue - FMinXValue) * 0.01;
//  KfZaY := (FMaxYValue - FMinYValue) * 0.01;
  //не применяется, т.к. если применять, но надо корректировать и другие параметры
end;

procedure TGraphMois.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if csDesigning in	ComponentState then Exit;
  if Shift = [] then Exit;

  if isMDown and (Scale > 100) and ((X <> PHit.X) or (Y <> PHit.Y)) then begin
    IsMMove := True;
    ShiftGraph(Point(X, Y));
  end;
end;

procedure TGraphMois.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not Focused and CanFocus then begin
    SetFocus;
    Exit;
  end;
  if (csDesigning in	ComponentState) or not IsCurves then Exit;
  if IsMMove then begin
    IsMMove := False;
    IsMDown := False;
    Exit;
  end;

  IsMDown := False;
  PHit := Point(X, Y);

  if Button = mbLeft then
    Scale := Scale + StepScale
  else
    if Button = mbRight then
      Scale := Scale - StepScale;

  if Button = mbMiddle then
    Scale := 100;
end;

procedure TGraphMois.Paint;
begin
  inherited;
  DoPaint(nil);
end;

procedure TGraphMois.ScaleChange(Source: TObject; NewScale: Integer);
begin
  if Assigned(FOnScaleChange) then FOnScaleChange(Self, NewScale);
end;

procedure TGraphMois.SetColor(const Value: TColor);
begin
  FColor := Value;
  Invalidate;
end;

procedure TGraphMois.SetColorAxis(const Value: TColor);
begin
  if FColorAxis = Value then Exit;
  FColorAxis := Value;
  Invalidate;
end;

procedure TGraphMois.SetColorGrid(const Value: TColor);
begin
  if FColorGrid = Value then Exit;
  FColorGrid := Value;
  Invalidate;
end;

procedure TGraphMois.SetCurves(const Value: TCurves);
begin
  FCurves.Assign(Value);
end;

procedure TGraphMois.SetDecimalHint(const Value: ShortInt);
begin
  if (Value < 0) or (Value > 6) then Exit;
  FDecimalHint := Value;
end;

procedure TGraphMois.SetDetails(const Value: Boolean);
begin
  if FDetails = Value then Exit;
  FDetails := Value;
  Invalidate;
end;

procedure TGraphMois.SetGridX(const Value: Boolean);
begin
  if FGridX = Value then Exit;
  FGridX := Value;
  Invalidate;
end;

procedure TGraphMois.SetGridY(const Value: Boolean);
begin
  if FGridY = Value then Exit;
  FGridY := Value;
  Invalidate;
end;

procedure TGraphMois.SetMaxXValue(const Value: Double);
begin
  if FMaxXValue = Value then Exit;
  FMaxXValue := Value;
  if Value <= 0 then begin
    FMaxXValue := 0.0;
  end;
  Invalidate
end;

procedure TGraphMois.SetMaxYValue(const Value: Double);
begin
  if FMaxYValue = Value then Exit;
  FMaxYValue := Value;
  if Value < 0 then begin
    FMaxYValue := 0;
  end;
  Invalidate;
end;

procedure TGraphMois.SetMinXValue(const Value: Double);
begin
  if FMinXValue = Value then Exit;
  FMinXValue := Value;
  Invalidate;
end;

procedure TGraphMois.SetMinYValue(const Value: Double);
begin
  if FMinYValue = Value then Exit;
  FMinYValue := Value;
  Invalidate;
end;

procedure TGraphMois.SetNavigator(const Value: Boolean);
begin
  if FNavigator = Value then Exit;
  FNavigator := Value;
  if SmPan = nil then begin
    SmPan := TNavigator.Create(Self);
    SmPan.Visible := FALSE;

    SmPan.ClientWidth := Width div 4;
    SmPan.ClientHeight := Height div 4;
    SmPan.Left := ClientToScreen(BoundsRect.TopLeft).X - BoundsRect.Left + Width-SmPan.Width;
    SmPan.Top := ClientToScreen(BoundsRect.BottomRight).Y - BoundsRect.Top - SmPan.Height;
  end;

  if FNavigator then begin
    TNavigator(SmPan).UpdateWin(Curves, FMaxXValue, FMinXValue, FMaxYValue, FMinYValue,
                                 ScMaxX, ScMinX, ScMaxY, ScMinY, Scale > 100);
    ShowWindow(SmPan.Handle, SW_SHOWNA)
  end else
    ShowWindow(SmPan.Handle, SW_HIDE);
end;

procedure TGraphMois.SetPrecision(const Value: ShortInt);
begin
  if FPrecision = Value then Exit;
  FPrecision := Value;
  if (Value < 0) or (Value > 3) then
    FPrecision := 1;
  Invalidate;
end;

procedure TGraphMois.SetScale(const Value: Integer);
var
  KK : Double;
  GP : TGraphPoint;
begin
  if FScale = Value then Exit;
  GP := GetGraphPointByPoint(PHit);

  FScale := Value;
  if FScale < 100 then FScale := 100;
  SclK := FScale / 100;

  KK := (FMaxXValue - FMinXValue) / SclK;  //ширина
  scMinX := GP.X - KK / 2;
  scMaxX := GP.X + KK / 2;
  KK := scMaxX - scMinX;
  if scMinX < FMinXValue{-KfZaX} then begin //корректировка, чтобы график не вылезал
    scMinX := FMinXValue{-KfZaX};
    scMaxX := scMinX + KK;
  end;
  if scMaxX > FMaxXValue{+KfZaX} then begin
    scMaxX := FMaxXValue{+KfZaX};
    scMinX := scMaxX - KK;
  end;

  KK := (FMaxYValue - FMinYValue) / SclK;  //высота
  scMinY := GP.Y - KK / 2;
  scMaxY := GP.Y + KK / 2;
  KK := scMaxY - scMinY;
  if scMinY < FMinYValue{-KfZaY} then begin
    scMinY := FMinYValue{-KfZaY};
    scMaxY := scMinY + KK;
  end;
  if scMaxY > FMaxYValue{+KfZaY} then begin
    scMaxY := FMaxYValue{+KfZaY};
    scMinY := scMaxY - KK;
  end;
  ScaleChange(Self, Scale);
  Invalidate;
end;

procedure TGraphMois.SetShowTextScale(const Value: Boolean);
begin
  if FShowTextScale = Value then Exit;
  FShowTextScale := Value;
  Invalidate;
end;

procedure TGraphMois.SetStepScale(const Value: Integer);
begin
  if FStepScale = Value then Exit;
  FStepScale := Value;
  if FStepScale <= 0 then FStepScale := 100;
  if FScale > 100 then
    Invalidate;
end;

procedure TGraphMois.ShiftFromNavigator(scX, scY: Double);
var IntX, IntY : Double;
begin
  IntX := scMaxX - scMinX;
  IntY := scMaxY - scMinY;
  scMinX := scX; scMaxX := scMinX + IntX;
  scMaxY := scY; scMinY := scMaxY - IntY;

  Invalidate;
end;

procedure TGraphMois.ShiftGraph(NewP: TPoint);
var
  KK : Double;
  GP, GP2 : TGraphPoint;
begin
  GP := GetGraphPointByPoint(PHit);
  GP2 := GetGraphPointByPoint(NewP);

  KK := scMaxX - scMinX;
  scMinX := scMinX + (GP.X - GP2.X);
  scMaxX := scMaxX + (GP.X - GP2.X);
  if scMinX < FMinXValue{-KfZaX} then begin
    scMinX := FMinXValue{-KfZaX};
    scMaxX := scMinX + KK;
  end;
  if scMaxX > FMaxXValue{+KfZaX} then begin
    scMaxX := FMaxXValue{+KfZaX};
    scMinX := scMaxX - KK;
  end;

  KK := scMaxY - scMinY;
  scMinY := scMinY + (GP.Y - GP2.Y);
  scMaxY := scMaxY + (GP.Y - GP2.Y);
  if scMinY < FMinYValue{-KfZaY} then begin
    scMinY := FMinYValue{-KfZaY};
    scMaxY := scMinY + KK;
  end;
  if scMaxY > FMaxYValue{+KfZaY} then begin
    scMaxY := FMaxYValue{+KfZaY};
    scMinY := scMaxY - KK;
  end;

  PHit := NewP;
  Invalidate;
end;

procedure TGraphMois.WMGetDlgCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TGraphMois.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TGraphMois.WMMouseWheel(var Message: TWMMouseWheel);
var D : Integer;
begin
  if not IsCurves then Exit;
  D := Message.WheelDelta;
  PHit := ScreenToClient(Point(Message.XPos, Message.YPos));

  IsMDown := False;
  if D < 0 then
    Scale := Scale + StepScale div 2
  else
    Scale := Scale - StepScale div 2;
end;

procedure TGraphMois.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

{ TCurves }

function TCurves.Add: TCurve;
begin
  Result := TCurve(inherited Add);
end;

constructor TCurves.Create(Graphic: TGraphMois);
begin
  if Graphic <> nil then
    inherited Create(Graphic.GetCurveClass)
  else
    inherited Create(TCurve);
  FGraphic := Graphic;
end;

function TCurves.GetItem(Index: Integer): TCurve;
begin
  Result := TCurve(inherited GetItem(Index));
end;

function TCurves.GetOwner: TPersistent;
begin
  Result := FGraphic;
end;

procedure TCurves.SetItem(Index: Integer; const Value: TCurve);
begin
  inherited SetItem(Index, Value);
end;

procedure TCurves.Update(Item: TCollectionItem);
begin
  inherited;
  FGraphic.Invalidate;
end;

{ TCurve }

procedure TCurve.AddPoint(aX, aY: Double);
begin
  SetLength(ArrayDX, Length(ArrayDX)+1);
  SetLength(ArrayDY, Length(ArrayDY)+1);
  ArrayDX[High(ArrayDX)] := aX;
  ArrayDY[High(ArrayDY)] := aY;
  TGraphMois(Collection.Owner).Invalidate;
end;

procedure TCurve.Assign(Source: TPersistent);
begin
  if Source is TCurve then begin
    ColorGraph := TCurve(Source).ColorGraph;
    ThickLine := TCurve(Source).ThickLine;
    Details := TCurve(Source).Details;
  end else
  inherited Assign(Source);
end;

procedure TCurve.ClearPoints;
begin
  ArrayDX := nil;
  ArrayDY := nil;
  TGraphMois(Collection.Owner).Invalidate;
end;

constructor TCurve.Create(Collection: TCollection);
begin
  FThickLine := 1;
  FColorGraph := clBlack;
  inherited Create(Collection);
end;

destructor TCurve.Destroy;
begin
  ArrayDX := nil;
  ArrayDY := nil;
  inherited;
end;

procedure TCurve.GetPoint(Index: Integer; var aX, aY: Double);
begin
  aX := 0; aY := 0;
  if (Index > High(ArrayDX)) or (Index < 0) then Exit;
  aX := ArrayDX[Index];
  aY := ArrayDY[Index];
end;

function TCurve.GetLen: Integer;
begin
  Result := High(ArrayDX);
end;

function TCurve.GetPoint(Index: Integer): TGraphPoint;
begin
  Result.X := 0;
  Result.Y := 0;
  if (Index > High(ArrayDX)) or (Index < 0) then Exit;
  Result.X := ArrayDX[Index];
  Result.Y := ArrayDY[Index];
end;

procedure TCurve.SetColorGraph(const Value: TColor);
begin
  if FColorGraph = Value then Exit;
  FColorGraph := Value;
  Changed(False);
end;

procedure TCurve.SetDetails(const Value: Boolean);
begin
  if FDetails = Value then Exit;
  FDetails := Value;
  Changed(False);
end;

procedure TCurve.SetThickLine(const Value: Integer);
begin
  if FThickLine = Value then Exit;
  FThickLine := Value;
  Changed(False);
end;

end.
