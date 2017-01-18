inherited f_Goods: Tf_Goods
  Caption = #1058#1086#1074#1072#1088#1099
  ClientHeight = 481
  ClientWidth = 720
  OnDestroy = FormDestroy
  ExplicitWidth = 736
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_keys: TcxGroupBox
    ExplicitWidth = 720
    Width = 720
    inherited btn_return: TcxButton
      Width = 230
      ExplicitWidth = 230
    end
  end
  object tl_groups: TcxTreeList
    Left = 0
    Top = 44
    Width = 361
    Height = 417
    Align = alLeft
    Bands = <
      item
      end>
    Images = f_CashBoxLite.il_main
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.Buttons = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Headers = False
    OptionsView.ShowRoot = False
    TabOrder = 1
    OnDblClick = tl_groupsDblClick
    OnFocusedNodeChanged = tl_groupsFocusedNodeChanged
    object tl_groups_ID: TcxTreeListColumn
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
    object tl_groups_Name: TcxTreeListColumn
      Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DataBinding.ValueType = 'String'
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object tl_groups_ChildCount: TcxTreeListColumn
      Visible = False
      Caption.Text = 'ChildCount'
      DataBinding.ValueType = 'String'
      Options.Customizing = False
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object tl_groups_GdsGrpID: TcxTreeListColumn
      Visible = False
      Caption.Text = 'gds_grp_id'
      DataBinding.ValueType = 'String'
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object tl_goods: TcxTreeList
    Left = 369
    Top = 44
    Width = 351
    Height = 417
    Align = alClient
    Bands = <
      item
      end>
    Images = f_CashBoxLite.il_main
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.Buttons = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Headers = False
    OptionsView.ShowRoot = False
    TabOrder = 2
    object tl_goods_ID: TcxTreeListColumn
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
    object tl_goods_Name: TcxTreeListColumn
      Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DataBinding.ValueType = 'String'
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object sb_path: TdxStatusBar
    Left = 0
    Top = 461
    Width = 720
    Height = 20
    Images = f_CashBoxLite.il_main
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.ImageIndex = 3
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sp_goods: TcxSplitter
    Left = 361
    Top = 44
    Width = 8
    Height = 417
    Control = tl_groups
  end
end
