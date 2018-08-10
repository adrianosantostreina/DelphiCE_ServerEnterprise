program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit1 in 'FormUnit1.pas' {Form1},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {SmServicos: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  Restaurantes.Utils in 'infra\Restaurantes.Utils.pas',
  ULGTDataSetHelper in 'infra\ULGTDataSetHelper.pas',
  Restaurantes.Constantes in 'infra\Restaurantes.Constantes.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
