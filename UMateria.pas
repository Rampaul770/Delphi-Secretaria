unit UMateria;

interface

uses
  System.SysUtils, Data.DB, UData, FireDAC.Phys.OracleWrapper;

type TMateria = class

private

// atributos e metodos privados
// atributos privados

Fid: Integer;
Fnome: String;
Fdescricao: String;
Fcursoid: Integer;

protected

// atributos e metodos protegidos

public

// atibutos e metodos publicos
// propiedade publicas

property ID: Integer read Fid;
property Nome: String read Fnome write Fnome;
property Descricao: String read Fdescricao write Fdescricao;
property CursoID: Integer read Fcursoid write Fcursoid;


// declara��o do metodo construtor
Constructor Create; overload;
Constructor Create(ID: Integer); overload;

// declara��o do metodo destrutor
Destructor Destroy; Override;

// metodos da classe
procedure CarregarMateria(ID: Integer);

function CadastrarMateria(): String;
function AtualizarMateria(ID: Integer): String;
function ExcluirMateria(): String;
function BuscarMaterias(): TDataSource; overload;
function BuscarMaterias(Nome: String): TDataSource; overload;
function BuscarMateriasDescricao(Descricao: String): TDataSource;

end;

implementation

{ Tmateria }

constructor TMateria.Create;
begin

// metodo contrutor

end;

constructor TMateria.Create(ID: Integer);
begin

// metodo contrutor

  CarregarMateria(ID);

end;

destructor TMateria.Destroy;
begin

// metodo destrutor

inherited;

end;

function TMateria.CadastrarMateria(): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcInsereMateria do
      begin
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_DESCRICAO').Value := Fdescricao;
        ParamByName('P_CURSO_ID').Value := Fcursoid;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - NOME INV�LIDO!';
        20002 : retorno := '20002 - DESCRI��O INV�LIDA!';
        20003 : retorno := '20003 - C�DIGO ID DO CURSO INV�LIDO!';
    		20004 : retorno := '20004 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TMateria.AtualizarMateria(ID: Integer): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcAtualizaMateria do
      begin
        ParamByName('P_ID').Value := Fid;
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_DESCRICAO').Value := Fdescricao;
        ParamByName('P_CURSO_ID').Value := Fcursoid;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - C�DIGO ID INV�LIDO!';
        20002 : retorno := '20002 - NOME INV�LIDO!';
        20003 : retorno := '20003 - DESCRI��O INV�LIDA!';
        20004 : retorno := '20004 - C�DIGO ID DO CURSO INV�LIDO!';
        20005 : retorno := '20005 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TMateria.ExcluirMateria(): String;
var
  retorno: String;
begin

  if Self.Fid > 0 then
  begin

    try

      with UData.DataModuleSecretaria do
      begin
        FDConn.Connected := True;

        with FDStoredProcExcluiMateria do
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
          20001 : retorno := '20001 - C�DIGO ID INV�LIDO!';
          20002 : retorno := '20002 - ERRO INESPERADO!';
        End;

    end;

  end;

  Result := retorno;

end;

procedure TMateria.CarregarMateria(ID: Integer);
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryMateria do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURSOID, CURSONOME, MATERIAID, MATERIANOME, MATERIADESCRICAO ' +
              'FROM VW_MATERIA_CURSO ' +
              'WHERE MATERIAID = ' + IntToStr(ID));

      Open();
    end;

    self.Fid := ID;
    self.Fnome := FDQueryMateriaMATERIANOME.Value;
    self.Fdescricao := FDQueryMateriaMATERIADESCRICAO.Value;
    self.Fcursoid := FDQueryMateriaCURSOID.AsInteger;

  end;

end;

function TMateria.BuscarMaterias(): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryMateria do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURSOID, CURSONOME, MATERIAID, MATERIANOME, MATERIADESCRICAO ' +
                'FROM VW_MATERIA_CURSO ' +
                'ORDER BY MATERIAID');

        Open();
      end;

      DtsMateria.DataSet := FDQueryMateria;
      Result := DtsMateria;
    end;

end;

function TMateria.BuscarMaterias(Nome: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryMateria do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURSOID, CURSONOME, MATERIAID, MATERIANOME, MATERIADESCRICAO ' +
                'FROM VW_MATERIA_CURSO ' +
                'WHERE MATERIANOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
                'ORDER BY MATERIAID');

        Open();
      end;

      DtsMateria.DataSet := FDQueryMateria;
      Result := DtsMateria;
    end;

end;

function TMateria.BuscarMateriasDescricao(Descricao: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryMateria do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURSOID, CURSONOME, MATERIAID, MATERIANOME, MATERIADESCRICAO ' +
                'FROM VW_MATERIA_CURSO ' +
                'WHERE MATERIADESCRICAO LIKE ' + Chr(39) + '%' + Descricao + '%' + Chr(39) + ' ' +
                'ORDER BY MATERIAID');

        Open();
      end;

      DtsMateria.DataSet := FDQueryMateria;
      Result := DtsMateria;
    end;

end;

end.

