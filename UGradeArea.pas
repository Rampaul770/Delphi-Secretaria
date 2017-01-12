unit UGradeArea;

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
  UData, UGrade, UGradeCadastro, UFuncUtils,
  Vcl.ComCtrls;

type
  TFrmGradeArea = class(TForm)
    menu: TMainMenu;
    Arquivo1: TMenuItem;
    Cadastrar1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    Atualizar1: TMenuItem;
    Recarregar1: TMenuItem;
    Excluir1: TMenuItem;
    PnlPesquisa: TPanel;
    TxtMateria: TEdit;
    BtnFiltrar: TButton;
    BtnRecarregar: TButton;
    Panel1: TPanel;
    DbgGrade: TDBGrid;
    RbtMateria: TRadioButton;
    RbtAluno: TRadioButton;
    TxtAluno: TEdit;
    RbtCurso: TRadioButton;
    TxtCurso: TEdit;
    RbtGrade: TRadioButton;
    TxtGrade: TEdit;
    N1: TMenuItem;
    Sair2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cadastrar1Click(Sender: TObject);
    procedure DbgGradeCellClick(Column: TColumn);
    procedure DbgGradeDblClick(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure Recarregar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure BtnRecarregarClick(Sender: TObject);
    procedure RbtMateriaClick(Sender: TObject);
    procedure RbtAlunoClick(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure DbgGradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RbtCursoClick(Sender: TObject);
    procedure RbtGradeClick(Sender: TObject);
    procedure DbgGradeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Sair2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizarGrid;
  end;

var
  FrmGradeArea: TFrmGradeArea;

implementation

{$R *.dfm}

procedure TFrmGradeArea.Atualizar1Click(Sender: TObject);
begin

  if DbgGrade.Fields[0].Text = '' then
    Exit;

  If not Assigned(FrmGradeCadastro) Then
    FrmGradeCadastro := TFrmGradeCadastro.Create(Application);

  with FrmGradeCadastro do
  begin
    Acao := 'UPDATE';
    ID := StrToInt(DbgGrade.Fields[0].Text);
    TxtNome.Text := DbgGrade.Fields[1].Text;
    KeyValueCurso := StrToInt(DbgGrade.Fields[2].Text);
    KeyValueMateria := StrToInt(DbgGrade.Fields[4].Text);
    KeyValueAluno := StrToInt(DbgGrade.Fields[6].Text);
    ShowModal;
  end;

end;

procedure TFrmGradeArea.Cadastrar1Click(Sender: TObject);
begin

  If not Assigned(FrmGradeCadastro) Then
    FrmGradeCadastro := TFrmGradeCadastro.Create(Application);

  FrmGradeCadastro.Acao := 'INSERT';
  FrmGradeCadastro.ShowModal;

end;

procedure TFrmGradeArea.DbgGradeCellClick(Column: TColumn);
begin

  StatusBar1.Panels[0].Text := '-> CLIQUE DUAS VEZES PARA EDITAR O REGISTRO!'

end;

procedure TFrmGradeArea.DbgGradeDblClick(Sender: TObject);
begin

  Atualizar1Click(Sender);

end;

procedure TFrmGradeArea.DbgGradeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  //Come�a Zebrando a linha �mpar
  with DbgGrade do
    begin
      if not (gdSelected in State) then
        if not odd(DataModuleSecretaria.FDQueryGrade.RecNo) then
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

procedure TFrmGradeArea.DbgGradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_DELETE then
    Excluir1Click(Sender);

end;

procedure TFrmGradeArea.Excluir1Click(Sender: TObject);
var
  Grade: TGrade;
  ID: Integer;
  CursoID: Integer;
  MateriaID: Integer;
  AlunoID: Integer;
begin

  if DbgGrade.Fields[0].Text = '' then
    Exit;

  ID := StrToInt(DbgGrade.Fields[0].Text);
  CursoID := StrToInt(DbgGrade.Fields[2].Text);
  MateriaID := StrToInt(DbgGrade.Fields[4].Text);
  AlunoID := StrToInt(DbgGrade.Fields[6].Text);

  if MessageBox(Handle, 'Deseja realmente excluir essa grade?',
                'Aviso', MB_YESNO or MB_ICONQUESTION) = ID_YES then
    begin
      try

        Grade := TGrade.Create(ID, CursoID, MateriaID, AlunoID);
        Grade.ExcluirGrade();

        Grade.BuscarGrades;

      finally

        FreeAndNil(Grade);

      end;
    end;


end;

procedure TFrmGradeArea.FormActivate(Sender: TObject);
begin

  AtualizarGrid;

end;

procedure TFrmGradeArea.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
  FrmGradeArea := Nil;

end;

procedure TFrmGradeArea.Sair1Click(Sender: TObject);
begin

  Close;
  FrmGradeArea := Nil;

end;

procedure TFrmGradeArea.Sair2Click(Sender: TObject);
begin

  Sair1Click(sender);

end;

procedure TFrmGradeArea.RbtMateriaClick(Sender: TObject);
begin

  TxtGrade.Enabled := False;
  TxtCurso.Enabled := False;
  TxtMateria.Enabled := True;
  TxtAluno.Enabled := False;

  TxtGrade.Clear;
  TxtCurso.Clear;
  TxtMateria.Clear;
  TxtAluno.Clear;

  TxtMateria.SetFocus;

end;

procedure TFrmGradeArea.RbtAlunoClick(Sender: TObject);
begin

  TxtGrade.Enabled := False;
  TxtCurso.Enabled := False;
  TxtMateria.Enabled := False;
  TxtAluno.Enabled := True;

  TxtGrade.Clear;
  TxtCurso.Clear;
  TxtMateria.Clear;
  TxtAluno.Clear;

  TxtAluno.SetFocus;

end;

procedure TFrmGradeArea.RbtCursoClick(Sender: TObject);
begin

  TxtGrade.Enabled := False;
  TxtCurso.Enabled := True;
  TxtMateria.Enabled := False;
  TxtAluno.Enabled := False;

  TxtGrade.Clear;
  TxtCurso.Clear;
  TxtMateria.Clear;
  TxtAluno.Clear;

  TxtCurso.SetFocus;


end;

procedure TFrmGradeArea.RbtGradeClick(Sender: TObject);
begin

  TxtGrade.Enabled := True;
  TxtCurso.Enabled := False;
  TxtMateria.Enabled := False;
  TxtAluno.Enabled := False;

  TxtGrade.Clear;
  TxtCurso.Clear;
  TxtMateria.Clear;
  TxtAluno.Clear;

  TxtGrade.SetFocus;

end;

procedure TFrmGradeArea.Recarregar1Click(Sender: TObject);
begin

  AtualizarGrid;

end;

procedure TFrmGradeArea.AtualizarGrid;
var
  Grade: TGrade;
begin

  try

    UData.DataModuleSecretaria.FDConn.Connected := True;

    Grade := TGrade.Create;

    DbgGrade.DataSource := Grade.BuscarGrades;

  finally

    FreeAndNil(Grade);

  end;

end;


procedure TFrmGradeArea.BtnFiltrarClick(Sender: TObject);
var
  Grade: TGrade;
begin

  try

    Grade := TGrade.Create;

    if RbtGrade.Checked then
      Grade.BuscarGrades(TxtGrade.Text);

    if RbtCurso.Checked then
      Grade.BuscarCursos(TxtCurso.Text);

    if RbtMateria.Checked then
      Grade.BuscarMaterias(TxtMateria.Text);

    if RbtAluno.Checked then
      Grade.BuscarAlunos(TxtAluno.Text);

  finally

    FreeAndNil(Grade);

  end;

end;

procedure TFrmGradeArea.BtnRecarregarClick(Sender: TObject);
begin


  TxtGrade.Enabled := True;
  TxtCurso.Enabled := False;
  TxtMateria.Enabled := False;
  TxtAluno.Enabled := False;

  TxtGrade.Clear;
  TxtCurso.Clear;
  TxtMateria.Clear;
  TxtAluno.Clear;

  AtualizarGrid;

  RbtGrade.Checked := True;
  TxtGrade.SetFocus;

end;

end.
