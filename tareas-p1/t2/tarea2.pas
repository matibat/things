procedure encriptar(entrada: TipoTexto; clave : TipoClave; var salida : TipoTexto);
var
  IndiceCaracter:           RangoTexto;
  IndicePalabra:            RangoTopeTexto;
  DesplazamientosAplicados: integer; { todo: borrame }
  AuxiliarSalida:           integer; { para apliar el desplazamiento }
begin
  IndicePalabra := 0;
  for IndiceCaracter := 1 to entrada.tope do
  begin
    if entrada.texto[IndiceCaracter] = ' ' then
    { el caracter es un espacio }
    begin
      salida.texto[IndiceCaracter] := ' ';
    end
    else
    { el caracter es una letra }
    begin
      { aplicar desplazamientos correspondientes a la letra }
      DesplazamientosAplicados := ((clave + IndicePalabra) mod 25);
      if DesplazamientosAplicados = 0 then DesplazamientosAplicados := 25;
      AuxiliarSalida := ord(entrada.texto[IndiceCaracter]) + DesplazamientosAplicados;
      if AuxiliarSalida > 90 then AuxiliarSalida := AuxiliarSalida - 26;
      salida.texto[IndiceCaracter] := chr(AuxiliarSalida);

      { actualizar el indece de la palabra leída }
      if (IndiceCaracter < entrada.tope) and ((entrada.texto[IndiceCaracter + 1] = ' ') and (entrada.texto[IndiceCaracter] <> ' ')) then
      { una letra seguida de un espacio indica el fin de una palabra }
      begin
        IndicePalabra := IndicePalabra + 1;
      end;
    end;
  end;
  salida.tope := entrada.tope;
end;

procedure desencriptar(entrada: TipoTexto; clave : TipoClave; var salida: TipoTexto);
var
  IndiceCaracter:           RangoTexto;
  IndicePalabra:            RangoTopeTexto;
  DesplazamientosAplicados: integer;
  AuxiliarSalida:           integer; { para apliar el desplazamiento }
begin
  IndicePalabra := 0;
  for IndiceCaracter := 1 to entrada.tope do
  begin
    if entrada.texto[IndiceCaracter] = ' ' then
    { el caracter es un espacio }
    begin
      salida.texto[IndiceCaracter] := ' ';
    end
    else
    { el caracter es una letra }
    begin
      { aplicar desplazamientos en sentido contrario }
      DesplazamientosAplicados := ((clave + IndicePalabra) mod 25);
      if DesplazamientosAplicados = 0 then DesplazamientosAplicados := 25;
      AuxiliarSalida := ord(entrada.texto[IndiceCaracter]) - DesplazamientosAplicados;
      if AuxiliarSalida < 65 then AuxiliarSalida := AuxiliarSalida + 26;
      salida.texto[IndiceCaracter] := chr(AuxiliarSalida);

      { actualizar el indece de la palabra leída }
      if (IndiceCaracter < entrada.tope) and ((entrada.texto[IndiceCaracter + 1] = ' ') and (entrada.texto[IndiceCaracter] <> ' ')) then
      { una letra seguida de un espacio indica el fin de una palabra }
      begin
        IndicePalabra := IndicePalabra + 1;
      end;
    end;
  end;
  salida.tope := entrada.tope;
end;

function PosiblesClaves(palabra: TipoPalabra; texto : TipoTexto) : listaClaves;
var
  IndiceCaracterTexto:      RangoTexto;
  IndiceCaracterPalabra:    RangoPalabra;
  IndicePalabra:            RangoTopeTexto;
  ClavesEncontradas:        array[1..25] of boolean;
  DesplazamientosAplicados: integer;
  PrimeraClavePalabra:      integer;
  ClavePalabraIntermedia:   integer;
  IrFinPalabra:             boolean;

  ReservadorDeMemoria:      listaClaves;
  AuxiliarSalida:           listaClaves;
begin
  { inicializar la lista de claves encontradas }
  for IndiceCaracterPalabra := 1 to 25 do
  begin
    ClavesEncontradas[IndiceCaracterPalabra] := false;
  end;

  IndicePalabra := 0;
  IndiceCaracterPalabra := 1;
  PrimeraClavePalabra := 0;
  IrFinPalabra := false;

  { leer cada uno de los caracteres del texto }
  for IndiceCaracterTexto := 1 to texto.tope do
  begin
    {writeln('Iterando caracter #', IndiceCaracterTexto, ' (', texto.texto[IndiceCaracterTexto], ')');}
    if texto.texto[IndiceCaracterTexto] = ' ' then
    { el caracter es un espacio }
    begin
      { inicializar variables para iterar una nueva palabra }
      IndiceCaracterPalabra := 1;
      PrimeraClavePalabra := 0;
      IrFinPalabra := false;
    end
    else if not IrFinPalabra then
    { el caracter es una letra y aun es probable que esta palabra sea palabra.texto encriptada }
    begin
      { definir la clave de la primera letra de la palabra iterada }
      if PrimeraClavePalabra = 0 then
      { no se ha definido la clave de la palabra a iterar }
      begin
        DesplazamientosAplicados := ord(texto.texto[IndiceCaracterTexto]) - ord(palabra.palabra[IndiceCaracterPalabra]);
        if DesplazamientosAplicados < 0 then DesplazamientosAplicados := DesplazamientosAplicados + 26;
        PrimeraClavePalabra := ((DesplazamientosAplicados - IndicePalabra) mod 25); { desplazamientos = (clave + indicePalabra) % 25 }
        if PrimeraClavePalabra <= 0 then PrimeraClavePalabra := PrimeraClavePalabra + 25;
        ClavePalabraIntermedia := PrimeraClavePalabra;
        { writeln('Se encontró una palabra... clave candidata: ', PrimeraClavePalabra, ', indice de palabra: ', IndicePalabra); }
      end
      else
      { es una letra intermedia }
      begin
        DesplazamientosAplicados := ord(texto.texto[IndiceCaracterTexto]) - ord(palabra.palabra[IndiceCaracterPalabra]);
        if DesplazamientosAplicados < 0 then DesplazamientosAplicados := DesplazamientosAplicados + 26;
        ClavePalabraIntermedia := ((DesplazamientosAplicados - IndicePalabra) mod 25); { desplazamientos = (clave + indicePalabra) % 25 }
        if ClavePalabraIntermedia <= 0 then ClavePalabraIntermedia := ClavePalabraIntermedia + 25;
      end;
        if (PrimeraClavePalabra <> ClavePalabraIntermedia) or
           (IndiceCaracterPalabra > palabra.tope)
        then
        { no existe una clave con la cual al desencriptar la palabra, esta sea la buscada }
        begin
          IrFinPalabra := true;
        end;
      { Si la palabra encontrada mide palabra.tope y el último caracter coincide... }
      if (PrimeraClavePalabra = ClavePalabraIntermedia) and
        (IndiceCaracterPalabra = palabra.tope) and 
      (
        { y si el siguiente caracter es un espacio }
        ((IndiceCaracterTexto <> texto.tope) and (texto.texto[IndiceCaracterTexto + 1] = ' ')) or
        { o el fin del texto }
        (IndiceCaracterTexto = texto.tope)
      ) and not IrFinPalabra and (texto.texto[IndiceCaracterTexto] <> palabra.palabra[IndiceCaracterPalabra]) then
      begin
        ClavesEncontradas[PrimeraClavePalabra] := true;
        {writeln('LA ENCONTRASTES WEE xd');}
      end;

      { actualizar el índice del caracter de la palabra }
      if not IrFinPalabra and (IndiceCaracterPalabra < palabra.tope) then
        IndiceCaracterPalabra := IndiceCaracterPalabra + 1;
    end;

    { actualizar el indece de la palabra leída }
    if (IndiceCaracterTexto < texto.tope) and ((texto.texto[IndiceCaracterTexto + 1] = ' ') and (texto.texto[IndiceCaracterTexto] <> ' ')) then
    { una letra seguida de un espacio indica el fin de una palabra }
    begin
      IndicePalabra := IndicePalabra + 1;
    end;
  end;
  AuxiliarSalida := nil;
  for IndiceCaracterPalabra := 1 to 25 do
  begin
    if ClavesEncontradas[26 - IndiceCaracterPalabra] then
    begin
      new(ReservadorDeMemoria);

      ReservadorDeMemoria^.clave := (26 - IndiceCaracterPalabra);
      ReservadorDeMemoria^.sig := AuxiliarSalida;

      AuxiliarSalida := ReservadorDeMemoria;
    end;
  end;
 PosiblesClaves := AuxiliarSalida;
end;

