program tarea1;
{Hola compilador, te ordeno que me ignores porque soy un comentario}
const
  MAXLARGO      = 7;
  MAXBASE       = 16;
  MINBASE       = 2;
  ERROR_MSG     = 'ERROR';
  STAGE_BASE    = 0;
  STAGE_VALUE   = 1;
  STAGE_END     = 2;
var
  rawChar:       char;    {Auxiliar para leer la entrada     }
  asciiChar:     integer; {Valor ascii del caracter ingresado}
  stage:         integer; {Etapa (base o valor)              }
  base:          integer; {Base                              }
  value:         longint; {Valor                             }
  temporalValue: longint; {Auxiliar para leer base y valor   }
  valueLength:   integer; {Para medir el largo de valor      }
begin
  {Inicializar variables}
  base          := 10; {La base del campo 'base' es 10}
  temporalValue := 0;
  valueLength   := 0;
  asciiChar     := 0;
  stage         := STAGE_BASE;

  {Leer entrada}
  while stage <> STAGE_END do
  begin
    {Leer caracter}
    read(rawChar);
    asciiChar := ord(rawChar);

    {Canonizar entrada}
    if ((asciiChar >= 48) and (asciiChar < 58)) then   {Si es un decimal...}
    begin
      {Mover cada digito un espacio a la izquierda y sumarle el valor decimal que asciiChar representa}
      valueLength   := valueLength + 1;
      if (MAXLARGO >= valueLength) then
      begin
        temporalValue := (temporalValue * base) + (asciiChar - 48);
      end;
    end
    else if ((asciiChar >= 65) and (asciiChar <= 90)) and (MAXLARGO >= valueLength) then {Si es una letra...}
    begin
      {Mover cada número un espacio a la izquierda y sumarle el valor que asciiChar representa en hexadecimal}
      valueLength := valueLength + 1;
      if (MAXLARGO >= valueLength) then
      begin
        temporalValue := (temporalValue * base) + (asciiChar - 55);
      end;
    end
    else
    begin
      {No es un caracter alfanumerico, puede ser un separador}
      case asciiChar of
        58: {58 es ':'}
        begin
          {Base leida}
          base          := temporalValue;
          stage         := STAGE_VALUE;
          temporalValue := 0;
          valueLength   := 0;
        end;
        46: {46 es '.'}
        begin
          value := temporalValue;
          {Valor leido, mostrar si cumple los requisitos}
          if ((base >= MINBASE) and (base <= MAXBASE)) and (valueLength <= MAXLARGO) then
          begin
            writeln(value);
            base          := 10;
            stage         := STAGE_BASE;
            temporalValue := 0;
            valueLength   := 0;
          end
          else
          begin
            writeln(ERROR_MSG);
            stage := STAGE_END;
          end;
        end;
        36: {36 es '$'}
          stage := STAGE_END;
      end;
    end; {Si no es ningun separador tampoco, entonces lo ignoro :-)}
  end;
end.

