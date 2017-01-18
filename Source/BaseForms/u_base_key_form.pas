unit u_base_key_form;

interface

uses
  u_base_form,
  Winapi.Windows,
  System.Classes,
  Vcl.Forms, Vcl.Menus, Vcl.StdCtrls, Vcl.Controls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxButtons, cxGroupBox;

type
  Tf_base_key_form = class(Tf_base_form)
    gb_keys: TcxGroupBox;
    btn_f1: TcxButton;
    btn_f2: TcxButton;
    btn_f3: TcxButton;
    btn_f4: TcxButton;
    btn_back: TcxButton;
    btn_return: TcxButton;
    btn_esc: TcxButton;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_escClick(Sender: TObject);
    procedure btn_f1Click(Sender: TObject);
    procedure btn_f2Click(Sender: TObject);
    procedure btn_f3Click(Sender: TObject);
    procedure btn_f4Click(Sender: TObject);
    procedure btn_backClick(Sender: TObject);
    procedure btn_returnClick(Sender: TObject);
  private
    fF1Name: string;
    fF2Name: string;
    fF3Name: string;
    fF4Name: string;
    fBackName: string;
    fReturnName: string;
    fEscName: string;
    procedure Move(const IsUp: Boolean);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Command(Key: Word); virtual;
  public
    property F1Name: string read fF1Name write fF1Name;
    property F2Name: string read fF2Name write fF2Name;
    property F3Name: string read fF3Name write fF3Name;
    property F4Name: string read fF4Name write fF4Name;
    property BackName: string read fBackName write fBackName;
    property ReturnName: string read fReturnName write fReturnName;
    property EscName: string read fEscName write fEscName;
  end;

var
  f_base_key_form: Tf_base_key_form;

implementation

uses
  cxTL;

{$R *.dfm}

//==============================================================================
procedure Tf_base_key_form.FormCreate(Sender: TObject);
  const
    f1_name     = 'Меню';
    f2_name     = 'Подбор товара';
    f3_name     = 'Вверх';
    f4_name     = 'Вниз';
    back_name   = 'Назад';
    return_name = 'Выбрать';
    esc_name    = 'Закрыть';
  begin
    inherited;
    fF1Name     := f1_name;
    fF2Name     := f2_name;
    fF3Name     := f3_name;
    fF4Name     := f4_name;
    fBackName   := back_name;
    fReturnName := return_name;
    fEscName    := esc_name;
  end;
//==============================================================================
procedure Tf_base_key_form.FormPaint(Sender: TObject);
  var
    i, c, w: Integer;
  begin
    inherited;
    c := 0;
    for i := 0 to ComponentCount -1 do
      if (Components[i] is TControl) and ((Components[i] as TControl).Parent = gb_keys) then
        Inc(c);
    w := Trunc(gb_keys.Width / c);
    for i := 0 to ComponentCount -1 do
      if (Components[i] is TControl) and ((Components[i] as TControl).Parent = gb_keys) then
        (Components[i] as TControl).Width := w;
  end;
//==============================================================================
procedure Tf_base_key_form.FormShow(Sender: TObject);
  const
    f1_pre_name     = '[ F1 ]';
    f2_pre_name     = '[ F2 ]';
    f3_pre_name     = '[ F3 ]';
    f4_pre_name     = '[ F4 ]';
    back_pre_name   = '[ ← ]';
    return_pre_name = '[ Enter ]';
    esc_pre_name    = '[ Esc ]';
  begin
    inherited;
    btn_f1.Caption      := f1_pre_name      + #10#13 + fF1Name;
    btn_f2.Caption      := f2_pre_name      + #10#13 + fF2Name;
    btn_f3.Caption      := f3_pre_name      + #10#13 + fF3Name;
    btn_f4.Caption      := f4_pre_name      + #10#13 + fF4Name;
    btn_back.Caption    := back_pre_name    + #10#13 + fBackName;
    btn_return.Caption  := return_pre_name  + #10#13 + fReturnName;
    btn_esc.Caption     := esc_pre_name     + #10#13 + fEscName;
  end;
//==============================================================================
procedure Tf_base_key_form.KeyDown(var Key: Word; Shift: TShiftState);
  begin
    Command(Key);
  end;
//==============================================================================
procedure Tf_base_key_form.Move(const IsUp: Boolean);
  var
    n: TcxTreeListNode;
  begin
    If Assigned(Screen.ActiveControl) and
       (Screen.ActiveControl Is TcxTreeList) and
       Assigned(TcxTreeList(Screen.ActiveControl).FocusedNode) then
      with TcxTreeList(Screen.ActiveControl) do
        begin
          n := FocusedNode;
          if IsUp then
            if n.Index > 0 then
              n := Items[n.Index -1]
            else
              n := Items[Count -1]
          else
            if n.Index < Count -1 then
              n := Items[n.Index + 1]
            else
              n := Items[0];
          n.Focused := true;
          n.MakeVisible;
        end;
  end;
//==============================================================================
procedure Tf_base_key_form.btn_backClick(Sender: TObject);
  begin
    Command(VK_BACK);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_escClick(Sender: TObject);
  begin
    Command(VK_ESCAPE);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_f1Click(Sender: TObject);
  begin
    Command(VK_F1);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_f2Click(Sender: TObject);
  begin
    Command(VK_F2);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_f3Click(Sender: TObject);
  begin
    Command(VK_F3);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_f4Click(Sender: TObject);
  begin
    Command(VK_F4);
  end;
//==============================================================================
procedure Tf_base_key_form.btn_returnClick(Sender: TObject);
  begin
    Command(VK_RETURN);
  end;
//==============================================================================
procedure Tf_base_key_form.Command(Key: Word);
  begin
    case Key of
      VK_F3: Move(True);
      VK_F4: Move(False);
    end;
  end;
//==============================================================================
end.
