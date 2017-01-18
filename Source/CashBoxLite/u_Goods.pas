unit u_Goods;

interface

uses
  u_base_modal_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Controls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxCustomData, cxStyles, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, dxSkinsdxStatusBarPainter, cxSplitter, dxStatusBar,
  cxInplaceContainer, cxButtons, cxGroupBox;

type
  Tf_Goods = class(Tf_base_modal_form)
    tl_groups: TcxTreeList;
    tl_goods: TcxTreeList;
    sb_path: TdxStatusBar;
    sp_goods: TcxSplitter;
    tl_groups_ID: TcxTreeListColumn;
    tl_groups_Name: TcxTreeListColumn;
    tl_goods_ID: TcxTreeListColumn;
    tl_goods_Name: TcxTreeListColumn;
    procedure FormResize(Sender: TObject);
    procedure tl_groupsFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefreshGoods(const grpNode: TcxTreeListNode;
      const id: Integer = 0);
    procedure OpenBarcode;
  protected
    procedure Command(Key: Word); override;
  public
    procedure RefreshGroups(const pNode: TcxTreeListNode;
      const id: Integer = 0);
  end;

var
  f_Goods: Tf_Goods;

implementation

uses
  Uni, u_common, u_treelist, u_CashBoxLite, u_GoodsBarcodeSearch;

{$R *.dfm}

//==============================================================================
procedure Tf_Goods.Command(Key: Word);
  begin
    case Key of
      VK_F1: OpenBarcode;
      VK_F2:
        begin
          keybd_event(VK_TAB, 0, 0, 0);
          keybd_event(VK_TAB, 0, KEYEVENTF_KEYUP, 0);
        end;
    else
      inherited;
    end;
  end;
//==============================================================================
procedure Tf_Goods.FormCreate(Sender: TObject);
  begin
    inherited;

    F1Name := 'Поиск по штрихкоду';
    F2Name := 'Переместить';
  end;
//==============================================================================
procedure Tf_Goods.FormResize(Sender: TObject);
  begin
    inherited;
    tl_groups.Width := Width div 2;
  end;
//==============================================================================
procedure Tf_Goods.OpenBarcode;
  begin
    with Tf_GoodsBarcodeSearch.Create(Self) do
      try
        ShowModal;
      finally
        Free;
      end;
  end;
//==============================================================================
procedure Tf_Goods.RefreshGoods(const grpNode: TcxTreeListNode;
  const id: Integer);
  const
    sql_text = 'select 1 as id, "Товар №1" as name, 4 as img ' +
               ' union all ' +
               'select 2, "Товар №2", 4 ' +
               ' union all ' +
               'select 3, "Товар №3", 4 ' +
               ' union all ' +
               'select 4, "Товар №4", 4 ';
  var
   qr: TUniQuery;
  begin
    qr := db.Query(sql_text);
    try
      qr.Open;
      TTreeList.FillTreeList(tl_goods,
                             qr,
                             [tl_goods_ID,
                              tl_goods_Name],
                             ['id',
                              'name'],
                             'img',
                             tl_goods_ID.ItemIndex);
    finally
      qr.Free;
    end;
  end;
//==============================================================================
procedure Tf_Goods.RefreshGroups(const pNode: TcxTreeListNode;
  const id: Integer);
  const
    sql_text = 'select 0 as id, "..." as name, 3 as img ' +
               ' union all ' +
               'select 1, "Группа №1", 3 ' +
               ' union all ' +
               'select 2, "Группа №2", 3 ' +
               ' union all ' +
               'select 3, "Группа №3", 3 ' +
               ' union all ' +
               'select 4, "Группа №4", 3 ';
  var
   qr: TUniQuery;
  begin
    qr := db.Query(sql_text);
    try
      qr.Open;
      TTreeList.FillTreeList(tl_groups,
                             qr,
                             [tl_groups_ID,
                              tl_groups_Name],
                             ['id',
                              'name'],
                             'img',
                             tl_groups_ID.ItemIndex);
    finally
      qr.Free;
    end;
  end;
//==============================================================================
procedure Tf_Goods.tl_groupsFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
  begin
    if (AFocusedNode <> APrevFocusedNode) and (AFocusedNode <> nil) then
      if Assigned(tl_goods.FocusedNode) then
        RefreshGoods(nil)
      else
        RefreshGoods(nil);
  end;
//==============================================================================
end.
