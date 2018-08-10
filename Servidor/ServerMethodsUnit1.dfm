object SmServicos: TSmServicos
  OldCreateOrder = False
  Height = 282
  Width = 466
  object fdConn: TFDConnection
    Params.Strings = (
      'Database=curso'
      'User_Name=curso'
      'Password=s32]4]381a'
      'Server=192.168.1.90'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 88
    Top = 64
  end
  object qryExportar: TFDQuery
    Connection = fdConn
    Left = 88
    Top = 136
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 280
    Top = 64
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 280
    Top = 136
  end
end
