unit u_Pay;

interface

uses
  u_base_modal_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxTextEdit, cxCurrencyEdit, cxImage,
  dxGDIPlusClasses, cxButtons, cxGroupBox;

type
  Tf_Pay = class(Tf_base_modal_form)
    gb_money: TcxGroupBox;
    gb_card: TcxGroupBox;
    img_money: TcxImage;
    img_card: TcxImage;
    ce_money: TcxCurrencyEdit;
    ce_card: TcxCurrencyEdit;
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
  f_Pay: Tf_Pay;

implementation

{$R *.dfm}

uses u_CashBoxLite, u_messages;

//==============================================================================
procedure Tf_Pay.Command(Key: Word);
  begin
    case Key of
      VK_F2:
        begin
          keybd_event(VK_TAB, 0, 0, 0);
          keybd_event(VK_TAB, 0, KEYEVENTF_KEYUP, 0);
        end;
      VK_RETURN: ModalResult := mrOk;
    else
      inherited;
    end;
  end;
//==============================================================================
procedure Tf_Pay.FormCreate(Sender: TObject);
  begin
    inherited;
    F1Name := '';
    btn_f1.Enabled := False;

    F2Name := 'Переместить';

    F3Name := '';
    btn_f3.Enabled := False;

    F4Name := '';
    btn_f4.Enabled := False;

    BackName := '';
    btn_back.Enabled := False;

    Width := 690;
    Height := 415;
    gb_money.Width := Width div 2;
    ce_money.Width := gb_money.Width -5;
    ce_card.Width := gb_card.Width -5;
  end;
//==============================================================================
procedure Tf_Pay.FormResize(Sender: TObject);
  begin
    //
  end;
//==============================================================================

end.
