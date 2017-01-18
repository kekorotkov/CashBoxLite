unit u_messages;

interface

uses
  Winapi.Windows,
  Vcl.Forms, Vcl.Controls;

type
  TMessage = class
  private
    class function ShowMessage(const Caption, Text: string; Flags: Cardinal;
      Form: TForm): integer;
  public
    class procedure InfoMessage(const Text: string; Form: TForm = nil);
    class function QuestionMessage(const Text: string;
      Form: TForm = nil): boolean;
    class procedure ErrorMessage(const Text: string; Form: TForm = nil);
    class procedure InfoMessageEx(const Text: string;
      FocusControl: TWinControl = nil; Form: TForm = nil);
  end;

implementation

{ TMessage }

//==============================================================================
class procedure TMessage.ErrorMessage(const Text: string; Form: TForm);
  begin
    ShowMessage('Ошибка!', Text, MB_ICONERROR, Form);
  end;
//==============================================================================
class procedure TMessage.InfoMessage(const Text: string; Form: TForm);
  begin
    ShowMessage('Внимание!', Text, MB_ICONINFORMATION, Form);
  end;
//==============================================================================
class procedure TMessage.InfoMessageEx(const Text: string;
  FocusControl: TWinControl; Form: TForm);
  begin
    InfoMessage(Text, Form);
    if Assigned(FocusControl) then
      FocusControl.SetFocus;
  end;
//==============================================================================
class function TMessage.QuestionMessage(const Text: string;
  Form: TForm): boolean;
  begin
    Result := ShowMessage('Вопрос', Text, MB_ICONQUESTION or MB_YESNO,
      Form) = IDYES;
  end;
//==============================================================================
class function TMessage.ShowMessage(const Caption, Text: string;
  Flags: Cardinal; Form: TForm): integer;
  var
    wnd: HWND;
  begin
    if Assigned(Form) then
      wnd := Form.Handle
    else
      wnd := 0;
    Result := MessageBox(wnd, PChar(Text), PChar(Caption), Flags);
  end;
//==============================================================================

end.
