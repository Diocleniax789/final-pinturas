PROGRAM final_pinturas;
USES crt;

TYPE

    pinturas = RECORD
            codp: integer;
            descripcion: string;
            precio: array[0..3]of real;
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

FUNCTION verifica_tamanio_archivo_pinturas(): boolean;
 BEGIN
 reset(archivo_pinturas);
 IF filesize(archivo_pinturas) = 0 THEN
  verifica_tamanio_archivo_pinturas:= true
 ELSE
  verifica_tamanio_archivo_pinturas:= false;
 close(archivo_pinturas);
 END;

{
FUNCTION valida_envase(): integer;
VAR
 op: integer;
 BEGIN
  REPEAT
  writeln('ENVASES');
  writeln('-------');
  writeln();
  writeln('0. 1 Litro');
  writeln('1. 4 Litros');
  writeln('2. 10 Litros');
  writeln('3. 20 Litros');
  writeln();
  write('Seleccione tipo de envase: ');
  readln(op);
  IF (op < 0) OR (op > 3) THEN
   writeln('VALOR INCORRECTO. INGRESE NUEVAMENTE');
  UNTIL (op >= 0) AND (op <= 3);
 valida_envase:= op;
 END;   }

PROCEDURE ordena_archivo_pinturas_por_cod_pintura;
VAR
   i,j: integer;
   registro_aux: pinturas;
   BEGIN
   reset(archivo_pinturas);
   FOR i:= 0 TO filesize(archivo_pinturas) - 2 DO
    BEGIN
    FOR j:= i + 1 TO filesize(archivo_pinturas) - 1 DO
     BEGIN
     seek(archivo_pinturas, i);
     read(archivo_pinturas, registro_pinturas);
     seek(archivo_pinturas, j);
     read(archivo_pinturas, registro_aux);
     IF registro_pinturas.codp > registro_aux.codp THEN
      BEGIN
      seek(archivo_pinturas,i);
      write(archivo_pinturas,registro_aux);
      seek(archivo_pinturas,j);
      write(archivo_pinturas,registro_pinturas);
      END;
     END;
    END;
   END;

FUNCTION existe_pintura(cod_pin: integer): boolean;
VAR
   f: boolean;
   BEGIN
   f:= false;
   REPEAT
   read(archivo_pinturas,registro_pinturas);
   IF cod_pin = registro_pinturas.codp THEN
    f:= true;
   UNTIL eof(archivo_pinturas) OR (f = true);
   IF f = true THEN
    existe_pintura:= true
   ELSE
    existe_pintura:= false;
   END;

PROCEDURE carga_pinturas;
VAR
 opcion: string;
 f,cod_pin: integer;
 op1: char;
 BEGIN
 IF verifica_tamanio_archivo_pinturas = true THEN
  BEGIN
  reset(archivo_pinturas);
  writeln('CARGA DE DATOS DE PINTURA');
  writeln('-------------------------');
  writeln();
  write('>>> Ingrese codigo de pintura: ');
  readln(registro_pinturas.codp);
  writeln();
  write('>>> Ingrese descripcion de pintura: ');
  readln(registro_pinturas.descripcion);
  writeln();
  write('>>> Ingrese los precios: ');
  FOR f:= 0 TO 3 DO
   BEGIN
   writeln('Precio ',f);
   writeln();
   write('Ingrese precio: ');
   readln(registro_pinturas.precio[f]);
   END;
  writeln();
  REPEAT
  write('>>> Es preparada[s/n]?: ');
  readln(op1);
  IF (op1 <> 's') AND (op1 <> 'n') THEN
   writeln('VALOR INCORRECTO. INGRESE NUEVAMENTE');
  UNTIL (op1 = 's') OR (op1 = 'n');
  registro_pinturas.preparado:= op1;
  writeln();
  write('>>> Ingrese el stock: ');
  FOR f:= 0 TO 3 DO
   BEGIN
    writeln('Stock',f);
    writeln();
    write('Ingrese los Stocks: ');
    readln(registro_pinturas.stock[f]);
   END;
  seek(archivo_pinturas,filesize(archivo_pinturas));
  write(archivo_pinturas, registro_pinturas);
  close(archivo_pinturas);
  writeln();
  writeln('===========================================');
  writeln('*** SE HA CARGADO EL REGISTRO CON EXITO ***');
  writeln('===========================================');
  delay(2000);
  END
 ELSE
  BEGIN
   REPEAT
   reset(archivo_pinturas);
   writeln('CARGA DE DATOS DE PINTURA');
   writeln('-------------------------');
   writeln();
   write('>>> Ingrese codigo de pintura: ');
   readln(cod_pin);
   IF existe_pintura(cod_pin) = true THEN
    BEGIN
    writeln();
    writeln('===============================');
    writeln('X CODIGO DE PINTURA EXISTENTE X');
    writeln('===============================');
    writeln();
    END
   ELSE
    BEGIN
    registro_pinturas.codp:= cod_pin;
    write('>>> Ingrese los precios: ');
    FOR f:= 0 TO 3 DO
     BEGIN
     writeln('Precio ',f);
     writeln();
     write('Ingrese precio: ');
     readln(registro_pinturas.precio[f]);
     END;
    writeln();
    REPEAT
     write('>>> Es preparada[s/n]?: ');
     readln(op1);
     IF (op1 <> 's') AND (op1 <> 'n') THEN
      writeln('VALOR INCORRECTO. INGRESE NUEVAMENTE');
    UNTIL (op1 = 's') OR (op1 = 'n');
    registro_pinturas.preparado:= op1;
    writeln();
    write('>>> Ingrese el stock: ');
    FOR f:= 0 TO 3 DO
     BEGIN
     writeln('Stock',f);
     writeln();
     write('Ingrese los Stocks: ');
     readln(registro_pinturas.stock[f]);
     END;
    seek(archivo_pinturas,filesize(archivo_pinturas));
    write(archivo_pinturas, registro_pinturas);
    writeln();
    writeln('===========================================');
    writeln('*** SE HA CARGADO EL REGISTRO CON EXITO ***');
    writeln('===========================================');
    ordena_archivo_pinturas_por_cod_pintura;
    END;
    close(archivo_pinturas);
    REPEAT
    writeln();
    writeln('Desea volver a cargar otro registro[s/n]?: ');
    readln(opcion);
    IF (opcion <> 's') AND (opcion <> 'n') THEN
     BEGIN
     writeln();
     writeln('========================================');
     writeln('X VALOR INCORRECTO. INGRESE NUEVAMENTE X');
     writeln('========================================');
     writeln();
     END;
    UNTIL (opcion = 's') OR (opcion = 'n');
    UNTIL (opcion = 'n');
   END;
  END;

PROCEDURE carga_pinturas_preparadas;
VAR
 cod_pin: integer;
 BEGIN
 IF verifica_tamanio_archivo_pinturas = true THEN
  BEGIN
  writeln();
  writeln('===================================================================');
  writeln('X NO HAY REGISTROS CARGADOS EN EL ARCHIVO PINTURAS. INTENTE LUEGO X');
  writeln('===================================================================');
  delay(2000);
  END
 ELSE
  BEGIN

  REPEAT
  reset(archivo_mezclas);
  reset(archivo_pinturas);
  seek(archivo_pinturas,filepos(archivo_pinturas) - 1);
  read(archivo_pinturas,registro_pinturas);
  IF registro_pinturas.preparado = 's' THEN
   BEGIN
   cod_pin:= registro_pinturas.codp;
   registro_mezclas.codp:= cod_pin;
   writeln(' *** Codigo de pintura aniadido ***');
   writeln();
   write('>>> Ingrese pintura 1: ');
   readln(pintura_1);
   write('>>> Ingrese pintura 2: ');
   readln(pintura_2);
   write('>>> Ingrese pintura 3: ');
   readln(pintura_3);

  UNTIL
















  END
 END;



PROCEDURE menu_principal;
VAR
   opcion: integer;
   BEGIN
   REPEAT
   clrscr;
   writeln('1. Carga pinturas');
   writeln('2. Carga pinturas preparadas');
   writeln('3. Generar pedido');
   writeln('4. Actualizar precios');
   writeln('5. Listado de pinturas preparadas');
   writeln('6. Salir');
   writeln();
   writeln('Seleccione una opcion: ');
   readln(opcion);
   CASE opcion OF
    1:BEGIN
      clrscr;
      carga_pinturas;
      END;
    2:BEGIN
      clrscr;
      carga_pinturas_preparadas;
      END;
  {  3:BEGIN
      clrscr;
      genera_pedido;
      END;
    4:BEGIN
      clrscr;
      actualiza_precio;
      END;
    5:BEGIN
      clrscr;
      listar_pinturas
      END;             }
   END;
   UNTIL (opcion = 6);
   END;

BEGIN
assign(archivo_pinturas,'C:\Users\JULIO\Desktop\final-pinturas\pinturas.dat');
assign(archivo_mezclas,'C:\Users\JULIO\Desktop\final-pinturas\mezclas.dat');
assign(archivo_pedidos,'C:\Users\JULIO\Desktop\final-pinturas\pedidos.dat');
crea_archivo_pinturas;
crea_archivo_mezclas;
crea_archivo_pedidos;
menu_principal;
END.
