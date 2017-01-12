unit UCurso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus;

type
  TFrmCurso = class(TForm)
    MainMenu1: TMainMenu;
    Cadastrar1: TMenuItem;
    Pesquisar1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCurso: TFrmCurso;

implementation

{$R *.dfm}

procedure TFrmCurso.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
  FrmCurso := Nil;

end;

procedure TFrmCurso.Sair1Click(Sender: TObject);
begin

  Close;
  FrmCurso := Nil;

end;

end.
