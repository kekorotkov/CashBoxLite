program CashBoxLite;

uses
  Vcl.Forms,
  u_Constants in 'u_Constants.pas',
  u_base_form in '..\BaseForms\u_base_form.pas' {f_base_form},
  u_base_key_form in '..\BaseForms\u_base_key_form.pas' {f_base_key_form},
  u_CashBoxLite in 'u_CashBoxLite.pas' {f_CashBoxLite},
  u_base_modal_form in '..\BaseForms\u_base_modal_form.pas' {f_base_modal_form},
  u_Goods in 'u_Goods.pas' {f_Goods},
  u_CashBoxMenu in 'u_CashBoxMenu.pas' {f_CashBoxMenu},
  u_messages in '..\Core\u_messages.pas',
  u_treelist in '..\Core\u_treelist.pas',
  u_common in '..\Core\u_common.pas',
  u_cript in '..\Core\u_cript.pas',
  u_md5 in '..\Core\u_md5.pas',
  u_SQLite_db in '..\Core\u_SQLite_db.pas',
  u_GoodsBarcodeSearch in 'u_GoodsBarcodeSearch.pas' {f_GoodsBarcodeSearch},
  u_Pay in 'u_Pay.pas' {f_Pay},
  u_AuthorizationBarcode in 'u_AuthorizationBarcode.pas' {f_AuthorizationBarcode},
  u_AuthorizationPassword in 'u_AuthorizationPassword.pas' {f_AuthorizationPassword},
  u_GoodsAdd in 'u_GoodsAdd.pas' {f_GoodsAdd},
  u_GoodsDel in 'u_GoodsDel.pas' {f_GoodsDel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_CashBoxLite, f_CashBoxLite);
  if Initialize then
    Application.Run
  else
    f_CashBoxLite.Free;
end.
