inherited f_base_key_form: Tf_base_key_form
  Caption = #1041#1072#1079#1086#1074#1072#1103' '#1092#1086#1088#1084#1072' '#1089' '#1082#1085#1086#1087#1082#1072#1084#1080
  KeyPreview = True
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gb_keys: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    TabOrder = 0
    Height = 44
    Width = 567
    object btn_f1: TcxButton
      Left = 78
      Top = 2
      Width = 79
      Height = 40
      Align = alLeft
      Caption = '[ F1 ]'
      TabOrder = 0
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_f1Click
    end
    object btn_f2: TcxButton
      Left = 157
      Top = 2
      Width = 80
      Height = 40
      Align = alLeft
      Caption = '[ F2 ]'
      TabOrder = 1
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_f2Click
    end
    object btn_f3: TcxButton
      Left = 237
      Top = 2
      Width = 88
      Height = 40
      Align = alLeft
      Caption = '[ F3 ]'
      TabOrder = 2
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_f3Click
    end
    object btn_f4: TcxButton
      Left = 325
      Top = 2
      Width = 88
      Height = 40
      Align = alLeft
      Caption = '[ F4 ]'
      TabOrder = 3
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_f4Click
    end
    object btn_back: TcxButton
      Left = 413
      Top = 2
      Width = 75
      Height = 40
      Align = alLeft
      Caption = '[ '#8592' ]'
      TabOrder = 4
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_backClick
    end
    object btn_return: TcxButton
      Left = 488
      Top = 2
      Width = 77
      Height = 40
      Align = alClient
      Caption = '[ Enter ]'
      TabOrder = 5
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_returnClick
    end
    object btn_esc: TcxButton
      Left = 2
      Top = 2
      Width = 76
      Height = 40
      Align = alLeft
      Caption = '[ Esc ]'
      TabOrder = 6
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      OnClick = btn_escClick
    end
  end
end
