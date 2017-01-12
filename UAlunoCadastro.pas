unit UAlunoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  UData, UAluno;

type
  TFrmAlunoCadastro = class(TForm)
    PnlCadastro: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LblNomeRequerido: TLabel;
    LblRARequerido: TLabel;
    LblEnderecoRequerido: TLabel;
    LblCEPRequerido: TLabel;
    LblCelularRequerido: TLabel;
    LblNascimentoRequerido: TLabel;
    LblMensagemRequerido: TLabel;
    TxtNome: TEdit;
    BtnCancelar: TButton;
    TxtEndereco: TEdit;
    MskCEP: TMaskEdit;
    MskTelefone: TMaskEdit;
    MskCelular: TMaskEdit;
    MskNascimento: TMaskEdit;
    BtnGravar: TButton;
    MskRA: TMaskEdit;
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function CampoObrigatorioValido(): Boolean;
    procedure CadastrarAluno;
    procedure AtualizarAluno(ID: Integer);
  public
    { Public declarations }
    Acao: String;
    ID: Integer;
  end;

var
  FrmAlunoCadastro: TFrmAlunoCadastro;

implementation

{$R *.dfm}

procedure TFrmAlunoCadastro.BtnCancelarClick(Sender: TObject);
begin

  Close;
  FrmAlunoCadastro := Nil;

end;

procedure TFrmAlunoCadastro.BtnGravarClick(Sender: TObject);
begin

  if CampoObrigatorioValido then
    if Acao = 'INSERT' then
      CadastrarAluno
    else
      AtualizarAluno(ID);

  Close;

end;

procedure TFrmAlunoCadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Action := caFree;
  FrmAlunoCadastro := Nil;

end;

procedure TFrmAlunoCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
    BtnCancelarClick(Sender);

end;

function TFrmAlunoCadastro.CampoObrigatorioValido(): Boolean;
var
  MostraMensagem: Boolean;
  Foco: Integer;
begin

  MostraMensagem := False;
  Foco := 0;

  if TxtNome.Text = '' then
    begin
      LblNomeRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 1;
    end
  else
    LblNomeRequerido.Visible := False;

  if MskRA.EditText = '_____' then
    begin
      LblRARequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 2;
    end
  else
    LblRARequerido.Visible := False;

  if TxtEndereco.Text = '' then
    begin
      LblEnderecoRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 3;
    end
  else
    LblEnderecoRequerido.Visible := False;

  if MskCEP.EditText = '_____-___' then
    begin
      LblCEPRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 4;
    end
  else
    LblCEPRequerido.Visible := False;

  if MskCelular.EditText = '(___)_____-____' then
    begin
      LblCelularRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 5;
    end
  else
    LblCelularRequerido.Visible := False;

  if MskNascimento.EditText = '__/__/____' then
    begin
      LblNascimentoRequerido.Visible := True;
      MostraMensagem := True;
      If Foco = 0 Then Foco := 6;
    end
  else
    LblNascimentoRequerido.Visible := False;


  if Foco = 1 then
    TxtNome.SetFocus
  else if Foco = 2 then
    begin
      MskRA.SetFocus;
      MskRA.SelStart := 0;
    end
  else if Foco = 3 then
    TxtEndereco.SetFocus
  else if Foco = 4 then
    begin
      MskCEP.SetFocus;
      MskCEP.SelStart := 0;
    end
  else if Foco = 5 then
    begin
      MskCelular.SetFocus;
      MskCelular.SelStart := 0;
    end
  else if Foco = 6 then
    begin
      MskNascimento.SetFocus;
      MskNascimento.SelStart := 0;
    end;

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

procedure TFrmAlunoCadastro.FormShow(Sender: TObject);
begin

  if Acao = 'INSERT' then
    FrmAlunoCadastro.Caption := 'Cadastrar Aluno'
  else
    FrmAlunoCadastro.Caption := 'Atualizar cadastro';

end;

procedure TFrmAlunoCadastro.CadastrarAluno;
var
  Aluno: TAluno;
  Retorno: String;
begin

  try

    Aluno := TAluno.Create;

    with Aluno do
    begin
      Nome := TxtNome.Text;
      RA := MskRA.EditText;
      Endereco := TxtEndereco.Text;
      CEP := MskCEP.Text;
      Telefone := MskTelefone.Text;
      Celular := MskCelular.Text;
      Nascimento := FormatDateTime('yyyy-mm-dd', StrToDate(MskNascimento.EditText));
    end;

    Retorno := Aluno.CadastrarAluno;

    if Retorno = '' then
      MessageBox(FrmAlunoCadastro.Handle, 'Aluno cadastrado com sucesso!', 'Aviso', MB_OK or MB_ICONINFORMATION)
    else
      MessageBox(FrmAlunoCadastro.Handle, PChar('Falha ao cadastrar o aluno!' + Char(13)  + Char(13) + 'Erro: ' + Retorno), 'Erro', MB_OK or MB_ICONSTOP);

  finally

    FreeAndNil(Aluno);

  end;

end;

procedure TFrmAlunoCadastro.AtualizarAluno(ID: Integer);
var
  Aluno: TAluno;
  Retorno: String;
begin

  try

    Aluno := TAluno.Create(ID);

    with Aluno do
    begin
      Nome := TxtNome.Text;
      RA := MskRA.EditText;
      Endereco := TxtEndereco.Text;
      CEP := MskCEP.Text;
      Telefone := MskTelefone.Text;
      Celular := MskCelular.Text;
      Nascimento := FormatDateTime('yyyy-mm-dd', StrToDate(MskNascimento.EditText));
    end;

    Retorno := Aluno.AtualizarAluno(ID);

    if Retorno = '' then
      MessageBox(FrmAlunoCadastro.Handle, 'Aluno atualizado com sucesso!', 'Aviso', MB_OK or MB_ICONINFORMATION)
    else
      MessageBox(FrmAlunoCadastro.Handle, PChar('Falha ao atualizar o cadastro do aluno!' + Char(13)  + Char(13) + 'Erro: ' + Retorno), 'Erro', MB_OK or MB_ICONSTOP);

  finally

    FreeAndNil(Aluno);

  end;

end;

end.
