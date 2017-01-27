unit u_base_modal_form;

interface

uses
  u_base_key_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Forms, Vcl.Menus, Vcl.StdCtrls, Vcl.Controls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxButtons, cxGroupBox;

type
  Tf_base_modal_form = class(Tf_base_key_form)
    procedure FormResize(Sender: TObject);
  private
    fIsDefFormPos: Boolean;
  protected
    procedure Command(Key: Word); override;
  public
    property IsDefFormPos: Boolean read fIsDefFormPos write fIsDefFormPos;
  end;

var
  f_base_modal_form: Tf_base_modal_form;

implementation

{$R *.dfm}

uses
  u_constants;

//==============================================================================
procedure Tf_base_modal_form.FormResize(Sender: TObject);
  begin
    inherited;
    if not IsDefFormPos then
      with Screen.WorkAreaRect do
        SetBounds(Left + mrgForm,
                  Top + mrgForm,
                  Right - Left - (mrgForm*2),
                  Bottom - Top - (mrgForm*2));
  end;
//==============================================================================
procedure Tf_base_modal_form.Command(Key: Word);
  begin
    case Key of
      VK_RETURN: ModalResult := mrOk;
      VK_ESCAPE: ModalResult := mrCancel;
    else
      inherited;
    end;
  end;
//==============================================================================
end.
