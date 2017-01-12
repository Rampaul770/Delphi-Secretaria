unit UCursoArea;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, FireDAC.Phys.OracleDef,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Phys.Oracle,
  UData, UCurso, UCursoCadastro, UFuncUtils,
  Vcl.ComCtrls;

type
  TFrmCursoArea = class(TForm)
    menu: TMainMenu;
    Arquivo1: TMenuItem;
    Cadastrar1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    Atualizar1: TMenuItem;
    Recarregar1: TMenuItem;
    Excluir1: TMenuItem;
    PnlPesquisa: TPanel;
    TxtNome: TEdit;
    BtnFiltrar: TButton;
    BtnRecarregar: TButton;
    Panel1: TPanel;
    DbgCurso: TDBGrid;
    RbtNome: TRadioButton;
    RbtRA: TRadioButton;
    TxtDescricao: TEdit;
    N1: TMenuItem;
    Sair2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cadastrar1Click(Sender: TObject);
    procedure DbgCursoCellClick(Column: TColumn);
    procedure DbgCursoDblClick(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure Recarregar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure BtnRecarregarClick(Sender: TObject);
    procedure RbtNomeClick(Sender: TObject);
    procedure RbtRAClick(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure DbgCursoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DbgCursoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Sair2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizarGrid;
  end;

var
  FrmCursoArea: TFrmCursoArea;

implementation

{$R *.dfm}

procedure TFrmCursoArea.Atualizar1Click(Sender: TObject);
begin

  if DbgCurso.Fields[0].Text = '' then
    Exit;

  If not Assigned(FrmCursoCadastro) Then
    FrmCursoCadastro := TFrmCursoCadastro.Create(Application);

  with FrmCursoCadastro do
  begin
    Acao := 'UPDATE';
    ID := StrToInt(DbgCurso.Fields[0].Text);
    TxtNome.Text := DbgCurso.Fields[1].Text;
    TxtDescricao.Text := DbgCurso.Fields[2].Text;
    ShowModal;
  end;

end;

procedure TFrmCursoArea.Cadastrar1Click(Sender: TObject);
begin

  If not Assigned(FrmCursoCadastro) Then
    FrmCursoCadastro := TFrmCursoCadastro.Create(Application);

  FrmCursoCadastro.Acao := 'INSERT';
  FrmCursoCadastro.ShowModal;

end;

procedure TFrmCursoArea.DbgCursoCellClick(Column: TColumn);
begin

  StatusBar1.Panels[0].Text := '-> CLIQUE DUAS VEZES PARA EDITAR O REGISTRO!'

end;

procedure TFrmCursoArea.DbgCursoDblClick(Sender: TObject);
begin

  Atualizar1Click(Sender);

end;

procedure TFrmCursoArea.DbgCursoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  //Começa Zebrando a linha ímpar
  with DbgCurso do
    begin
      if not (gdSelected in State) then
        if not odd(DataModuleSecretaria.FDQueryCurso.RecNo) then
          Canvas.Brush.Color := clWhite
        else
          Canvas.Brush.Color:= clMoneyGreen
      else
        begin
          Canvas.Brush.Color:= clSkyBlue;
          Canvas.Font.Style := [fsBold];
        end;

       Canvas.FillRect(Rect);
       DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

end;

procedure TFrmCursoArea.DbgCursoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_DELETE then
    Excluir1Click(Sender);

end;

procedure TFrmCursoArea.Excluir1Click(Sender: TObject);
var
  Curso: TCurso;
  ID: Integer;
begin

  if DbgCurso.Fields[0].Text = '' then
    Exit;

  ID := StrToInt(DbgCurso.Fields[0].Text);

  if MessageBox(Handle, 'Deseja realmente excluir esse curso?',
                'Aviso', MB_YESNO or MB_ICONQUESTION) = ID_YES then
    begin
      try

        Curso := TCurso.Create(ID);
        Curso.ExcluirCurso();

        Curso.BuscarCursos;

      finally

        FreeAndNil(Curso);

      end;
    end;


end;

procedure TFrmCursoArea.FormActivate(Sender: TObject);
begin

  AtualizarGrid;

end;

procedure TFrmCursoArea.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
  FrmCursoArea := Nil;

end;

procedure TFrmCursoArea.Sair1Click(Sender: TObject);
begin

  Close;
  FrmCursoArea := Nil;

end;

procedure TFrmCursoArea.Sair2Click(Sender: TObject);
begin

  Sair1Click(sender);

end;

procedure TFrmCursoArea.RbtNomeClick(Sender: TObject);
begin

  TxtNome.Enabled := True;
  TxtDescricao.Enabled := False;
  TxtDescricao.Clear;

  TxtNome.SetFocus;

end;

procedure TFrmCursoArea.RbtRAClick(Sender: TObject);
begin

  TxtNome.Enabled := False;
  TxtNome.Clear;
  TxtDescricao.Enabled := True;

  TxtDescricao.SetFocus;

end;

procedure TFrmCursoArea.Recarregar1Click(Sender: TObject);
begin

  AtualizarGrid;

end;

procedure TFrmCursoArea.AtualizarGrid;
var
  Curso: TCurso;
begin

  try

    UData.DataModuleSecretaria.FDConn.Connected := True;

    Curso := TCurso.Create;

    DbgCurso.DataSource := Curso.BuscarCursos;

  finally

    FreeAndNil(Curso);

  end;

end;


procedure TFrmCursoArea.BtnFiltrarClick(Sender: TObject);
var
  Curso: TCurso;
begin

  try

    Curso := TCurso.Create;

    if RbtNome.Checked then
      Curso.BuscarCursos(TxtNome.Text)
    else
      Curso.BuscarCursosDescricao(TxtDescricao.Text);

  finally

    FreeAndNil(Curso);

  end;

end;

procedure TFrmCursoArea.BtnRecarregarClick(Sender: TObject);
begin

  TxtNome.Clear;
  TxtDescricao.Clear;

  AtualizarGrid;

  RbtNome.Checked := True;
  TxtNome.SetFocus;

end;

end.
