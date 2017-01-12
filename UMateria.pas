unit UMateria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus;

type
  TFrmMateria = class(TForm)
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
  FrmMateria: TFrmMateria;

implementation

{$R *.dfm}

procedure TFrmMateria.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
  FrmMateria := Nil;

end;

procedure TFrmMateria.Sair1Click(Sender: TObject);
begin

  Close;
  FrmMateria := Nil;

end;

end.
