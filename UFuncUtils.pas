unit UFuncUtils;

interface

uses
  System.SysUtils;

function TiraMascara(Text: String): String;

implementation

function TiraMascara(Text: String): String;
var
  Caracteres: array[0..3] of char;
  i: Integer;
begin

  Caracteres[0] := '-';
  Caracteres[1] := '(';
  Caracteres[2] := ')';
  Caracteres[3] := '/';

  for i := 0 to High(Caracteres) do
    Text := StringReplace(Text, Caracteres[i], '', [rfReplaceAll, rfIgnoreCase]);

  Result := Text;

end;

end.
