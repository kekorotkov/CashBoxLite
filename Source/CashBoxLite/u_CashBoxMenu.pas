unit u_CashBoxMenu;

interface

uses
  u_base_modal_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Controls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxCustomData, cxStyles, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxButtons, cxGroupBox;

type
  Tf_CashBoxMenu = class(Tf_base_modal_form)
    tl_menu: TcxTreeList;
    tl_menu_ID: TcxTreeListColumn;
    tl_menu_Name: TcxTreeListColumn;
    procedure FormCreate(Sender: TObject);
    procedure tl_menuDblClick(Sender: TObject);
  private
    procedure OpenMenuItem;
  protected
    procedure Command(Key: Word); override;
  public
    procedure RefreshMenu(const id: Integer = 0);
  end;

var
  f_CashBoxMenu: Tf_CashBoxMenu;

implementation

uses
  Uni, u_common, u_treelist, u_CashBoxLite;

{$R *.dfm}

{ Tf_CashBoxMenu }

//==============================================================================
procedure Tf_CashBoxMenu.Command(Key: Word);
  begin
    case Key of
      VK_RETURN: OpenMenuItem;
    else
      inherited;
    end;
  end;
//==============================================================================
procedure Tf_CashBoxMenu.OpenMenuItem;
  var
    id: Integer;
  begin
    if Assigned(tl_menu.FocusedNode) then
      begin
        id := tl_menu.FocusedNode.Values[tl_menu_ID.ItemIndex];

        case id of
          7: f_CashBoxLite.Close;
        end;
      end;
  end;
//==============================================================================
procedure Tf_CashBoxMenu.FormCreate(Sender: TObject);
  begin
    inherited;

    BackName := '';
    btn_back.Enabled := False;

    F1Name := '';
    btn_f1.Enabled := False;

    F2Name := '';
    btn_f2.Enabled := False;
  end;
//==============================================================================
procedure Tf_CashBoxMenu.RefreshMenu(const id: Integer);
  const
    sql_text = 'select 1 as id, "Возврат" as name, 5 as img ' +
               ' union all ' +
               'select 2, "Прием товара", 6 ' +
               ' union all ' +
               'select 3, "Просмотр остатков", 7 ' +
               ' union all ' +
               'select 4, "Ревизия", 8 ' +
               ' union all ' +
               'select 5, "Тара", 9 ' +
               ' union all ' +
               'select 6, "Закрыть смену", 10 ' +
               ' union all ' +
               'select 7, "Выход из программы", 11';
  var
   qr: TUniQuery;
  begin
    qr := db.Query(sql_text);
    try
      qr.Open;
      TTreeList.FillTreeList(tl_menu,
                             qr,
                             [tl_menu_ID,
                              tl_menu_Name],
                             ['id',
                              'name'],
                             'img',
                             tl_menu_ID.ItemIndex);
    finally
      qr.Free;
    end;
  end;
//==============================================================================
procedure Tf_CashBoxMenu.tl_menuDblClick(Sender: TObject);
  begin
    OpenMenuItem;
  end;
//==============================================================================
end.
