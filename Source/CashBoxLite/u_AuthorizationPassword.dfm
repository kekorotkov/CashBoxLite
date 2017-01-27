inherited f_AuthorizationPassword: Tf_AuthorizationPassword
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
  ClientHeight = 113
  ClientWidth = 592
  Position = poMainFormCenter
  ExplicitWidth = 608
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_keys: TcxGroupBox
    Width = 592
    inherited btn_return: TcxButton
      Width = 102
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
    Style.StyleController = f_CashBoxLite.st_main_control
    Style.IsFontAssigned = True
    TabOrder = 1
    OnKeyPress = txt_BarcodeKeyPress
    Height = 55
    Width = 577
  end
end
