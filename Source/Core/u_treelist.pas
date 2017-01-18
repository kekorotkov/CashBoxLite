unit u_treelist;

interface

uses
  System.SysUtils,
  Data.DB,
  cxTL;

type
  TTreeList = class
  public
    class procedure FillTreeList(const TreeList: TcxTreeList;
      const Dataset: TDataset; const Columns: array of TcxTreeListColumn;
      const FieldNames: array of string; ImageFieldName: string = '';
      KeyField: Integer = 0; LocateTo: string = ''; BuildTree: boolean = false;
      ParentField: integer = 1);
    class procedure CheckUncheckChildren(const Node: TcxTreeListNode;
      const CheckColumn: TcxTreeListColumn; const IsCheck: Boolean = True);
  end;

implementation

{ TTreeList }

//==============================================================================
class procedure TTreeList.CheckUncheckChildren(const Node: TcxTreeListNode;
  const CheckColumn: TcxTreeListColumn; const IsCheck: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to Node.Count -1 do
      begin
        Node.Items[i].Values[CheckColumn.ItemIndex] := ord(IsCheck);
        CheckUncheckChildren(Node.Items[i], CheckColumn, IsCheck);
      end;
  end;
//==============================================================================
class procedure TTreeList.FillTreeList(const TreeList: TcxTreeList;
  const Dataset: TDataset; const Columns: array of TcxTreeListColumn;
  const FieldNames: array of string; ImageFieldName: string; KeyField: Integer;
  LocateTo: String; BuildTree: boolean; ParentField: integer);

  function AddToParent(Node, InNode : TcxTreeListNode) : boolean;
    var
      i : integer;
    begin
      Result := false;
      if Assigned(InNode) then
        begin
          if Node.Values[ParentField] = InNode.Values[KeyField] then
            begin
              Node.MoveTo(InNode, tlamAddChildFirst);
              Result := true;
            end
          else
            for i := 0 to InNode.Count -1 do
              if AddToParent(Node, InNode.Items[i]) then
                begin
                  Result := true;
                  Break;
                end;
        end
      else
        begin
          for i := TreeList.Count-1 downto 0 do
            if AddToParent(Node, TreeList.Items[i]) then
              Break;
        end;
    end;
  var
    l, i, j: integer;
    n, nFocused: TCxTreeListNode;
  begin
    l := Length(Columns);
    if Assigned(TreeList) and Assigned(Dataset) and (l > 0) and (l = Length(FieldNames)) then
      begin
        TreeList.BeginUpdate;
        try
          nFocused := nil;
          TreeList.Clear;
          Dataset.First;
          for i := 0 to Dataset.RecordCount -1 do
            begin
              n := TreeList.Add;
              if ImageFieldName <> '' then
                begin
                  n.ImageIndex := Dataset.FieldByName(ImageFieldName).AsInteger;
                  n.SelectedIndex := n.ImageIndex;
                end;
              for j := 0 to l -1 do
                n.Values[Columns[j].ItemIndex] := Dataset.FieldByName(FieldNames[j]).Value;
              if (KeyField >= 0) and (Trim(LocateTo) <> '') and (n.Texts[KeyField] = LocateTo) then
                nFocused := n;
              Dataset.Next;
            end;
          if BuildTree then
            begin
              for i := TreeList.Count -1 downto 0 do
                AddToParent(TreeList.Items[i], nil);
            end;
        finally
          TreeList.EndUpdate;
        end;
        if Assigned(nFocused) then
          begin
            nFocused.Focused := true;
            nFocused.MakeVisible;
          end;

        if (TreeList.AbsoluteCount > 0) and (Trim(LocateTo) = '') then
          with TreeList.TopNode do
            begin
              Focused := true;
              MakeVisible;
            end;
      end;
  end;
//==============================================================================
end.
