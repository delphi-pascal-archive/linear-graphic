object Form1: TForm1
  Left = 217
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Linear Graphic'
  ClientHeight = 510
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object SpeedButton1: TSpeedButton
    Left = 136
    Top = 8
    Width = 121
    Height = 25
    Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 264
    Top = 48
    Width = 97
    Height = 16
    Caption = #1052#1072#1089#1096#1090#1072#1073': 100%'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = '1-'#1103' '#1082#1088#1080#1074#1072#1103
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 672
    Top = 8
    Width = 137
    Height = 25
    Caption = #1053#1072#1074#1080#1075#1072#1090#1086#1088
    TabOrder = 1
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 491
    Width = 817
    Height = 19
    Panels = <>
  end
  object Button4: TButton
    Left = 672
    Top = 40
    Width = 137
    Height = 25
    Caption = #1044#1088#1091#1075#1072#1103' '#1082#1088#1080#1074#1072#1103
    TabOrder = 2
    OnClick = Button4Click
  end
  object Button3: TButton
    Left = 264
    Top = 8
    Width = 113
    Height = 25
    Caption = #1052#1072#1089#1096#1090#1072#1073' 100%'
    TabOrder = 4
    OnClick = Button3Click
  end
  object GraphMois1: TGraphMois
    Left = 8
    Top = 72
    Width = 801
    Height = 409
    ColorAxis = clBlack
    MaxXValue = 100.000000000000000000
    MinYValue = -10.000000000000000000
    MaxYValue = 100.000000000000000000
    GridX = True
    GridY = True
    Color = clWhite
    ColorGrid = clSilver
    StepScale = 100
    Curves = <
      item
        ColorGraph = clRed
        ThickLine = 1
        Details = False
      end
      item
        ColorGraph = clFuchsia
        ThickLine = 4
        Details = False
      end
      item
        ColorGraph = clGreen
        ThickLine = 1
        Details = False
      end
      item
        ColorGraph = clBlack
        ThickLine = 1
        Details = False
      end>
    DecimalHint = 1
    ShowTextScale = True
    Precision = 3
    Details = False
    OnScaleChange = GraphMois1ScaleChange
    ParentShowHint = False
    ShowHint = True
    TabStop = True
    TabOrder = 3
  end
  object Button5: TButton
    Left = 8
    Top = 40
    Width = 121
    Height = 25
    Caption = #1047#1072#1084#1077#1076#1083#1077#1085#1085#1086
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 136
    Top = 40
    Width = 121
    Height = 25
    Caption = #1062#1074#1077#1090' '#1075#1088#1072#1092#1080#1082#1072
    TabOrder = 7
    OnClick = Button6Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 152
    Top = 24
  end
  object ColorDialog1: TColorDialog
    Left = 88
    Top = 24
  end
end
