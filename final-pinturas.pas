PROGRAM final-pinturas;
USES crt;

TYPE

    pinturas = RECORD
            codp: integer;
            descripcion: string;
            pre: array[0..3]of real;
            preparado: char;
            stock: array [0..3]of integer;
            END;

    mezclas = RECORD
           codp: integer;
           mezcla: array[0..2,0..1]of integer;
           END;

   pedidos = RECORD
           Fecha_pedido: string[8];
           codp: integer;
           tipo_envase: integer;
           cant_pedida: integer;
           pre_total: real;
           END;

VAR
archivo_pinturas: FILE OF pinturas;
registro_pinturas: pinturas;
archivo_mezclas: FILE OF mezclas;
registro_mezclas: mezclas;
archivo_pedidos: FILE OF pedidos;
registro_pedidos: pedidos;

PROCEDURE crea_archivo_pinturas;
 BEGIN
 rewrite(archivo_pinturas);
 close(archivo_pinturas);
 END;

PROCEDURE crea_archivo_mezclas;
 BEGIN
 rewrite(archivo_mezclas);
 close(archivo_mezclas);
 END;

PROCEDURE crea_archivo_pedidos;
 BEGIN
 rewrite(archivo_pedidos);
 close(archivo_pedidos);
 END;

PROCEDURE menu_principal;
VAR
   opcion: integer;
   BEGIN
   REPEAT
   clrscr;
   writeln('1. Generar pedido');
   writeln('2. Actualizar precios');
   writeln('3. Listado de pinturas preparadas');
   writeln('4. Salir');
   writeln();
   writeln('Seleccione una opcion: ');
   readln(opcion);
   CASE opcion OF
    1:BEGIN
      clrscr;
      genera_pedido;
      END;
    2:BEGIN
      clrscr;
      actualiza_precio;
      END;
    3:BEGIN
      clrscr;
      listar_pinturas
      END;
   END;
   UNTIL (opcion = 4);
   END;

BEGIN
assign(archivo_pinturas,'C:\Users\JULIO\Desktop\final-pinturas\pinturas.dat');
assign(archivo_mezclas,'C:\Users\JULIO\Desktop\final-pinturas\mezclas.dat');
assign(archivo_pedidos,'C:\Users\JULIO\Desktop\final-pinturas\pedidos.dat');
crea_archivos_pinturas;
crea_archivos_mezclas;
crea_archivos_pedidos;
menu_principal;




END.
