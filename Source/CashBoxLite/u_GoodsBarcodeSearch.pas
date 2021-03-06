unit u_GoodsBarcodeSearch;

interface

uses
  u_base_modal_form,
  Winapi.Windows,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Menus,
  System.Classes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxTextEdit, cxButtons, cxGroupBox;

type
  Tf_GoodsBarcodeSearch = class(Tf_base_modal_form)
    txt_Barcode: TcxTextEdit;
    procedure txt_BarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_GoodsBarcodeSearch: Tf_GoodsBarcodeSearch;

implementation

{$R *.dfm}

uses u_CashBoxLite;

//==============================================================================
procedure Tf_GoodsBarcodeSearch.FormCreate(Sender: TObject);
  begin
    inherited;
    F1Name := '';
    btn_f1.Enabled := False;

    F2Name := '';
    btn_f2.Enabled := False;

    F3Name := '';
    btn_f3.Enabled := False;

    F4Name := '';
    btn_f4.Enabled := False;

    BackName := '';
    btn_back.Enabled := False;

    IsDefFormPos := True;
  end;
//==============================================================================
procedure Tf_GoodsBarcodeSearch.txt_BarcodeKeyPress(Sender: TObject;
  var Key: Char);
  begin
    if not (Key in ['0'..'9', #8]) then
      Key := #0;
  end;
//==============================================================================

end.
