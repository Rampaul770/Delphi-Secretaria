unit UMateriaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  UData, UCurso, UMateria, Vcl.DBCtrls;

type
  TFrmMateriaCadastro = class(TForm)
    PnlCadastro: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    LblNomeRequerido: TLabel;
    LblDescricaoRequerido: TLabel;
    LblMensagemRequerido: TLabel;
    TxtNome: TEdit;
    BtnCancelar: TButton;
    TxtDescricao: TEdit;
    BtnGravar: TButton;
    Label3: TLabel;
    DbcCurso: TDBLookupComboBox;
    LblCursoRequerido: TLabel;
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function CampoObrigatorioValido(): Boolean;
    procedure CadastrarMateria;
    procedure AtualizarMateria(ID: Integer);
  public
    { Public declarations }
    Acao: String;
    ID: Integer;
    KeyValueCurso: Integer;
  end;

var
  FrmMateriaCadastro: TFrmMateriaCadastro;

implementation

{$R *.dfm}

procedure TFrmMateriaCadastro.BtnCancelarClick(Sender: TObject);
begin

  Close;
  FrmMateriaCadastro := Nil;

end;

procedure TFrmMateriaCadastro.BtnGravarClick(Sender: TObject);
begin

  if CampoObrigatorioValido then
    if Acao = 'INSERT' then
      begin
        CadastrarMateria;
        Close;
      end
    else
      begin
        AtualizarMateria(ID);
        Close;
      end;

end;

procedure TFrmMateriaCadastro.FormActivate(Sender: TObject);
var
  Curso: TCurso;
begin

  try

    UData.DataModuleSecretaria.FDConn.Connected := True;

    Curso := TCurso.Create;

    DbcCurso.ListField := 'NOME';
    DbcCurso.KeyField := 'ID';
    DbcCurso.ListSource := Curso.BuscarCursos;
    DbcCurso.KeyValue := KeyValueCurso;

  finally

    FreeAndNil(Curso);

  end;

end;

procedure TFrmMateriaCadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Materia: TMateria;
begin

  Action := caFree;
  FrmMateriaCadastro := Nil;

  try

    Materia := TMateria.Create;
    Materia.BuscarMaterias;

  finally

    FreeAndNil(Materia);

  end;

end;

procedure TFrmMateriaCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
    BtnCancelarClick(Sender);

end;

function TFrmMateriaCadastro.CampoObrigatorioValido(): Boolean;
var
  MostraMensagem: Boolean;
  Foco: Integer;
begin

  MostraMensagem := False;
  Foco := 0;

  if DbcCurso.Text = '' then
    begin
      LblCursoRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 1;
    end
  else
    LblCursoRequerido.Visible := False;

  if TxtNome.Text = '' then
    begin
      LblNomeRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 2;
    end
  else
    LblNomeRequerido.Visible := False;

  if TxtDescricao.Text = '' then
    begin
      LblDescricaoRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 3;
    end
  else
    LblDescricaoRequerido.Visible := False;


  if Foco = 1 then
    DbcCurso.SetFocus
  else if Foco = 2 then
    TxtNome.SetFocus
  else if Foco = 3 then
    TxtDescricao.SetFocus;


  if MostraMensagem then
    begin
      LblMensagemRequerido.Visible := True;
      Result := False;
    end
  else
    begin
      LblMensagemRequerido.Visible := False;
      Result := True;
    end

end;

procedure TFrmMateriaCadastro.FormShow(Sender: TObject);
begin

  if Acao = 'INSERT' then
    FrmMateriaCadastro.Caption := 'Cadastrar Materia'
  else
    FrmMateriaCadastro.Caption := 'Atualizar cadastro';

end;

procedure TFrmMateriaCadastro.CadastrarMateria;
var
  Materia: TMateria;
  Retorno: String;
begin

  try

    Materia := TMateria.Create;

    with Materia do
    begin
      Nome := TxtNome.Text;
      Descricao := TxtDescricao.Text;
      CursoID := DbcCurso.KeyValue;
    end;

    Retorno := Materia.CadastrarMateria;

    if Retorno = '' then
      MessageBox(FrmMateriaCadastro.Handle, 'Mat�ria cadastrada com sucesso!', 'Aviso', MB_OK or MB_ICONINFORMATION)
    else
      MessageBox(FrmMateriaCadastro.Handle, PChar('Falha ao cadastrar a mat�ria!' + Char(13)  + Char(13) + 'Erro: ' + Retorno), 'Erro', MB_OK or MB_ICONSTOP);

  finally

    FreeAndNil(Materia);

  end;

end;

procedure TFrmMateriaCadastro.AtualizarMateria(ID: Integer);
var
  Materia: TMateria;
  Retorno: String;
begin

  try

    Materia := TMateria.Create(ID);

    with Materia do
    begin
      Nome := TxtNome.Text;
      Descricao := TxtDescricao.Text;
      CursoID := DbcCurso.KeyValue;
    end;

    Retorno := Materia.AtualizarMateria();

    if Retorno = '' then
      MessageBox(FrmMateriaCadastro.Handle, 'Mat�ria atualizada com sucesso!', 'Aviso', MB_OK or MB_ICONINFORMATION)
    else
      MessageBox(FrmMateriaCadastro.Handle, PChar('Falha ao atualizar o cadastro da mat�ria!' + Char(13)  + Char(13) + 'Erro: ' + Retorno), 'Erro', MB_OK or MB_ICONSTOP);

  finally

    FreeAndNil(Materia);

  end;

end;

end.
