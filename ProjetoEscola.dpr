program ProjetoEscola;

uses
  Vcl.Forms,
  UMenu in 'UMenu.pas' {FrmMenu},
  UAlunoArea in 'UAlunoArea.pas' {FrmAlunoArea},
  UData in 'UData.pas' {DataModuleSecretaria: TDataModule},
  USobre in 'USobre.pas' {FrmSobre},
  UAlunoCadastro in 'UAlunoCadastro.pas' {FrmAlunoCadastro},
  UAluno in 'UAluno.pas',
  UFuncUtils in 'UFuncUtils.pas',
  UMateria in 'UMateria.pas',
  UMateriaArea in 'UMateriaArea.pas' {FrmMateriaArea},
  UMateriaCadastro in 'UMateriaCadastro.pas' {FrmMateriaCadastro},
  UCurso in 'UCurso.pas',
  UCursoArea in 'UCursoArea.pas' {FrmCursoArea},
  UCursoCadastro in 'UCursoCadastro.pas' {FrmCursoCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmAlunoArea, FrmAlunoArea);
  Application.CreateForm(TDataModuleSecretaria, DataModuleSecretaria);
  Application.CreateForm(TFrmSobre, FrmSobre);
  Application.CreateForm(TFrmAlunoCadastro, FrmAlunoCadastro);
  Application.CreateForm(TFrmMateriaArea, FrmMateriaArea);
  Application.CreateForm(TFrmMateriaCadastro, FrmMateriaCadastro);
  Application.CreateForm(TFrmCursoArea, FrmCursoArea);
  Application.CreateForm(TFrmCursoCadastro, FrmCursoCadastro);
  Application.Run;
end.
