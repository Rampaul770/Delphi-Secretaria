object FrmAlunoArea: TFrmAlunoArea
  Left = 0
  Top = 0
  ActiveControl = TxtNome
  Caption = 'Cadastro de Alunos'
  ClientHeight = 442
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menu
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 71
    Width = 716
    Height = 352
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object DbgAluno: TDBGrid
      Left = 2
      Top = 2
      Width = 712
      Height = 348
      Align = alClient
      DataSource = DataModuleSecretaria.DtsAluno
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DbgAlunoCellClick
      OnDblClick = DbgAlunoDblClick
      OnKeyDown = DbgAlunoKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ID'
          Title.Alignment = taCenter
          Title.Caption = 'Registro'
          Width = 47
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Alignment = taCenter
          Title.Caption = 'Nome'
          Width = 293
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'RA'
          Title.Alignment = taCenter
          Title.Caption = 'R.A.'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO'
          Title.Alignment = taCenter
          Title.Caption = 'Endere'#231'o'
          Width = 244
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CEP'
          Title.Alignment = taCenter
          Title.Caption = 'C.E.P.'
          Width = 104
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TELEFONE'
          Title.Alignment = taCenter
          Title.Caption = 'Telefone'
          Width = 104
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CELULAR'
          Title.Alignment = taCenter
          Title.Caption = 'Celular'
          Width = 104
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'NASCIMENTO'
          Title.Alignment = taCenter
          Title.Caption = 'Nascimento'
          Width = 104
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'MATRICULA'
          Title.Alignment = taCenter
          Title.Caption = 'Matr'#237'cula'
          Width = 140
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 716
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 716
    Height = 71
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object TxtNome: TEdit
      Left = 68
      Top = 11
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 2
    end
    object MskRA: TMaskEdit
      Left = 68
      Top = 38
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '00000;0;_'
      MaxLength = 5
      TabOrder = 3
      Text = ''
    end
    object BtnFiltrar: TButton
      Left = 428
      Top = 21
      Width = 75
      Height = 25
      Caption = '&Filtrar'
      TabOrder = 4
      OnClick = BtnFiltrarClick
    end
    object BtnRecarregar: TButton
      Left = 516
      Top = 21
      Width = 75
      Height = 25
      Caption = '&Recarregar'
      TabOrder = 5
      OnClick = BtnRecarregarClick
    end
    object RbtNome: TRadioButton
      Left = 11
      Top = 13
      Width = 49
      Height = 17
      Caption = 'Nome:'
      Checked = True
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = True
      OnClick = RbtNomeClick
    end
    object RbtRA: TRadioButton
      Left = 11
      Top = 40
      Width = 49
      Height = 17
      Caption = 'RA:'
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = RbtRAClick
    end
  end
  object menu: TMainMenu
    Left = 672
    Top = 392
    object Arquivo1: TMenuItem
      Caption = '&Arquivo'
      object Cadastrar1: TMenuItem
        Caption = '&Cadastrar'
        OnClick = Cadastrar1Click
      end
      object Atualizar1: TMenuItem
        Caption = 'A&tualizar'
        OnClick = Atualizar1Click
      end
      object Excluir1: TMenuItem
        Caption = '&Excluir'
        OnClick = Excluir1Click
      end
    end
    object Recarregar1: TMenuItem
      Caption = '&Recarregar'
      ShortCut = 116
      OnClick = Recarregar1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sai&r'
      OnClick = Sair1Click
    end
  end
end
