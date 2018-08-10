unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.StorageJSON, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Restaurantes.Utils,
  ULGTDataSetHelper;

type
{$METHODINFO ON}
  TSmServicos = class(TDataModule)
    fdConn: TFDConnection;
    qryExportar: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function Estabelecimentos(const AID: string): TJSONArray;
  end;
{$METHODINFO OFF}

implementation

uses
  Data.DBXPlatform;


{$R *.dfm}


{ TSmServicos }

function TSmServicos.Estabelecimentos(const AID: string): TJSONArray;
const
  _SQL = 'SELECT * FROM CURSO.ESTABELECIMENTOS';
begin
  //Result := 'GET - Delphi'
  qryExportar.Close;
  if AId.Equals(EmptyStr) then
    qryExportar.Open(_SQL)
  else
  begin
    qryExportar.SQL.Clear;
    qryExportar.SQL.Add(_SQL);
    qryExportar.SQL.Add(' WHERE ID = :PID');
    qryExportar.Params.CreateParam(ftInteger, 'PID', ptInput);
    qryExportar.ParamByName('PID').AsInteger := aId.ToInteger();
    qryExportar.Open();
  end;

  if qryExportar.IsEmpty
  then Result := TJSONArray.Create('Mensagem', 'Nenhum estabelecimento encontrado.')
  else Result := qryExportar.DataSetToJSON;

  TUtils.FormatarJSON(GetInvocationMetadata().ResponseCode, Result.ToString);
end;

end.

