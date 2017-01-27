inherited f_CashBoxMenu: Tf_CashBoxMenu
  Caption = #1052#1077#1085#1102
  PixelsPerInch = 96
  TextHeight = 13
  object tl_menu: TcxTreeList
    Left = 0
    Top = 44
    Width = 671
    Height = 361
    Align = alClient
    Bands = <
      item
      end>
    Images = f_CashBoxLite.il_main
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.CellEndEllipsis = True
    OptionsView.Buttons = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Headers = False
    OptionsView.ShowRoot = False
    Styles.StyleSheet = f_CashBoxLite.sts_default
    TabOrder = 1
    OnDblClick = tl_menuDblClick
    object tl_menu_ID: TcxTreeListColumn
      Visible = False
      Caption.Text = 'ID'
      DataBinding.ValueType = 'String'
      Options.Customizing = False
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object tl_menu_Name: TcxTreeListColumn
      Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DataBinding.ValueType = 'String'
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
end
