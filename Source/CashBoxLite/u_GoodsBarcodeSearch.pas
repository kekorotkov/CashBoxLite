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
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Command(Key: Word); override;
  public
    { Public declarations }
  end;

var
  f_GoodsBarcodeSearch: Tf_GoodsBarcodeSearch;

implementation

{$R *.dfm}

//==============================================================================
procedure Tf_GoodsBarcodeSearch.Command(Key: Word);
  begin
    case Key of
      VK_RETURN: ModalResult := mrOk;
    else
      inherited;
    end;
  end;
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
  end;
//==============================================================================
procedure Tf_GoodsBarcodeSearch.FormResize(Sender: TObject);
  begin
    Width := 600;
    Height := 150;
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
