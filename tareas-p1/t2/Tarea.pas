{
   InCo- Fing
   Laboratorio 2017
   Segunda Tarea

   Programa Principal
}

program Tarea;
uses crt;

(****************************************)
(* Definicion de tipos dados en la letra *)
(****************************************)
{$INCLUDE estructuras.pas}

type
   TipoComando = (enc, des, claves, salir, error);
   Comando = record case com: TipoComando  of
	       enc    : ( txtClaro   : TipoTexto;
		          claveEnc   : TipoClave );
	       des    : ( txtEncript : TipoTexto;
		          claveDes   : TipoClave );
	       claves : ( txt        : TipoTexto;
                          palabra    : TipoPalabra);
	       salir  : ();
	       error  : ();
	     end;

{ aquí­ se incluye el archivo entregado por el estudiante}
(****************************************)
(* Procedimientos de encriptar y desencriptar
   y funcion de posibles claves *)
(****************************************)
{$INCLUDE tarea2.pas}



procedure LeerComando(var cmd : Comando);
{ lectura de una linea de comando con los siguientes posibles  formatos:
- e:CLAVE:TEXTO
- d:CLAVE:TEXTO
- c:PALABRA:TEXTO
- s
donde CLAVE es un numero de 1 a 25, PALABRA es una palabra en mayuscula
de hasta 25 caracteres y TEXTO es un texto con palabras en mayusculas y
hasta 350 caracteres.
si se produce algun error de formato se retorna el comando de tipo error.
}
const SEP =  ':';
var   bien  : boolean;
      texto : TipoTexto;
      clave : TipoClave;
      palabra  :  TipoPalabra;

   procedure LeerCom (var cmd : Comando);
   { lee la letra que indica el comando y en caso de ser necesario el
     separador (:)
     si se produce algun error de formato se retorna el comando de tipo error. }
   var aux : char;
   begin
      read(aux);
      case aux of
	's' : cmd.com := salir;
	'e' : cmd.com := enc;
	'd' : cmd.com := des;
	'c' : cmd.com := claves;
        else  cmd.com := error
      end;
      if aux in ['e','d','c'] then
      begin
	read(aux);
        if aux <> SEP then
	   cmd.com := error
      end
   end;

   procedure LeerClave (var clave : TipoClave; var ok : boolean);
   { lee un numero entre 1 y 25 y el separador
     en ok se retorna si no se produce algun error de formato }
   var aux : char;
       k   : integer;
   begin
      ok := true;
      k  := 0;
      read(aux);
      repeat
	 k  := k * 10 + ord(aux) - ord('0');
	 ok := (aux >= '0') and (aux <= '9') and (k >= 1) and (k <= 25);
	 read(aux);
      until (aux = SEP) or not ok;

      if ok then clave := k
   end;

   procedure LeerTexto (var texto : TipoTexto; var ok : boolean);
   { lee un texto
     en ok se retorna si no se produce algun error de formato }
   var aux : char;
   begin
      texto.tope := 0;
      ok := true;
      while ok and not eoln do
      begin
	 read(aux);
	 ok := (texto.tope < MaxTexto) and
	       ((aux = ' ') or  (aux >= 'A') and (aux <= 'Z'));
	 if ok then
	 begin
	    texto.tope := texto.tope + 1;
	    texto.texto[texto.tope] := aux;
	 end
      end
   end;

   procedure LeerPalabra (var texto : TipoPalabra; var ok : boolean);
   { lee una palabra y el separador
     en ok se retorna si no se produce algun error de formato }

   var aux : char;
   begin
      texto.tope := 0;
      ok := true;
      read(aux);
      while ok and (aux <> SEP) do
      begin
	 ok := (texto.tope < MaxPalabra) and
	       (aux >= 'A') and (aux <= 'Z');
	 if ok then
	 begin
	    texto.tope := texto.tope + 1;
	    texto.palabra[texto.tope] := aux;
	 end;
	 read(aux)
      end
   end;

begin
   LeerCom(cmd);
   case cmd.com of
     enc, des : begin
	          LeerClave (clave,bien);
	          if bien then LeerTexto(texto,bien);
	          if bien then
		     if cmd.com = enc then
		     begin
			cmd.claveEnc := clave;
			cmd.txtClaro := texto
		     end
	             else
		     begin
			cmd.claveDes   := clave;
			cmd.txtEncript := texto
		     end
                  else
		     cmd.com := error
                end;
     claves   : begin
	          LeerPalabra (palabra,bien);
	          if bien then LeerTexto(texto,bien);
	          if bien then
		  begin
			cmd.palabra := palabra;
			cmd.txt     := texto
		  end
                  else
		     cmd.com := error
	        end
   end;
   if not eoln then cmd.com := error;
   readln
end;

procedure MostrarTexto (t : TipoTexto);
{ muestra el contenido del texto }
var i : integer;
begin
   for i := 1 to t.tope do write (t.texto[i]);
   writeln
end;

procedure MostrarLista (l : listaClaves);
{ muestra el contenido de la lista }
begin
   if l <> nil then
   begin
      write(l^.clave);
      l := l^.sig
   end;
   while l <> nil do
   begin
      write (', ', l^.clave);
      l := l^.sig
   end;
   writeln
end;

procedure BorrarLista(lista : ListaClaves);
{ libera el espacio ocupado por la lista }
var
   tmp,p : ListaClaves;
begin
   p:= lista;
   while p <> nil do
   begin
      tmp:= p;
      p:= p^.sig;
      dispose(tmp);
   end;
end;


var cmd    : Comando;
    salida : TipoTexto;
    lista  : ListaClaves;


{ Programa Principal }
begin
   ClrScr;
   writeln('######################################');
   writeln('##### BIENVENIDO A CRIPTO PROG1 ######');
   writeln('######################################');  
   writeln('##### - para encriptar          ######');
   writeln('#####   e:CLAVE:TEXTO           ######');
   writeln('##### - para desencriptar       ######');
   writeln('#####   d:CLAVE:TEXTO           ######');
   writeln('##### - para posibles claves    ######');
   writeln('#####   c:PALABRA:TEXTO         ######');
   writeln('##### - para salir              ######');
   writeln('#####   s                       ######');
   writeln('######################################');
   writeln;

   repeat
      LeerComando(cmd);
      case cmd.com of
	enc    : begin
		    encriptar(cmd.txtClaro,cmd.claveEnc,salida);
		    MostrarTexto(salida)
		 end;
	des    : begin
		    desencriptar(cmd.txtEncript,cmd.claveDes,salida);
		    MostrarTexto(salida)
		 end;
	claves : begin
		    lista := posiblesClaves(cmd.palabra,cmd.txt);
		    MostrarLista(lista);
		    BorrarLista(lista)
		 end;
	error  : writeln('Error al leer comando.')
      end
   until cmd.com = salir;
   
   writeln('######################################');
   writeln('##### NOS VEMOS!!!              ######');
   writeln('######################################')  

end.
