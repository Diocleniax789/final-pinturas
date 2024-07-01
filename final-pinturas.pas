PROGRAM final-pinturas;
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
 END;

PROCEDURE carga_pinturas;
VAR
 env,op,op1,f: integer;
 BEGIN
 REPEAT
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
  env:= valida_envase;
  writeln();
  write('>>> Ingrese el precios: ');
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
    write('Ingrese Stock: ');
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

 UNTIL
 END;



PROCEDURE menu_principal;
VAR
   opcion: integer;
   BEGIN
   REPEAT
   clrscr;
   writeln('1. Carga pinturas');
   writeln('2. Generar pedido');
   writeln('3. Actualizar precios');
   writeln('4. Listado de pinturas preparadas');
   writeln('5. Salir');
   writeln();
   writeln('Seleccione una opcion: ');
   readln(opcion);
   CASE opcion OF
    1:BEGIN
      clrscr;
      carga_datos;
      END;
    2:BEGIN
      clrscr;
      genera_pedido;
      END;
    3:BEGIN
      clrscr;
      actualiza_precio;
      END;
    4:BEGIN
      clrscr;
      listar_pinturas
      END;
   END;
   UNTIL (opcion = 5);
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
