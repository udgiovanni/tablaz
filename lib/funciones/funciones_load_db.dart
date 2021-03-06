// ignore_for_file: unnecessary_string_interpolations
//Importando las librerias a Utilizar
//dart:io facilita el trabajo con archivos
import 'dart:io';
//dart:convert facilita la conversion de datos
import 'dart:convert';
import 'package:tablaz/clases/database_tz.dart';
import 'package:tablaz/funciones/cargando_data.dart';
import 'package:tablaz/objetos/objetos.dart';
import 'package:sqlite3/sqlite3.dart';

//TXT a List de String para UTF-8
class FuncionesLoadDatabase {
  Future<List<String>> txtToListString(String ruta) async {
    File dataLoad = File(ruta);
    String dataCargad = dataLoad.readAsStringSync();
    String replace1 = dataCargad.replaceAll('"', ' ');
    String dataCargada = replace1.replaceAll("'", " ");
    //var bytesTxt = await dataLoad.readAsBytes();
    //String dataCargada = String.fromCharCodes(bytesTxt);
    LineSplitter lineasDataCargada = const LineSplitter();
    List<String> lineasCargadas = lineasDataCargada.convert(dataCargada);
    List<String> linean = [];
    for (int i = 0; i <= lineasCargadas.length - 1; i++) {
      linean.add(lineasCargadas[i]);
    }
    return linean;
  }

//TXT a List String para ANSI
  Future<List<String>> txtToListStringANSI(String ruta) async {
    File dataLoad = File(ruta);
    var bytesTxt = await dataLoad.readAsBytes();
    String dataCargadaBytex = String.fromCharCodes(bytesTxt);
    String replace1 = dataCargadaBytex.replaceAll('"', ' ');
    String dataCargada = replace1.replaceAll("'", " ");
    //var bytesTxt = await dataLoad.readAsBytes();
    //String dataCargada = String.fromCharCodes(bytesTxt);
    LineSplitter lineasDataCargada = const LineSplitter();
    List<String> lineasCargadas = lineasDataCargada.convert(dataCargada);
    List<String> linean = [];
    for (int i = 0; i <= lineasCargadas.length - 1; i++) {
      linean.add(lineasCargadas[i]);
    }
    return linean;
  }

//Funcion que almacena en la DB los datos de la tabla cuentas
  Future<void> guardarDatosCuentasDB(List<String> datosCuentas) async {
    //contador
    int i = 0;
    //Validador
    bool validador = false;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla

    db.execute('''
    BEGIN;
    DROP TABLE IF EXISTS ACCOUNT;
    CREATE TABLE ACCOUNT (
      VKONT,
      GPART,
      VKTYP,
      STREET,
      VKBEZ,
      VKONA,
      REGIOGR_CA_T,
      KTOKL,
      KOFIZ_SD,
      ABWVK,
      FORMKEY,
      ZZDIR,
      IKEY,
      ZPORTION,
      REGIOGROUP
    );
    ''');
    final inserAccountData = db.prepare('''
    INSERT INTO ACCOUNT (
        VKONT,
        GPART,
        VKTYP,
        STREET,
        VKBEZ,
        VKONA,
        REGIOGR_CA_T,
        KTOKL,
        KOFIZ_SD,
        ABWVK,
        FORMKEY,
        ZZDIR,
        IKEY,
        ZPORTION,
        REGIOGROUP
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosCuentas.length - 1; i++) {
      String linea = datosCuentas[i];
      CuentaContratoType cuenta = fz.dataCuenta(linea);
      inserAccountData.execute([
        cuenta.VKONT,
        cuenta.GPART,
        cuenta.VKTYP,
        cuenta.STREET,
        cuenta.VKBEZ,
        cuenta.VKONA,
        cuenta.REGIOGR_CA_T,
        cuenta.KTOKL,
        cuenta.KOFIZ_SD,
        cuenta.ABWVK,
        cuenta.FORMKEY,
        cuenta.ZZDIR,
        cuenta.IKEY,
        cuenta.ZPORTION,
        cuenta.REGIOGROUP
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE ACCOUNT
    SET VKONT = NULL WHERE VKONT = '';
    UPDATE ACCOUNT
    SET GPART = NULL WHERE GPART = '';
    UPDATE ACCOUNT
    SET VKTYP = NULL WHERE VKTYP = '';
    UPDATE ACCOUNT
    SET STREET = NULL WHERE STREET = '';
    UPDATE ACCOUNT
    SET VKBEZ = NULL WHERE VKBEZ = '';
    UPDATE ACCOUNT
    SET VKONA = NULL WHERE VKONA = '';
    UPDATE ACCOUNT
    SET REGIOGR_CA_T = NULL WHERE REGIOGR_CA_T = '';
    UPDATE ACCOUNT
    SET KTOKL = NULL WHERE KTOKL = '';
    UPDATE ACCOUNT
    SET KOFIZ_SD = NULL WHERE KOFIZ_SD = '';
    UPDATE ACCOUNT
    SET ABWVK = NULL WHERE ABWVK = '';
    UPDATE ACCOUNT
    SET FORMKEY = NULL WHERE FORMKEY = '';
    UPDATE ACCOUNT
    SET ZZDIR = NULL WHERE ZZDIR = '';
    UPDATE ACCOUNT
    SET IKEY = NULL WHERE IKEY = '';
    UPDATE ACCOUNT
    SET ZPORTION = NULL WHERE ZPORTION = '';
    UPDATE ACCOUNT
    SET REGIOGROUP = NULL WHERE REGIOGROUP = '';
    DELETE FROM ACCOUNT
    WHERE VKONT IS NULL;
    COMMIT;
    ''');
    inserAccountData.dispose();
    validador = true;
  }

//Funcion que almacena en la DB los datos de la tabla InterlocutorComercial
  Future<void> guardarDatosIntComercialDB(
      List<String> datosInrComercial) async {
    //contador
    int i = 0;
    //Validador
    bool validador = false;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS PARTNER;
      CREATE TABLE PARTNER (
        PARTNER,
        NAME_ORG1,
        BU_SORT1,
        STREET,
        HOUSE_NUM1,
        CITY2,
        REGIOGROUP,
        TEL_NUMBER,
        CLERK_ID,
        NAME_FIRST,
        NAME_LAST,
        BU_SORT2,
        BPKIND,
        TITLE,
        HOUSE_NUM2,
        CITY1,
        REGION
      );
    
    ''');
    final insertInterlocutorData = db.prepare('''
    INSERT INTO PARTNER (
        PARTNER,
        NAME_ORG1,
        BU_SORT1,
        STREET,
        HOUSE_NUM1,
        CITY2,
        REGIOGROUP,
        TEL_NUMBER,
        CLERK_ID,
        NAME_FIRST,
        NAME_LAST,
        BU_SORT2,
        BPKIND,
        TITLE,
        HOUSE_NUM2,
        CITY1,
        REGION
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosInrComercial.length - 1; i++) {
      String linea = datosInrComercial[i];
      InterlocutorComercialType interlocutor =
          fz.dataInterlocutorComercial(linea);
      insertInterlocutorData.execute([
        interlocutor.PARTNER,
        interlocutor.NAME_ORG1,
        interlocutor.BU_SORT1,
        interlocutor.STREET,
        interlocutor.HOUSE_NUM1,
        interlocutor.CITY2,
        interlocutor.REGIOGROUP,
        interlocutor.TEL_NUMBER,
        interlocutor.CLERK_ID,
        interlocutor.NAME_FIRST,
        interlocutor.NAME_LAST,
        interlocutor.BU_SORT2,
        interlocutor.BPKIND,
        interlocutor.TITLE,
        interlocutor.HOUSE_NUM2,
        interlocutor.CITY1,
        interlocutor.REGION
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE PARTNER
    SET PARTNER = NULL WHERE PARTNER = '';
    UPDATE PARTNER
    SET NAME_ORG1 = NULL WHERE NAME_ORG1 = '';
    UPDATE PARTNER
    SET BU_SORT1= NULL WHERE BU_SORT1= '';
    UPDATE PARTNER
    SET STREET= NULL WHERE STREET= '';
    UPDATE PARTNER
    SET HOUSE_NUM1= NULL WHERE HOUSE_NUM1= '';
    UPDATE PARTNER
    SET CITY2= NULL WHERE CITY2= '';
    UPDATE PARTNER
    SET REGIOGROUP= NULL WHERE REGIOGROUP= '';
    UPDATE PARTNER
    SET TEL_NUMBER= NULL WHERE TEL_NUMBER= '';
    UPDATE PARTNER
    SET CLERK_ID= NULL WHERE CLERK_ID= '';
    UPDATE PARTNER
    SET NAME_FIRST= NULL WHERE NAME_FIRST= '';
    UPDATE PARTNER
    SET NAME_LAST= NULL WHERE NAME_LAST= '';
    UPDATE PARTNER
    SET BU_SORT2= NULL WHERE BU_SORT2= '';
    UPDATE PARTNER
    SET BPKIND= NULL WHERE BPKIND= '';
    UPDATE PARTNER
    SET TITLE= NULL WHERE TITLE= '';
    UPDATE PARTNER
    SET HOUSE_NUM2= NULL WHERE HOUSE_NUM2= '';
    UPDATE PARTNER
    SET CITY1= NULL WHERE CITY1= '';
    UPDATE PARTNER
    SET REGION= NULL WHERE REGION= '';
    DELETE FROM PARTNER
    WHERE PARTNER IS NULL;
    COMMIT;
    ''');
    insertInterlocutorData.dispose();
    validador = true;
  }

//Funcion que almacena en la DB los datos de la tabla Alta Instalacion
  Future<void> guardarAltaInstalacionDB(
      List<String> datosAltasInstalacion) async {
    //contador
    int i = 0;
    //Validador
    bool validador = false;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS MOVE;
      CREATE TABLE MOVE (
        VERTRAG,
        ANLAGE,
        VKONTO,
        SPARTE,
        STAGRUVER,
        EINZDAT,
        AUSZDAT
      );
    ''');
    final insertAltaInstalacionData = db.prepare('''
      INSERT INTO MOVE (
        VERTRAG,
        ANLAGE,
        VKONTO,
        SPARTE,
        STAGRUVER,
        EINZDAT,
        AUSZDAT
        ) VALUES (?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosAltasInstalacion.length - 1; i++) {
      String linea = datosAltasInstalacion[i];
      AltaInstalacionType altaInstalacion = fz.dataAltaInstalacion(linea);
      insertAltaInstalacionData.execute([
        altaInstalacion.VERTRAG,
        altaInstalacion.ANLAGE,
        altaInstalacion.VKONTO,
        altaInstalacion.SPARTE,
        altaInstalacion.STAGRUVER,
        altaInstalacion.EINZDAT,
        altaInstalacion.AUSZDAT
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    DELETE FROM MOVE
    WHERE VERTRAG ='';
    UPDATE MOVE
    SET ANLAGE = NULL WHERE ANLAGE = '';
    UPDATE MOVE
    SET VKONTO = NULL WHERE VKONTO = '';
    UPDATE MOVE
    SET SPARTE = NULL WHERE SPARTE = '';
    UPDATE MOVE
    SET EINZDAT = NULL WHERE EINZDAT = '';
    UPDATE MOVE
    SET AUSZDAT = NULL WHERE AUSZDAT = '';
    COMMIT;
        ''');
    insertAltaInstalacionData.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Medidores
  Future<void> guardarMedidorDB(List<String> datosMedidores) async {
    //contador
    int i = 0;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla

    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS DEVICE;
      CREATE TABLE DEVICE (
        EQUNR,
        VSTELLE,
        HERST,
        MATNR,
        ILOAN,
        SERNR,
        EQTYP,
        STTXT,
        BIS,
        IWERK,
        INGRP,
        TPLNR
      );
    ''');
    final insertDataMedidor = db.prepare('''
      INSERT INTO DEVICE (
        EQUNR,
        VSTELLE,
        HERST,
        MATNR,
        ILOAN,
        SERNR,
        EQTYP,
        STTXT,
        BIS,
        IWERK,
        INGRP,
        TPLNR
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
      ''');
    for (i; i <= datosMedidores.length - 1; i++) {
      String linea = datosMedidores[i];
      AparatoType medidor = fz.dataMedidor(linea);
      insertDataMedidor.execute([
        medidor.EQUNR,
        medidor.VSTELLE,
        medidor.HERST,
        medidor.MATNR,
        medidor.ILOAN,
        medidor.SERNR,
        medidor.EQTYP,
        medidor.STTXT,
        medidor.BIS,
        medidor.IWERK,
        medidor.INGRP,
        medidor.TPLNR
      ]);
    }
    db.execute('''COMMIT;''');
    db.execute('''
    BEGIN;
    DELETE FROM DEVICE WHERE EQUNR = '';
    UPDATE DEVICE
    SET VSTELLE = NULL WHERE VSTELLE = '';
    UPDATE DEVICE
    SET HERST = NULL WHERE HERST = '';
    UPDATE DEVICE
    SET MATNR = NULL WHERE MATNR = '';
    UPDATE DEVICE
    SET ILOAN = NULL WHERE ILOAN = '';
    UPDATE DEVICE
    SET SERNR = NULL WHERE SERNR = '';
    UPDATE DEVICE
    SET EQTYP = NULL WHERE EQTYP = '';
    UPDATE DEVICE
    SET STTXT = NULL WHERE STTXT = '';
    UPDATE DEVICE
    SET BIS = NULL WHERE BIS = '';
    UPDATE DEVICE
    SET IWERK = NULL WHERE IWERK = '';
    UPDATE DEVICE
    SET INGRP = NULL WHERE INGRP = '';
    UPDATE DEVICE
    SET INGRP = NULL WHERE INGRP = '';
    UPDATE DEVICE
    SET TPLNR = NULL WHERE TPLNR = '';
    COMMIT;
    ''');
    insertDataMedidor.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Instalaciones
  Future<void> guardarInstalacionesDB(List<String> datosInstalaciones) async {
    //contador
    int i = 0;
    //Validador
    bool validador = false;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS INSTLN;
      CREATE TABLE INSTLN (
        ANLAGE,
        VSTELLE,
        SPARTE,
        AB,
        BIS,
        AKLASSE,
        TARIFTYP,
        BRANCHE,
        ABLEINH,
        ANLART,
        TEMP_AREA,
        KONDIGR,
        TARIFART
      );
    ''');
    final insertDataInstalacion = db.prepare('''
    INSERT INTO INSTLN (
        ANLAGE,
        VSTELLE,
        SPARTE,
        AB,
        BIS,
        AKLASSE,
        TARIFTYP,
        BRANCHE,
        ABLEINH,
        ANLART,
        TEMP_AREA,
        KONDIGR,
        TARIFART
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosInstalaciones.length - 1; i++) {
      String linea = datosInstalaciones[i];
      InstalacionType instalacionType = fz.dataInstalacion(linea);
      insertDataInstalacion.execute([
        instalacionType.ANLAGE,
        instalacionType.VSTELLE,
        instalacionType.SPARTE,
        instalacionType.AB,
        instalacionType.BIS,
        instalacionType.AKLASSE,
        instalacionType.TARIFTYP,
        instalacionType.BRANCHE,
        instalacionType.ABLEINH,
        instalacionType.ANLART,
        instalacionType.TEMP_AREA,
        instalacionType.KONDIGR,
        instalacionType.TARIFART
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    DELETE FROM INSTLN
    WHERE ANLAGE = '';
    UPDATE INSTLN
    SET VSTELLE = NULL WHERE VSTELLE = '';
    UPDATE INSTLN
    SET SPARTE = NULL WHERE SPARTE = '';
    UPDATE INSTLN
    SET AB = NULL WHERE AB = '';
    UPDATE INSTLN
    SET BIS = NULL WHERE BIS = '';
    UPDATE INSTLN
    SET AKLASSE = NULL WHERE AKLASSE = '';
    UPDATE INSTLN
    SET TARIFTYP = NULL WHERE TARIFTYP = '';
    UPDATE INSTLN
    SET BRANCHE = NULL WHERE BRANCHE = '';
    UPDATE INSTLN
    SET ABLEINH = NULL WHERE ABLEINH = '';
    UPDATE INSTLN
    SET ANLART = NULL WHERE ANLART = '';
    UPDATE INSTLN
    SET TEMP_AREA = NULL WHERE TEMP_AREA = '';
    UPDATE INSTLN
    SET KONDIGR = NULL WHERE KONDIGR = '';
    UPDATE INSTLN
    SET TARIFART = NULL WHERE TARIFART = '';
    COMMIT;
    ''');
    insertDataInstalacion.dispose();
    validador = true;
  }

//Funcion que almacena en la DB los datos de la tabla Objeto de Conexion
  Future<void> guardarObjetoConexionDB(List<String> datosObjetoConexion) async {
    //contador
    int i = 0;
    //Validador
    bool validador = false;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS CONNOBJ;
      CREATE TABLE CONNOBJ (
        HAUS,
        STREET,
        REGPOLIT,
        REGIOGROUP,
        ILOAN,
        SWERK,
        STR_SUPPL2,
        HOUSE_NUM1,
        CITY1,
        REGION,
        BUILDING,
        COUNC
      );
    ''');
    final insertDataObjetoConexion = db.prepare('''
    INSERT INTO CONNOBJ (
        HAUS,
        STREET,
        REGPOLIT,
        REGIOGROUP,
        ILOAN,
        SWERK,
        STR_SUPPL2,
        HOUSE_NUM1,
        CITY1,
        REGION,
        BUILDING,
        COUNC
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    ''');

    for (i; i <= datosObjetoConexion.length - 1; i++) {
      String linea = datosObjetoConexion[i];
      ObjetoConexionType objetoConexionType = fz.dataObjetoConexio(linea);
      insertDataObjetoConexion.execute([
        objetoConexionType.HAUS,
        objetoConexionType.STREET,
        objetoConexionType.REGPOLIT,
        objetoConexionType.REGIOGROUP,
        objetoConexionType.ILOAN,
        objetoConexionType.SWERK,
        objetoConexionType.STR_SUPPL2,
        objetoConexionType.HOUSE_NUM1,
        objetoConexionType.CITY1,
        objetoConexionType.REGION,
        objetoConexionType.BUILDING,
        objetoConexionType.COUNC
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    DELETE FROM CONNOBJ WHERE HAUS = '';
    UPDATE CONNOBJ
    SET STREET = NULL WHERE STREET = '';
    UPDATE CONNOBJ
    SET REGPOLIT = NULL WHERE REGPOLIT = '';
    UPDATE CONNOBJ
    SET REGIOGROUP = NULL WHERE REGIOGROUP = '';
    UPDATE CONNOBJ
    SET ILOAN = NULL WHERE ILOAN = '';
    UPDATE CONNOBJ
    SET SWERK = NULL WHERE ILOAN = '';
    UPDATE CONNOBJ
    SET STR_SUPPL2 = NULL WHERE STR_SUPPL2 = '';
    UPDATE CONNOBJ
    SET HOUSE_NUM1 = NULL WHERE HOUSE_NUM1 = '';
    UPDATE CONNOBJ
    SET CITY1 = NULL WHERE CITY1 = '';
    UPDATE CONNOBJ
    SET REGION = NULL WHERE REGION = '';
    UPDATE CONNOBJ
    SET BUILDING = NULL WHERE BUILDING = '';
    UPDATE CONNOBJ
    SET COUNC = NULL WHERE COUNC = '';
    COMMIT;
    ''');
    insertDataObjetoConexion.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Instalaciones
  Future<void> guardarPuntoSumiinistroDB(
      List<String> datosPuntoSuministro) async {
    //contador
    int i = 0;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS PREMISE;
      CREATE TABLE PREMISE (
        VSTELLE,
        HAUS,
        VBSART,
        HAUS_NUM2,
        FLOOR,
        ROOMNUMBER,
        STR_ERG2,
        STR_ERG4,
        LGZUSATZ,
        ANZPERS
      );
    ''');
    final insertDataPuntoInstalacion = db.prepare('''
    INSERT INTO PREMISE (
        VSTELLE,
        HAUS,
        VBSART,
        HAUS_NUM2,
        FLOOR,
        ROOMNUMBER,
        STR_ERG2,
        STR_ERG4,
        LGZUSATZ,
        ANZPERS
        ) VALUES (?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosPuntoSuministro.length - 1; i++) {
      String linea = datosPuntoSuministro[i];
      PuntoSuministroType puntoSuministroType = fz.dataPuntoSuministro(linea);
      insertDataPuntoInstalacion.execute([
        puntoSuministroType.VSTELLE,
        puntoSuministroType.HAUS,
        puntoSuministroType.VBSART,
        puntoSuministroType.HAUS_NUM2,
        puntoSuministroType.FLOOR,
        puntoSuministroType.ROOMNUMBER,
        puntoSuministroType.STR_ERG2,
        puntoSuministroType.STR_ERG4,
        puntoSuministroType.LGZUSATZ,
        puntoSuministroType.ANZPERS
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    DELETE FROM PREMISE WHERE VSTELLE = '';
    UPDATE PREMISE
    SET HAUS = NULL WHERE HAUS = '';
    UPDATE PREMISE
    SET VBSART = NULL WHERE VBSART = '';
    UPDATE PREMISE
    SET HAUS_NUM2 = NULL WHERE HAUS_NUM2 = '';
    UPDATE PREMISE
    SET FLOOR = NULL WHERE FLOOR = '';
    UPDATE PREMISE
    SET ROOMNUMBER = NULL WHERE ROOMNUMBER = '';
    UPDATE PREMISE
    SET STR_ERG2 = NULL WHERE STR_ERG2 = '';
    UPDATE PREMISE
    SET STR_ERG4 = NULL WHERE STR_ERG4 = '';
    UPDATE PREMISE
    SET LGZUSATZ = NULL WHERE LGZUSATZ = '';
    UPDATE PREMISE
    SET ANZPERS = NULL WHERE ANZPERS = '';
    COMMIT;
    ''');

    insertDataPuntoInstalacion.dispose();
  }

  Future<void> crearTablaZ(String cualquierCosa) async {
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    db.execute('''
      BEGIN;
      --ELIMINANDO TABLAS POR SI NO BORRAN LA BASE DE DATOS CREADO CON ANTERIORIDAD

      DROP TABLE IF EXISTS MOVE_IN_AC;
      DROP TABLE IF EXISTS MOVE_IN_AL;
      DROP TABLE IF EXISTS MOVE_IN_AC_AFORO;
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN;
      DROP INDEX IF EXISTS IX_ACCOUNT_VKONT;
      DROP INDEX IF EXISTS IX_MOVE_IN_AC;
      DROP INDEX IF EXISTS IX_MOVE_IN_AL;
      DROP TABLE IF EXISTS MOVE_IN_AL_AFORO;
      DROP TABLE IF EXISTS AC_AFORO;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO_TEMP;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO_TEMP2;

      /*CREANDO LA TABLA DE INSTALACI??N DE SERVICIOS DE ACUEDUCTO Y ORGANIZANDOLA 
      DE MAYOR A MENOR POR FECHA DE VALIDEZ PARA OBTENER EL PRIMER REGISTRO EN 
      EL GROUP BY POR CUENTA CONTRATO BUSCANDO QUE EN EL JOIN SE OBTENGA LA ULTIMA INSTALACION
      CREADA EN EL PREDIO*/

      CREATE TABLE MOVE_IN_AC AS
      SELECT * FROM MOVE WHERE SPARTE = '10' ORDER BY EINZDAT DESC;

      --IGUAL QUE LA TABLA ANTERIOR PERO PARA ALCANTARILLADO
      CREATE TABLE MOVE_IN_AL AS
      SELECT * FROM MOVE WHERE SPARTE = '20' ORDER BY EINZDAT DESC;

      /*CREANDO UNA TABLA CON UN CONTADOR PARA BUSCAR LAS CUENTAS QUE TIENEN
      DOBLE INSTALACI??N DE ALCANTARILLADO ACTIVO*/

      CREATE TABLE MOVE_IN_AL_AFORO AS
      SELECT * , count(*) AS CANT_INSTALACIONES FROM MOVE WHERE SPARTE = '20' AND AUSZDAT = '99991231' GROUP BY VKONTO ORDER BY EINZDAT DESC;
      --ELIMINANDO LA TABLA CON LA CANTIDAD DE INSTALACIONES ACTIVAS PARA DISMINUIR EL TAMA??O DE LA DB
      DROP TABLE IF EXISTS ACCOUNT_AC_AFORO;

      --CREANDO UNA TABLA CON LAS CUENTAS QUE TIENEN DOBLE INSTALACI??N DE ALCANTARILLADO ACTIVO (ALCANTARILLADO POR AFORO)
      CREATE TABLE AC_AFORO AS
      SELECT *
      FROM MOVE_IN_AL_AFORO WHERE MOVE_IN_AL_AFORO.CANT_INSTALACIONES >1 ORDER BY EINZDAT ASC;

      DROP TABLE IF EXISTS MOVE_IN_AL_AFORO;

      /*CREANDO LA TABLA QUE CONTIENE LA INFORMACI??N DE LAS INSTALACIONES ACTIVAS DE CUENTAS
      CON ALCANTARILLADO POR AFORO*/

      CREATE TABLE ACCOUNTS_AL_AFORO_TEMP AS
      SELECT MOVE_IN_AL.VERTRAG, MOVE_IN_AL.VKONTO
      FROM AC_AFORO
      LEFT OUTER JOIN MOVE_IN_AL ON AC_AFORO.VKONTO = MOVE_IN_AL.VKONTO
      WHERE MOVE_IN_AL.AUSZDAT = '99991231'
      ORDER BY AC_AFORO.EINZDAT ASC;

      /*OBTENIENDO LA INFORMACI??N DE LAS CUENTAS CON DOBLE INSTALACI??N DE ALCANTARILLADO*/
      CREATE TABLE ACCOUNTS_AL_AFORO_TEMP2 AS
      SELECT ACCOUNTS_AL_AFORO_TEMP.VERTRAG,
      AC_AFORO.VERTRAG as SEGUNDA_INSTA
      FROM ACCOUNTS_AL_AFORO_TEMP
      LEFT OUTER JOIN AC_AFORO ON ACCOUNTS_AL_AFORO_TEMP.VKONTO = AC_AFORO.VKONTO;

      /*CREANDO TABLA CON LAS CUENTAS CONTRATO CON DOBLE INSTALACI??N DE ALCANTARILLADO ACTIVA*/
      CREATE TABLE ACCOUNTS_AL_AFORO AS
      SELECT
      ACCOUNTS_AL_AFORO_TEMP2.VERTRAG,
      MOVE_IN_AL.VKONTO, MOVE_IN_AL.SPARTE,
      MOVE_IN_AL.STAGRUVER, MOVE_IN_AL.EINZDAT,
      MOVE_IN_AL.AUSZDAT, MOVE_IN_AL.ANLAGE
      FROM ACCOUNTS_AL_AFORO_TEMP2
      LEFT OUTER JOIN MOVE_IN_AL ON ACCOUNTS_AL_AFORO_TEMP2.VERTRAG = MOVE_IN_AL.VERTRAG;

      /*ELIMINANDO LA TABLA TEMPORAL QUE CREO LAS CUENTAS CON DOBLE INSTALACI??N
      DE ALCANTARILLADO ACTIVA*/
      DROP TABLE IF EXISTS AC_AFORO;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO_TEMP;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO_TEMP2;

      --CREANDO INDICES SOBRES LAS LLAVEZ QUE SE UTILIZAN PARA REALIZAR EL JOIN CON EL FIN DE INCREMENTAR EL RENDIMIENTO

      CREATE INDEX "IX_ACCOUNT_VKONT" ON "ACCOUNT" (
        "VKONT"
      );
      CREATE INDEX "IX_MOVE_IN_AC" ON "MOVE_IN_AC" (
        "VKONTO"
      );
      CREATE INDEX "IX_MOVE_IN_AL" ON "MOVE_IN_Al" (
        "VKONTO"
      );
      /*REALIZANDO LOS JOINS QUE REALIZAN LA UNI??N ENTRE LAS
      CUENTAS Y LAS ALTAS DE INSTALACION*/
      DROP TABLE IF EXISTS TB_Z_ACCOUNTS_MOVE_IN_TEMP;
      CREATE TABLE TB_Z_ACCOUNTS_MOVE_IN_TEMP AS
      SELECT 
      /*CAMPOS SEG??N LA ESTRUCTURA SUMINISTRADA
      --CAMPO 0 ACCOUNT_VKONT CUENTA CONTRATO*/
      ACCOUNT.VKONT AS ACCOUNT_VKONT,
      --CAMPO 1 ACCOUNT_VKTYP TIPO CUENTA
      ACCOUNT.VKTYP AS ACCOUNT_VKTYP,
      --CAMPO 2 ACCOUNT_VKONA CUENTA INTERNA (ANTERIOR)
      ACCOUNT.VKONA AS ACCOUNT_VKONA,
      --CAMPOR 3 ACCOUNT_REGIOGROUP_CA ESTRUCTURA REGIONAL
      ACCOUNT.REGIOGR_CA_T AS ACCOUNT_REGIOGROUP_CA,
      --CAMPO 4 ACCOUNT_KTOKL ESTRATO SOCIOECON??MICO
      ACCOUNT.KTOKL AS ACCOUNT_KTOKL,
      --CAMPO 5 ACCOUNT_KOFIZ_SD CLASE DE USO
      ACCOUNT.KOFIZ_SD AS ACCOUNT_KOFIZ_SD,
      --CAMPO 6 ACCOUNT_ABWVK COD PAGADOR COLECTIVO
      ACCOUNT.ABWVK AS ACCOUNT_ABWVK,
      --CAMPO 8 ACCOUNT_ZPORTION PORCION
      ACCOUNT.ZPORTION AS ACCOUNT_ZPORTION,
      --CAMPO 9 ACCOUNT_REGIOGROUP ESTRUCTURA REGIONAL
      ACCOUNT.REGIOGROUP AS ACCOUNT_REGIOGROUP,
      --CAMPO 15 MOVE_IN_VERTRAG_1 CONTRATO ACTUAL ACUEDUCTO
      MOVE_IN_AC.VERTRAG AS MOVE_IN_VERTRAG_1,
      --CAMPO 16 MOVE_IN_VERTRAG_2 CONTRATO ACTUAL ALCANTARILLADO
      MOVE_IN_AL.VERTRAG AS MOVE_IN_VERTRAG_2,
      --CAMPO 17 MOVE_IN_VERTRAG_3 CONTRATO ACTUAL ALCANTARILLADO POR AFORO
      ACCOUNTS_AL_AFORO.VERTRAG AS MOVE_IN_VERTRAG_3,
      --CAMPO 18 MOVE_IN_ANLAGE_1 INSTALACION ACUEDUCTO
      MOVE_IN_AC.ANLAGE AS MOVE_IN_ANLAGE_1,
      --CAMPO 19 MOVE_IN_ANLAGE_2 INSTALACION ALCANTARILLADO
      MOVE_IN_AL.ANLAGE AS MOVE_IN_ANLAGE_2,
      --CAMPO 20 MOVE_IN_ANLAGE_3 INSTALACION ALCANTARILLADO POR AFORO 
      ACCOUNTS_AL_AFORO.ANLAGE AS MOVE_IN_ANLAGE_3,
      --CAMPO 21 MOVE_IN_SPARTE_1 SECTOR INSTALACION ACUEDUCTO
      MOVE_IN_AC.SPARTE AS MOVE_IN_SPARTE_1,
      --CAMPO 22 MOVE_IN_SPARTE_2 SECTOR INSTALACION ALCANTARILLADO
      MOVE_IN_AL.SPARTE AS MOVE_IN_SPARTE_2,
      --CAMPO 23 MOVE_IN_SPARTE_3 SECTOR INSTALACION ALCANTARILLADO POR AFORO
      ACCOUNTS_AL_AFORO.SPARTE AS MOVE_IN_SPARTE_3,
      --CAMPO 24 MOVE_IN_STAGRUVER_1 GRP_ESTADISTICA ACUEDUCTO
      MOVE_IN_AC.STAGRUVER AS MOVE_IN_STAGRUVER_1,
      --CAMPO 25 MOVE_IN_STAGRUVER_2 GRP_ESTAIDSTICA ALCANTARILLADO
      MOVE_IN_AL.STAGRUVER AS MOVE_IN_STAGRUVER_2,
      --CAMPO 26 MOVE_IN_STAGRUVER_2 GRP_ESTAIDSTICA_ALCANTARILLADO POR AFORO
      ACCOUNTS_AL_AFORO.STAGRUVER AS MOVE_IN_STAGRUVER_3,
      --CAMPO 27 MOVE_IN_EINZDAT_1 FECHA DE ALTA ACUEDUCTO
      MOVE_IN_AC.EINZDAT AS MOVE_IN_EINZDAT_1,
      --CAMPO 28 MOVE_IN_EINZDAT_2 FECHA DE ALTA ALCANTARILLADO
      MOVE_IN_AL.EINZDAT AS MOVE_IN_EINZDAT_2,
      --CAMPO 29 MOVE_IN_EINZDAT_3 FECHA DE ALTA ALCANTARILLADO POR AFORO
      ACCOUNTS_AL_AFORO.EINZDAT AS MOVE_IN_EINZDAT_3,
      --CAMPO 30 MOVE_IN_AUSZDAT_1 FECHA DE BAJA ACUEDUCTO
      MOVE_IN_AC.AUSZDAT AS MOVE_IN_AUSZDAT_1,
      --CAMPO 31 MOVE_IN_AUSZDAT_2 FECHA DE BAJA ALCANTARILLADO
      MOVE_IN_AL.AUSZDAT AS MOVE_IN_AUSZDAT_2,
      --CAMPO 32 MOVE_IN_AUSZDAT_3 FECHA DE BAJA ALCANTARILLADO POR AFORO
      ACCOUNTS_AL_AFORO.AUSZDAT AS MOVE_IN_AUSZDAT_3
      FROM ACCOUNT
      /*REALIZANDO LOS CRUCES ENTRE LAS ALTAS DE INSTALACI??N Y LAS CUENTAS CONTRATO*/
      LEFT OUTER JOIN MOVE_IN_AL ON ACCOUNT.VKONT = MOVE_IN_AL.VKONTO
      LEFT OUTER JOIN MOVE_IN_AC ON ACCOUNT.VKONT = MOVE_IN_AC.VKONTO
      LEFT OUTER JOIN ACCOUNTS_AL_AFORO ON ACCOUNT.VKONT = ACCOUNTS_AL_AFORO.VKONTO;

      /*ELIMINANDO LAS INSTALACIONES DUPLICADAS PARA 
      OBTENER LOS CAMPOS CON DOBLE INSTALACI??N DE ALCANTARILLADO*/

      DELETE FROM TB_Z_ACCOUNTS_MOVE_IN_TEMP WHERE
      MOVE_IN_VERTRAG_2 == MOVE_IN_VERTRAG_3;

      /*ELIMINANDO LOS DATOS DUPLICADOS EN LA UNI??N QUE SE GENERAN POR LAS MULTIPLES INSTALACIONES ASOCIADAS
      A UNA CUENTA CONTRATO
      */
      CREATE TABLE TABLA_Z_ACCOUNTS_MOVE_IN AS 
      SELECT * FROM TB_Z_ACCOUNTS_MOVE_IN_TEMP
      GROUP BY ACCOUNT_VKONT;

      /* ELIMINANDO TABLAS TEMPORALES USADAS PARA REALIZAR EL JOIN
      ENTRE ACCOUNT Y MOVE_IN*/

      DROP TABLE IF EXISTS TB_Z_ACCOUNTS_MOVE_IN_TEMP;
      DROP TABLE IF EXISTS MOVE_IN_AC;
      DROP TABLE IF EXISTS MOVE_IN_AL;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AC;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AL;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AL_AF;

      /*
      CREANDO TABLAS PARA FACILITAR EL JOIN ENTRE LA ALTA
      DE INSTALACI??N Y LA INSTALACI??N
      */
      --ACUEDUCTO
      CREATE TABLE MOVE_IN_INSTLN_AC AS
      SELECT TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_1,
      INSTLN.SPARTE AS INSTLN_SPARTE_1,
      INSTLN.AB AS INSTLN_AB_1,
      INSTLN.BIS AS INSTLN_BIS_1,
      INSTLN.AKLASSE AS INSTLN_AKLASSE_1,
      INSTLN.TARIFTYP AS INSTLN_TARIFTYP_1,
      INSTLN.BRANCHE AS INSTLN_BRANCHE_1,
      INSTLN.ABLEINH AS INSTLN_ABLEINH_1,
      INSTLN.ANLART AS INSTLN_ANLART_1,
      INSTLN.TEMP_AREA AS INSTLN_TEMP_AREA_1,
      INSTLN.KONDIGR AS INSTLN_KONDIGR_1,
      INSTLN.TARIFART AS INSTLN_TARIFART_1
      FROM TABLA_Z_ACCOUNTS_MOVE_IN
      INNER JOIN INSTLN ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_1 = INSTLN.ANLAGE
      GROUP BY MOVE_IN_ANLAGE_1;

      --ALCANTARILLADO
      CREATE TABLE MOVE_IN_INSTLN_AL AS
      SELECT TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_2,
      INSTLN.SPARTE AS INSTLN_SPARTE_2,
      INSTLN.AB AS INSTLN_AB_2,
      INSTLN.BIS AS INSTLN_BIS_2,
      INSTLN.AKLASSE AS INSTLN_AKLASSE_2,
      INSTLN.TARIFTYP AS INSTLN_TARIFTYP_2,
      INSTLN.BRANCHE AS INSTLN_BRANCHE_2,
      INSTLN.ABLEINH AS INSTLN_ABLEINH_2,
      INSTLN.ANLART AS INSTLN_ANLART_2,
      INSTLN.TEMP_AREA AS INSTLN_TEMP_AREA_2,
      INSTLN.KONDIGR AS INSTLN_KONDIGR_2,
      INSTLN.TARIFART AS INSTLN_TARIFART_2
      FROM TABLA_Z_ACCOUNTS_MOVE_IN
      INNER JOIN INSTLN ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_2 = INSTLN.ANLAGE
      GROUP BY MOVE_IN_ANLAGE_1;

      --ALCANTARILLADO POR AFORO

      CREATE TABLE MOVE_IN_INSTLN_AL_AF AS
      SELECT TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_3,
      INSTLN.SPARTE AS INSTLN_SPARTE_3,
      INSTLN.AB AS INSTLN_AB_3,
      INSTLN.BIS AS INSTLN_BIS_3,
      INSTLN.AKLASSE AS INSTLN_AKLASSE_3,
      INSTLN.TARIFTYP AS INSTLN_TARIFTYP_3,
      INSTLN.BRANCHE AS INSTLN_BRANCHE_3,
      INSTLN.ABLEINH AS INSTLN_ABLEINH_3,
      INSTLN.ANLART AS INSTLN_ANLART_3,
      INSTLN.TEMP_AREA AS INSTLN_TEMP_AREA_3,
      INSTLN.KONDIGR AS INSTLN_KONDIGR_3,
      INSTLN.TARIFART AS INSTLN_TARIFART_3
      FROM TABLA_Z_ACCOUNTS_MOVE_IN
      INNER JOIN INSTLN ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_3 = INSTLN.ANLAGE
      GROUP BY MOVE_IN_ANLAGE_1;

      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN;

      /*REALIZANDO EL JOIN PARA CARGAR LOS DATOS DE LA INSTALACI??N A LA TABLA Z*/
      CREATE TABLE TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN AS
      SELECT 
      --SELECCIONANDO LOS CAMPOS DE TABLA Z CREADA CON ANTERIORIDAD
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_VKONT,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_VKTYP,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_VKONA,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_KTOKL,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_KOFIZ_SD,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_ABWVK,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_ZPORTION,
      TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_REGIOGROUP,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_VERTRAG_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_VERTRAG_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_VERTRAG_3,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_STAGRUVER_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_STAGRUVER_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_STAGRUVER_3,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_EINZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_EINZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_EINZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_AUSZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_AUSZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_AUSZDAT_3,
      -- CAMPO 33 SECTOR ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_SPARTE_1 AS INSTLN_SPARTE_1,
      -- CAMPO 34 SECTOR ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_SPARTE_2 AS INSTLN_SPARTE_2,
      -- CAMPO 35 SECTOR ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_SPARTE_3 AS INSTLN_SPARTE_3,
      -- CAMPO 36 INICIO VALIDEZ ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_AB_1 AS INSTLN_AB_1,
      -- CAMPO 37 INICIO VALIDEZ ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_AB_2 AS INSTLN_AB_2,
      -- CAMPO 38 INICIO VALIDEZ ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_AB_3 AS INSTLN_AB_3,
      --CAMPO 39 FIN VALIDEZ INSTALACION ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_BIS_1 AS INSTLN_BIS_1,
      --CAMPO 40 FIN VALIDEZ INSTALACION ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_BIS_2 AS INSTLN_BIS_2,
      --CAMPO 41 FIN VALIDEZ INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_BIS_3 AS INSTLN_BIS_3,
      -- CAMPO 42 CLASE DE CALCULO INSTALACI??N ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_AKLASSE_1 AS INSTLN_AKLASSE_1,
      -- CAMPO 43 CLASE DE CALCULO INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_AKLASSE_2 AS INSTLN_AKLASSE_2,
      -- CAMPO 44 CLASE DE CALCULO INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_AKLASSE_3 AS INSTLN_AKLASSE_3,
      -- CAMPO 45 CLASE DE TARIFA INSTALACI??N ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_TARIFTYP_1 AS INSTLN_TARIFTYP_1,
      --CAMPO 46 CLASE DE TARIFA INSTALACION ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_TARIFTYP_2 AS INSTLN_TARIFTYP_2,
      --CAMPO 47 CLASE DE TARIFA INSTALACION ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_TARIFTYP_3 AS INSTLN_TARIFTYP_3,
      --CAMPO 48 SOL SECTORIAL INSTALACI??N ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_BRANCHE_1 AS INSTLN_BRANCHE_1,
      --CAMPO 49 SOL SECTORIAL INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_BRANCHE_2 AS INSTLN_BRANCHE_2,
      --CAMPO 50 SOL SECTORIAL INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_BRANCHE_3 AS INSTLN_BRANCHE_3,
      -- CAMPO 51 UNIDAD DE LECTURA INSTALACION ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_ABLEINH_1 AS INSTLN_ABLEINH_1,
      -- CAMPO 52 UNIDAD DE LECTURA INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_ABLEINH_2 AS INSTLN_ABLEINH_2,
      -- CAMPO 53 UNIDAD DE LECTURA INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_ABLEINH_3 AS INSTLN_ABLEINH_3,
      -- CAMPO 54 ESTADO PUNTO DE CONSUMO ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_ANLART_1 AS INSTLN_ANLART_1,
      -- CAMPO 55 ESTADO PUNTO DE CONSUMO ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_ANLART_2 AS INSTLN_ANLART_2,
      -- CAMPO 56 ESTADO PUNTO DE CONSUMO ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_ANLART_3 AS INSTLN_ANLART_3,
      -- CAMPO 57 ZONA DE TEMPERATURA INSTALACI??N ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_TEMP_AREA_1 AS INSTLN_TEMP_AREA_1,
      -- CAMPO 58 ZONA DE TEMPERATURA INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_TEMP_AREA_2 AS INSTLN_TEMP_AREA_2,
      -- CAMPO 59 ZONA DE TEMPERATURA INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL_AF.INSTLN_TEMP_AREA_3 AS INSTLN_TEMP_AREA_3,
      -- CAMPO 60 ZONA DE TEMPERATURA INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AC.INSTLN_KONDIGR_1 AS INSTLN_KONDIGR_1,
      -- CAMPO 61 GRUPO DE VALORES CONCRETOS ACUEDUCTO
      MOVE_IN_INSTLN_AL.INSTLN_KONDIGR_2 AS INSTLN_KONDIGR_2,
      -- CAMPO 62 GRUPO DE VALORES CONCRETO ALCANTARILLADO
      MOVE_IN_INSTLN_AL_AF.INSTLN_KONDIGR_3 AS INSTLN_KONDIGR_3,
      -- CAMPO 63 TIPO DE TARIFA INSTALACI??N ACUEDUCTO
      MOVE_IN_INSTLN_AC.INSTLN_TARIFART_1 AS INSTLN_TARIFART_1,
      -- CAMPO 64 TIPO DE TARIFA INSTALACI??N ALCANTARILLADO
      MOVE_IN_INSTLN_AL.INSTLN_TARIFART_2 AS INSTLN_TARIFART_2,
      -- CAMPO 65 TIPO DE TARIFA INSTALACI??N ALCANTARILLADO POR AFORO
      MOVE_IN_INSTLN_AL_AF.INSTLN_TARIFART_3 AS INSTLN_TARIFART_3
      FROM TABLA_Z_ACCOUNTS_MOVE_IN
      LEFT OUTER JOIN MOVE_IN_INSTLN_AC ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_1 =MOVE_IN_INSTLN_AC.MOVE_IN_ANLAGE_1
      LEFT OUTER JOIN MOVE_IN_INSTLN_AL ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_2 =MOVE_IN_INSTLN_AL.MOVE_IN_ANLAGE_2
      LEFT OUTER JOIN MOVE_IN_INSTLN_AL_AF ON TABLA_Z_ACCOUNTS_MOVE_IN.MOVE_IN_ANLAGE_3 =MOVE_IN_INSTLN_AL_AF.MOVE_IN_ANLAGE_3
      GROUP BY TABLA_Z_ACCOUNTS_MOVE_IN.ACCOUNT_VKONT;

      --ELIMINANDO TABLA TEMPORAL TABLA Z JOIN ACCOUNT CON MOVE_IN
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN;
      DROP TABLE IF EXISTS PREMISE_KEY_TABLA_Z;
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY;

      --OBTENIENDO LA PK DE LA TABLA PREMISE
      CREATE TABLE TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY AS
      SELECT 
      --SELECCIONANDO CAMPOS EXISTENTES TABLA Z,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_VKONT,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_VKTYP,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_VKONA,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_KTOKL,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_KOFIZ_SD,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_ABWVK,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_ZPORTION,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_REGIOGROUP,

      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_VERTRAG_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_VERTRAG_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_VERTRAG_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_ANLAGE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_ANLAGE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_ANLAGE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_STAGRUVER_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_STAGRUVER_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_STAGRUVER_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_EINZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_EINZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_EINZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_AUSZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_AUSZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_AUSZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AB_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AB_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AB_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BIS_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BIS_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BIS_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AKLASSE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AKLASSE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_AKLASSE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFTYP_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFTYP_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFTYP_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BRANCHE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BRANCHE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_BRANCHE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ABLEINH_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ABLEINH_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ABLEINH_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ANLART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ANLART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_ANLART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TEMP_AREA_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TEMP_AREA_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TEMP_AREA_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_KONDIGR_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_KONDIGR_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_KONDIGR_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.INSTLN_TARIFART_3,
      -- CAMPO 75 PUNTO DE SUMINISTRO INSTALACI??N ACUEDUCTO
      INSTLN.VSTELLE AS PREMISE_VSTELLE
      FROM TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN
      LEFT OUTER JOIN INSTLN ON TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.MOVE_IN_ANLAGE_1 = INSTLN.ANLAGE
      GROUP BY TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN.ACCOUNT_VKONT;

      --ELIMINANDO TABLA CREADA CON ANTERIORIDAD
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE;
      -- REALIZANDO EL JOIN ENTRE ACCOUNT MOVE-IN Y PREMISE
      CREATE TABLE TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE AS
      SELECT 

      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_VKONT,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_VKTYP,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_VKONA,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_KTOKL,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_KOFIZ_SD,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_ABWVK,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_ZPORTION,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_REGIOGROUP,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_VERTRAG_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_VERTRAG_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_VERTRAG_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_ANLAGE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_ANLAGE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_ANLAGE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_STAGRUVER_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_STAGRUVER_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_STAGRUVER_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_EINZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_EINZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_EINZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_AUSZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_AUSZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.MOVE_IN_AUSZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AB_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AB_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AB_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BIS_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BIS_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BIS_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AKLASSE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AKLASSE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_AKLASSE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFTYP_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFTYP_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFTYP_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BRANCHE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BRANCHE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_BRANCHE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ABLEINH_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ABLEINH_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ABLEINH_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ANLART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ANLART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_ANLART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TEMP_AREA_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TEMP_AREA_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TEMP_AREA_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_KONDIGR_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_KONDIGR_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_KONDIGR_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.INSTLN_TARIFART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.PREMISE_VSTELLE,
      -- CAMPO 76 TIPO DE PUNTO DE CONSUMO
      PREMISE.VBSART AS PREMISE_VBSART,
      -- CAMPO 77 DATO DE AGREGACI??N
      PREMISE.HAUS_NUM2 AS PREMISE_HAUS_NUM2,
      -- CAMPO 78 UHB
      PREMISE.FLOOR AS PREMISE_FLOOR,
      -- CAMPO 79 UNH
      PREMISE.ROOMNUMBER AS PREMISE_ROOMNUMBER,
      -- CAMPO 80 NUMERO DE PERSONAS
      PREMISE.ANZPERS AS PREMISE_ANZPERS,
      -- CAMPO 81 CHIP CATASTRAL
      PREMISE.LGZUSATZ AS PREMISE_LGZUSATZ,
      -- CAMPO 82 OBJETO DE CONEXION
      PREMISE.HAUS AS CONNOBJ_HAUS
      FROM TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY
      LEFT OUTER JOIN PREMISE ON TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.PREMISE_VSTELLE = PREMISE.VSTELLE
      GROUP BY TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY.ACCOUNT_VKONT;
      --ELIMINANDO TABLAS TEMPORALES USADAS PARA REALIZAR EL JOIN
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN_PREMISE_KEY;
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_INSTLN;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AC;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AL;
      DROP TABLE IF EXISTS ACCOUNTS_AL_AFORO;
      DROP TABLE IF EXISTS MOVE_IN_INSTLN_AL_AF;
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ;

      CREATE TABLE TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ AS
      --SELECCCIONANDO LOS CAMPOS DE LA TABLA Z
      SELECT 
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_VKONT,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_VKTYP,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_VKONA,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_KTOKL,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_KOFIZ_SD,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_ABWVK,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_ZPORTION,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_REGIOGROUP,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_VERTRAG_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_VERTRAG_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_VERTRAG_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_ANLAGE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_ANLAGE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_ANLAGE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_STAGRUVER_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_STAGRUVER_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_STAGRUVER_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_EINZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_EINZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_EINZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_AUSZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_AUSZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.MOVE_IN_AUSZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AB_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AB_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AB_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BIS_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BIS_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BIS_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AKLASSE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AKLASSE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_AKLASSE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFTYP_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFTYP_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFTYP_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BRANCHE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BRANCHE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_BRANCHE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ABLEINH_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ABLEINH_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ABLEINH_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ANLART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ANLART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_ANLART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TEMP_AREA_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TEMP_AREA_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TEMP_AREA_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_KONDIGR_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_KONDIGR_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_KONDIGR_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.INSTLN_TARIFART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_VSTELLE,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_VBSART,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_HAUS_NUM2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_FLOOR,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_ROOMNUMBER,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_ANZPERS,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.PREMISE_LGZUSATZ,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.CONNOBJ_HAUS,
      --CAMPO 86 CALLE OBJETO DE CONEXI??N
      CONNOBJ.STREET AS CONNOBJ_STREET,
      --CAMPO 87 BARRIO OBJETO DE CONEXION
      CONNOBJ.REGPOLIT AS CONNOBJ_REGPOLIT,
      --CAMPO 88 ESTRUCTURA REGIONAL OBJETO DE CONEXION
      CONNOBJ.REGIOGROUP AS CONNOBJ_REGIOGROUP,
      --CAMPO 89 CENTRO DE EMPLAZAMIENTO OBJETO DE CONEXI??N
      CONNOBJ.SWERK AS CONNOBJ_SWERK,
      --CAMPO 91 SUPLEMENTO DIRECCI??N 2 OBJETO DE CONEXI??N
      CONNOBJ.STR_SUPPL2 AS CONNOBJ_STR_SUPPL2,
      --CAMPO 92 NUMERO DE PLACA
      CONNOBJ.REGPOLIT AS CONNOBJ_HOUSE_NUM1,
      --CAMPO 93 MUNICIPIO
      CONNOBJ.CITY1 AS CONNOBJ_CITY1,
      --CAMPO 94 REGI??N DEL DEPARTAMENTE
      CONNOBJ.REGION AS CONNOBJ_REGION
      FROM TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE
      LEFT OUTER JOIN CONNOBJ ON TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.CONNOBJ_HAUS = CONNOBJ.HAUS
      GROUP BY TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE.ACCOUNT_VKONT;

      --ELIMINANDO TABLA TABLA_Z_PK_PARTNER SI EXISTE
      DROP TABLE IF EXISTS TABLA_Z_PK_PARTNER;
      --OBTENIENDO LLAVE PRIMARIA DEL INTERLOCUTOR COMERCIAL
      CREATE TABLE TABLA_Z_PK_PARTNER AS
      SELECT
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_VKONT,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_VKTYP,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_VKONA,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_KTOKL,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_KOFIZ_SD,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_ABWVK,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_ZPORTION,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_REGIOGROUP,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_VERTRAG_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_VERTRAG_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_VERTRAG_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_ANLAGE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_ANLAGE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_ANLAGE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_STAGRUVER_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_STAGRUVER_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_STAGRUVER_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_EINZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_EINZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_EINZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_AUSZDAT_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_AUSZDAT_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.MOVE_IN_AUSZDAT_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_SPARTE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_SPARTE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_SPARTE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AB_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AB_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AB_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BIS_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BIS_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BIS_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AKLASSE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AKLASSE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_AKLASSE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFTYP_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFTYP_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFTYP_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BRANCHE_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BRANCHE_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_BRANCHE_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ABLEINH_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ABLEINH_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ABLEINH_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ANLART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ANLART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_ANLART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TEMP_AREA_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TEMP_AREA_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TEMP_AREA_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_KONDIGR_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_KONDIGR_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_KONDIGR_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFART_1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFART_2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.INSTLN_TARIFART_3,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_VSTELLE,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_VBSART,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_HAUS_NUM2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_FLOOR,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_ROOMNUMBER,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_ANZPERS,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.PREMISE_LGZUSATZ,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_HAUS,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_STREET,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_REGPOLIT,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_REGIOGROUP,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_SWERK,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_STR_SUPPL2,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_HOUSE_NUM1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_CITY1,
      TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.CONNOBJ_REGION,
      ACCOUNT.GPART AS PARTNER_PARTNER
      FROM TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ
      LEFT OUTER JOIN ACCOUNT ON TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_VKONT = ACCOUNT.GPART
      GROUP BY TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ.ACCOUNT_VKONT;

      --ELIMINANDO TABLAS TEMPORALES AS
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE;
      DROP TABLE IF EXISTS TABLA_Z_ACCOUNTS_MOVE_IN_PREMISE_CONNOBJ;


      /*OBTENIENDO TELEFONOS, SE BUSCA EVITAR LA PERDIDA DEL NUMERO DE TELEFONO EN EL CRUCE
      DEBIDO A QUE EN EL BORRADO DE LOS DUPLICADOS SOLO SE TOMA UN REGISTRO
      */
      DROP TABLE IF EXISTS TELEFONOS_INT_COMERCIAL;
      CREATE TABLE TELEFONOS_INT_COMERCIAL AS
      SELECT PARTNER.PARTNER, PARTNER.TEL_NUMBER
      FROM PARTNER WHERE TEL_NUMBER IS NOT NULL
      GROUP BY PARTNER
      ;

      -- ELIMINANDO DUPLICADOS INTERLOCUTOR COMERCIAL
      DROP TABLE IF EXISTS INT_COMERCIAL_UNICO;

      CREATE TABLE INT_COMERCIAL_UNICO AS
      SELECT * FROM PARTNER
      GROUP BY PARTNER.PARTNER;

      --AGREGANDO DATOS DEL INTERLOCUTOR COMERCIAL A LA TABLA Z
      DROP TABLE IF EXISTS TABLA_Z_PARTNER;
      CREATE TABLE TABLA_Z_PARTNER AS
      SELECT 
      TABLA_Z_PK_PARTNER.ACCOUNT_VKONT,
      TABLA_Z_PK_PARTNER.ACCOUNT_VKTYP,
      TABLA_Z_PK_PARTNER.ACCOUNT_VKONA,
      TABLA_Z_PK_PARTNER.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_PK_PARTNER.ACCOUNT_KTOKL,
      TABLA_Z_PK_PARTNER.ACCOUNT_KOFIZ_SD,
      TABLA_Z_PK_PARTNER.ACCOUNT_ABWVK,
      TABLA_Z_PK_PARTNER.ACCOUNT_ZPORTION,
      TABLA_Z_PK_PARTNER.ACCOUNT_REGIOGROUP,
      TABLA_Z_PK_PARTNER.MOVE_IN_VERTRAG_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_VERTRAG_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_VERTRAG_3,
      TABLA_Z_PK_PARTNER.MOVE_IN_ANLAGE_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_ANLAGE_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_ANLAGE_3,
      TABLA_Z_PK_PARTNER.MOVE_IN_SPARTE_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_SPARTE_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_SPARTE_3,
      TABLA_Z_PK_PARTNER.MOVE_IN_STAGRUVER_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_STAGRUVER_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_STAGRUVER_3,
      TABLA_Z_PK_PARTNER.MOVE_IN_EINZDAT_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_EINZDAT_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_EINZDAT_3,
      TABLA_Z_PK_PARTNER.MOVE_IN_AUSZDAT_1,
      TABLA_Z_PK_PARTNER.MOVE_IN_AUSZDAT_2,
      TABLA_Z_PK_PARTNER.MOVE_IN_AUSZDAT_3,
      TABLA_Z_PK_PARTNER.INSTLN_SPARTE_1,
      TABLA_Z_PK_PARTNER.INSTLN_SPARTE_2,
      TABLA_Z_PK_PARTNER.INSTLN_SPARTE_3,
      TABLA_Z_PK_PARTNER.INSTLN_AB_1,
      TABLA_Z_PK_PARTNER.INSTLN_AB_2,
      TABLA_Z_PK_PARTNER.INSTLN_AB_3,
      TABLA_Z_PK_PARTNER.INSTLN_BIS_1,
      TABLA_Z_PK_PARTNER.INSTLN_BIS_2,
      TABLA_Z_PK_PARTNER.INSTLN_BIS_3,
      TABLA_Z_PK_PARTNER.INSTLN_AKLASSE_1,
      TABLA_Z_PK_PARTNER.INSTLN_AKLASSE_2,
      TABLA_Z_PK_PARTNER.INSTLN_AKLASSE_3,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFTYP_1,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFTYP_2,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFTYP_3,
      TABLA_Z_PK_PARTNER.INSTLN_BRANCHE_1,
      TABLA_Z_PK_PARTNER.INSTLN_BRANCHE_2,
      TABLA_Z_PK_PARTNER.INSTLN_BRANCHE_3,
      TABLA_Z_PK_PARTNER.INSTLN_ABLEINH_1,
      TABLA_Z_PK_PARTNER.INSTLN_ABLEINH_2,
      TABLA_Z_PK_PARTNER.INSTLN_ABLEINH_3,
      TABLA_Z_PK_PARTNER.INSTLN_ANLART_1,
      TABLA_Z_PK_PARTNER.INSTLN_ANLART_2,
      TABLA_Z_PK_PARTNER.INSTLN_ANLART_3,
      TABLA_Z_PK_PARTNER.INSTLN_TEMP_AREA_1,
      TABLA_Z_PK_PARTNER.INSTLN_TEMP_AREA_2,
      TABLA_Z_PK_PARTNER.INSTLN_TEMP_AREA_3,
      TABLA_Z_PK_PARTNER.INSTLN_KONDIGR_1,
      TABLA_Z_PK_PARTNER.INSTLN_KONDIGR_2,
      TABLA_Z_PK_PARTNER.INSTLN_KONDIGR_3,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFART_1,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFART_2,
      TABLA_Z_PK_PARTNER.INSTLN_TARIFART_3,
      TABLA_Z_PK_PARTNER.PREMISE_VSTELLE,
      TABLA_Z_PK_PARTNER.PREMISE_VBSART,
      TABLA_Z_PK_PARTNER.PREMISE_HAUS_NUM2,
      TABLA_Z_PK_PARTNER.PREMISE_FLOOR,
      TABLA_Z_PK_PARTNER.PREMISE_ROOMNUMBER,
      TABLA_Z_PK_PARTNER.PREMISE_ANZPERS,
      TABLA_Z_PK_PARTNER.PREMISE_LGZUSATZ,
      TABLA_Z_PK_PARTNER.CONNOBJ_HAUS,
      TABLA_Z_PK_PARTNER.CONNOBJ_STREET,
      TABLA_Z_PK_PARTNER.CONNOBJ_REGPOLIT,
      TABLA_Z_PK_PARTNER.CONNOBJ_REGIOGROUP,
      TABLA_Z_PK_PARTNER.CONNOBJ_SWERK,
      TABLA_Z_PK_PARTNER.CONNOBJ_STR_SUPPL2,
      TABLA_Z_PK_PARTNER.CONNOBJ_HOUSE_NUM1,
      TABLA_Z_PK_PARTNER.CONNOBJ_CITY1,
      TABLA_Z_PK_PARTNER.CONNOBJ_REGION,
      TABLA_Z_PK_PARTNER.PARTNER_PARTNER,
      INT_COMERCIAL_UNICO.NAME_ORG1 AS PARTNER_NAME_ORG1,
      INT_COMERCIAL_UNICO.BU_SORT1 AS PARTNER_BUSORT1,
      TELEFONOS_INT_COMERCIAL.TEL_NUMBER AS PARTNER_TEL_NUMBER,
      INT_COMERCIAL_UNICO.NAME_FIRST AS PARTNER_NAME_FIRST,
      INT_COMERCIAL_UNICO.NAME_LAST AS PARTNER_NAME_LSAT
      FROM TABLA_Z_PK_PARTNER
      LEFT OUTER JOIN INT_COMERCIAL_UNICO ON TABLA_Z_PK_PARTNER.PARTNER_PARTNER = INT_COMERCIAL_UNICO.PARTNER
      LEFT OUTER JOIN TELEFONOS_INT_COMERCIAL ON TABLA_Z_PK_PARTNER.PARTNER_PARTNER = TELEFONOS_INT_COMERCIAL.PARTNER
      GROUP BY TABLA_Z_PK_PARTNER.ACCOUNT_VKONT;

      --ELIMINANDO TABLAS TEMPORALES
      DROP TABLE IF EXISTS TABLA_Z_PK_PARTNER;
      DROP TABLE IF EXISTS INT_COMERCIAL_UNICO;
      DROP TABLE IF EXISTS TELEFONOS_INT_COMERCIAL;

      --REALIZANDO UNI??N ENTRE LA TABLA_Z_PARTNER Y DEVICE
      DROP TABLE IF EXISTS TABLA_Z;
      CREATE TABLE TABLA_Z AS
      SELECT
      TABLA_Z_PARTNER.ACCOUNT_VKONT,
      TABLA_Z_PARTNER.ACCOUNT_VKTYP,
      TABLA_Z_PARTNER.ACCOUNT_VKONA,
      TABLA_Z_PARTNER.ACCOUNT_REGIOGROUP_CA,
      TABLA_Z_PARTNER.ACCOUNT_KTOKL,
      TABLA_Z_PARTNER.ACCOUNT_KOFIZ_SD,
      TABLA_Z_PARTNER.ACCOUNT_ABWVK,
      TABLA_Z_PARTNER.ACCOUNT_ZPORTION,
      TABLA_Z_PARTNER.ACCOUNT_REGIOGROUP,
      TABLA_Z_PARTNER.MOVE_IN_VERTRAG_1,
      TABLA_Z_PARTNER.MOVE_IN_VERTRAG_2,
      TABLA_Z_PARTNER.MOVE_IN_VERTRAG_3,
      TABLA_Z_PARTNER.MOVE_IN_ANLAGE_1,
      TABLA_Z_PARTNER.MOVE_IN_ANLAGE_2,
      TABLA_Z_PARTNER.MOVE_IN_ANLAGE_3,
      TABLA_Z_PARTNER.MOVE_IN_SPARTE_1,
      TABLA_Z_PARTNER.MOVE_IN_SPARTE_2,
      TABLA_Z_PARTNER.MOVE_IN_SPARTE_3,
      TABLA_Z_PARTNER.MOVE_IN_STAGRUVER_1,
      TABLA_Z_PARTNER.MOVE_IN_STAGRUVER_2,
      TABLA_Z_PARTNER.MOVE_IN_STAGRUVER_3,
      TABLA_Z_PARTNER.MOVE_IN_EINZDAT_1,
      TABLA_Z_PARTNER.MOVE_IN_EINZDAT_2,
      TABLA_Z_PARTNER.MOVE_IN_EINZDAT_3,
      TABLA_Z_PARTNER.MOVE_IN_AUSZDAT_1,
      TABLA_Z_PARTNER.MOVE_IN_AUSZDAT_2,
      TABLA_Z_PARTNER.MOVE_IN_AUSZDAT_3,
      TABLA_Z_PARTNER.INSTLN_SPARTE_1,
      TABLA_Z_PARTNER.INSTLN_SPARTE_2,
      TABLA_Z_PARTNER.INSTLN_SPARTE_3,
      TABLA_Z_PARTNER.INSTLN_AB_1,
      TABLA_Z_PARTNER.INSTLN_AB_2,
      TABLA_Z_PARTNER.INSTLN_AB_3,
      TABLA_Z_PARTNER.INSTLN_BIS_1,
      TABLA_Z_PARTNER.INSTLN_BIS_2,
      TABLA_Z_PARTNER.INSTLN_BIS_3,
      TABLA_Z_PARTNER.INSTLN_AKLASSE_1,
      TABLA_Z_PARTNER.INSTLN_AKLASSE_2,
      TABLA_Z_PARTNER.INSTLN_AKLASSE_3,
      TABLA_Z_PARTNER.INSTLN_TARIFTYP_1,
      TABLA_Z_PARTNER.INSTLN_TARIFTYP_2,
      TABLA_Z_PARTNER.INSTLN_TARIFTYP_3,
      TABLA_Z_PARTNER.INSTLN_BRANCHE_1,
      TABLA_Z_PARTNER.INSTLN_BRANCHE_2,
      TABLA_Z_PARTNER.INSTLN_BRANCHE_3,
      TABLA_Z_PARTNER.INSTLN_ABLEINH_1,
      TABLA_Z_PARTNER.INSTLN_ABLEINH_2,
      TABLA_Z_PARTNER.INSTLN_ABLEINH_3,
      TABLA_Z_PARTNER.INSTLN_ANLART_1,
      TABLA_Z_PARTNER.INSTLN_ANLART_2,
      TABLA_Z_PARTNER.INSTLN_ANLART_3,
      TABLA_Z_PARTNER.INSTLN_TEMP_AREA_1,
      TABLA_Z_PARTNER.INSTLN_TEMP_AREA_2,
      TABLA_Z_PARTNER.INSTLN_TEMP_AREA_3,
      TABLA_Z_PARTNER.INSTLN_KONDIGR_1,
      TABLA_Z_PARTNER.INSTLN_KONDIGR_2,
      TABLA_Z_PARTNER.INSTLN_KONDIGR_3,
      TABLA_Z_PARTNER.INSTLN_TARIFART_1,
      TABLA_Z_PARTNER.INSTLN_TARIFART_2,
      TABLA_Z_PARTNER.INSTLN_TARIFART_3,
      TABLA_Z_PARTNER.PREMISE_VSTELLE,
      TABLA_Z_PARTNER.PREMISE_VBSART,
      TABLA_Z_PARTNER.PREMISE_HAUS_NUM2,
      TABLA_Z_PARTNER.PREMISE_FLOOR,
      TABLA_Z_PARTNER.PREMISE_ROOMNUMBER,
      TABLA_Z_PARTNER.PREMISE_ANZPERS,
      TABLA_Z_PARTNER.PREMISE_LGZUSATZ,
      TABLA_Z_PARTNER.CONNOBJ_HAUS,
      TABLA_Z_PARTNER.CONNOBJ_STREET,
      TABLA_Z_PARTNER.CONNOBJ_REGPOLIT,
      TABLA_Z_PARTNER.CONNOBJ_REGIOGROUP,
      TABLA_Z_PARTNER.CONNOBJ_SWERK,
      TABLA_Z_PARTNER.CONNOBJ_STR_SUPPL2,
      TABLA_Z_PARTNER.CONNOBJ_HOUSE_NUM1,
      TABLA_Z_PARTNER.CONNOBJ_CITY1,
      TABLA_Z_PARTNER.CONNOBJ_REGION,
      TABLA_Z_PARTNER.PARTNER_PARTNER,
      TABLA_Z_PARTNER.PARTNER_NAME_ORG1,
      TABLA_Z_PARTNER.PARTNER_BUSORT1,
      TABLA_Z_PARTNER.PARTNER_TEL_NUMBER,
      TABLA_Z_PARTNER.PARTNER_NAME_FIRST,
      TABLA_Z_PARTNER.PARTNER_NAME_LSAT,
      DEVICE.EQUNR AS DEVICE_EQUNR,
      DEVICE.HERST AS DEVICE_HERST,
      DEVICE.MATNR AS DEVICE_MATNR,
      DEVICE.ILOAN AS DEVICE_ILOAN,
      DEVICE.SERNR AS DEVICE_SERNR,
      DEVICE.STTXT AS DEVICE_STTXT
      FROM TABLA_Z_PARTNER
      LEFT OUTER JOIN DEVICE ON TABLA_Z_PARTNER.PREMISE_VSTELLE = DEVICE.VSTELLE
      GROUP BY TABLA_Z_PARTNER.ACCOUNT_VKONT;

      DROP TABLE IF EXISTS TABLA_Z_PARTNER;


      COMMIT;
      ''');
  }

  //Cargar datos SPOOL Vigencia actual
  Future<void> guardarDatosVigenciaActual(
      List<String> datosVigenciaActual) async {
    //Funciones Generales Tabla z
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //contador
    int i = 0;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();

    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS VIGENCIA01;
      CREATE TABLE VIGENCIA01 (
        ZZCTACONTR,
        ZZDIRENVIO,
        ZZDIAMEDID,
        ZZLECACTUAL,
        ZZLECANTERI,
        ZZULTCONSUMO,
        ZZCODULTCONS,
        ZZCNSPROMHIST,
        ZZINDINQUILIN,
        ZZMESMORA,
        ZZVLRTER,
        IND_FRADIG,
        ZZTELEFONO,
        ZZCORREO
      );
    ''');
    final insertDataVigencia01 = db.prepare('''
    INSERT INTO VIGENCIA01 (
        ZZCTACONTR,
        ZZDIRENVIO,
        ZZDIAMEDID,
        ZZLECACTUAL,
        ZZLECANTERI,
        ZZULTCONSUMO,
        ZZCODULTCONS,
        ZZCNSPROMHIST,
        ZZINDINQUILIN,
        ZZMESMORA,
        ZZVLRTER,
        IND_FRADIG,
        ZZTELEFONO,
        ZZCORREO
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)        
    ''');
    for (i; i <= datosVigenciaActual.length - 1; i++) {
      String linea = datosVigenciaActual[i];
      SpoolVigenciaActual vigenciaACT = fz.dataSpoolActual(linea);
      insertDataVigencia01.execute([
        vigenciaACT.ZZCTACONTR,
        vigenciaACT.ZZDIRENVIO,
        vigenciaACT.ZZDIAMEDID,
        vigenciaACT.ZZLECACTUAL,
        vigenciaACT.ZZLECANTERI,
        vigenciaACT.ZZULTCONSUMO,
        vigenciaACT.ZZCODULTCONS,
        vigenciaACT.ZZCNSPROMHIST,
        vigenciaACT.ZZINDINQUILIN,
        vigenciaACT.ZZMESMORA,
        vigenciaACT.ZZVLRTER,
        vigenciaACT.IND_FRADIG,
        vigenciaACT.ZZTELEFONO,
        vigenciaACT.ZZCORREO
      ]);
    }
    insertDataVigencia01.dispose();
    db.execute('''
    COMMIT;
    ''');
  }

  Future<void> guardarDatosVigenciasAnteriores(SpoolDataTable dataSpool) async {
    //Funciones Generales Tabla z
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //contador
    int i = 0;
    //Database
    DatabaseClass dbTBZ = DatabaseClass();
    Database db = await dbTBZ.getDatabase();
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS ${dataSpool.nombreTabla};
      CREATE TABLE ${dataSpool.nombreTabla}(
        ZZCTACONTR,
        ZZULTCONSUMO,
        ZZCODULTCONS
      );
    ''');
    final insertDataVigenciaAnterior = db.prepare('''
    INSERT INTO ${dataSpool.nombreTabla} (
        ZZCTACONTR,
        ZZULTCONSUMO,
        ZZCODULTCONS
        ) VALUES (?,?,?)        
    ''');
    for (i; i <= dataSpool.dataSpool.length - 1; i++) {
      String linea = dataSpool.dataSpool[i];
      SpoolVigenciasAnteriores vigenciaANT = fz.dataSpolAnterior(linea);
      insertDataVigenciaAnterior.execute([
        vigenciaANT.ZZCTACONTR,
        vigenciaANT.ZZULTCONSUMO,
        vigenciaANT.ZZCODULTCONS
      ]);
    }
    insertDataVigenciaAnterior.dispose();
    db.execute('''
    COMMIT;
    ''');
  }
}
