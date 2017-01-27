unit u_SQLite_db;

interface

uses
  Uni, SQLiteUniProvider;

type
  TDataBase = class
  private
    fConnection: TUniConnection;
    fProvidet: TSQLiteUniProvider;
  public
    property Connection: TUniConnection read fConnection;
    constructor Create;
    destructor Destroy; override;
    function Connect: Boolean;
    procedure Disconnect;
    function Query(const SQL: string): TUniQuery;
    function StoredProc(const StoredProcName: string): TUniStoredProc;
    procedure BeginTransaction;
    procedure EndTransaction;
    function InsertIntoTable(const TableName: string; const Fields: array of string;
      const Values: array of Variant): integer;
    procedure UpdateTable(const TableName: string; Fields: array of string;
      Values: array of Variant; const Condition: string);
  end;

implementation

uses
  u_messages, u_cript,
  System.SysUtils, System.Win.Registry, System.Variants,
  Winapi.Windows;

const
  db_path = 'db\SQLite\main.db';
  client_library_path = 'db\SQLite\sqlite3.dll';

{ TDataBase }

//==============================================================================
procedure TDataBase.BeginTransaction;
  begin
    fConnection.AutoCommit := False;
    fConnection.StartTransaction;
  end;
//==============================================================================
function TDataBase.Connect: Boolean;
  begin
    Result := True;
    try
      fConnection.Connected := False;
      fConnection.Database := db_path;
      fConnection.Connected := True;
    except
      on e: Exception do
        begin
          Result := False;
          TMessage.ErrorMessage(e.Message);
        end;
    end;
  end;
//==============================================================================
constructor TDataBase.Create;
  begin
    fProvidet := TSQLiteUniProvider.Create(nil);
    fConnection := TUniConnection.Create(nil);

    with Connection do
      begin
        ProviderName := 'SQLite';
        LoginPrompt := False;
        ConnectString := ConnectString + ';Use Unicode=True';
        ConnectString := ConnectString + ';Client Library=' + client_library_path;
      end;
  end;
//==============================================================================
destructor TDataBase.Destroy;
  begin
    Connection.Free;
    fProvidet.Free;
  end;
//==============================================================================
procedure TDataBase.Disconnect;
  begin
    fConnection.Connected := False;
  end;
//==============================================================================
procedure TDataBase.EndTransaction;
  begin
    try
      try
        fConnection.Commit;
      except
        fConnection.Rollback;
      end;
    finally
      fConnection.AutoCommit := True;
    end;
  end;
//==============================================================================
function TDataBase.InsertIntoTable(const TableName: string;
  const Fields: array of string; const Values: array of Variant): integer;
  var
    q: string;
    i: integer;
  begin
    q := 'INSERT INTO ' + TableName + ' (';
    for i := 0 to Length(Fields) -1 do
      q := q + Fields[i] + ',';
    Delete(q, Length(q), 1);
    q := q + ') VALUES (';
    for i := 0 to Length(Values) -1 do
      if VarIsStr(Values[i]) and (Copy(Values[i], 1, 1) = '%') then
        q := q + Copy(Values[i], 2, MaxInt) + ','
      else
        q := q + ':P' + IntToStr(i) + ',';
    Delete(q, Length(q), 1);
    q := q + ')';
    with Query(q) do
      try
        SQL.Text := q;
        for i := 0 to Length(Values) -1 do
          if not VarIsStr(Values[i]) or (Copy(Values[i], 1, 1) <> '%') then
            ParamByName('P' + IntToStr(i)).Value := Values[i];
        ExecSQL;
        SQL.Text := 'SELECT LAST_INSERT_ROWID()';
        Open;
        Result := Fields[0].AsInteger;
      finally
        Free;
      end;
  end;
//==============================================================================
function TDataBase.Query(const SQL: string): TUniQuery;
  begin
    Result := TUniQuery.Create(nil);
    Result.Connection := fConnection;
    Result.SQL.Text := SQL;
  end;
//==============================================================================
function TDataBase.StoredProc(const StoredProcName: string): TUniStoredProc;
  begin
    Result := TUniStoredProc.Create(nil);
    Result.Connection := fConnection;
    Result.StoredProcName := StoredProcName;
  end;
//==============================================================================
procedure TDataBase.UpdateTable(const TableName: string;
  Fields: array of string; Values: array of Variant; const Condition: string);
  var
    q: string;
    i: integer;
  begin
    q := 'UPDATE ' + TableName + ' SET ';
    for i := 0 to Length(Fields) -1 do
      q := q + Fields[i] + '=:P' + IntToStr(i) + ',';
    Delete(q, Length(q), 1);
    q := q + ' WHERE ' + Condition;
    with Query(q) do
      try
        for i := 0 to Length(Values) -1 do
          ParamByName('P' + IntToStr(i)).Value := Values[i];
        ExecSQL;
      finally
        Free;
      end;
  end;
//==============================================================================

end.
