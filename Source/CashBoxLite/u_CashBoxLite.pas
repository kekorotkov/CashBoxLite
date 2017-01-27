unit u_CashBoxLite;

interface

uses
  u_base_key_form,
  Winapi.Windows,
  System.Classes, System.SysUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.ImgList, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, dxSkinsdxStatusBarPainter, dxSkinsForm,
  cxEditRepositoryItems, cxClasses, cxLabel, cxTextEdit, cxCurrencyEdit,
  dxStatusBar, cxButtons, cxGroupBox, cxStyles, cxTL, cxCustomData,
  cxTLdxBarBuiltInMenu, cxInplaceContainer;

type
  Tf_CashBoxLite = class(Tf_base_key_form)
    il_main: TcxImageList;
    er_main: TcxEditRepository;
    er_main_count: TcxEditRepositoryCurrencyItem;
    er_main_price: TcxEditRepositoryCurrencyItem;
    sc_main: TdxSkinController;
    lf_main: TcxLookAndFeelController;
    sb_main: TdxStatusBar;
    gb_SalesTicker: TcxGroupBox;
    gb_allsum: TcxGroupBox;
    ce_sum: TcxCurrencyEdit;
    lbl_sum: TcxLabel;
    er_main_price_ReadOnly: TcxEditRepositoryCurrencyItem;
    st_main: TcxStyleRepository;
    st_main_control: TcxEditStyleController;
    st_default_font: TcxStyle;
    sts_default: TcxTreeListStyleSheet;
    er_main_txt: TcxEditRepositoryTextItem;
    er_main_count_is_piece: TcxEditRepositoryCurrencyItem;
    tl_cheque: TcxTreeList;
    tl_cheque_ID: TcxTreeListColumn;
    tl_cheque_name: TcxTreeListColumn;
    tl_cheque_unit: TcxTreeListColumn;
    tl_cheque_price: TcxTreeListColumn;
    tl_cheque_Count: TcxTreeListColumn;
    tl_cheque_sum: TcxTreeListColumn;
    tl_cheque_IsPiece: TcxTreeListColumn;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SelectSalID: Integer;
    procedure OpenGoods;
    procedure OpenMenu;
    procedure OpenPay;
    procedure CreateSal;
    function AddSalPos(const GoodsID: Integer; const Price,
      Count: Double): integer;
    procedure RefreshSale(const id: Integer = 0);
    procedure RefreshFullSum;
    procedure DelPos;
    procedure EdtPos;
  protected
    procedure Command(Key: Word); override;
  public
    { Public declarations }
  end;

var
  f_CashBoxLite: Tf_CashBoxLite;

implementation

{$R *.dfm}

uses
  u_Goods, u_CashBoxMenu, u_Pay, Uni, u_GoodsAdd, u_common, u_treelist,
  u_GoodsDel;

//==============================================================================
procedure Tf_CashBoxLite.CreateSal;
  begin
    SelectSalID := db.InsertIntoTable('sal_main', ['date_create'], ['%datetime()']);
  end;
//==============================================================================
procedure Tf_CashBoxLite.DelPos;
  begin
    if Assigned(tl_cheque.FocusedNode) then
      with Tf_GoodsDel.Create(Self) do
        try
          if ShowModal = mrOk then
            begin
              db.UpdateTable('sal_pos',
                             ['is_del',
                              'date_del'],
                             [1,
                              '%datetime()'],
                             'id=' + tl_cheque.FocusedNode.Texts[tl_cheque_ID.ItemIndex]);
              RefreshSale;
            end;
        finally
          Free;
        end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.EdtPos;
  begin
    if Assigned(tl_cheque.FocusedNode) then
      with Tf_GoodsAdd.Create(Self) do
        try
          txt_Name.Text := tl_cheque.FocusedNode.Texts[tl_cheque_name.ItemIndex];
          txt_Unit.Text := tl_cheque.FocusedNode.Texts[tl_cheque_unit.ItemIndex];
          ce_Price.Value := tl_cheque.FocusedNode.Values[tl_cheque_price.ItemIndex];
          ce_Count.Value := tl_cheque.FocusedNode.Values[tl_cheque_Count.ItemIndex];

          if tl_cheque.FocusedNode.Values[tl_cheque_IsPiece.ItemIndex] = 1 then
            ce_Count.RepositoryItem := er_main_count_is_piece
          else
            begin
              ce_Count.TextHint := 'Положите товар на весы!';
              ce_Count.TabStop := False;
              ce_Count.Enabled := False;
            end;

          if ShowModal = mrOk then
            begin
              db.UpdateTable('sal_pos',
                             ['gds_count',
                              'sal_pos_sum'],
                             [ce_Count.Value,
                              ce_Count.Value * ce_Price.Value],
                             'id=' + tl_cheque.FocusedNode.Values[tl_cheque_ID.ItemIndex]);
              RefreshSale(tl_cheque.FocusedNode.Values[tl_cheque_ID.ItemIndex]);
            end;
        finally
          Free;
        end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.FormCreate(Sender: TObject);
  begin
    inherited;
    with Screen.WorkAreaRect do
      SetBounds(Left, Top, Right-Left, Bottom-Top);
    BackName := 'Корректировка кол-ва';
    EscName := 'Удалить товар из чека';
    ReturnName := 'Оплата';
    SelectSalID := 1;
  end;
//==============================================================================
procedure Tf_CashBoxLite.FormResize(Sender: TObject);
  var
    i, c, w: Integer;
  begin
    inherited;
    c := sb_main.Panels.Count;
    w := Trunc(sb_main.Width / c);
    for i := 0 to c -1 do
      sb_main.Panels.Items[i].Width := w;
  end;
//==============================================================================
procedure Tf_CashBoxLite.FormShow(Sender: TObject);
  begin
    inherited;
    RefreshSale;
  end;
//==============================================================================
procedure Tf_CashBoxLite.OpenGoods;
  var
    SalePosID: Integer;
  begin
    with Tf_goods.Create(Self) do
      try
        RefreshGroups;
        if ShowModal = mrOk then
          with Tf_GoodsAdd.Create(Self) do
            try
              with tl_goods.FocusedNode do
                begin
                  txt_Name.Text := Texts[tl_goods_Name.ItemIndex];
                  txt_Unit.Text := Texts[tl_goods_Unit_Name.ItemIndex];
                  ce_Price.Value := Values[tl_goods_Price.ItemIndex];

                  if Values[tl_goods_IsPiece.ItemIndex] = 1 then
                    begin
                      ce_Count.RepositoryItem := er_main_count_is_piece;
                      ce_Count.Value := 1;
                    end
                  else
                    begin
                      ce_Count.TextHint := 'Положите товар на весы!';
                      ce_Count.TabStop := False;
                      ce_Count.Enabled := False;
                    end;
                  if ShowModal = mrOk then
                    begin
                      if SelectSalID = 0 then
                        CreateSal;

                      SalePosID := AddSalPos(Values[tl_goods_ID.ItemIndex],
                                             Values[tl_goods_Price.ItemIndex],
                                             ce_Count.Value);

                      RefreshSale(SalePosID);
                    end;
                end;
            finally
              Free;
            end;
      finally
        Free;
      end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.OpenMenu;
  begin
    with Tf_CashBoxMenu.Create(Self) do
      try
        RefreshMenu;
        ShowModal;
      finally
        Free;
      end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.OpenPay;
  begin
    if tl_cheque.AbsoluteCount > 0 then
      with Tf_Pay.Create(Self) do
        try
          ShowModal;
        finally
          Free;
        end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.RefreshFullSum;
  var
    sm: double;
    i: Integer;
  begin
    sm := 0.0;
    for i := 0 to tl_cheque.AbsoluteCount -1 do
      sm := sm + tl_cheque.AbsoluteItems[i].Values[tl_cheque_sum.ItemIndex];
    ce_sum.Value := sm;
  end;
//==============================================================================
procedure Tf_CashBoxLite.RefreshSale(const id: Integer);
  const
    sql_text = 'select p.id, ' +
               '       g.name, ' +
               '       u.short_name, ' +
               '       replace(p.gds_price, ".", ",") as gds_price, ' +
               '       replace(p.gds_count, ".", ",") as gds_count, ' +
               '       replace(p.sal_pos_sum, ".", ",") as sal_pos_sum, ' +
               '       u.is_piece, ' +
               '       4 as img ' +
               '    from sal_pos p ' +
               '    join gds_main g ' +
               '      on g.id  = p.gds_id ' +
               '    join gds_units u ' +
               '      on u.id = unit_id ' +
               '   where p.is_del = 0 ' +
               '     and p.sal_id = :par_sal_id';
  var
    qr: TUniQuery;
  begin
    qr := db.Query(sql_text);
    try
      qr.Prepare;
      qr.ParamByName('par_sal_id').Value := SelectSalID;
      qr.Open;
      TTreeList.FillTreeList(tl_cheque,
                             qr,
                             [tl_cheque_ID,
                              tl_cheque_name,
                              tl_cheque_unit,
                              tl_cheque_price,
                              tl_cheque_Count,
                              tl_cheque_sum,
                              tl_cheque_IsPiece],
                             ['id',
                              'name',
                              'short_name',
                              'gds_price',
                              'gds_count',
                              'sal_pos_sum',
                              'is_piece'],
                             'img',
                             tl_cheque_ID.ItemIndex,
                             IntToStr(id));
      RefreshFullSum;
    finally
      qr.Free;
    end;
  end;
//==============================================================================
function Tf_CashBoxLite.AddSalPos(const GoodsID: Integer; const Price,
  Count: Double): integer;
  const
    sql_text = 'select p.id, p.gds_count, p.sal_pos_sum ' +
               '  from sal_pos p ' +
               ' where p.is_del = 0 ' +
               '   and p.sal_id = :par_sal_id ' +
               '   and p.gds_id = :par_gds_id ' +
               '   and gds_price = :par_price';
  var
    id: Integer;
    sm, cnt: Double;
  begin
    sm := Price * Count;
    // Проверяем есть ли такая позиция, если есть, то увеличиваем кол-во
    with db.Query(sql_text) do
      try
        Prepare;
        ParamByName('par_sal_id').Value := SelectSalID;
        ParamByName('par_gds_id').Value := GoodsID;
        ParamByName('par_price').Value := Price;
        Open;
        if RecordCount = 0 then
          // создаем позицию
          id := db.InsertIntoTable('sal_pos',
                                   ['sal_id',
                                    'gds_id',
                                    'gds_price',
                                    'gds_count',
                                    'sal_pos_sum',
                                    'date_create'],
                                   [SelectSalID,
                                    GoodsID,
                                    Price,
                                    Count,
                                    sm,
                                    '%datetime()'])
        else
          begin
            id := FieldByName('id').Value;
            cnt := Count + FieldByName('gds_count').Value;
            sm := sm + FieldByName('sal_pos_sum').Value;
            db.UpdateTable('sal_pos',
                           ['gds_count',
                            'sal_pos_sum'],
                           [cnt,
                            sm],
                           'id=' + IntToStr(id));
          end;
        Result := id;
      finally
        Free;
      end;
  end;
//==============================================================================
procedure Tf_CashBoxLite.Command(Key: Word);
  begin
    case Key of
      VK_F1: OpenMenu;
      VK_F2: OpenGoods;
      VK_RETURN: OpenPay;
      VK_ESCAPE: DelPos;
      VK_BACK: EdtPos;
    else
      inherited;
    end;
  end;
//==============================================================================
end.
