object FrmAlunoPesquisa: TFrmAlunoPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisa de Alunos'
  ClientHeight = 126
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PnlPesquisa: TPanel
    Left = 7
    Top = 8
    Width = 440
    Height = 108
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label8: TLabel
      Left = 11
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object Label9: TLabel
      Left = 11
      Top = 41
      Width = 18
      Height = 13
      Caption = 'RA:'
    end
    object TxtNome: TEdit
      Left = 76
      Top = 11
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 0
    end
    object BtnCancelar: TButton
      Left = 346
      Top = 70
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 3
      OnClick = BtnCancelarClick
    end
    object MskRA: TMaskEdit
      Left = 76
      Top = 38
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      EditMask = '00000;0;_'
      MaxLength = 5
      TabOrder = 1
      Text = ''
    end
    object BtnPesquisar: TButton
      Left = 263
      Top = 70
      Width = 75
      Height = 25
      Caption = '&Pesquisar'
      TabOrder = 2
    end
  end
end
