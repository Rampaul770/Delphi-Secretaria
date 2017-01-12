program ProjetoEscola;

uses
  Vcl.Forms,
  UMenu in 'UMenu.pas' {FrmMenu},
  UAlunoArea in 'UAlunoArea.pas' {FrmAlunoArea},
  UData in 'UData.pas' {DataModuleSecretaria: TDataModule},
  USobre in 'USobre.pas' {FrmSobre},
  UAlunoCadastro in 'UAlunoCadastro.pas' {FrmAlunoCadastro},
  UAluno in 'UAluno.pas',
  UFuncUtils in 'UFuncUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmAlunoArea, FrmAlunoArea);
  Application.CreateForm(TDataModuleSecretaria, DataModuleSecretaria);
  Application.CreateForm(TFrmSobre, FrmSobre);
  Application.CreateForm(TFrmAlunoCadastro, FrmAlunoCadastro);
  Application.Run;
end.
