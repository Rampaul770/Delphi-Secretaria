unit UCurso;

interface

uses
  System.SysUtils, Data.DB, UData, FireDAC.Phys.OracleWrapper;

type TCurso = class

private

// atributos e metodos privados
// atributos privados

Fid: Integer;
Fnome: String;
Fdescricao: String;

protected

// atributos e metodos protegidos

public

// atibutos e metodos publicos
// propiedade publicas

property ID: Integer read Fid;
property Nome: String read Fnome write Fnome;
property Descricao: String read Fdescricao write Fdescricao;


// declaração do metodo construtor
Constructor Create; overload;
Constructor Create(ID: Integer); overload;

// declaração do metodo destrutor
Destructor Destroy; Override;

// metodos da classe
procedure CarregarCurso(ID: Integer);

function CadastrarCurso(): String;
function AtualizarCurso(ID: Integer): String;
function ExcluirCurso(): String;
function BuscarCursos(): TDataSource; overload;
function BuscarCursos(Nome: String): TDataSource; overload;
function BuscarCursosDescricao(Descricao: String): TDataSource;

end;

implementation

{ Tcurso }

constructor TCurso.Create;
begin

// metodo contrutor

end;

constructor TCurso.Create(ID: Integer);
begin

// metodo contrutor

  CarregarCurso(ID);

end;

destructor TCurso.Destroy;
begin

// metodo destrutor

inherited;

end;

function TCurso.CadastrarCurso(): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcInsereCurso do
      begin
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_DESCRICAO').Value := Fdescricao;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - NOME INVÁLIDO!';
        20002 : retorno := '20002 - DESCRIÇÃO INVÁLIDA!';
    		20003 : retorno := '20003 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TCurso.AtualizarCurso(ID: Integer): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcAtualizaCurso do
      begin
        ParamByName('P_ID').Value := Fid;
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_DESCRICAO').Value := Fdescricao;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - CODIGO ID INVÁLIDO!';
        20002 : retorno := '20002 - NOME INVÁLIDO!';
        20003 : retorno := '20003 - DESCRIÇÃO INVÁLIDA!';
        20004 : retorno := '20004 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TCurso.ExcluirCurso(): String;
var
  retorno: String;
begin

  if Self.Fid > 0 then
  begin

    try

      with UData.DataModuleSecretaria do
      begin
        FDConn.Connected := True;

        with FDStoredProcExcluiCurso do
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
          20001 : retorno := '20001 - CODIGO ID INVÁLIDO!';
          20002 : retorno := '20002 - ERRO INESPERADO!';
        End;

    end;

  end;

  Result := retorno;

end;

procedure TCurso.CarregarCurso(ID: Integer);
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryCurso do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, NOME, DESCRICAO ' +
              'FROM CURSO ' +
              'WHERE ID = ' + IntToStr(ID));

      Open();
    end;

    self.Fid := ID;
    self.Fnome := FDQueryCursoNOME.Value;
    self.Fdescricao := FDQueryCursoDESCRICAO.Value;

  end;

end;

function TCurso.BuscarCursos(): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryCurso do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, DESCRICAO ' +
                'FROM CURSO ' +
                'ORDER BY ID');

        Open();
      end;

      DtsCurso.DataSet := FDQueryCurso;
      Result := DtsCurso;
    end;

end;

function TCurso.BuscarCursos(Nome: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryCurso do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, DESCRICAO ' +
                'FROM CURSO ' +
                'WHERE NOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
                'ORDER BY ID');

        Open();
      end;

      DtsCurso.DataSet := FDQueryCurso;
      Result := DtsCurso;
    end;

end;

function TCurso.BuscarCursosDescricao(Descricao: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryCurso do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, NOME, DESCRICAO ' +
                'FROM CURSO ' +
                'WHERE DESCRICAO LIKE ' + Chr(39) + '%' + Descricao + '%' + Chr(39) + ' ' +
                'ORDER BY ID');

        Open();
      end;

      DtsCurso.DataSet := FDQueryCurso;
      Result := DtsCurso;
    end;

end;

end.

