inherited f_GoodsAdd: Tf_GoodsAdd
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 179
  ClientWidth = 617
  Position = poMainFormCenter
  ExplicitWidth = 633
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_keys: TcxGroupBox
    ExplicitWidth = 617
    Width = 617
    inherited btn_return: TcxButton
      Width = 127
      ExplicitWidth = 127
    end
  end
  object lbl_Name: TcxLabel
    Left = 8
    Top = 51
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    Transparent = True
  end
  object lbl_Unit: TcxLabel
    Left = 71
    Top = 81
    Caption = #1045#1076'.'#1080#1079#1084'.'
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    Transparent = True
  end
  object lbl_Price: TcxLabel
    Left = 90
    Top = 114
    Caption = #1062#1077#1085#1072
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    Transparent = True
  end
  object lbl_Count: TcxLabel
    Left = 74
    Top = 147
    Caption = #1050#1086#1083'-'#1074#1086
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    Transparent = True
  end
  object txt_Name: TcxTextEdit
    Left = 142
    Top = 50
    TabStop = False
    ParentFont = False
    Properties.ReadOnly = True
    Style.StyleController = f_CashBoxLite.st_main_control
    TabOrder = 5
    Width = 467
  end
  object txt_Unit: TcxTextEdit
    Left = 142
    Top = 80
    TabStop = False
    ParentFont = False
    Properties.ReadOnly = True
    Style.StyleController = f_CashBoxLite.st_main_control
    TabOrder = 6
    Width = 163
  end
  object ce_Price: TcxCurrencyEdit
    Left = 142
    Top = 113
    TabStop = False
    RepositoryItem = f_CashBoxLite.er_main_price_ReadOnly
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    TabOrder = 7
    Width = 163
  end
  object ce_Count: TcxCurrencyEdit
    Left = 142
    Top = 146
    RepositoryItem = f_CashBoxLite.er_main_count
    ParentFont = False
    Style.StyleController = f_CashBoxLite.st_main_control
    TabOrder = 8
    Width = 163
  end
end
