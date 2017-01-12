object FrmCurso: TFrmCurso
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cursos'
  ClientHeight = 181
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 200
    Top = 112
    object Cadastrar1: TMenuItem
      Caption = '&Cadastrar'
    end
    object Pesquisar1: TMenuItem
      Caption = '&Pesquisar'
    end
    object Sair1: TMenuItem
      Caption = 'Sai&r'
      OnClick = Sair1Click
    end
  end
end
