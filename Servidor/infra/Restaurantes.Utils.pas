unit Restaurantes.Utils;

interface

uses
  System.JSON.Writers,
  System.SysUtils,
  System.StrUtils,
  System.NetEncoding,
  System.Classes,

  FireDAC.Comp.Client,

  Data.Db,
  Data.DBXPlatform,

  Restaurantes.Constantes;

type
  TUtils = class
    private

    public
      class procedure AddJSONValue(const AWriter: TJSONTextWriter; const AQuery: TFDQuery; const AContador: Integer);
      class procedure FormatarJSON(const AIDCode: Integer; const AContent: string);
  end;

implementation

uses
  REST.JSON;

{ TUtils }

class procedure TUtils.AddJSONValue(const AWriter: TJSONTextWriter;
  const AQuery: TFDQuery; const AContador: Integer);
var
  ftTipoCampo : TFieldType;
  StreamIn    : TStream;
  StreamOut   : TStringStream;
begin
  //Pegar o nome do campo
  AWriter.WritePropertyName(AQuery.Fields[AContador].FieldName);
  ftTipoCampo := AQuery.Fields.Fields[AContador].DataType;

  case ftTipoCampo of
    ftString, ftFmtMemo, ftMemo, ftWideString, ftWideMemo, ftUnknown:
      AWriter.WriteValue(AQuery.Fields[AContador].AsString);

    //Devolvendo a imagem em Base64
    ftBlob :
      begin
        StreamIn    := AQuery.CreateBlobStream(AQuery.Fields.Fields[AContador], bmRead);
        StreamOut   := TStringStream.Create;
        TNetEncoding.Base64.Encode(StreamIn, StreamOut);
        StreamOut.Position := 0;
        AWriter.WriteValue(StreamOut.DataString);
      end;

    ftSmallint, ftInteger, ftWord, ftLongWord, ftShortint, ftLargeint, ftByte:
        AWriter.WriteValue(AQuery.Fields[AContador].AsInteger);

    ftBoolean:
        AWriter.WriteValue(AQuery.Fields[AContador].AsBoolean);
      ftFloat, ftCurrency, ftExtended, ftFMTBcd, ftBCD:
        AWriter.WriteValue(AQuery.Fields[AContador].AsFloat);

    ftDate:
      if not AQuery.Fields[AContador].IsNull then
        AWriter.WriteValue(FormatDatetime('DD/MM/YYYY', AQuery.Fields[AContador].AsDateTime))
      else
        AWriter.WriteValue('');

    ftDateTime:
      if not AQuery.Fields[AContador].IsNull then
        AWriter.WriteValue(FormatDatetime('DD/MM/YYYY hh:nn:ss', AQuery.Fields[AContador].AsDateTime))
      else
        AWriter.WriteValue('');

    ftTime, ftTimeStamp:
      if not AQuery.Fields[AContador].IsNull then
        AWriter.WriteValue(FormatDatetime('HH:NN:SS', AQuery.Fields[AContador].AsDateTime))
      else
        AWriter.WriteValue('');

    ftBytes:
      AWriter.WriteValue(AQuery.Fields[AContador].AsBytes);
  end;
end;

class procedure TUtils.FormatarJSON(const AIDCode: Integer;
  const AContent: string);
begin

  GetInvocationMetadata().ResponseCode    := AIDCode;
  GetInvocationMetadata().ResponseContent :=  AContent;
end;

end.
