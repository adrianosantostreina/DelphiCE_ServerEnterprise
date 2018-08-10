unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Grid, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Edit1: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  REST.Types;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not (Edit1.Text.Equals(EmptyStr)) then
  begin
    RESTRequest1.Params.AddItem(
      'id',
      Edit1.Text,
      TRESTRequestParameterKind.pkURLSEGMENT
    );
    RESTRequest1.Resource := 'estabelecimentos/{id}';
  end
  else
  begin
    RESTRequest1.Params.Clear;
    RESTRequest1.Resource := 'estabelecimentos';
  end;

  RESTRequest1.Execute;
end;

end.
