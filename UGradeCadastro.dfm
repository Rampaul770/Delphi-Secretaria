object FrmGradeCadastro: TFrmGradeCadastro
  Left = 0
  Top = 0
  Caption = 'Cadastro de Grades'
  ClientHeight = 180
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlCadastro: TPanel
    Left = 7
    Top = 8
    Width = 441
    Height = 165
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object LblCursoRequerido: TLabel
      Left = 426
      Top = 42
      Width = 7
      Height = 13
      Caption = '*'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object LblMateriaRequerido: TLabel
      Left = 426
      Top = 71
      Width = 7
      Height = 13
      Caption = '*'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object LblMensagemRequerido: TLabel
      Left = 11
      Top = 133
      Width = 130
      Height = 13
      Caption = '* Campos obrigat'#243'rios!'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 11
      Top = 42
      Width = 32
      Height = 13
      Caption = 'Curso:'
    end
    object LblNomeRequerido: TLabel
      Left = 426
      Top = 15
      Width = 7
      Height = 13
      Caption = '*'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 10
      Top = 71
      Width = 40
      Height = 13
      Caption = 'Mat'#233'ria:'
    end
    object Label4: TLabel
      Left = 10
      Top = 101
      Width = 31
      Height = 13
      Caption = 'Aluno:'
    end
    object LblAlunoRequerido: TLabel
      Left = 425
      Top = 101
      Width = 7
      Height = 13
      Caption = '*'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object BtnCancelar: TButton
      Left = 346
      Top = 128
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 5
      OnClick = BtnCancelarClick
    end
    object BtnGravar: TButton
      Left = 265
      Top = 128
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 4
      OnClick = BtnGravarClick
    end
    object DbcCurso: TDBLookupComboBox
      Left = 56
      Top = 39
      Width = 365
      Height = 21
      KeyField = 'ID'
      ListField = 'ID'
      ListSource = DataModuleSecretaria.DtsCurso
      TabOrder = 1
      OnCloseUp = DbcCursoCloseUp
    end
    object DbcMateria: TDBLookupComboBox
      Left = 56
      Top = 67
      Width = 365
      Height = 21
      KeyField = 'MATERIAID'
      ListField = 'MATERIANOME'
      ListSource = DataModuleSecretaria.DtsMateria
      TabOrder = 2
    end
    object DbcAluno: TDBLookupComboBox
      Left = 56
      Top = 97
      Width = 365
      Height = 21
      KeyField = 'ID'
      ListField = 'ID'
      ListSource = DataModuleSecretaria.DtsAluno
      TabOrder = 3
    end
    object TxtNome: TButtonedEdit
      Left = 56
      Top = 11
      Width = 364
      Height = 21
      CharCase = ecUpperCase
      Images = ImageList1
      RightButton.HotImageIndex = 0
      RightButton.ImageIndex = 0
      RightButton.PressedImageIndex = 0
      RightButton.Visible = True
      TabOrder = 0
      OnRightButtonClick = TxtNomeRightButtonClick
    end
    object DblNomes: TDBLookupListBox
      Left = 213
      Top = 11
      Width = 188
      Height = 82
      TabOrder = 6
      Visible = False
      OnDblClick = DblNomesDblClick
    end
  end
  object ImageList1: TImageList
    Left = 184
    Top = 128
    Bitmap = {
      494C010102000800180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000000000008080
      80008080800080808000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF000000000000000000808080008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000000000000000000000000000000000008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000FFFF00000000000000000000000000000000000000000000FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000FFFF00000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000000000000000000000000000000000008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000FFFF00000000000000000000000000008080800000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000FFFF00000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800000000000000000008080
      8000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFC00000000
      FFF8FC1000000000F820F82000000000F000F0C000000000F000F1E000000000
      E000C0E000000000800081E00000000000004020000000008000806000000000
      FC00FD0000000000FE3FFE3F00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
