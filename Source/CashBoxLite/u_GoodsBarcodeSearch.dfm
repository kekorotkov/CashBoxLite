inherited f_GoodsBarcodeSearch: Tf_GoodsBarcodeSearch
  Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072' '#1087#1086' '#1096#1090#1088#1080#1093#1082#1086#1076#1091
  ClientHeight = 114
  ClientWidth = 593
  Position = poMainFormCenter
  ExplicitWidth = 609
  ExplicitHeight = 153
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_keys: TcxGroupBox
    ExplicitWidth = 593
    Width = 593
    inherited btn_return: TcxButton
      Width = 103
      ExplicitWidth = 103
    end
  end
  object txt_Barcode: TcxTextEdit
    Left = 8
    Top = 50
    AutoSize = False
    ParentFont = False
    Properties.Alignment.Horz = taCenter
    Properties.MaxLength = 20
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -35
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 1
    OnKeyPress = txt_BarcodeKeyPress
    Height = 55
    Width = 577
  end
end
