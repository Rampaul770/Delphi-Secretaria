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


// declara��o do metodo construtor
Constructor Create; overload;
//Constructor Create(ID: Integer); overload;
constructor Create(ID, CursoID, MateriaID, AlunoID: Integer); overload;

// declara��o do metodo destrutor
Destructor Destroy; Override;

// metodos da classe
procedure CarregarGrade(ID, CursoID, MateriaID, AlunoID: Integer);

function CadastrarGrade(): String;
function AtualizarGrade(CursoID, MateriaID, AlunoID: Integer): String;
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

constructor TGrade.Create(ID, CursoID, MateriaID, AlunoID: Integer);
begin

// metodo contrutor

  CarregarGrade(ID, CursoID, MateriaID, AlunoID);

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

      Case Ex.Errors[0].ErrorCode of
        00001 : retorno := '00001 - CURSO, MAT�RIA, ALUNO J� CADASTRADO PARA ESSA GRADE!';
        20001 : retorno := '20001 - NOME INV�LIDO!';
        20002 : retorno := '20002 - C�DIGO ID DO CURSO INV�LIDO!';
        20003 : retorno := '20003 - C�DIGO ID DA MAT�RIA INV�LIDO!';
        20004 : retorno := '20004 - C�DIGO ID DE ALUNO INV�LIDO!';
        20005 : retorno := '20005 - C�DIGO ID DE MAT�RIA OU CURSO INV�LIDOS!';
        20006 : retorno := '20006 - CURSO, MAT�RIA E ALUNO ESPECIFICADO J� CADASTRADOS PARA ESSA GRADE!';
        20007 : retorno := '20007 - ERRO INESPERADO';
      End;

  end;

  Result := retorno;

end;

function TGrade.AtualizarGrade(CursoID, MateriaID, AlunoID: Integer): String;
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
        ParamByName('P_CURSO_ID_NOVO').Value := CursoID;
        ParamByName('P_MATERIA_ID_NOVO').Value := MateriaID;
        ParamByName('P_ALUNO_ID_NOVO').Value := AlunoID;
        ExecProc;
      end;

      FDConn.Connected := False;
    end;

  except

    On Ex : EOCINativeException do

      Case Ex.Errors[0].ErrorCode of
        20001 : retorno := 'C�DIGO ID DA GRADE INV�LIDO!';
        20002 : retorno := 'NOME INV�LIDO!';
        20003 : retorno := 'C�DIGO ID DO CURSO INV�LIDO!';
        20004 : retorno := 'C�DIGO ID DA MAT�RIA INV�LIDO!';
        20005 : retorno := 'C�DIGO ID DE ALUNO INV�LIDO!';
        20006 : retorno := 'C�DIGO ID DE MAT�RIA OU CURSO INV�LIDOS!';
        20007 : retorno := 'C�DIGO ID DE MAT�RIA OU CURSO INV�LIDOS!';
        20008 : retorno := 'CURSO, MAT�RIA E ALUNO ESPECIFICADO J� CADASTRADOS PARA ESSA GRADE!';
        20009 : retorno := 'ERRO INESPERADO';
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
          ParamByName('P_CURSO_ID').Value := Fcursoid;
          ParamByName('P_MATERIA_ID').Value := Fmateriaid;
          ParamByName('P_ALUNO_ID').Value := Falunoid;
          ExecProc;
        end;

        FDConn.Connected := False;
      end;

    except

      On Ex : EOCINativeException do

        Case Ex.Errors[0].ErrorCode of
          20001 : retorno := '20001 - C�DIGO ID DA GRADE INV�LIDO!';
          20002 : retorno := '20002 - C�DIGO ID DO CURSO INV�LIDO!';
          20003 : retorno := '20003 - C�DIGO ID DA MAT�RIA INV�LIDO!';
          20004 : retorno := '20004 - C�DIGO ID DO ALUNO INV�LIDO!';
          20005 : retorno := '20005 - C�DIGO ID DE CURSO OU MAT�RIA INV�LIDOS!';
          20006 : retorno := '20006 - ERRO INESPERADO';
        End;

    end;

  end;

  Result := retorno;

end;

procedure TGrade.CarregarGrade(ID, CursoID, MateriaID, AlunoID: Integer);
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
              'WHERE ID = ' + IntToStr(ID) + ' ' +
              'AND CURSOID = ' + IntToStr(CursoID) + ' ' +
              'AND MATERIAID = ' + IntToStr(MateriaID) + ' ' +
              'AND ALUNOID = ' + IntToStr(AlunoID));

      Open();
    end;

    self.Fid := ID;
    self.Fnome := FDQueryGradeGRADENOME.Value;
    self.Fcursoid := FDQueryGradeCURSOID.AsInteger;
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

