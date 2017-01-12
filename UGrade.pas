unit UGrade;

interface

uses
  System.SysUtils, Data.DB, UData, FireDAC.Phys.OracleWrapper;

type TGrade = class

private

// atributos e metodos privados
// atributos privados

Fid: Integer;
Fnome: String;
Fcursoid: Integer;
Fmateriaid: Integer;
Falunoid: Integer;

protected

// atributos e metodos protegidos

public

// atibutos e metodos publicos
// propiedade publicas


property ID: Integer read Fid;
property Nome: String read Fnome write Fnome;
property CursoID: Integer read Fcursoid write Fcursoid;
property MateriaID: Integer read Fmateriaid write Fmateriaid;
property AlunoID: Integer read Falunoid write Falunoid;


// declaração do metodo construtor
Constructor Create; overload;
Constructor Create(ID: Integer); overload;

// declaração do metodo destrutor
Destructor Destroy; Override;

// metodos da classe
procedure CarregarGrade(ID: Integer);

function CadastrarGrade(): String;
function AtualizarGrade(ID: Integer): String;
function ExcluirGrade(): String;
function BuscarGrades(): TDataSource; overload;
function BuscarGrades(Nome: String): TDataSource; overload;
function BuscarCursos(Nome: String): TDataSource;
function BuscarMaterias(Nome: String): TDataSource;
function BuscarAlunos(Nome: String): TDataSource;
function BuscarNomes(): TDataSource;

end;

implementation

{ Tmateria }

constructor TGrade.Create;
begin

// metodo contrutor

end;

constructor TGrade.Create(ID: Integer);
begin

// metodo contrutor

  CarregarGrade(ID);

end;

destructor TGrade.Destroy;
begin

// metodo destrutor

inherited;

end;

function TGrade.CadastrarGrade(): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcInsereGrade do
      begin
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_CURSO_ID').Value := Fcursoid;
        ParamByName('P_MATERIA_ID').Value := Fmateriaid;
        ParamByName('P_ALUNO_ID').Value := Falunoid;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := '20001 - NOME INVÁLIDO!';
        20002 : retorno := '20002 - CÓDIGO ID DA MATERIA INVÁLIDO!';
        20003 : retorno := '20003 - CÓDIGO ID DE ALUNO INVÁLIDO!';
        20004 : retorno := '20004 - CÓDIGO ID DE MATÉRIA OU CURSO INVÁLIDOS!';
        20005 : retorno := '20005 - ERRO INESPERADO!';
      End;

  end;

  Result := retorno;

end;

function TGrade.AtualizarGrade(ID: Integer): String;
var
  retorno: String;
begin

  try

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDStoredProcAtualizaGrade do
      begin
        ParamByName('P_ID').Value := Fid;
        ParamByName('P_NOME').Value := Fnome;
        ParamByName('P_CURSO_ID').Value := Fcursoid;
        ParamByName('P_MATERIA_ID').Value := Fmateriaid;
        ParamByName('P_ALUNO_ID').Value := Falunoid;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      //retorno := IntToStr(Ex.Errors[0].ErrorCode);

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := 'CÓDIGO ID DA GRADE INVÁLIDO!';
        20002 : retorno := 'NOME INVÁLIDO!';
        20003 : retorno := 'CÓDIGO ID DO CURSO INVÁLIDO!';
        20004 : retorno := 'CÓDIGO ID DA MATÉRIA INVÁLIDO!';
        20005 : retorno := 'CÓDIGO ID DE ALUNO INVÁLIDO!';
        20006 : retorno := 'CÓDIGO ID DE MATÉRIA OU CURSO INVÁLIDOS!';
        20007 : retorno := 'ERRO INESPERADO';
      End;

  end;

  Result := retorno;

end;

function TGrade.ExcluirGrade(): String;
var
  retorno: String;
begin

  if Self.Fid > 0 then
  begin

    try

      with UData.DataModuleSecretaria do
      begin
        FDConn.Connected := True;

        with FDStoredProcExcluiGrade do
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
          20001 : retorno := '20001 - CÓDIGO ID DA MATERIA INVÁLIDO!';
          20002 : retorno := '20002 - ERRO INESPERADO!';
        End;

    end;

  end;

  Result := retorno;

end;

procedure TGrade.CarregarGrade(ID: Integer);
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryGrade do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
              'FROM VW_GRADE ' +
              'WHERE ID = ' + IntToStr(ID));

      Open();
    end;

    self.Fid := ID;
    self.Fnome := FDQueryGradeGRADENOME.Value;
    self.Fmateriaid := FDQueryGradeMATERIAID.AsInteger;
    Self.Falunoid := FDQueryGradeALUNOID.AsInteger;

  end;

end;

function TGrade.BuscarGrades(): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryGrade do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
                'FROM VW_GRADE ' +
                'ORDER BY ID');

        Open();
      end;

      DtsGrade.DataSet := FDQueryGrade;
      Result := DtsGrade;
    end;

end;

function TGrade.BuscarNomes(): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryGradeNomes do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT DISTINCT NOME ' +
                'FROM GRADE ' +
                'ORDER BY NOME');

        Open();
      end;

      DtsGradeNomes.DataSet := FDQueryGradeNomes;
      Result := DtsGradeNomes;
    end;

end;

function TGrade.BuscarGrades(Nome: String): TDataSource;
begin

    with UData.DataModuleSecretaria do
    begin
      FDConn.Connected := True;

      with FDQueryGrade do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
                'FROM VW_GRADE ' +
                'WHERE GRADENOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
                'ORDER BY ID');

        Open();
      end;

      DtsGrade.DataSet := FDQueryGrade;
      Result := DtsGrade;
    end;

end;

function TGrade.BuscarCursos(Nome: String): TDataSource;
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryGrade do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
              'FROM VW_GRADE ' +
              'WHERE CURSONOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
              'ORDER BY ID');

      Open();
    end;

    DtsGrade.DataSet := FDQueryGrade;
    Result := DtsGrade;

  end;

end;

function TGrade.BuscarMaterias(Nome: String): TDataSource;
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryGrade do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
              'FROM VW_GRADE ' +
              'WHERE MATERIANOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
              'ORDER BY ID');

      Open();
    end;

    DtsGrade.DataSet := FDQueryGrade;
    Result := DtsGrade;

  end;

end;

function TGrade.BuscarAlunos(Nome: String): TDataSource;
begin

  with UData.DataModuleSecretaria do
  begin
    FDConn.Connected := True;

    with FDQueryGrade do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, GRADENOME, CURSOID, CURSONOME, MATERIAID, MATERIANOME, ALUNOID, ALUNORA, ALUNONOME ' +
              'FROM VW_GRADE ' +
              'WHERE ALUNONOME LIKE ' + Chr(39) + '%' + Nome + '%' + Chr(39) + ' ' +
              'ORDER BY ID');

      Open();
    end;

    DtsGrade.DataSet := FDQueryGrade;
    Result := DtsGrade;

  end;

end;

end.

