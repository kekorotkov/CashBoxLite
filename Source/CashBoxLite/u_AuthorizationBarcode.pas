unit u_AuthorizationBarcode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_base_modal_form, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinCaramel, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGroupBox;

type
  Tf_AuthorizationBarcode = class(Tf_base_modal_form)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_AuthorizationBarcode: Tf_AuthorizationBarcode;

implementation

{$R *.dfm}

//==============================================================================
procedure Tf_AuthorizationBarcode.FormCreate(Sender: TObject);
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

end.
