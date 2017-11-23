const
   MaxTexto   = 350;
   MaxPalabra = 25;
type
   {rangos para arreglos con tope texto y palabra}
   RangoTexto       = 1 .. MaxTexto;
   RangoTopeTexto   = 0 .. MaxTexto;
   RangoPalabra     = 1 .. MaxPalabra;
   RangoTopePalabra = 0 .. MaxPalabra;

   { definición del texto}
   TipoTexto = record
                 texto : array[RangoTexto] of char;
                 tope  : RangoTopeTexto;
               end;

   { definición de palabra}
   TipoPalabra = record
                   palabra : array [RangoPalabra] of char;
                   tope    : RangoTopePalabra;
                 end;

   { clave de encriptación }
   TipoClave = 1 .. 25;

   { estructura usada en subprograma PosiblesClaves }
   listaClaves = ^celda;
   celda = record
             clave  :  TipoClave;
             sig    :  listaClaves;
           end;
