unit u_cript;

interface

uses
  System.SysUtils, Vcl.Forms;

const
  cKey = 'keyWorkYUQajda342342423423423423K3LAKDJSL9RTIKJ';

type
  TCript = class
  private
    class procedure SetCrypt(var psSrc, Dest, Key: string;
      const KeyLen: Integer);
    class procedure SetDescrypt(var psSrc, Dest, Key: string;
      const KeyLen: Integer);
  public
    class function Decrypt(aText: string): string;
    class function Encrypts(aText: string): string;
    class function Crypt(Action, Src: string): string;
  end;

implementation

{ TCript }

//==============================================================================
class function TCript.Crypt(Action, Src: string): string;
  label
    Fim;
  var
    KeyLen: Integer;
    Dest, Key: string;
  begin
    if Trim(Src) = '' then
      begin
        Result := Src;
        Exit;
      end;

    Key := cKey;
    Dest := '';
    KeyLen := Length(Key);
    if (Action = UpperCase('C')) then
      SetCrypt(Src, Dest, Key, KeyLen)
    else
      if (Action = UpperCase('D')) then
        SetDescrypt(Src, Dest, Key, KeyLen);
    Result := Dest;
  end;
//==============================================================================
class function TCript.Decrypt(aText: string): string;
  begin
    Result := Crypt('D', aText);
  end;
//==============================================================================
class function TCript.Encrypts(aText: string): string;
  begin
    Result := TCript.Crypt('C', aText);
  end;
//==============================================================================
class procedure TCript.SetCrypt(var psSrc, Dest, Key: string;
  const KeyLen: Integer);
  var
    KeyPos: Integer;
    OffSet: Integer;
    SrcPos: Integer;
    SrcAsc: Integer;
    Range: Integer;
  begin
    KeyPos := 0;
    Range := 256;
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(psSrc) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(psSrc[SrcPos]) + OffSet) mod 255;

      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end;
//==============================================================================
class procedure TCript.SetDescrypt(var psSrc, Dest, Key: string;
  const KeyLen: Integer);
  var
    KeyPos: Integer;
    OffSet: Integer;
    SrcPos: Integer;
    SrcAsc: Integer;
    TmpSrcAsc: Integer;
  begin
    KeyPos := 0;
    OffSet := StrToIntDef(('$' + copy(psSrc, 1, 2)), 0);
    SrcPos := 3;
    repeat
      SrcAsc := StrToIntDef(('$' + copy(psSrc, SrcPos, 2)), 0);
      if (KeyPos < KeyLen) then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(psSrc));
  end;
//==============================================================================
end.
