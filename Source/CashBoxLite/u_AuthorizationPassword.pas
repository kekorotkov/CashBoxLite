unit u_AuthorizationPassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_base_modal_form, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinCaramel, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGroupBox,
  cxTextEdit;

type
  Tf_AuthorizationPassword = class(Tf_base_modal_form)
    txt_Barcode: TcxTextEdit;
    procedure txt_BarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_AuthorizationPassword: Tf_AuthorizationPassword;

implementation

{$R *.dfm}

uses u_CashBoxLite;

//==============================================================================
procedure Tf_AuthorizationPassword.FormCreate(Sender: TObject);
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
procedure Tf_AuthorizationPassword.txt_BarcodeKeyPress(Sender: TObject;
  var Key: Char);
  begin
    if not (Key in ['0'..'9', #8]) then
      Key := #0;
  end;
//==============================================================================
end.
