object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 429
  Width = 737
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=localhost:1521/xe'
      'User_Name=localdb'
      'Password=userapp'
      'DriverID=Ora')
    Left = 16
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 96
    Top = 24
  end
  object FDStoredProc1: TFDStoredProc
    Connection = FDConnection1
    SchemaName = 'LOCALDB'
    StoredProcName = 'SP_INSERE_ALUNO'
    Left = 160
    Top = 24
    ParamData = <
      item
        Position = 1
        Name = 'P_NOME'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 2
        Name = 'P_RA'
        DataType = ftFixedChar
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 5
      end
      item
        Position = 3
        Name = 'P_ENDERECO'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 200
      end
      item
        Position = 4
        Name = 'P_CEP'
        DataType = ftFixedChar
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 8
      end
      item
        Position = 5
        Name = 'P_TELEFONE'
        DataType = ftBCD
        FDDataType = dtBCD
        Precision = 11
        ParamType = ptInput
      end
      item
        Position = 6
        Name = 'P_CELULAR'
        DataType = ftBCD
        FDDataType = dtBCD
        Precision = 11
        ParamType = ptInput
      end
      item
        Position = 7
        Name = 'P_NASCIMENTO'
        DataType = ftDateTime
        FDDataType = dtDateTime
        NumericScale = 1000
        ParamType = ptInput
      end>
  end
  object DataSource1: TDataSource
    Left = 240
    Top = 24
  end
  object FDPhysOracleDriverLink1: TFDPhysOracleDriverLink
    VendorHome = 'XE'
    VendorLib = 'C:\instantclient_12_1\oci.dll'
    Left = 376
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 496
    Top = 24
  end
end
