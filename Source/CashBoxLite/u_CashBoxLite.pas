unit u_CashBoxLite;

interface

uses
  u_base_key_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.ImgList, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, dxSkinsdxStatusBarPainter, dxSkinsForm,
  cxEditRepositoryItems, cxClasses, cxLabel, cxTextEdit, cxCurrencyEdit,
  dxStatusBar, cxButtons, cxGroupBox;

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
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure OpenGoods;
    procedure OpenMenu;
    procedure OpenPay;
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
  u_Goods, u_CashBoxMenu, u_Pay;

//==============================================================================
procedure Tf_CashBoxLite.FormCreate(Sender: TObject);
  begin
    inherited;
    with Screen.WorkAreaRect do
      SetBounds(Left, Top, Right-Left, Bottom-Top);
    BackName := 'Корректировка кол-ва';
    EscName := 'Удалить товар из чека';
    ReturnName := 'Оплата';
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
procedure Tf_CashBoxLite.OpenGoods;
  begin
    with Tf_goods.Create(Self) do
      try
        RefreshGroups(nil);
        ShowModal;
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
    with Tf_Pay.Create(Self) do
      try
        ShowModal;
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
    else
      inherited;
    end;
  end;
//==============================================================================
end.
