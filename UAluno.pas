unit UAluno;

interface

uses
  System.SysUtils, Data.DB, UData, FireDAC.Phys.OracleWrapper;

type TAluno = class

private

// atributos e metodos privados
// atributos privados

Fid: Integer;
Fnome: String;
Fra: String;
Fendereco: String;
Fcep: String;
Ftelefone: String;
Fcelular: String;
Fnascimento: String;
Fmatricula: String;

protected

// atributos e metodos protegidos

public

// atibutos e metodos publicos
// propiedade publicas

property ID: Integer read Fid;
property Nome: String read Fnome write Fnome;
property RA: String read Fra write Fra;
property Endereco: String read Fendereco write Fendereco;
property CEP: String read Fcep write Fcep;
property Telefone: String read Ftelefone write Ftelefone;
property Celular: String read Fcelular write Fcelular;
property Nascimento: String read Fnascimento write Fnascimento;
property Matricula: String read Fmatricula;


// declaração do metodo construtor
Constructor Create; overload;
Constructor Create(ID: Integer); overload;

// declaração do metodo destrutor
Destructor Destroy; Override;

// metodos da classe
procedure CarregarAluno(ID: Integer);

function CadastrarAluno(): String;
function AtualizarAluno(ID: Integer): String;
function ExcluirAluno(): String;
function BuscarAlunos(): TDataSource; overload;
function BuscarAlunos(Nome: String): TDataSource; overload;
function BuscarAlunos(RA: Integer): TDataSource; overload;

end;

implementation

{ Tpessoa }

constructor TAluno.Create;
begin

// metodo contrutor

end;

constructor TAluno.Create(ID: Integer);
begin

// metodo contrutor

  CarregarAluno(ID);

end;

destructor TAluno.Destroy;
begin

// metodo destrutor

inherited;

end;

function TAluno.CadastrarAluno(): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcInsereAluno do
      begin
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_RA').Value := Fra;
        ParamByName('P_ENDERECO').Value := Fendereco;
        ParamByName('P_CEP').Value := Fcep;
        ParamByName('P_TELEFONE').Value := Ftelefone;
        ParamByName('P_CELULAR').Value := Fcelular;
        ParamByName('P_NASCIMENTO').Value := Fnascimento;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - NOME INVÁLIDO!';
        20002 : retorno := '20002 - CÓDIGO DO RA INVÁLIDO!';
        20003 : retorno := '20003 - CÓDIGO DO RA INVÁLIDO!';
        20004 : retorno := '20004 - ENDERECO INVÁLIDO!';
        20005 : retorno := '20005 - CÓDIGO DO CEP INVÁLIDO!';
        20006 : retorno := '20006 - CÓDIGO DO CEP INVÁLIDO!';
        20007 : retorno := '20007 - TELEFONE INVÁLIDO!';
        20008 : retorno := '20008 - TELEFONE INVÁLIDO!';
        20009 : retorno := '20009 - CELULAR INVÁLIDO!';
        20010 : retorno := '20010 - CELULAR INVÁLIDO!';
        20011 : retorno := '20011 - DATA DE NASCIMENTO INVÁLIDA!';
        20012 : retorno := '20012 - DATA DE NASCIMENTO INVÁLIDA!';
        20013 : retorno := '20013 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TAluno.AtualizarAluno(ID: Integer): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcAtualizaAluno do
      begin
        ParamByName('P_ID').Value := Fid;
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_RA').Value := Fra;
        ParamByName('P_ENDERECO').Value := Fendereco;
        ParamByName('P_CEP').Value := Fcep;
        ParamByName('P_TELEFONE').Value := Ftelefone;
        ParamByName('P_CELULAR').Value := Fcelular;
        ParamByName('P_NASCIMENTO').Value := Fnascimento;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - CÓDIGO ID INVÁLIDO!';
        20002 : retorno := '20002 - NOME INVÁLIDO!';
        20003 : retorno := '20003 - CÓDIGO DO RA INVÁLIDO!';
        20004 : retorno := '20004 - CÓDIGO DO RA INVÁLIDO!';
        20005 : retorno := '20005 - ENDERECO INVÁLIDO!';
        20006 : retorno := '20006 - CÓDIGO DO CEP INVÁLIDO!';
        20007 : retorno := '20007 - CÓDIGO DO CEP INVÁLIDO!';
        20008 : retorno := '20008 - TELEFONE INVÁLIDO!';
        20009 : retorno := '20009 - TELEFONE INVÁLIDO!';
        20010 : retorno := '20010 - CELULAR INVÁLIDO!';
        20011 : retorno := '20011 - CELULAR INVÁLIDO!';
        20012 : retorno := '20012 - DATA DE NASCIMENTO INVÁLIDA!';
        20013 : retorno := '20013 - DATA DE NASCIMENTO INVÁLIDA!';
        20014 : retorno := '20014 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TAluno.ExcluirAluno(): String;
var
  retorno: String;
begin

  if Self.Fid > 0 then
  begin

    try

      with UData.DataModuleSecretaria do
      begin
        FDConn.Connected := True;

        with FDStoredProcExcluiAluno do
        begin
          ParamByName('P_ID').Value := Self.Fid;
          ExecProc;
        end;

        FDConn.Connected := False;
      end;

    except

      On Ex : EOCINativeException do

        //retorno := IntToStr(Ex.Errors[0].ErrorCode);

        Case Ex.Errors[0].ErrorCode of
          20001 : retorno := '20001 - CÓDIGO ID INVÁLIDO!';
          20002 : retorno := '20002 - ERRO INESPERADO!';
        End;

    end;

  end;

  Result := retorno;

end;

procedure TAluno.CarregarAluno(ID: Integer);
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryAluno do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, NOME, RA, ENDERECO, CEP, ' +
              'TELEFONE, CELULAR, NASCIMENTO, MATRICULA ' +
              'FROM VW_ALUNO ' +
              'WHERE ID = ' + IntToStr(ID));

      Open();
    end;

    self.Fid := ID;
    self.Fnome := FDQueryAlunoNOME.Value;
    self.Fra := FDQueryAlunoRA.Value;
    self.Fendereco := FDQueryAlunoENDERECO.Value;
    self.Fcep := FDQueryAlunoCEP.Value;
    self.Ftelefone := FDQueryAlunoTELEFONE.Value;
    self.Fcelular := FDQueryAlunoCELULAR.Value;
    self.Fnascimento := FDQueryAlunoNASCIMENTO.Value;
    self.Fmatricula := FDQueryAlunoMATRICULA.Value;

  end;

end;

function TAluno.BuscarAlunos(): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryAluno do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, RA, ENDERECO, CEP, ' +
                'TELEFONE, CELULAR, NASCIMENTO, MATRICULA ' +
                'FROM VW_ALUNO ' +
                'ORDER BY ID');

        Open();
      end;

      DtsAluno.DataSet := FDQueryAluno;
      Result := DtsAluno;
    end;

end;

function TAluno.BuscarAlunos(Nome: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryAluno do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, RA, ENDERECO, CEP, ' +
                'TELEFONE, CELULAR, NASCIMENTO, MATRICULA ' +
                'FROM VW_ALUNO ' +
                'WHERE NOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
                'ORDER BY ID');

        Open();
      end;

      DtsAluno.DataSet := FDQueryAluno;
      Result := DtsAluno;
    end;

end;

function TAluno.BuscarAlunos(RA: Integer): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryAluno do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, RA, ENDERECO, CEP, ' +
                'TELEFONE, CELULAR, NASCIMENTO, MATRICULA ' +
                'FROM VW_ALUNO ' +
                'WHERE RA = ' + IntToStr(RA) + ' ' +
                'ORDER BY ID');

        Open();
      end;

      DtsAluno.DataSet := FDQueryAluno;
      Result := DtsAluno;
    end;

end;

end.

