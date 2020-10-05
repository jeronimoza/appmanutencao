object fThreads: TfThreads
  Left = 0
  Top = 0
  Caption = 'Threads'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 441
    Height = 13
    Align = alTop
    Caption = 'Intervalo Thread1(em milisegundos)'
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 172
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 441
    Height = 13
    Align = alTop
    Caption = 'Intervalo Thread2(em milisegundos)'
    ExplicitLeft = 0
    ExplicitTop = 34
    ExplicitWidth = 172
  end
  object ProgressBar1: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 126
    Width = 441
    Height = 25
    Align = alTop
    Max = 200
    TabOrder = 3
    ExplicitLeft = 0
    ExplicitTop = 93
    ExplicitWidth = 447
  end
  object Button1: TButton
    AlignWithMargins = True
    Left = 3
    Top = 95
    Width = 441
    Height = 25
    Align = alTop
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
    ExplicitLeft = -8
    ExplicitTop = 8
    ExplicitWidth = 447
  end
  object Edit1: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 22
    Width = 441
    Height = 21
    Align = alTop
    TabOrder = 0
    Text = '100'
    ExplicitLeft = 0
    ExplicitTop = -6
    ExplicitWidth = 447
  end
  object Edit2: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 68
    Width = 441
    Height = 21
    Align = alTop
    TabOrder = 1
    Text = '200'
    ExplicitLeft = 0
    ExplicitTop = 8
    ExplicitWidth = 447
  end
end
