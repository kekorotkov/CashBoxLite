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
    { Private declarations }
  protected
    procedure Command(Key: Word); override;
  public
    { Public declarations }
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
    with Screen.WorkAreaRect do
      SetBounds(Left + mrgForm,
                Top + mrgForm,
                Right - Left - (mrgForm*2),
                Bottom - Top - (mrgForm*2));
  end;
//==============================================================================
procedure Tf_base_modal_form.Command(Key: Word);
  begin
    if Key = VK_ESCAPE then
      ModalResult := mrCancel
    else
      inherited;
  end;
//==============================================================================
end.
