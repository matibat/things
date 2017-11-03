procedure printText(texto: TipoTexto);
var
  i: integer;
begin
  for i := 1 to texto.tope do
    write(texto.texto[i]);
  writeln('');
end;

procedure DefinirTexto(inputStr: string; size: RangoTopeTexto; var outputArray: TipoTexto);
const
  CantidadTextos = 1;
type
  ArrayChar = array of char;
var
  i: RangoTopeTexto;
begin
  for i := 1 to size do
  begin
    outputArray.texto[i] := inputStr[i];
  end;
  outputArray.tope := size;
end;

var
  TextoTemporal: TipoTexto;
  Salida:        TipoTexto;

  ListaTextos:    array of string;
  CantidadTextos: integer;
  IndiceTexto:    integer;
  ClaveAProbar:   integer;
begin
  ClaveAProbar := 1;
  CantidadTextos := 9;
  SetLength(ListaTextos, CantidadTextos);

  ListaTextos[0] := 'OLA K ASE';
  ListaTextos[1] := ' EXISTENCE IS PAIN';
  ListaTextos[2] := 'DONT  BE SAD ';
  ListaTextos[3] := ' XXX';
  ListaTextos[4] := '   ALL   YOU   NEED   IS   LOVE   ';
  ListaTextos[5] := ' HOLA ';
  ListaTextos[6] := 'VSAUCE';
  ListaTextos[7] := '  VENUS  PROJECT';
  ListaTextos[8] := 'DONT WORRY  BE HAPPY';
  for IndiceTexto := 0 to CantidadTextos-1 do
  begin
    DefinirTexto(ListaTextos[IndiceTexto], Length(ListaTextos[IndiceTexto]), TextoTemporal);

    write('Texto #', IndiceTexto, ':'#9);
    printText(TextoTemporal);
    write('|Encriptado:'#9);
    encriptar(TextoTemporal, ClaveAProbar, Salida);
    printText(Salida);

    write('|Desencriptado:'#9);
    desencriptar(Salida, ClaveAProbar, TextoTemporal);
    printText(TextoTemporal);
  end;
end.

