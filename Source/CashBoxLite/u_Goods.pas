unit u_Goods;

interface

uses
  u_base_modal_form,
  Winapi.Windows,
  System.Classes, System.SysUtils, System.Variants,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Controls, Vcl.Forms,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinCaramel, cxCustomData, cxStyles, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, dxSkinsdxStatusBarPainter, cxSplitter, dxStatusBar,
  cxInplaceContainer, cxButtons, cxGroupBox;

type
  Tf_Goods = class(Tf_base_modal_form)
    tl_groups: TcxTreeList;
    tl_goods: TcxTreeList;
    sb_path: TdxStatusBar;
    sp_goods: TcxSplitter;
    tl_groups_ID: TcxTreeListColumn;
    tl_groups_Name: TcxTreeListColumn;
    tl_goods_ID: TcxTreeListColumn;
    tl_goods_Name: TcxTreeListColumn;
    tl_groups_ChildCount: TcxTreeListColumn;
    tl_groups_GdsGrpID: TcxTreeListColumn;
    procedure FormResize(Sender: TObject);
    procedure tl_groupsFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tl_groupsDblClick(Sender: TObject);
  private
    lstBreadCrumbs: TStringList;
    procedure RefreshGoods(const grpNode: TcxTreeListNode; const id: Integer = 0);
    procedure OpenBarcode;
    procedure Return;
    procedure RefreshBreadCrumbs(const Node: TcxTreeListNode);
  protected
    procedure Command(Key: Word); override;
  public
    procedure RefreshGroups(const pID: Integer = 0; const id: Integer = 0);
  end;

var
  f_Goods: Tf_Goods;

implementation

uses
  Uni, u_common, u_treelist, u_CashBoxLite, u_GoodsBarcodeSearch;

{$R *.dfm}

//==============================================================================
procedure Tf_Goods.Command(Key: Word);
  begin
    case Key of
      VK_F1: OpenBarcode;
      VK_F2:
        begin
          keybd_event(VK_TAB, 0, 0, 0);
          keybd_event(VK_TAB, 0, KEYEVENTF_KEYUP, 0);
        end;
      VK_RETURN: Return;
      VK_BACK:
        begin
          if tl_groups.Items[0].Values[tl_groups_ChildCount.ItemIndex] = -1 then
            begin
              RefreshBreadCrumbs(tl_groups.Items[0]);
              RefreshGroups(NVL(tl_groups.Items[0].Values[tl_groups_ID.ItemIndex], 0));
            end;
        end;
    else
      inherited;
    end;
  end;
//==============================================================================
procedure Tf_Goods.FormCreate(Sender: TObject);
  begin
    inherited;
    F1Name := 'Поиск по штрихкоду';
    F2Name := 'Переместить';
    lstBreadCrumbs := TStringList.Create;
  end;
//==============================================================================
procedure Tf_Goods.FormDestroy(Sender: TObject);
  begin
    lstBreadCrumbs.Free;
    inherited;
  end;
//==============================================================================
procedure Tf_Goods.FormResize(Sender: TObject);
  begin
    inherited;
    tl_groups.Width := Width div 2;
  end;
//==============================================================================
procedure Tf_Goods.OpenBarcode;
  begin
    with Tf_GoodsBarcodeSearch.Create(Self) do
      try
        ShowModal;
      finally
        Free;
      end;
  end;
//==============================================================================
procedure Tf_Goods.RefreshBreadCrumbs(const Node: TcxTreeListNode);
  var
    i: Integer;
    s: string;
  begin
    if Node.Values[tl_groups_ChildCount.ItemIndex] = -1 then
      lstBreadCrumbs.Delete(lstBreadCrumbs.Count -1)
    else
      lstBreadCrumbs.Add(Node.Texts[tl_groups_Name.ItemIndex]);

    s := '';
    for i := 0 to lstBreadCrumbs.Count -1 do
      s := s + lstBreadCrumbs.Strings[i] + '/';

    sb_path.Panels.Items[0].Text := s;
  end;
//==============================================================================
procedure Tf_Goods.RefreshGoods(const grpNode: TcxTreeListNode;
  const id: Integer);
  const
    sql_all_text = 'select g.id, g.name, 4 as img ' +
                   '  from gds_grp_hierarchy h ' +
                   '  join gds_grp_link l ' +
                   '    on l.grp_id = h.child_id ' +
                   '  join gds_main g ' +
                   '    on g.id = l.gds_id ' +
                   ' where h.parent_id = :par_grp_id';
    sql_text = 'select g.id, g.name, 4 as img ' +
               '  from gds_grp_link l ' +
               '  join gds_main g ' +
               '    on g.id = l.gds_id ' +
               ' where l.grp_id = :par_grp_id';
  var
   qr: TUniQuery;
  begin
    if grpNode.Values[tl_groups_ChildCount.ItemIndex] = 0 then
      qr := db.Query(sql_text)
    else
      qr := db.Query(sql_all_text);
    try
      qr.Prepare;
      qr.ParamByName('par_grp_id').Value := grpNode.Values[tl_groups_GdsGrpID.ItemIndex];
      qr.Open;
      TTreeList.FillTreeList(tl_goods,
                             qr,
                             [tl_goods_ID,
                              tl_goods_Name],
                             ['id',
                              'name'],
                             'img',
                             tl_goods_ID.ItemIndex);
    finally
      qr.Free;
    end;
  end;
//==============================================================================
procedure Tf_Goods.RefreshGroups(const pID, id: Integer);
  const
    sql_hi_lvl_text = 'select g.id, ' +
                      '       (select count(h.id) ' +
                      '          from gds_grp_hierarchy h ' +
                      '         where h.lvl = 1 ' +
                      '           and h.parent_id = g.id) as child_count, ' +
                      '       g.name, ' +
                      '       g.id as gds_grp_id, ' +
                      '       3 as img ' +
                      '  from gds_grp g ' +
                      ' where not g.id in (select h.child_id ' +
                      '                     from gds_grp_hierarchy h ' +
                      '                    where h.lvl = 1)';
    sql_text = 'select (select h.parent_id ' +
               '          from gds_grp_hierarchy h ' +
               '         where h.lvl = 1 ' +
               '           and h.child_id = :par_parent_id) as id, ' +
               '       -1 as child_count, ' +
               '       "..." as name, ' +
               '       :par_parent_id as gds_grp_id, ' +
               '       12 as img ' +
               ' union all ' +
               'select t.id, ' +
               '       t.child_count, ' +
               '       t.name, ' +
               '       t.id as gds_grp_id,' +
               '       case when t.child_count = 0 then 3 else 13 end as img ' +
               '  from (select g.id, ' +
               '               (select count(h.id) ' +
               '                  from gds_grp_hierarchy h ' +
               '                 where h.lvl = 1 ' +
               '                   and h.parent_id = g.id) as child_count, ' +
               '               g.name ' +
               '          from gds_grp_hierarchy h ' +
               '          join gds_grp g ' +
               '            on g.id = h.child_id ' +
               '         where h.lvl = 1 ' +
               '           and h.parent_id = :par_parent_id) t';
  var
   qr: TUniQuery;
  begin
    if pID = 0 then
      qr := db.Query(sql_hi_lvl_text)
    else
      qr := db.Query(sql_text);
    try
      if pID <> 0 then
        begin
          qr.Prepare;
          qr.ParamByName('par_parent_id').Value := pID;
        end;

      qr.Open;
      TTreeList.FillTreeList(tl_groups,
                             qr,
                             [tl_groups_ID,
                              tl_groups_ChildCount,
                              tl_groups_Name,
                              tl_groups_GdsGrpID],
                             ['id',
                              'child_count',
                              'name',
                              'gds_grp_id'],
                             'img',
                             tl_groups_ID.ItemIndex);
    finally
      qr.Free;
    end;
  end;
//==============================================================================
procedure Tf_Goods.Return;
  begin
    if Assigned(Screen.ActiveControl) and (Screen.ActiveControl Is TcxTreeList) then
      if TcxTreeList(Screen.ActiveControl).Name = 'tl_groups' then
        begin
          if Assigned(tl_groups.FocusedNode) then
            with tl_groups.FocusedNode do
              if Values[tl_groups_ChildCount.ItemIndex] <> 0 then
                begin
                  RefreshBreadCrumbs(tl_groups.FocusedNode);
                  RefreshGroups(NVL(Values[tl_groups_ID.ItemIndex], 0));
                end
              else
                if tl_goods.Count > 0 then
                  btn_f2.Click;
        end
      else
        if Assigned(tl_groups.FocusedNode) then
          ModalResult := mrOk;
  end;
//==============================================================================
procedure Tf_Goods.tl_groupsDblClick(Sender: TObject);
  begin
    btn_return.Click;
  end;
//==============================================================================
procedure Tf_Goods.tl_groupsFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
  begin
    if (AFocusedNode <> APrevFocusedNode) and (AFocusedNode <> nil) then
      if Assigned(tl_goods.FocusedNode) then
        RefreshGoods(AFocusedNode, tl_goods.FocusedNode.Values[tl_goods_ID.ItemIndex])
      else
        RefreshGoods(AFocusedNode);
  end;
//==============================================================================
end.
