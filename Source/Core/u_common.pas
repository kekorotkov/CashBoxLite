unit u_common;

interface

uses
  u_SQLite_db,
  Winapi.Windows,
  System.Variants;

  function Initialize: Boolean;
  procedure UnInitialize;
  function Mutex: Boolean;

(******************************************************************************)
(*                          Прочие процедуры и функции                        *)
(******************************************************************************)
  function NVL(v1, v2: variant): variant;
  function ZTN(const Value: variant): Variant;


var
  db: TDataBase;

implementation

uses
//  u_connect,
  Vcl.Forms,
  Vcl.Controls;

const
  MUTEX_NAME = 'CashBoxLite_01jan2017';

var
  HMutex : THandle;

//==============================================================================
function Mutex: Boolean;
  begin
    HMutex := CreateMutex(nil, True, MUTEX_NAME);
    Result := GetLastError <> ERROR_ALREADY_EXISTS;
  end;
//==============================================================================
function Initialize: Boolean;
  begin
    Result := False;
    if Mutex then
      begin
        db := TDataBase.Create;
        if db.Connect then
          Result := True;
      end;
  end;
//==============================================================================
procedure UnInitialize;
  begin
    //
  end;
//==============================================================================
function NVL(v1, v2: variant): variant;
  begin
    if v1 = null then
      Result := v2
    else
      Result := v1;
  end;
//==============================================================================
function ZTN(const Value: variant): Variant;
  begin
    Result := Value;
    case VarType(Value) of
      varSmallInt,
      varUString,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varByte,
      varWord,
      varLongWord,
      varVariant,
      varInt64:
        if Value = 0 then
          Result := null;
    end;
  end;
//==============================================================================
end.
