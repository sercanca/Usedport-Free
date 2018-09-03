object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Port Scan'
  ClientHeight = 332
  ClientWidth = 530
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    530
    332)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 20
    Width = 27
    Height = 13
    Caption = 'Port :'
  end
  object ScanPortList: TStringGrid
    Left = 8
    Top = 56
    Width = 514
    Height = 241
    Anchors = [akLeft, akTop, akRight, akBottom]
    FixedColor = clDefault
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitHeight = 250
  end
  object FindPortEdit: TEdit
    Left = 46
    Top = 17
    Width = 344
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    OnChange = FindPortEditChange
    OnExit = FindPortEditExit
    OnKeyPress = FindPortEditKeyPress
    OnMouseDown = FindPortEditMouseDown
  end
  object FindButton: TButton
    Left = 460
    Top = 16
    Width = 62
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Find'
    ImageIndex = 0
    Images = Form1.imgBtn16x16
    TabOrder = 2
    OnClick = FindButtonClick
  end
  object DetailCheck: TCheckBox
    Left = 401
    Top = 19
    Width = 51
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Detail'
    TabOrder = 3
  end
  object protocolCount: TPanel
    Left = 0
    Top = 303
    Width = 530
    Height = 29
    Align = alBottom
    Alignment = taLeftJustify
    TabOrder = 4
    ExplicitTop = 335
    ExplicitWidth = 545
  end
end
