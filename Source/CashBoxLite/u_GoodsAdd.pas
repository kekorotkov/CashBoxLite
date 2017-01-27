unit u_GoodsAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_base_modal_form, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinCaramel, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGroupBox,
  cxTextEdit, cxLabel, cxCurrencyEdit;

type
  Tf_GoodsAdd = class(Tf_base_modal_form)
    lbl_Name: TcxLabel;
    lbl_Unit: TcxLabel;
    lbl_Price: TcxLabel;
    lbl_Count: TcxLabel;
    txt_Name: TcxTextEdit;
    txt_Unit: TcxTextEdit;
    ce_Price: TcxCurrencyEdit;
    ce_Count: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Command(Key: Word); override;
  public
    { Public declarations }
  end;

var
  f_GoodsAdd: Tf_GoodsAdd;

implementation

{$R *.dfm}

uses u_CashBoxLite;

//==============================================================================
procedure Tf_GoodsAdd.Command(Key: Word);
  begin
    case Key of
      VK_BACK: ;
    else
      inherited;
    end;
  end;
//==============================================================================
procedure Tf_GoodsAdd.FormCreate(Sender: TObject);
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

    BackName := 'Стереть';

    IsDefFormPos := True;
  end;
//==============================================================================

end.
