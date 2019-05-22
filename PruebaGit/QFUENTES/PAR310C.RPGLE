000100000904     H decedit(',') datedit(*dmy/)
000200040824     H actgrp(*caller) dftactgrp(*no)
000300101229     H option(*nodebugio)
000400020620     H copyright('© AXA Todos los derechos reservados')
000500000904     ?*****************************************************************
000600000904     ?*  PAR310C : CABECERA DE SUPERPOLIZAS                           *
000700000904     ?*          : MODULO DE PRODUCCION POR ARTICULOS                 *
000800000904     ?*                                                               *
000900000904     ?*  FECHA   : 06/12/96                                           *
001000000904     ?*  AUTOR   : ALEJANDRO RODRIGUEZ                                *
001100000904     ?*                              (C) COPYRIGHT COLINET-TROTTA SRL *
001200031126     ?*****************************************************************
001300031126     ?*                   M O D I F I C A C I O N E S                 *
001400031126     ?* AHR 17/09/98: Cambio significado del campo c1cocp ahora es
001500031126     ?* operaciòn garantizada si o no para proceso de debitros zonales
001600031126     ?* AHR 17/09/98: agrego f4 para tarjetas de credito...
001700031126     ?* AHR 18/09/98: Pongo control de recibos/solicitudes duplicadas
001800031126     ?* AHR 28/09/98: pongo mensaje de aviso de que cuando es forma
001900031126     ?* de pago 4 y si no hay contado informado, la operacion debería
002000031126     ?* estar garantizada...
002100031126     ?* HDT 06/10/98: Corrigo validación recibos. Deshabilito el CR1.
002200031126     ?* MAV 15/03/99: Incorpora Vida Entera y Temporario.
002300031126     ?* HDT 05/04/99: Monotributo.
002400031126     ?* HDT 30/03/00: Tipo cuenta libre.
002500031126     ?* HDT 05/04/00: Mal hecho lo anterior.
002600031126     ?* HDT 07/04/00: Incorporo NI8.
002700031126     ?*               Administración CBU.
002800031126     ?* HDT 26/05/00: Permitir tipo cuenta banco en cero.
002900031126     ?* MAV 27/06/00: Agrega permite cambio de cadena.
003000031126     ?* MAV 28/06/00: Ultimo programa por ahora es cambio de cadena.
003100031126     ?* HDT 23/08/00 -Validar CBU/CTA según PARM MA34.
003200031126     ?*              -Validar tipo cta.bco.contra BCT. Hacerlo an-
003300031126     ?*               tes de validar cuenta.                             *PAR350
003400031126     ?*              -Foma pago 4 no rebotaba legajo.
003500031126     ?* HDT 25/09/00 -Redenomino campos del 320.
003600031126     ?*              -Entonces, el MA34 del 320 pasa a ser $ZMA34.
003700031126     ?* MAV 11/04/01: Agrega bloqueo de cotización de emisión, este
003800031126     ?* control se activa con MA41 y funciona con el indicador 19...
003900031126     ?* NWN 28/01/02: Arreglo de Cambio cotización de emisión
004000031126     ?*               Ver sentencias (NWN01)
004100031126     ?* NWN 17/02/02: Agrego cambios por Salud...
004200031126     ?*               Ver sentencias (NWN02)
004300031126     ?* NWN 05/03/02: Agrego llamada a programa PRO320R
004400031126     ?*               Ver sentencias (NWN03)
004500031126     ?* NWN 19/07/02: Agrego Archivo GNHDTC y controlo que
004600031126     ?*               la Tarjeta no este Bloqueada
004700031126     ?* NWN 09/09/02: Fuerzo Marca de Refacturación para Artículo 1003
004800031126     ?* NWN 07/03/03: Agrego Archivo GNHDCB y controlo que la cuenta
004900031126     ?*               bancaria no este Bloqueada
005000031126     ?* NWN 05/08/03: Controlo que Tanto Tarjeta De Credito como Cuenta
005100031126     ?*               Bancaria no este Bloqueadas con la letra 'T'.
005200031126     ?* SLU 26.11.2003   - Recompilamos por campo SOLICITUD en PAWPC0
005300040120     ?* SLU 20/01/04   -Para determinar si forzar o no la marca de Refactu-
005400040120     ?*               ración automática, se chequea la T@MA47 y por si
005500040120     ?*               se fuerza dicha marca en la pantalla.
005600040120     ?* SLU 20/01/2004 -Si este programa es llamado desde Speedway (Web)
005700040120     ?*               protege los campos de pantalla y toma los valores que
005800040120     ?*               le llegan desde el llamador y realiza la lógic normal
005900040120     ?*               como si el usuario hubiese seleccionado los valores para
006000040120     ?*               los mismos.
006100040202     ?* NWN 28/01/04  Se agrega control sobre Tarjeta de Credito y Debíto
006200040202     ?*               en Cuenta. No se chequeaba por la existencia de las
006300040202     ?*               Tarjetas o las Cuentas Bancarias.-
006400040416     ?* SLU 16/04/2005 -Graba nuevo archivo de control para función "Ir a..."
006500040416     ?*               que salta a los distintos pasos de emisión.
006600040426     ?* SLU 26/04/2004 -Para Speedway V1 se protegen campos por *IN07.
006700040426     ?*               En esta etapa Asegurado y Forma de Pago.
006800040426     ?* SGF 26/04/2004 - SP0052. La llamo con Tipo de cambio Vendedor.
006900040715     ?* NWN-NWN 15/07/04 -Se Desafecta Responsable no Inscripto.
007000040715     ?*                   A partir de 21/07/2004 no corre mas.
007100040721     ?*                   Se agrega validación sobre campo X1CIVA.
007200040818     ?* SLU 18/08/2004 - Debe respetarse el Productor, así como el asegurado
007300040817     ?*               que llega desde Speedway.
007400040818     ?*                - El Cobrador debe ser igual al Productor si la forma
007500040818     ?*               de Pago es 4 "Cobradores Comunes".
007600040824     ?* SLU 24/08/2004 - Cuando se trata de una renovación hay que respetar la
007700040824     ?*               fecha desde del Speedway si lo llaman desde allí, en caso
007800040824     ?*               contrario, se sigue la lógica normal.
007900040824     ?*               La fecha Hasta, encaso de las Renovaciones SPDWY
008000040824     ?*               hay que recalcularla según lo normal para este
008100040824     ?*               movimiento.
008200040902     ?* SLU 02/08/2004 - Corrección PTF20040824. Faltaba IF condicionando
008300040902     ?*               el uso del recalculo de fechas para Speedway cuando
008400040902     ?*               era una Renovación.
008500041022     ?* SLU 22/10/2004 - Sólo en el caso de Vida se exije la fecha de
008600041022     ?*               nacimiento del asegurado en otros riesgos hacerlo
008700041022     ?*               entorpece la emisión.
008800041025     ?* SGF 07/10/2004 - Se graba Nro. de R.U.T.A. del asegurado en EC1.
008900041025     ?*                  Se recupera desde SEHASE.
009000050119     ?* SGF 19/01/2005 - Solo daba error cuando fecha de vigencia desde era
009100050119     ?*                  mayor a vigencia hasta, con lo cual permitía emitir
009200050119     ?*                  pólizas con vigencia desde igual a vigencia hasta,
009300050119     ?*                  provocando que dicha póliza no esté vigente ni
009400050119     ?*                  siquiera un día. Se muestra mensaje de error.
009500050119     ?*                  Validación cruzada entre dupe y vig.hasta. Si dupe
009600050119     ?*                  es 99, vig.hasta debe ser 99/99/9999 y viceversa.
009700050121     ?* SGF 21/01/2005 - Mal la PTF SGF19012005. Solo debe validarse dupe<->
009800050121     ?*                  vigencia hasta en nuevas/renovaciones.
009900050418     ?*  SGF 18/04/2005 - Recompilo por cambio de formato en EC1/ED0.          *
010000090202     ?* NWN 02/02/2009 - No se tiene que controlar nada por tiso = 81.-        *
010100100716     ?*  SGF 15/07/2010 - Anulaciones por Falta de Pago se controla en         *
010200100716     ?*                   SPANXFP para permitir usarse en Interface.           *
010300100906     ?*  SGF 09/10/2010 - No funcionaba la carga de asegurados adicionales     *
010400100907     ?*                   en Endosos y/o Renovación. Si funcionaba cuando      *
010500100907     ?*                   se retomaba suspendida. Le faltaba un SETLL por      *
010600100907     ?*                   lo tanto NUNCA funcionó (tampoco nunca se usó).      *
010700100907     ?*                   Corrijo dicha situación.                             *
010800101229     ?*  NWN 29/12/2010 - Agregado de Validaciones por Arranque de Vida        *
010900101229     ?*                   Obligatorio.
011000110131     ?*  NWN 01/02/2011 - Formas de pago 1,2 y 3 invalidas para Vida           *
011100110131     ?*                   Obligatorio.
011200110623     ?*  NWN 23/06/2011 - Se deshabilita PTF NWN01022011 para Vida             *
011300110623     ?*                   Obligatorio. Solo la parte de validacion
011400110623     ?*                   de Forma de Pago.
011500140603     ?*  SGF 03/06/2014 - Grabo mensaje como "ya listado" por ahorro de        *
011600140603     ?*                   papel.
011700140826      *
011800140826      *  SMA 26/08/2014 - Por pedido 3634 se agrega el uso de
011900140826      * T@MA52 para Condicion de IVA en las renovaciones de AP
012000140826      * '0' = Respetar Condición de IVA de póliza anterior
012100140826      * '1' = Refrescar desde el asegurado
012200140826      * Este cambio afecta solo a las renovaciones.
012300140826      *
012400140905     ?*  SGF 05/09/2014 - La validación del bloqueo de asegurado estaba         *
012500140905     ?*                   prendiendo el indicador equivocado.                   *
012600140905     ?*                   Prendía el 51 lo cual hacía que en pantalla se        *
012700140905     ?*                   mostrara el mensaje "Asegurado inexistente"           *
012800140905     ?*                   confundiendo al emisor.                               *
012900141021     ?* SFA 21/10/14- Valida que Persona Jurídica no puede ser
013000141021     ?*               consumidor final.
013100141107      *  MLA 07/11/2014 - se agrega el uso de T@MA52 para Condicion de IVA
013200141107      *                   para los endosos de AP
013300150810     ?* NWN 10/08/15- Recompilación por cambio de mensaje en pantalla
013400150810     ?*               indicador 91.-
013500150810     ?*               También se agrega prefix a SET901.
013600101229     ?*
013700000904     ?*****************************************************************
013800000904     Fpar310cm  cf   e             workstn usropn
013900000904     F                                     sfile(par310s1:sf1rrn)
014000000904     F                                     sfile(par310s2:sf2rrn)
014100000904     Fset630    if   e           k disk
014200000904     Fset605    if   e           k disk
014300000904     Fset902    uf   e           k disk
014400150810     Fset901    if   e           k disk    prefix(xx:2)
014500000904     Fpawpc0    uf   e           k disk
014600000904     Fpawpd0    uf a e           k disk
014700040416     Fpawp310   uf a e           k disk
014800000904     Fpahec0    uf a e           k disk
014900000904     Fpahec1    uf a e           k disk
015000000904     Fpahec4    uf a e           k disk
015100000904     Fpahec5    uf a e           k disk
015200020206NWN  Fpahec6    uf a e           k disk
015300000904     Fpahec2    uf   e           k disk
015400000904     Fpahcp0    uf   e           k disk
015500000904     Fpahed0    if   e           k disk
015600000904     Fpahed003  if   e           k disk
015700010314     Fpahec017  if   e           k disk
015800000904     Fgntmon    if   e           k disk
015900000904     Fgnhdaf    if   e           k disk
016000000904     Fgnhda1    if   e           k disk
016100000904     Fsehni1    if   e           k disk
016200000904     Fset620    if   e           k disk
016300000904     Fset621    if   e           k disk
016400000904     Fset12003  if   e           k disk
016500000904     ?*AHCR1  IF  E           K        DISK
016600000904     Fpahcr002  if   e           k disk
016700000904     Fsehase01  if   e           k disk
016800000904     Fsehni201  if   e           k disk
016900000904     Fsehni301  if   e           k disk
017000000904     Fsehni4    if   e           k disk
017100000904     Fsehni8    if   e           k disk
017200000904     Fgnttc101  if   e           k disk
017300000904     Fcntbco    if   e           k disk
017400000904     Fcntbcs    if   e           k disk
017500000904     Fcntbct    if   e           k disk                                         PAR350
017600041022     Fset001    if   e           k disk    prefix(t01_:2)
017700000904     Fset320    if   e           k disk
017800040715     Fgntiv1    if   e           k disk
017900000904     Fset6119   if   e           k disk
018000010314     Fpahmsg    uf a e           k disk
018100020719     Fgnhdtc    if   e           k disk
018200030307     Fgnhdcb    if   e           k disk
018300040120     ?******************************************************************
018400040120     ?* *ENTRY -> Se usa área de comunicación ILE para el uso de paráme*
018500040120     ?*           tros condicionales.                                  *
018600040120     ?*  empr : Empresa                                                *
018700040120     ?*  sucu : Sucursal.                                              *
018800040120     ?*  arcd : Artículo.                                              *
018900040120     ?*  spo1 : Superpóliza nueva.                                     *
019000040120     ?*  spol : Superpóliza Anterior.                                  *
019100040120     ?*  sspo : Suplemento de Superpóliza.                             *
019200040120     ?*  mand : Mandato con el que se llamó al programa.               *
019300040120     ?*  epgm : Finalización del Programa.                             *
019400040120     ?*  con_param : *ON -> Se llamó al troncal con parámetros externos*
019500040120     ?*                     (p.ej. Speedway)                           *
019600040120     ?*              *OFF -> Emisión estándar.                         *
019700040120     ?*  nivc : Código de Productor.                                   *
019800040120     ?*  asen : Código Asegurado.                                      *
019900040120     ?*  fvde : Fecha de Vigencia Desde del Movimiento.                *
020000040120     ?*  fpro : Fecha Propuesta.                                       *
020100040120     ?*                                                                *
020200040120     ?******************************************************************
020300040120     Dpar310c          pr                  extpgm('PAR310C')
020400040120     D empr                                like(w0empr)
020500040120     D sucu                                like(w0sucu)
020600040120     D arcd                                like(w0arcd)
020700040120     D spo1                                like(w0spo1)
020800040120     D spol                                like(w0spol)
020900040120     D sspo                                like(w0sspo)
021000040120     D mand                           2
021100040120     D epgm                           3
021200040120     D con_parm                       1n   options(*nopass)
021300040120     D nivc                                like(c1nivc) options(*nopass)
021400040120     D asen                                like(c1asen) options(*nopass)
021500040120     D fvde                           8  0 options(*nopass)
021600040120     D fpro                           8  0 options(*nopass)
021700040120
021800040120     Dpar310c          pi
021900040120     D @@empr                              like(w0empr)
022000040120     D @@sucu                              like(w0sucu)
022100040120     D @@arcd                              like(w0arcd)
022200040120     D @@spo1                              like(w0spo1)
022300040120     D @@spol                              like(w0spol)
022400040120     D @@sspo                              like(w0sspo)
022500040120     D @@mand                         2
022600040120     D endpgm                         3
022700040120     D con_parm                       1n   options(*nopass)
022800040120     D p@nivc                              like(c1nivc) options(*nopass)
022900040120     D p@asen                              like(c1asen) options(*nopass)
023000040120     D p@fvde                         8  0 options(*nopass)
023100040120     D p@fpro                         8  0 options(*nopass)
023200040824     ?******************************************************************
023300040824     ?* Procedure name: fecha_hasta
023400040824     ?* Purpose:        Calcular la fecha hasta según parámetros. Base fech...
023500040824     ?*                          a Desde recibida.
023600040824     ?* Returns:        Fecha Hasta calculada.
023700040824     ?* Parameter:      fh_desde => Fecha desde DDMMAAAA
023800040824     ?* Parameter:      fh_mar5 => Contenido de la variable X!MAR5
023900040824     ?* Parameter:      fh_dupe => Duración del perodo base para calculo.
024000040824     ?* Parameter:      fh_asen => Asegurado a chequear
024100040824     ?*--------------------------------------------------
024200040824     D fecha_hasta     pr                  like(x1desd)
024300040824     D  fh_desde                           like(x1desd)
024400040824     D  fh_mar5                            like(x1mar5)
024500040824     D  fh_dupe                            like(x1dupe)
024600040824     D  fh_asen                            like(x1asen)
024700040120     ?******************************************************************
024800041022     D* Prototype for procedure: es_vida
024900041022     P* Purpose:        Determina Rama de Vida
025000041022     P* Returns:        Es o no vida
025100041022     P* Parameter:      pr_rama => Rama a chequear.
025200041022
025300041022     D es_vida         PR             1N
025400041022     D pr_rama                             LIKE(d0rama)
025500041022     ?******************************************************************
025600000904     D nc              s              5  0 dim(10)                              NIVELES
025700000904     D wrk             s              1    dim(25)                              TRABAJO
025800000904     D wr1             s              1    dim(20)                              TRABAJO
025900000904     D wr2             s              1    dim(35)                              TRABAJO
026000000904     D wr3             s              1    dim(7)                               TRABAJO
026100000904     D num             s              1    dim(5)                               TRABAJO
026200000904     D @di             s              1    dim(10) ctdata perrcd(10)            DIGITOS
026300000904     D com             s              5  0 dim(10)                              COASEGURO
026400000904     D ase             s             47    dim(20)                              TRABAJO
026500000904     ?*- INICIALIZAR CONSTANTES...
026600000904     D $$c001          c                   const('RESPONSABLE INSCRIP.')
026700000904     D $$c002          c                   const('RESP. NO INSCRIPTO  ')
026800000904     D $$c003          c                   const('NO RESPONSABLE      ')
026900000904     D $$c004          c                   const('EXENTO              ')
027000000904     D $$c005          c                   const('CONSUMIDOR FINAL    ')
027100000904     D $$c006          c                   const('MONOTRIBUTO         ')
027200000904     D $$c007          c                   const('NO CATEGORIZADO     ')
027300000904     ?*- INICIALIZAR CONSTANTES...
027400000904     D $$si            c                   const('SI**')
027500000904     D $$no            c                   const('NO**')
027600000904     ?*- INICIALIZAR CONSTANTES...
027700000904     D $$d001          c                   const('DEBITO AUTOMATICO   ')
027800000904     D $$d002          c                   const('TARJETA CUPONES     ')
027900000904     ?*- INICIALIZAR CONSTANTES...
028000000904     D $$e001          c                   const('TARJETA DEB.AUTOMAT.')
028100000904     D $$e002          c                   const('BANCO CTA.CTE.      ')
028200000904     D $$e003          c                   const('BANCO CAJA AHORROS  ')
028300000904     D $$e004          c                   const('COBRADORES COMUNES  ')
028400000904     D $$e005          c                   const('COBRADORES MUTUALES ')
028500000904     D $$e006          c                   const('CONTADO/CHEQUEADO***')
028600000904     D $$e007          c                   const('TARJETA CUPON TOTAL ')
028700010314     ?*- INICIALIZAR CONSTANTES...
028800010314     D $$q001          c                   const('PAR312X   ')
028900010314     D $$q002          c                   const('SE EMITIO OPERACION -
029000010314     D                                     PARA UN ASEGURADO QU-
029100010314     D                                     E TIENE ANULACIONES -
029200010314     D                                     POR FALTA DE PAGO***-
029300010314     D                                     ********************-
029400010314     D                                     ********************')
029500000904     ?*- EDICION DE CAMPOS NUMERICOS...
029600000904     D                 ds
029700000904     D  p@0170                 1     70
029800000904     D  p@0120                 1     20
029900000904     D  p@2145                21     45
030000000904     D  p@4670                46     70
030100000904     ?*- EDICION NUMERO DE CUIT...
030200000904     D                 ds
030300000904     D  dfcuit                01     11
030400000904     D  c@0102                01     02
030500000904     D  c@0310                03     10
030600000904     D  c@1111                11     11
030700000904     D                 ds
030800000904     D  x1cuit                01     13
030900000904     D  d@0102                01     02
031000000904     D  d@0303                03     03
031100000904     D  d@0411                04     11
031200000904     D  d@1212                12     12
031300000904     D  d@1313                13     13
031400000904     ?*- AGRUPACION DIA-MES-AÑO EN UN SOLO CAMPO...
031500000904     D                 ds
031600000904     D  p@fdma                01     08  0
031700000904     D  p@fdia                01     02  0
031800000904     D  p@fmes                03     04  0
031900000904     D  p@faÑo                05     08  0
032000000904     ?*- AGRUPACION AÑO-MES-DIA EN UN SOLO CAMPO...
032100000904     D                 ds
032200000904     D  p@famd                01     08  0
032300000904     D  p@1aÑo                01     04  0
032400000904     D  p@1mes                05     06  0
032500000904     D  p@1dia                07     08  0
032600020123     ?*- AGRUPACION AÑO-MES-DIA EN UN SOLO CAMPO...
032700020123     D                 ds
032800020123     D  @@fech                01     08  0
032900020123     D  @@femd                01     02  0
033000020123     D  @@femm                03     04  0
033100020123     D  @@fema                05     08  0
033200101228     ?*- AGRUPACION DIA-MES-AÑO - COMPARACION DIA VIDA OBLIGATORIO...
033300101228     D                 ds
033400101228     D  p1fdma                01     08  0
033500101228     D  p1fdia                01     02  0
033600101228     D  p1fmes                03     04  0
033700101228     D  p1faÑo                05     08  0
033800101229     ?*- AGRUPACION AÑO-MES-DIA - COMPARACION DIA VIDA OBLIGATORIO...
033900101229     D                 ds
034000101229     D  p2famd                01     08  0
034100101229     D  p2faÑo                01     04  0
034200101229     D  p2fmes                05     06  0
034300101229     D  p2fdia                07     08  0
034400000904     ?*- PARAMETROS PARA 'SPFECH'...
034500000904     D p@fech          ds
034600000904     D  p@flap                01     05  0
034700000904     D  p@ffec                06     13  0
034800040120     ?*- Renombremos indicadores para uso en lógica...
034900040120     ?* Tabla de Indicadores. Nombramos Indicadores.                     *
035000040120     ?* Renombra Indicadores. -------------------------------------------*
035100040120     D puntinds        s               *   inz(%addr(*in))
035200040120     D                 ds                  based(puntinds)
035300040426     D spdwy_v1               07     07n
035400040426     D por_parametros         08     08n
035500000904     ?*- AREA DEL PROGRAMA...
035600000904     D                sds
035700000904     D  vsuser               254    263
035800101227     ?*- Area de datos local...
035900101229     Dcontrol_Vida    uds                  dtaara(dtactlvid1)
036000101229     D  ctlvida_fecha          1      8  0
036100101229     D  ctlvida_nropo          9     15  0
036200000904     ?*- AREA LOCAL DE DATOS...
036300000904     D                uds
036400000904     D  usempr               401    401
036500000904     D  ussucu               402    403
036600020620     ?* Campos Independientes
036700020719     D $$asen          s                   like(x1asen)
036800020719     D $$cbrn          s                   like(x1cbrn)
036900020719     D $$ccuo          s                   like(x1ccuo)
037000020719     D $$cfpg          s                   like(x1cfpg)
037100020719     D $$civa          s                   like(x1civa)
037200020719     D $$cmas          s                   like(x1cmas)
037300020719     D $$cobn          s                   like(x1cobn)
037400020719     D $$cocp          s                   like(x1cocp)
037500020719     D $$come          s                   like(x1come)
037600020719     D $$conr          s                   like(x1conr)
037700020719     D $$ctcu          s                   like(x1ctcu)
037800020719     D $$czco          s                   like(x1czco)
037900020719     D $$desd          s                   like(x1desd)
038000020719     D $$dupe          s                   like(x1dupe)
038100020719     D $$fing          s                   like(x1fing)
038200020719     D $$fvto          s                   like(x1fvto)
038300020719     D $$hast          s                   like(x1hast)
038400020719     D $$ivbc          s                   like(x1ivbc)
038500020719     D $$ivsu          s                   like(x1ivsu)
038600020719     D $$mone          s                   like(x1mone)
038700020719     D $$ncre          s                   like(x1ncre)
038800020719     D $$ncta          s                   like(x1ncta)
038900020719     D $$nic1          s                   like(x1nic1)
039000020719     D $$nit1          s                   like(x1nit1)
039100020719     D $$nivc          s                   like(x1nivc)
039200020719     D $$nivt          s                   like(x1nivt)
039300020719     D $$nrct          s                   like(x1nrct)
039400020719     D $$nrla          s                   like(x1nrla)
039500020719     D $$nrln          s                   like(x1nrln)
039600020719     D $$nrtc          s                   like(x1nrtc)
039700020719     D $$opag          s                   like(x1opag)
039800020719     D $$paas          s                   like(x1paas)
039900020719     D $$paco          s                   like(x1paco)
040000020719     D $$pmas          s                   like(x1pmas)
040100020719     D $$sarc          s                   like(x1sarc)
040200020719     D $$soln          s                   like(x1soln)
040300020719     D $$strg          s                   like(x1strg)
040400020719     D $$tcta          s                   like(x1tcta)
040500020719     D $$wcoa          s                   like(x1wcoa)
040600020719     D $0sspo          s                   like(x0sspo)
040700020719     D $3nivc          s                   like(x3nivc)
040800020719     D $3nivt          s                   like(x3nivt)
040900020719     D $5asen          s                   like(xxasen)
041000020719     D $5niv1          s                   like(x5niv1)
041100020719     D $5niv2          s                   like(x5niv2)
041200020719     D $5niv3          s                   like(x5niv3)
041300020719     D $5niv4          s                   like(x5niv4)
041400020719     D $5niv5          s                   like(x5niv5)
041500020719     D $5niv6          s                   like(x5niv6)
041600020719     D $5niv7          s                   like(x5niv7)
041700020719     D $5niv8          s                   like(x5niv8)
041800020719     D $5niv9          s                   like(x5niv9)
041900020719     D @@asen          s                   like(x1asen)
042000020719     D @@c             s              5  0
042100020719     D @@cfpg          s                   like(c1cfpg)
042200020719     D @@ciap          s              1
042300020719     D @@cobn          s                   like(x1cobn)
042400020719     D @@conr          s              6  0
042500020719     D @@desd          s                   like(x1desd)
042600020719     D @@in33          s              1  0
042700020719     D @@in91          s              1  0
042800020719     D @@mar2          s              1
042900020719     D @@ma05          s              1
043000020719     D @@ma16          s              1
043100020719     D @@ma23          s              1
043200020719     D @@ma24          s              1
043300020719     D @@ma29          s              1
043400020719     D @@ma30          s              1
043500020719     D @@ma40          s              1
043600020719     D @@ma41          s              1
043700040426     D @@ma44          s              1
043800040120     D @@ma47          s              1
043900020719     D @@nic1          s                   like(x5nivc)
044000020719     D @@nivc          s                   like(c1nivc)
044100020719     D @@nivt          s                   like(c1nivt)
044200020719     D @@niv1          s                   like(x5nivt)
044300020719     D @@nom1          s                   like(x5nom1)
044400020719     D @@oper          s                   like(z0oper)
044500020719     D @@part          s              3  0
044600020719     D @@suop          s                   like(z0suop)
044700020719     D @@t             s              1  0
044800020719     D @@x             s              6  0
044900020719     D @cd             s              2  0
045000020719     D @e              s              2  0
045100020719     D @w              s              9  0
045200021031     D wwempr          s                   like(c1empr)
045300021031     D wwsucu          s                   like(c1sucu)
045400021031     D wwarcd          s                   like(c1arcd)
045500021031     D wwspol          s                   like(c1spol)
045600021031     D wwsspo          s                   like(c1sspo)
045700021031     D @1asen          s                   like(x1asen)
045800020719     D @1desd          s                   like(x1desd)
045900020719     D @1nivc          s                   like(c1nivc)
046000020719     D @1nivt          s                   like(c1nivt)
046100020719     D @1sspo          s                   like(w0sspo)
046200020719     D @2asen          s                   like(x1asen)
046300020719     D @2desd          s                   like(x1desd)
046400020719     D @2hast          s                   like(x1hast)
046500020719     D @3asen          s                   like(x1asen)
046600020719     D @3desd          s                   like(x1desd)
046700020719     D @4asen          s                   like(x1asen)
046800020719     D @4desd          s                   like(x1desd)
046900020719     D @5asen          s                   like(x1asen)
047000020719     D sf1rrn          s              9  0
047100020719     D sf2rrn          s              9  0
047200020719     D x               s              9  0
047300020719     D xxiden          s              1  0
047400020719     D y               s              9  0
047500100712     D @@sino          s               n
047600000904     ?*****************************************************************
047700000904      /SPACE
047800000904     ?*****************************************************************
047900020719     ?* Reserva campos de archivos para no confundir con 630.
048000020719     Is1t320
048100000928     I              t@fea1                      $zfea1
048200000928     I              t@fem1                      $zfem1
048300000928     I              t@fea2                      $zfea2
048400000928     I              t@fem2                      $zfem2
048500000928     I              t@fed2                      $zfed2
048600000928     I              t@fea3                      $zfea3
048700000928     I              t@fem3                      $zfem3
048800000928     I              t@fed3                      $zfed3
048900000928     I              t@fea4                      $zfea4
049000000928     I              t@fem4                      $zfem4
049100000928     I              t@fed4                      $zfed4
049200000928     I              t@fea5                      $zfea5
049300000928     I              t@fem5                      $zfem5
049400000928     I              t@fed5                      $zfed5
049500000928     I              t@ma01                      $zma01
049600000928     I              t@ma02                      $zma02
049700000928     I              t@ma03                      $zma03
049800000928     I              t@ma04                      $zma04
049900000928     I              t@ma05                      $zma05
050000000928     I              t@ma06                      $zma06
050100000928     I              t@ma07                      $zma07
050200000928     I              t@ma08                      $zma08
050300000928     I              t@ma09                      $zma09
050400000928     I              t@ma10                      $zma10
050500000928     I              t@ma11                      $zma11
050600000928     I              t@ma12                      $zma12
050700000928     I              t@ma13                      $zma13
050800000928     I              t@ma14                      $zma14
050900000928     I              t@ma15                      $zma15
051000000928     I              t@ma16                      $zma16
051100000928     I              t@ma17                      $zma17
051200000928     I              t@ma18                      $zma18
051300000928     I              t@ma19                      $zma19
051400000928     I              t@ma20                      $zma20
051500000928     I              t@ma21                      $zma21
051600000928     I              t@ma22                      $zma22
051700000928     I              t@ma23                      $zma23
051800000928     I              t@ma24                      $zma24
051900000928     I              t@ma25                      $zma25
052000000928     I              t@ma26                      $zma26
052100000928     I              t@ma27                      $zma27
052200000928     I              t@ma28                      $zma28
052300000928     I              t@ma29                      $zma29
052400000928     I              t@ma30                      $zma30
052500000928     I              t@ma31                      $zma31
052600000928     I              t@ma32                      $zma32
052700000928     I              t@ma33                      $zma33
052800000928     I              t@ma34                      $zma34
052900000928     I              t@ma35                      $zma35
053000000928     I              t@ma36                      $zma36
053100000928     I              t@ma37                      $zma37
053200000928     I              t@ma38                      $zma38
053300000928     I              t@ma39                      $zma39
053400000928     I              t@ma40                      $zma40
053500000928     I              t@ma41                      $zma41
053600000928     I              t@ma42                      $zma42
053700000928     I              t@ma43                      $zma43
053800000928     I              t@ma44                      $zma44
053900000928     I              t@ma45                      $zma45
054000000928     I              t@ma46                      $zma46
054100000928     I              t@ma47                      $zma47
054200000928     I              t@ma48                      $zma48
054300000928     I              t@ma49                      $zma49
054400000928     I              t@ma50                      $zma50
054500000928     I              t@pg01                      $zpg01
054600000928     I              t@pg02                      $zpg02
054700000928     I              t@pg03                      $zpg03
054800000928     I              t@pg04                      $zpg04
054900000928     I              t@pg05                      $zpg05
055000000928     I              t@pg06                      $zpg06
055100000928     I              t@pg07                      $zpg07
055200000928     I              t@pg08                      $zpg08
055300000928     I              t@pg09                      $zpg09
055400000928     I              t@pg10                      $zpg10
055500000928     I              t@pg11                      $zpg11
055600000928     I              t@pg12                      $zpg12
055700000928     I              t@pg13                      $zpg13
055800000928     I              t@pg14                      $zpg14
055900000928     I              t@pg15                      $zpg15
056000000928     I              t@pg16                      $zpg16
056100000928     I              t@pg17                      $zpg17
056200000928     I              t@pg18                      $zpg18
056300000928     I              t@pg19                      $zpg19
056400000928     I              t@pg20                      $zpg20
056500000928     I              t@pr01                      $zpr01
056600000928     I              t@pr02                      $zpr02
056700000928     I              t@pr03                      $zpr03
056800000928     I              t@pr04                      $zpr04
056900000928     I              t@pr05                      $zpr05
057000000928     I              t@pr06                      $zpr06
057100000928     I              t@pr07                      $zpr07
057200000928     I              t@pr08                      $zpr08
057300000928     I              t@pr09                      $zpr09
057400000928     I              t@pr10                      $zpr10
057500000928     I              t@po01                      $zpo01
057600000928     I              t@po02                      $zpo02
057700000928     I              t@po03                      $zpo03
057800000928     I              t@po04                      $zpo04
057900000928     I              t@po05                      $zpo05
058000000928     I              t@nrc1                      $znrc1
058100000928     I              t@com1                      $zcom1
058200000928     I              t@nrm1                      $znrm1
058300000928     I              t@esm1                      $zesm1
058400000928     I              t@nrc2                      $znrc2
058500000928     I              t@com2                      $zcom2
058600000928     I              t@nrm2                      $znrm2
058700000928     I              t@esm2                      $zesm2
058800000928     I              t@nrc3                      $znrc3
058900000928     I              t@com3                      $zcom3
059000000928     I              t@nrm3                      $znrm3
059100000928     I              t@esm3                      $zesm3
059200000928     I              t@op01                      $zop01
059300000928     I              t@op02                      $zop02
059400000928     I              t@op03                      $zop03
059500000928     I              t@op04                      $zop04
059600000928     I              t@op05                      $zop05
059700000928     I              t@su01                      $zsu01
059800000928     I              t@su02                      $zsu02
059900000928     I              t@su03                      $zsu03
060000000928     I              t@su04                      $zsu04
060100000928     I              t@su15                      $zsu15
060200000928     I              t@co01                      $zco01
060300000928     I              t@co02                      $zco02
060400000928     I              t@co03                      $zco03
060500000928     I              t@co04                      $zco04
060600000928     I              t@co05                      $zco05
060700000928     I              t@co06                      $zco06
060800000928     I              t@co07                      $zco07
060900000928     I              t@co08                      $zco08
061000000928     I              t@co09                      $zco09
061100000928     I              t@co10                      $zco10
061200000928     I              t@no01                      $zno01
061300000928     I              t@no02                      $zno02
061400000928     I              t@no03                      $zno03
061500000928     I              t@di01                      $zdi01
061600000928     I              t@di02                      $zdi02
061700000928     I              t@di03                      $zdi03
061800000928     I              t@di04                      $zdi04
061900000928     I              t@di05                      $zdi05
062000000928     I              t@com9                      $zcom9
062100000928     I              t@tic9                      $ztic9
062200000928     I              t@lib9                      $zlib9
062300000928     I              t@arc9                      $zarc9
062400000928     I              t@spo9                      $zspo9
062500000928     I              t@ram9                      $zram9
062600000928     I              t@nrc9                      $znrc9
062700000928     I              t@tio9                      $ztio9
062800000928     I              t@sto9                      $zsto9
062900000928     I              t@sts9                      $zsts9
063000000928     I              t@imc9                      $zimc9
063100000928     I              t@pla9                      $zpla9
063200000928     I              t@nco9                      $znco9
063300000928     I              t@cfp9                      $zcfp9
063400000928     I              t@dup9                      $zdup9
063500000928     I              t@nrr9                      $znrr9
063600000904     ?*-
063700000904     ?*****************************************************************
063800020719     ?*- PROCESO TRONCAL-----------------------------------
063900020719?1b? C                   select                                                 ?P----------01
064000020719     ?*- SALIDA DEL PROGRAMA RETRN-------------------------                     ?            |
064100020719?1x? C                   when      endpgm = *blanks                             ?w----------01
064200020719     C                   open      par310cm                                     ?            |
064300020719     C                   exsr      inicio                                       ?            |
064400020719?2b? C                   dou       *inkc                                        ?P---------02|
064500020719?3b? C     xxiden        caseq     0             pant00                         ?P--------03||
064600020719     C     xxiden        caseq     1             pant01                         ?          |||
064700020719     C     xxiden        caseq     2             pant02                         ?          |||
064800020719     C     xxiden        caseq     3             pant03                         ?          |||
064900020719     C     xxiden        caseq     4             pant04                         ?          |||
065000020719     C     xxiden        caseq     5             pant05                         ?          |||
065100020719?3e? C                   endcs                                                  ?F--------03||
065200020719?2e? C                   enddo                                                  ?F---------02|
065300020719     ?*- CICLO DEL PROGRAMA COMPLEMENTARIO-----------------                     ?            |
065400020719?2b? C                   if        @@mand = 'KA'                                ?P---------02|
065500020719     C                   exsr      pant06                                       ?           ||
065600020719?2e? C                   endif                                                  ?F---------02|
065700020719     ?*- GRABAR MENSAJES DE AUDITORIA----------------------                     ?            |
065800020719?2b? C                   if        @@in91 > *zeros                              ?P---------02|
065900020719     C                   exsr      gramsg                                       ?           ||
066000020719?2x? C                   else                                                   ?X.........02|
066100020719     C                   exsr      bormsg                                       ?           ||
066200020719?2e? C                   endif                                                  ?F---------02|
066300020719     ?*- CERRAR Y SALIR------------------------------------                     ?            |
066400020719     C                   close     par310cm                                     ?            |
066500020719     C                   return                                                 ?            |
066600020719     ?*- SALIDA DEL PROGRAMA CON LAST RECORD---------------                     ?            |
066700020719?1x? C                   when      endpgm = 'FIN'                               ?w----------01
066800020719     C                   exsr      srclos                                       ?            |
066900020719     C                   seton                                            lr    ?            |
067000020719?1e? C                   endsl                                                  ?F----------01
067100000904     ?******************************************************
067200020719     C     inicio        begsr
067300020719     ?** INICIO DE PROGRAMA -------------------------------
067400020719     ?*- DEFINICION DE CAMPOS...
067500020719     ?*- DEFINICIONES GENERALES...
067600020719     C                   eval      sf1rrn = *zeros
067700020719     C                   eval      sf2rrn = *zeros
067800020719     C                   eval      @@conr = *zeros
067900020719     ?*- BORRATINA DE VARIABLES INTERNAS...
068000020719     C                   clear                   @@desd
068100020719     C                   clear                   @1desd
068200020719     C                   clear                   @2desd
068300020719     C                   clear                   @2hast
068400020719     C                   clear                   @@asen
068500020719     C                   clear                   @1asen
068600020719     C                   clear                   @2asen
068700020719     C                   clear                   @3asen
068800020719     C                   clear                   @4asen
068900020719     C                   clear                   @@oper
069000020719     C                   clear                   @@suop
069100020719     C                   clear                   @@nivt
069200020719     C                   clear                   @@nivc
069300020719     C                   clear                   @@cfpg
069400020719     ?*- CAMPOS DE PANTALLA 00...
069500020719     ?*- CAMPOS DE PANTALLA 01...
069600020719     ?*- CAMPOS DE PANTALLA 03...
069700020719     ?*- CAMPOS DE PANTALLA 05...
069800020719     ?*- CAMPOS DE PANTALLA 05...
069900020719     ?*- APAGAR TODOS LOS INDICADORES...
070000020719     C                   eval      x = *zeros
070100020719?1b? C                   dou       x = 99                                       ?P----------01
070200020719     C                   add       1             x                              ?            |
070300020719     C                   eval      *in(x) = '0'                                 ?            |
070400020719?1e? C                   enddo                                                  ?F----------01
070500020719     ?*- LIMPIAR PANTALLA COMPLETA...
070600020719     C                   clear                   par31001
070700020719     ?*- DEFINICION DE CLAVES P/ACCESO A ARCHIVOS ...
070800020719     ?*- PAHMSG...
070900020719     C     k1@msg        klist
071000020719     C                   kfld                    msempr
071100020719     C                   kfld                    mssucu
071200020719     C                   kfld                    msarcd
071300020719     C                   kfld                    msspol
071400020719     C                   kfld                    mssspo
071500020719     C                   kfld                    msrama
071600020719     C                   kfld                    msarse
071700020719     C                   kfld                    msoper
071800020719     C                   kfld                    mssuop
071900141114     ?*- SET901...
072000141114     C     k1t901        klist
072100141118     C                   kfld                    w0tiou
072200141118     C                   kfld                    w0stou
072300141114     ?*- SET120...
072400141114     C     k1t120        klist
072500141114     C                   kfld                    usempr
072600141114     C                   kfld                    ussucu
072700141114     C                   kfld                    z0ncoc
072800020719     C     k2t120        klist
072900020719     C                   kfld                    usempr
073000020719     C                   kfld                    ussucu
073100020719     C                   kfld                    x2ncoc
073200020719     C     k3t120        klist
073300020719     C                   kfld                    usempr
073400020719     C                   kfld                    ussucu
073500020719     ?*- SET620...
073600020719     C     k1t620        klist
073700020719     C                   kfld                    @@arcd
073800020719     ?*- SET630...
073900020719     C     k1t630        klist
074000020719     C                   kfld                    @@arcd
074100020719     ?*- SET605...
074200020719     C     k1t605        klist
074300020719     C                   kfld                    @@arcd
074400020719     C                   kfld                    x1sarc
074500020719     ?*- SET621...
074600020719     C     k1t621        klist
074700020719     C                   kfld                    @@arcd
074800020719     ?*- CNTBCO...
074900020719     C     k1tbco        klist
075000020719     C                   kfld                    x1ivbc
075100020719     ?*- CNTBCS...
075200020719     C     k1tbcs        klist
075300020719     C                   kfld                    x1ivbc
075400020719     C                   kfld                    x1ivsu
075500020719     ?*- CNTBCT...
075600020719     C     k1tbct        klist
075700020719     C                   kfld                    x1ivbc
075800020719     C                   kfld                    x1tcta
075900020719     ?*- SET320...
076000020719     C     k1@320        klist
076100020719     C                   kfld                    usempr
076200020719     C                   kfld                    ussucu
076300020719     ?*- SET6119..
076400020719     C     k1t611        klist
076500020719     C                   kfld                    usempr
076600020719     C                   kfld                    ussucu
076700020719     C                   kfld                    x1nit1
076800020719     C                   kfld                    x1nic1
076900020719     C                   kfld                    @@arcd
077000020719     C                   kfld                    x1mone
077100020719     C                   kfld                    w0tiou
077200020719     C                   kfld                    w0stou
077300020719     C     k2t611        klist
077400020719     C                   kfld                    usempr
077500020719     C                   kfld                    ussucu
077600020719     C                   kfld                    x1nit1
077700020719     C                   kfld                    x1nic1
077800020719     C                   kfld                    @@arcd
077900020719     C                   kfld                    x1mone
078000020719     C                   kfld                    w0tiou
078100020719     ?*- PAHCR0...
078200020719     C     k1@cr0        klist
078300020719     C                   kfld                    usempr
078400020719     C                   kfld                    ussucu
078500020719     C                   kfld                    @@conr
078600020719     C     k2@cr0        klist
078700020719     C                   kfld                    usempr
078800020719     C                   kfld                    ussucu
078900020719     ?*- PAHEC0...
079000020719     C     k1@ec0        klist
079100020719     C                   kfld                    @@empr
079200020719     C                   kfld                    @@sucu
079300020719     C                   kfld                    @@arcd
079400020719     C                   kfld                    @@spol
079500020719     C     k2@ec0        klist
079600020719     C                   kfld                    @@empr
079700020719     C                   kfld                    @@sucu
079800020719     C                   kfld                    @@arcd
079900020719     C                   kfld                    @@spo1
080000020719     ?*- PAHEC1...
080100020719     C     k1@ec1        klist
080200020719     C                   kfld                    @@empr
080300020719     C                   kfld                    @@sucu
080400020719     C                   kfld                    @@arcd
080500020719     C                   kfld                    @@spol
080600020719     C                   kfld                    @@sspo
080700020719     C     k2@ec1        klist
080800020719     C                   kfld                    @@empr
080900020719     C                   kfld                    @@sucu
081000020719     C                   kfld                    @@arcd
081100020719     C                   kfld                    @@spo1
081200020719     C     k3@ec1        klist
081300020719     C                   kfld                    @@empr
081400020719     C                   kfld                    @@sucu
081500020719     C                   kfld                    @@arcd
081600020719     C                   kfld                    @@spol
081700020719     C                   kfld                    x0sspo
081800021031     C     keyec1        klist
081900021031     C                   kfld                    d0empr
082000021031     C                   kfld                    d0sucu
082100021031     C                   kfld                    d0arcd
082200021031     C                   kfld                    d0spol
082300021031     C                   kfld                    d0sspo
082400021031     C     k1yec1        klist
082500021031     C                   kfld                    wwempr
082600021031     C                   kfld                    wwsucu
082700021031     C                   kfld                    wwarcd
082800021031     C                   kfld                    wwspol
082900021031     C                   kfld                    wwsspo
083000020719     ?*- PAHEC4...
083100020719     C     k1@ec4        klist
083200020719     C                   kfld                    @@empr
083300020719     C                   kfld                    @@sucu
083400020719     C                   kfld                    @@arcd
083500020719     C                   kfld                    @@spol
083600020719     C                   kfld                    @@sspo
083700020719     C     k2@ec4        klist
083800020719     C                   kfld                    c1empr
083900020719     C                   kfld                    c1sucu
084000020719     C                   kfld                    c1arcd
084100020719     C                   kfld                    c1spol
084200020719     C                   kfld                    c1sspo
084300020719     ?*- PAHEC5...
084400020719     C     k1@ec5        klist
084500020719     C                   kfld                    @@empr
084600020719     C                   kfld                    @@sucu
084700020719     C                   kfld                    @@arcd
084800020719     C                   kfld                    @@spol
084900020719     C                   kfld                    @@sspo
085000020719     C     k2@ec5        klist
085100020719     C                   kfld                    c1empr
085200020719     C                   kfld                    c1sucu
085300020719     C                   kfld                    c1arcd
085400020719     C                   kfld                    c1spol
085500020719     C                   kfld                    c1sspo
085600020719     ?*- PAHEC6...
085700020719     C     k1@ec6        klist
085800020719     C                   kfld                    @@empr
085900020719     C                   kfld                    @@sucu
086000020719     C                   kfld                    @@arcd
086100020719     C                   kfld                    @@spol
086200020719     C                   kfld                    @@sspo
086300020719     ?*- PAHCP0...
086400020719     C     k1@cp0        klist
086500020719     C                   kfld                    @@empr
086600020719     C                   kfld                    @@sucu
086700020719     C                   kfld                    x1cobn
086800020719     C     k2@cp0        klist
086900020719     C                   kfld                    c4empr
087000020719     C                   kfld                    c4sucu
087100020719     C                   kfld                    c4cobn
087200020719     ?*- PAHED0...
087300020719     C     k1@ed0        klist
087400020719     C                   kfld                    z0empr
087500020719     C                   kfld                    z0sucu
087600020719     C                   kfld                    z0arcd
087700020719     C                   kfld                    z0spol
087800020719     C                   kfld                    z0sspo
087900020719     C                   kfld                    z0rama
088000020719     C                   kfld                    z0arse
088100020719     C     k2@ed0        klist
088200020719     C                   kfld                    c1empr
088300020719     C                   kfld                    c1sucu
088400020719     C                   kfld                    c1arcd
088500020719     C                   kfld                    c1spol
088600020719     C                   kfld                    c1sspo
088700020719     C     k3@ed0        klist
088800020719     C                   kfld                    z0empr
088900020719     C                   kfld                    z0sucu
089000020719     C                   kfld                    z0arcd
089100020719     C                   kfld                    z0spol
089200020719     C                   kfld                    @1sspo
089300020719     C                   kfld                    z0rama
089400020719     C                   kfld                    z0arse
089500020719     C     k4@ed0        klist
089600020719     C                   kfld                    w0empr
089700020719     C                   kfld                    w0sucu
089800020719     C                   kfld                    w0arcd
089900020719     C                   kfld                    w0spo1
090000020719     ?*- PAWPC0...
090100020719     C     k1@pc0        klist
090200020719     C                   kfld                    @@empr
090300020719     C                   kfld                    @@sucu
090400020719     C                   kfld                    @@arcd
090500020719     C                   kfld                    @@spo1
090600020719     ?*- PAWPD0...
090700020719     C     k1@pd0        klist
090800020719     C                   kfld                    z0empr
090900020719     C                   kfld                    z0sucu
091000020719     C                   kfld                    z0arcd
091100020719     C                   kfld                    z0spo1
091200020719     C                   kfld                    z0spol
091300020719     C                   kfld                    z0sspo
091400020719     C                   kfld                    z0rama
091500020719     C                   kfld                    z0arse
091600020719     C                   kfld                    z0oper
091700020719     C                   kfld                    z0suop
091800020719     C     k2@pd0        klist
091900020719     C                   kfld                    @@empr
092000020719     C                   kfld                    @@sucu
092100020719     C                   kfld                    @@arcd
092200020719     C                   kfld                    @@spo1
092300020719     C                   kfld                    @@spol
092400020719     C                   kfld                    @@sspo
092500020719     C     k3@pd0        klist
092600020719     C                   kfld                    z0empr
092700020719     C                   kfld                    z0sucu
092800020719     C                   kfld                    z0arcd
092900020719     C                   kfld                    z0spo1
093000020719     C                   kfld                    z0spol
093100020719     C                   kfld                    z0sspo
093200020719     C                   kfld                    z0rama
093300020719     C                   kfld                    z0arse
093400020719     ?*- SEHNI1...
093500020719     C     k1@ni1        klist
093600020719     C                   kfld                    usempr
093700020719     C                   kfld                    ussucu
093800020719     C                   kfld                    x1nivt
093900020719     ?*- SEHNI2...
094000020719     C     k1@ni2        klist
094100020719     C                   kfld                    usempr
094200020719     C                   kfld                    ussucu
094300020719     C                   kfld                    x1nivt
094400020719     C                   kfld                    x1nivc
094500020719     C     k2@ni2        klist
094600020719     C                   kfld                    usempr
094700020719     C                   kfld                    ussucu
094800020719     C                   kfld                    @@t
094900020719     C                   kfld                    @@c
095000020719     C     k3@ni2        klist
095100020719     C                   kfld                    usempr
095200020719     C                   kfld                    ussucu
095300020719     C                   kfld                    x3nivt
095400020719     C                   kfld                    x3nivc
095500020719     C     k4@ni2        klist
095600020719     C                   kfld                    usempr
095700020719     C                   kfld                    ussucu
095800020719     C                   kfld                    x1nit1
095900020719     C                   kfld                    x1nic1
096000020719     C     k5@ni2        klist
096100020719     C                   kfld                    usempr
096200020719     C                   kfld                    ussucu
096300020719     C                   kfld                    @@niv1
096400020719     C                   kfld                    @@nic1
096500020719     ?*- SEHNI3...
096600020719     C     k1@ni3        klist
096700020719     C                   kfld                    usempr
096800020719     C                   kfld                    ussucu
096900020719     C                   kfld                    x1cbrn
097000020719     ?*- SEHNI4...
097100020719     C     k1@ni4        klist
097200020719     C                   kfld                    usempr
097300020719     C                   kfld                    ussucu
097400020719     C                   kfld                    x1cbrn
097500020719     C                   kfld                    x1czco
097600020719     C                   kfld                    x1mone
097700020719     ?*- SEHNI8...
097800020719     C     k1@ni8        klist
097900020719     C                   kfld                    usempr
098000020719     C                   kfld                    ussucu
098100020719     C                   kfld                    x1opag
098200020719     ?*- GNHDTC...
098300030307     C     k1@dcb        klist
098400020719     C                   kfld                    x1asen
098500040202     C     k2@dcb        klist
098600040202     C                   kfld                    x1asen
098700040202     C                   kfld                    x1ivbc
098800040202     C                   kfld                    x1ivsu
098900040202     C                   kfld                    x1tcta
099000040202     C                   kfld                    x1ncta
099100030307     ?*- GNHDTC...
099200030307     C     k1@dtc        klist
099300030307     C                   kfld                    x1asen
099400030307     C                   kfld                    x1ctcu
099500030307     C                   kfld                    x1nrtc
099600020719     ?*- BUSCAR REGISTRO DE PARAMETROS COBRANZA...
099700020719     C     k1@320        chain     s1t320                             20
099800020719     ?*- BUSCAR REGISTRO DE OPERACION SUSPENDIDA...
099900020719     C     k1@pc0        chain(n)  p1wpc0                             20
100000040120
100100020719     ?*- BUSCAR REGISTRO DEL ARTICULO...
100200020719     C     k1t620        chain     s1t620                             20
100300020719     C  n20              eval      @@mar2 = t@mar2
100400020719     ?*- BUSCAR REGISTRO DEL CONFIGURACION DEL ARTICULO...
100500040120     C     k1t630        chain     s1t630
100600040120?1b? C                   if        %found                                       ?P----------01
100700040120     C                   eval      @@ma05 = t@ma05                              ?            |
100800040120     C                   eval      @@ma16 = t@ma16                              ?            |
100900040120     C                   eval      @@ma23 = t@ma23                              ?            |
101000040120     C                   eval      @@ma24 = t@ma24                              ?            |
101100040120     C                   eval      @@ma29 = t@ma29                              ?            |
101200040120     C                   eval      @@ma30 = t@ma30                              ?            |
101300040120     C                   eval      @@ma40 = t@ma40                              ?            |
101400040120     C                   eval      @@ma41 = t@ma41                              ?            |
101500040426     C                   eval      @@ma44 = t@ma44                              ?            |
101600040120     C                   eval      @@ma47 = t@ma47                              ?            |
101700040120?1e? C                   endif                                                  ?F----------01
101800020719     ?*- PROTEJER TARJETA DE CREDITO/BANCO...
101900020719     C                   setoff                                       23
102000020719     C     @@ma24        comp      '1'                                    23
102100020719     ?*- PARA EMITIR PANTALLA 0...
102200040120     ?* Chequeo de emisión por parámetros (Speedway, etc.)
102300040120?1b? C                   if        %parms > 8                                   ?P----------01
102400040120     C                   eval      por_parametros = con_parm                    ?            |
102500040120?1e? C                   endif                                                  ?F----------01
102600040426     ?* Chequeo de Speedway V1.
102700040426     C                   eval      spdwy_v1 = (@@ma44 = '1')
102800040426
102900020719     C                   exsr      borr01
103000020719     C                   exsr      carg01
103100020719     C                   exsr      apag01
103200020719     ?*- NOMBRE DE EMPRESA/SUCURSAL...
103300020719     C                   call      'SP0000'
103400020719     C                   parm                    @@emsu           80
103500020719     C                   eval      xxemsu = @@emsu
103600101227     ?*- Leemos area de Datos Vida Obligatorio...
103700101229     C                   in        control_vida
103800101229     C                   unlock    control_vida
103900020719     ?*-
104000020719     C                   endsr
104100000904     ?******************************************************
104200020719     C     pant00        begsr
104300020719     ?** PROCESO PANTALLA '0' -----------------------------
104400020719     ?*- ENTRADA/SALIDA PANTALLA '0' ...
104500020719     C                   exfmt     par31000
104600020719     ?*- CORRIGE SITUACIONES DE ERROR ...
104700020719     C                   exsr      apagar
104800020719     ?*- PROCESA TECLAS DE FUNCION...
104900020719?1b? C                   select                                                 ?P----------01
105000020719     ?*- F3=SALIR...                                                            ?            |
105100020719?1x? C                   when      *inkc                                        ?w----------01
105200020719     C                   eval      @@mand = 'KC'                                ?            |
105300020719     ?*- F4=SOLICITUD...                                                        ?            |
105400020719?1x? C                   when      *inkd                                        ?w----------01
105500020719     C                   exsr      soli00                                       ?            |
105600020719     ?*- AYUDA...                                                               ?            |
105700020719?1x? C                   when      *in80                                        ?w----------01
105800020719     ?*- PULSA INTRO...                                                         ?            |
105900020719?1x? C                   when      not *in29                                    ?w----------01
106000020719     C                   exsr      vali00                                       ?            |
106100020719?1e? C                   endsl                                                  ?F----------01
106200020719     C                   endsr
106300000904     ?******************************************************
106400020719     C     borr00        begsr
106500020719     ?** BORRADO PANTALLA 00-------------------------------
106600020719     C                   clear                   x0sspo
106700020719     C                   clear                   x0desd
106800020719     C                   clear                   $0sspo
106900020719     C                   endsr
107000000904     ?******************************************************
107100020719     C     grab00        begsr
107200020719     ?** CONCRECION PANTALLA 00----------------------------
107300020719     C                   exsr      defe38
107400020719     C                   exsr      prot01
107500020719     C                   endsr
107600000904     ?******************************************************
107700020719     C     soli00        begsr
107800020719     ?** SOLICITUD PANTALLA 00-----------------------------
107900020719     C                   endsr
108000000904     ?******************************************************
108100000904      /SPACE
108200000904     ?******************************************************
108300020719     C     vali00        begsr
108400020719     ?** VALIDACION PANTALLA 00----------------------------
108500020719     C     k3@ec1        chain(n)  p1hec1                             20
108600020719?1b? C                   if        not *in20                                    ?P----------01
108700020719     C                   eval      p@faÑo = c1fioa                              ?            |
108800020719     C                   eval      p@fmes = c1fiom                              ?            |
108900020719     C                   eval      p@fdia = c1fiod                              ?            |
109000020719     C                   eval      x0desd = p@fdma                              ?            |
109100020719?2b? C                   if        c1tiou = 3  and                              ?P---------02|
109200020719     C                             c1stos = 01                                  ?           ||
109300020719?2x? C                   else                                                   ?X.........02|
109400020719     C                   z-add     51            @e                   50        ?           ||
109500020719?2e? C                   endif                                                  ?F---------02|
109600020719?1x? C                   else                                                   ?X..........01
109700020719     C                   eval      x0desd = *zeros                              ?            |
109800020719     C                   z-add     51            @e                   50        ?            |
109900020719?1e? C                   endif                                                  ?F----------01
110000020719     ?*- SI NO EXISTEN ERRORES AVANZAR...
110100020719?1b? C                   if        not *in50  and                               ?P----------01
110200020719     C                             x0sspo = $0sspo  and                         ?            |
110300020719     C                             *in90                                        ?            |
110400020719     C                   exsr      grab00                                       ?            |
110500020719     C                   eval      xxiden = 1                                   ?            |
110600020719     C                   setoff                                       90        ?            |
110700020719?1x? C                   else                                                   ?X..........01
110800020719     C                   eval      $0sspo = x0sspo                              ?            |
110900020719     C                   seton                                        90        ?            |
111000020719?1e? C                   endif                                                  ?F----------01
111100020719     ?* SI EXISTEN ERRORES...
111200020719?1b? C                   if        *in50                                        ?P----------01
111300020719     C                   eval      *in(@e) = '1'                                ?            |
111400020719     C                   setoff                                       90        ?            |
111500020719     C                   write     par31000                                     ?            |
111600020719?1e? C                   endif                                                  ?F----------01
111700020719     C                   endsr
111800000904     ?******************************************************
111900020719     C     pant01        begsr
112000020719     ?** PROCESO PANTALLA '1' -----------------------------
112100020719     ?*- ENTRADA/SALIDA PANTALLA '1' ...
112200020719     C                   exfmt     par31001
112300020719     ?*- CORRIGE SITUACIONES DE ERROR ...
112400020719     C                   exsr      apagar
112500020719     ?*- PROCESA TECLAS DE FUNCION...
112600020719?1b? C                   select                                                 ?P----------01
112700020719     ?*- F3=SALIR...                                                            ?            |
112800020719?1x? C                   when      *inkc                                        ?w----------01
112900020719     C                   eval      @@mand = 'KC'                                ?            |
113000020719     ?*- F4=SOLICITUD...                                                        ?            |
113100020719?1x? C                   when      *inkd                                        ?w----------01
113200020719     C                   exsr      soli01                                       ?            |
113300020719     ?*- F7=MAS ASEGURADOS...                                                   ?            |
113400020719?1x? C                   when      *inkg                                        ?w----------01
113500020719     C                   eval      xxiden = 4                                   ?            |
113600020719     C                   clear                   xxasen                         ?            |
113700020719     C                   clear                   xxnomb                         ?            |
113800020719     ?*- F8=TRABAJAR CON TARJETAS DE CREDITO                                    ?            |
113900020719?1x? C                   when      *inkh  and                                   ?w----------01
114000020719     C                             *in23                                        ?            |
114100020719?2b? C                   select                                                 ?P---------02|
114200020719?2x? C                   when      x1cfpg = 1  or                               ?w---------02|
114300020719     C                             x1cfpg = 7                                   ?           ||
114400020719     C                   clear                   x1ivbc                         ?           ||
114500020719     C                   clear                   x1ivsu                         ?           ||
114600020719     C                   clear                   x1tcta                         ?           ||
114700020719     C                   clear                   x1ncta                         ?           ||
114800020719     C                   exsr      srtarj                                       ?           ||
114900020719?2x? C                   when      x1cfpg = 2  or                               ?w---------02|
115000020719     C                             x1cfpg = 3                                   ?           ||
115100020719     C                   clear                   x1ctcu                         ?           ||
115200020719     C                   clear                   x1nrtc                         ?           ||
115300020719     C                   exsr      srbanc                                       ?           ||
115400020719?2x? C                   other                                                  ?w---------02|
115500020719     C                   clear                   x1ivbc                         ?           ||
115600020719     C                   clear                   x1ivsu                         ?           ||
115700020719     C                   clear                   x1tcta                         ?           ||
115800020719     C                   clear                   x1ncta                         ?           ||
115900020719     C                   clear                   x1ctcu                         ?           ||
116000020719     C                   clear                   x1nrtc                         ?           ||
116100020719?2e? C                   endsl                                                  ?F---------02|
116200020719     ?*- F20=CADENA...                                                          ?            |
116300020719?1x? C                   when      *inku  and                                   ?w----------01
116400020719     C                             x1nivt <> *zeros  and                        ?            |
116500020719     C                             x1nivc <> *zeros                             ?            |
116600020719     C                   call      'PAR3031'                                    ?            |
116700020719     C                   parm                    x1nivt                         ?            |
116800020719     C                   parm                    x1nivc                         ?            |
116900020719     ?*- AYUDA...                                                               ?            |
117000020719?1x? C                   when      *in80                                        ?w----------01
117100020719     ?*- PULSA INTRO...                                                         ?            |
117200020719?1x? C                   when      not *in29                                    ?w----------01
117300020719     C                   exsr      vali01                                       ?            |
117400020719?1e? C                   endsl                                                  ?F----------01
117500020719     C                   endsr
117600000904     ?******************************************************
117700020719     C     srtarj        begsr
117800020719     ?** RUTINA PARA SELECCION TARJETA DE CREDITO----------
117900020719?1b? C                   if        x1ctcu <> *zeros  and                        ?P----------01
118000020719     C                             x1nrtc <> *zeros                             ?            |
118100020719     C                   eval      x1ctcu = *zeros                              ?            |
118200020719     C                   eval      x1nrtc = *zeros                              ?            |
118300020719?1x? C                   else                                                   ?X..........01
118400020719     C                   call      'PGG653R'                                    ?            |
118500020719     C                   parm                    x1asen                         ?            |
118600020719     C                   parm                    x1ctcu                         ?            |
118700020719     C                   parm                    x1nrtc                         ?            |
118800020719     C                   parm      '1'           p@reto            1            ?            |
118900020719?1e? C                   endif                                                  ?F----------01
119000020719     C                   endsr
119100001107     ?******************************************************
119200020719     C     srbanc        begsr
119300020719     ?** RUTINA PARA SELECCION CUENTA BANCARIA-------------
119400020719?1b? C                   if        x1ivbc <> *zeros  and                        ?P----------01
119500020719     C                             x1ivsu <> *zeros  and                        ?            |
119600020719     C                             x1tcta <> *zeros  and                        ?            |
119700020719     C                             x1ncta <> *blanks                            ?            |
119800020719     C                   eval      x1ivbc = *zeros                              ?            |
119900020719     C                   eval      x1ivsu = *zeros                              ?            |
120000020719     C                   eval      x1tcta = *zeros                              ?            |
120100020719     C                   eval      x1ncta = *blanks                             ?            |
120200020719?1x? C                   else                                                   ?X..........01
120300020719     C                   call      'PGG653S'                                    ?            |
120400020719     C                   parm                    x1asen                         ?            |
120500020719     C                   parm                    x1ivbc                         ?            |
120600020719     C                   parm                    x1ivsu                         ?            |
120700020719     C                   parm                    x1tcta                         ?            |
120800020719     C                   parm                    x1ncta                         ?            |
120900020719     C                   parm      '1'           p@reto                         ?            |
121000020719?1e? C                   endif                                                  ?F----------01
121100020719     C                   endsr
121200000904     ?******************************************************
121300020719     C     borr01        begsr
121400020719     ?** BORRADO PANTALLA 01-------------------------------
121500020719     C                   clear                   x1mone
121600020719     C                   clear                   x1come
121700020719     C                   clear                   x1asen
121800020719     C                   clear                   x1civa
121900020719     C                   clear                   x1opag
122000020719     C                   clear                   x1fing
122100020719     C                   clear                   x1desd
122200020719     C                   clear                   x1dupe
122300020719     C                   clear                   x1mar5
122400020719     C                   clear                   x1hast
122500020719     C                   clear                   x1nivt
122600020719     C                   clear                   x1nivc
122700020719     C                   clear                   x1cfpg
122800020719     C                   clear                   x1conr
122900020719     C                   clear                   x1strg
123000020719     C                   clear                   x1cbrn
123100020719     C                   clear                   x1czco
123200020719     C                   clear                   x1cocp
123300020719     C                   clear                   x1nrla
123400020719     C                   clear                   x1nrln
123500020719     C                   clear                   x1ctcu
123600020719     C                   clear                   x1nrtc
123700020719     C                   clear                   x1nrct
123800020719     C                   clear                   x1ivbc
123900020719     C                   clear                   x1ivsu
124000020719     C                   clear                   x1tcta
124100020719     C                   clear                   x1ncta
124200020719     C                   clear                   x1wcoa
124300020719     C                   clear                   x1nit1
124400020719     C                   clear                   x1nic1
124500020719     C                   clear                   x1nin1
124600020719     C                   clear                   x1xopr
124700020719     C                   clear                   x1copr
124800020719     C                   clear                   x1ncre
124900020719     C                   clear                   x1fvto
125000020719     C                   clear                   x1ccuo
125100020719     C                   clear                   x1cobn
125200020719     C                   clear                   x1soln
125300020719     C                   clear                   x1sarc
125400020719     C                   clear                   x1sard
125500020719     C                   clear                   x1cmas
125600020719     C                   clear                   x1pmas
125700020719     C                   clear                   x1paco
125800020719     C                   clear                   x1paas
125900020719     C                   clear                   $$mone
126000020719     C                   clear                   $$come
126100020719     C                   clear                   $$asen
126200020719     C                   clear                   $$civa
126300020719     C                   clear                   $$opag
126400020719     C                   clear                   $$fing
126500020719     C                   clear                   $$desd
126600020719     C                   clear                   $$dupe
126700020719     C                   clear                   $$hast
126800020719     C                   clear                   $$nivt
126900020719     C                   clear                   $$nivc
127000020719     C                   clear                   $$cfpg
127100020719     C                   clear                   $$conr
127200020719     C                   clear                   $$strg
127300020719     C                   clear                   $$cbrn
127400020719     C                   clear                   $$czco
127500020719     C                   clear                   $$cocp
127600020719     C                   clear                   $$nrla
127700020719     C                   clear                   $$nrln
127800020719     C                   clear                   $$ctcu
127900020719     C                   clear                   $$nrtc
128000020719     C                   clear                   $$nrct
128100020719     C                   clear                   $$ivbc
128200020719     C                   clear                   $$ivsu
128300020719     C                   clear                   $$tcta
128400020719     C                   clear                   $$ncta
128500020719     C                   clear                   $$wcoa
128600020719     C                   clear                   $$nit1
128700020719     C                   clear                   $$nic1
128800020719     C                   clear                   $$ncre
128900020719     C                   clear                   $$fvto
129000020719     C                   clear                   $$ccuo
129100020719     C                   clear                   $$cobn
129200020719     C                   clear                   $$soln
129300020719     C                   clear                   $$sarc
129400020719     C                   clear                   $$cmas
129500020719     C                   clear                   $$pmas
129600020719     C                   clear                   $$paco
129700020719     C                   clear                   $$paas
129800020719     C                   clear                   @@desd
129900020719     C                   clear                   @@asen
130000020719     C                   clear                   @1desd
130100020719     C                   clear                   @@cobn
130200020719     C                   clear                   x
130300020719     C                   clear                   y
130400020719     C                   endsr
130500000904     ?******************************************************
130600020719     C     carg01        begsr
130700020719     ?** BORRADO PANTALLA 01-------------------------------
130800020719     ?* Si el paso01 ya está en cero es la primera vez que
130900020719     ?* entra el programa, entonces ejecuta rutinas de car-
131000020719     ?* ga por defecto, caso contrario carga desde los
131100020719     ?* archivos PAHEC0 y PAHEC1...
131200020719?1b? C                   select                                                 ?P----------01
131300020719?1x? C                   when      w0wp01 = 1                                   ?w----------01
131400020719     C     k1@ec0        chain(n)  p1hec0                             20        ?            |
131500020719     C  n20k1@ec1        chain(n)  p1hec1                             20        ?            |
131600020719     ?*- RECUPERO DE OPERACION SUSPENDIDA O VUELTA A                            ?            |
131700020719     ?*- CABECERA: CARGA DESDE ARCHIVOS YA GRABADOS...                          ?            |
131800020719     ?*- DATOS DEL PAHEC0...                                                    ?            |
131900020719     C                   eval      p@faÑo = c0fipa                              ?            |
132000020719     C                   eval      p@fmes = c0fipm                              ?            |
132100020719     C                   eval      p@fdia = c0fipd                              ?            |
132200020719     C                   eval      x1fing = p@fdma                              ?            |
132300020719     C                   eval      x1mar1 = c0mar1                              ?            |
132400020719     ?*- DATOS DEL PAHEC1...                                                    ?            |
132500020719     C                   eval      x1mone = c1mone                              ?            |
132600020719     C                   movel     c1come        x1come                         ?            |
132700020719     C                   movel     c1asen        x1asen                         ?            |
132800020719     C                   movel     c1asen        @@asen                         ?            |
132900020719     C                   movel     c1asen        @1asen                         ?            |
133000020719     C                   movel     c1asen        @2asen                         ?            |
133100020719     C                   movel     c1asen        @3asen                         ?            |
133200020719     C                   movel     c1civa        x1civa                         ?            |
133300020719     C                   movel     c1opag        x1opag                         ?            |
133400020719     C                   eval      p@faÑo = c1fioa                              ?            |
133500020719     C                   eval      p@fmes = c1fiom                              ?            |
133600020719     C                   eval      p@fdia = c1fiod                              ?            |
133700020719     C                   eval      x1desd = p@fdma                              ?            |
133800020719     C                   eval      p@1dia = p@fdia                              ?            |
133900020719     C                   eval      p@1mes = p@fmes                              ?            |
134000020719     C                   eval      p@1aÑo = p@faÑo                              ?            |
134100020719     C                   eval      @1desd = p@famd                              ?            |
134200020719     C                   eval      @3desd = p@famd                              ?            |
134300020719     C                   movel     c1dupe        x1dupe                         ?            |
134400020719     C                   eval      x1mar5 = c1mar5                              ?            |
134500020719     C                   eval      p@faÑo = c1fvoa                              ?            |
134600020719     C                   eval      p@fmes = c1fvom                              ?            |
134700020719     C                   eval      p@fdia = c1fvod                              ?            |
134800020719     C                   eval      x1hast = p@fdma                              ?            |
134900020719     C                   movel     c1nivt        x1nivt                         ?            |
135000020719     C                   movel     c1nivc        x1nivc                         ?            |
135100020719     C                   eval      @@nivt = c1nivt                              ?            |
135200020719     C                   eval      @@nivc = c1nivc                              ?            |
135300020719     C                   movel     c1cfpg        x1cfpg                         ?            |
135400020719     C                   movel     c1conr        x1conr                         ?            |
135500020719     C                   eval      x1strg = c1strg                              ?            |
135600020719     C                   movel     c1cbrn        x1cbrn                         ?            |
135700020719     C                   movel     c1czco        x1czco                         ?            |
135800020719     C                   eval      x1cocp = c1cocp                              ?            |
135900020719     C                   eval      x1nrla = c1nrla                              ?            |
136000020719     C                   movel     c1nrln        x1nrln                         ?            |
136100020719     C                   movel     c1ctcu        x1ctcu                         ?            |
136200020719     C                   movel     c1nrtc        x1nrtc                         ?            |
136300020719     C                   movel     c1nrct        x1nrct                         ?            |
136400020719     C                   movel     c1ivbc        x1ivbc                         ?            |
136500020719     C                   movel     c1ivsu        x1ivsu                         ?            |
136600020719     C                   movel     c1tcta        x1tcta                         ?            |
136700020719     C                   eval      x1ncta = c1ncta                              ?            |
136800020719     C                   movel     c1wcoa        x1wcoa                         ?            |
136900020719     C                   eval      x1nit1 = h1nivt                              ?            |
137000020719     C                   eval      x1nic1 = h1nivc                              ?            |
137100020719     C                   eval      x1xopr = h1xopr                              ?            |
137200020719     C                   eval      x1copr = h1copr                              ?            |
137300020719     C                   eval      x1ncre = c1ncre                              ?            |
137400020719     C                   eval      x1ccuo = c1ccuo                              ?            |
137500020719     C                   eval      p@faÑo = c1ffca                              ?            |
137600020719     C                   eval      p@fmes = c1ffcm                              ?            |
137700020719     C                   eval      p@fdia = c1ffcd                              ?            |
137800020719     C                   eval      x1fvto = p@fdma                              ?            |
137900020719     C                   eval      nc(01) = c1niv1                              ?            |
138000020719     C                   eval      nc(02) = c1niv2                              ?            |
138100020719     C                   eval      nc(03) = c1niv3                              ?            |
138200020719     C                   eval      nc(04) = c1niv4                              ?            |
138300020719     C                   eval      nc(05) = c1niv5                              ?            |
138400020719     C                   eval      nc(06) = c1niv6                              ?            |
138500020719     C                   eval      nc(07) = c1niv7                              ?            |
138600020719     C                   eval      nc(08) = c1niv8                              ?            |
138700020719     C                   eval      nc(09) = c1niv9                              ?            |
138800020719     C     k1@ec4        chain(n)  p1hec4                             20        ?            |
138900020719     C  n20              eval      @@cobn = c4cobn                              ?            |
139000020719     C  n20              eval      x1cobn = c4cobn                              ?            |
139100020719     C  n20              eval      x1soln = c4soln                              ?            |
139200020719     C  n20              eval      x1sarc = c4sarc                              ?            |
139300020719     C     k1@ec5        setll     p1hec5                                       ?            |
139400020719     C                   exsr      sf3car                                       ?            |
139500020719     C                   exsr      desc01                                       ?            |
139600020719     C                   exsr      prot01                                       ?            |
139700020719     C                   eval      xxiden = 1                                   ?            |
139800020719     C     k1@ec6        chain     p1hec6                             22        ?            |
139900020719     C                   eval      x1pmas = c6por1                              ?            |
140000020719     C                   eval      x1paco = c6por2                              ?            |
140100020719     C                   eval      x1paas = c6por3                              ?            |
140200020719     C                   z-add     c6imp1        x1cmas                         ?            |
140300020719     ?*- PROTEJER CODIGO DE COASEGURO EN SEGUNDA ENTRADA...                     ?            |
140400020719     C                   seton                                            14    ?            |
140500020719?1x? C                   when      w0wp01 = 0                                   ?w----------01
140600020719     ?*- PRIMERA ENTRADA DEL PROGRAMA...                                        ?            |
140700020719     ?*- BUSCA DATOS POR DEFECTO SEGUN EL TIPO DE FUNCION..                     ?            |
140800020719?2b? C                   select                                                 ?P---------02|
140900020719?2x? C                   when      w0tiou = 1                                   ?w---------02|
141000020719     C                   exsr      defe01                                       ?           ||
141100020719     C                   exsr      prot01                                       ?           ||
141200020719     C                   eval      xxiden = 1                                   ?           ||
141300020719?2x? C                   when      w0tiou = 2                                   ?w---------02|
141400020719     C                   exsr      defe02                                       ?           ||
141500020719     C                   exsr      prot01                                       ?           ||
141600020719     C                   eval      xxiden = 1                                   ?           ||
141700020719?2x? C                   when      w0tiou = 3  and                              ?w---------02|
141800020719     C                             w0stos <> 08                                 ?           ||
141900020719     C                   exsr      defe03                                       ?           ||
142000020719     C                   exsr      prot01                                       ?           ||
142100020719     C                   eval      xxiden = 1                                   ?           ||
142200020719?2x? C                   when      w0tiou = 3  and                              ?w---------02|
142300020719     C                             w0stos = 08                                  ?           ||
142400020719     C                   exsr      borr00                                       ?           ||
142500020719     C                   eval      xxiden = *zeros                              ?           ||
142600020719?2x? C                   when      w0tiou = 5                                   ?w---------02|
142700020719     C                   exsr      defe05                                       ?           ||
142800020719     C                   exsr      prot01                                       ?           ||
142900020719     C                   eval      xxiden = 1                                   ?           ||
143000020719?2e? C                   endsl                                                  ?F---------02|
143100040120     ?* Si trabaja por parámetros, "remacha" por valores recibidos.             ?            |
143200040120?2b? C                   if        por_parametros                               ?P---------02|
143300040120     C                   exsr      exte00                                       ?           ||
143400040120?2e? C                   endif                                                  ?F---------02|
143500020719?1e? C                   endsl                                                  ?F----------01
143600020719     C                   endsr
143700000904     ?******************************************************
143800020719     C     defe01        begsr
143900020719     ?** BUSCAR DATOS POR DEFECTO--------------------------
144000020719     ?** SUPERPOLIZA ASIGNADA...
144100020719     C                   eval      x1spol = @@spol
144200020719     ?** MONEDA...
144300020719     C     k1t621        chain     s1t621                             20
144400020719?1b? C                   if        not *in20                                    ?P----------01
144500020719     C                   eval      x1mone = t@mone                              ?            |
144600020719?1e? C                   endif                                                  ?F----------01
144700020719     ?** DURACION DE LA SUPERPOLIZA...
144800020719     C     k1t621        chain     s1t620                             20
144900020719?1b? C                   if        not *in20                                    ?P----------01
145000020719     C                   movel     t@dupe        x1dupe                         ?            |
145100020719     C                   eval      x1mar5 = t@mar1                              ?            |
145200020719?1e? C                   endif                                                  ?F----------01
145300020719     ?** VIGENCIA HASTA EN SUPERPOLIZA ABIERTA...
145400020719?1b? C                   if        x1dupe = 99                                  ?P----------01
145500020719     C                   eval      x1hast = 99999999                            ?            |
145600020719?1e? C                   endif                                                  ?F----------01
145700020719     ?** CODIGO DE RECIBO/SOLICITUD....
145800020719?1b? C                   select                                                 ?P----------01
145900020719?1x? C                   when      t@mar2 = '0'                                 ?w----------01
146000020719     C                   eval      x1strg = 'N'                                 ?            |
146100020719?1x? C                   when      t@mar2 = '1'                                 ?w----------01
146200020719     C                   eval      x1strg = 'S'                                 ?            |
146300020719?1x? C                   when      t@mar2 = '2'                                 ?w----------01
146400020719     C                   eval      x1strg = 'N'                                 ?            |
146500020719?1e? C                   endsl                                                  ?F----------01
146600020719     ?** CODIGO DE FORMA DE COBRANZA...
146700020719     C                   movel     '4'           x1cfpg
146800020719     ?** CODIGO DE COBRA PRODUCTOR SI/NO...
146900020719     C                   eval      x1cocp = '0'
147000020719     C                   eval      x1sino = $$no
147100020719     ?** COBERTURA Y PROPUESTA...
147200020719     C                   eval      x1cobn = *zeros
147300020719     C                   eval      x1soln = *zeros
147400020719     ?** SUBARTICULO...
147500020719     C                   eval      x1sarc = *zeros
147600020719     ?** HABILITAR SUBARCHIVO DE ASEGURADOS...
147700020719     C                   exsr      sf4car
147800020719     ?** CODIGO DE REFACTURACION...
147900020719?1b? C                   if        t@free = '1'                                 ?P----------01
148000020719     C                   eval      x1mar1 = '0'                                 ?            |
148100020719?1x? C                   else                                                   ?X..........01
148200020719     C                   eval      x1mar1 = '1'                                 ?            |
148300020719?1e? C                   endif                                                  ?F----------01
148400040120     ?** CODIGO DE REFACTURACION PARA ARTICULOS DE AUTOS.
148500040120?1b? C                   if        @@ma47 = '1'                                 ?P----------01
148600021004     C                   eval      x1mar1 = '1'                                 ?            |
148700021004?1e? C                   endif                                                  ?F----------01
148800020719     C                   endsr
148900000904     ?******************************************************
149000020719     C     defe02        begsr
149100020719     ?** BUSCAR DATOS POR DEFECTO EN RENOVACION------------
149200020719     ?** SUPERPOLIZA ASIGNADA...
149300020719     C                   eval      x1spol = @@spol
149400020719     C                   setoff                                           98
149500020719     C     k2@ec1        setgt     p1hec1
149600020719?1b? C                   dow       1 = 1                                        ?P----------01
149700020719     C     k2@ec1        readpe(n) p1hec1                                 98    ?            |
149800020719?2b? C                   if        not *in98                                    ?P---------02|
149900020719?3b? C                   if        c1tiou = 1  or                               ?P--------03||
150000020719     C                             c1tiou = 2  or                               ?          |||
150100020719     C                             c1tiou = 5  or                               ?          |||
150200020719     C                             c1tiou = 3  and                              ?          |||
150300020719     C                             c1stos <> 09  and                            ?          |||
150400020719     C                             c1stos <> 08                                 ?          |||
150500020719?1v? C                   leave                                                  ?          |||
150600020719?3e? C                   endif                                                  ?F--------03||
150700020719?2e? C                   endif                                                  ?F---------02|
150800020719?1e? C                   enddo                                                  ?F----------01
150900020719     ?*- DATOS POR DEFECTO EN RENOVACION Y PRIMERA
151000020719     ?*- ENTRADA DEL PROGRAMA....
151100020719     ?*- CABECERA: DE LA SUPERPOLIZA QUE SE RENUEVA Y DEL
151200020719     ?*- ULTIMO ENDOSO DE LA POLIZA QUE SE RENUEVA...
151300020719     ?*- DATOS DEL PAHEC0...
151400020719     C                   eval      x1fing = *zeros
151500020719     ?*- DATOS DEL PAHEC1...
151600020719     C                   eval      x1mone = c1mone
151700020719     C                   movel     c1come        x1come
151800020719     C                   movel     c1asen        x1asen
151900020719     C                   movel     c1asen        @@asen
152000020719     C                   movel     c1asen        @1asen
152100020719     C                   movel     c1asen        @2asen
152200020719     C                   movel     c1asen        @3asen
152300020719     C                   movel     c1civa        x1civa
152400140819     c                   if        t@ma52 = '1'
152500140819     c     x1asen        chain     s1hase01
152600140819     c                   if        %found(sehase01)
152700140819     c                   eval      x1civa = ASCIVA
152800140819     c                   endif
152900140819     c                   endif
153000020719     C                   movel     c1opag        x1opag
153100020719     C                   eval      p@faÑo = c1fioa
153200020719     C                   eval      p@fmes = c1fiom
153300020719     C                   eval      p@fdia = c1fiod
153400020719     C                   eval      x1desd = p@fdma
153500020719     C                   movel     c1dupe        x1dupe
153600020719     C                   eval      x1mar5 = c1mar5
153700020719     C                   eval      p@faÑo = c1fvoa
153800020719     C                   eval      p@fmes = c1fvom
153900020719     C                   eval      p@fdia = c1fvod
154000020719     C                   eval      x1hast = p@fdma
154100020719     C                   movel     c1nivt        x1nivt
154200020719     C                   movel     c1nivc        x1nivc
154300020719     C                   movel     c1cfpg        x1cfpg
154400020719     C                   eval      x1conr = *zeros
154500020719     C                   eval      x1strg = 'N'
154600020719     C                   eval      x1cocp = '0'
154700020719     C                   movel     c1cbrn        x1cbrn
154800020719     C                   movel     c1czco        x1czco
154900020719     C                   eval      x1nrla = c1nrla
155000020719     C                   movel     c1nrln        x1nrln
155100020719     C                   movel     c1ctcu        x1ctcu
155200020719     C                   movel     c1nrtc        x1nrtc
155300020719     C                   movel     c1nrct        x1nrct
155400020719     C                   movel     c1ivbc        x1ivbc
155500020719     C                   movel     c1ivsu        x1ivsu
155600020719     C                   movel     c1tcta        x1tcta
155700020719     C                   eval      x1ncta = c1ncta
155800020719     C                   movel     c1wcoa        x1wcoa
155900020719     C                   eval      x1nit1 = h1nivt
156000020719     C                   eval      x1nic1 = h1nivc
156100020719     C                   eval      x1ncre = c1ncre
156200020719     C                   eval      p@faÑo = c1ffca
156300020719     C                   eval      p@fmes = c1ffcm
156400020719     C                   eval      p@fdia = c1ffcd
156500020719     C                   eval      x1fvto = p@fdma
156600020719     C                   eval      x1ccuo = c1ccuo
156700020719     ?* LA VIGENCIA DESDE ES EL VENCIMIENTO ANTERIOR...
156800020719     C                   eval      p@faÑo = c1fvoa
156900020719     C                   eval      p@fmes = c1fvom
157000020719     C                   eval      p@fdia = c1fvod
157100020719     C                   eval      x1desd = p@fdma
157200020719     C                   movel     c1dupe        x1dupe
157300020719     C                   eval      x1mar5 = c1mar5
157400020719     ?* LA VIGENCIA HASTA SE CALCULA...
157500040824     C                   eval      x1hast =  +
157600040824     C                             fecha_hasta(x1desd : x1mar5 : x1dupe : +
157700040824     C                                         x1asen)
157800110201     ?* PARA VIDA OBLIGATORIO EN RENOVACIONES LA FECHA DE FIN DE VIGENCIA
157900110201     ?* SE CALCULA NUEVAMENTE..NO HAY MAS POLIZAS CON VIGENCIA ABIERTA(9999)
158000110201     ?** DURACION DE LA SUPERPOLIZA...
158100110201     C     k1t621        chain     s1t621                             20
158200110201?1b? C                   if        not *in20                                    ?P----------01
158300110201     C     t@rama        chain     s1t001                             20
158400110201?1b? C                   if        not *in20 and                                ?P----------01
158500110201?1b? C                             t01_rame = 21                                ?P----------01
158600110201     C     k1t620        chain     s1t620                             20
158700110201?1b? C                   if        not *in20                                    ?P----------01
158800110201     C                   movel     t@dupe        x1dupe                         ?            |
158900110201     C                   eval      x1mar5 = t@mar1                              ?            |
159000110201     ?* LA VIGENCIA HASTA SE CALCULA NUEVAMENTE...
159100110201?1e? C                   endif                                                  ?F----------01
159200110201?1e? C                   endif                                                  ?F----------01
159300110201?1e? C                   endif                                                  ?F----------01
159400020719     ?** COBERTURA Y PROPUESTA...
159500020719     C                   eval      x1cobn = *zeros
159600020719     C                   eval      x1soln = *zeros
159700020719     ?** CODIGO DE SUBARTÍCULO...
159800020719     C     k2@ec4        chain     p1hec4                             20
159900020719     C  n20              eval      x1sarc = c4sarc
160000020719     C   20              eval      x1sarc = *zeros
160100020719     ?** CODIGO DE REFACTURACION...
160200020719?1b? C                   if        t@free = '1'                                 ?P----------01
160300020719     C                   eval      x1mar1 = '0'                                 ?            |
160400020719?1x? C                   else                                                   ?X..........01
160500020719     C                   eval      x1mar1 = '1'                                 ?            |
160600020719?1e? C                   endif                                                  ?F----------01
160700040120     ?** CODIGO DE REFACTURACION PARA ARTICULOS DE AUTOS.
160800040120?1b? C                   if        @@ma47 = '1'                                 ?P----------01
160900021004     C                   eval      x1mar1 = '1'                                 ?            |
161000021004?1e? C                   endif                                                  ?F----------01
161100020719     ?*- CARGAR ASEGURADOS ADICIONALES...
161200100906     C     k2@ec5        setll     pahec5
161300020719     C                   exsr      sf4car
161400020719     ?*- DESCRIPCIONES...
161500020719     C                   exsr      desc01
161600020719     C     k1@ec6        chain     p1hec6                             20
161700020719     C                   eval      x1pmas = c6por1
161800020719     C                   eval      x1paco = c6por2
161900020719     C                   eval      x1paas = c6por3
162000020719     C                   movel     c6imp1        x1cmas
162100020719     C                   endsr
162200000904     ?******************************************************
162300020719     C     defe03        begsr
162400020719     ?** BUSCAR DATOS POR DEFECTO EN ENDOSOS---------------
162500020719     ?** SUPERPOLIZA ASIGNADA...
162600020719     C                   eval      x1spol = @@spol
162700020719     C                   setoff                                           98
162800020719     C     k2@ec1        setgt     p1hec1
162900020719?1b? C                   dow       1 = 1                                        ?P----------01
163000020719     C     k2@ec1        readpe(n) p1hec1                                 98    ?            |
163100020719?2b? C                   if        not *in98                                    ?P---------02|
163200020719?3b? C                   if        c1tiou = 1  or                               ?P--------03||
163300020719     C                             c1tiou = 2  or                               ?          |||
163400020719     C                             c1tiou = 5  or                               ?          |||
163500020719     C                             c1tiou = 3  and                              ?          |||
163600020719     C                             c1stos <> 09  and                            ?          |||
163700021031     C                             c1stos <> 08                                 ?          |||
163800020719?1v? C                   leave                                                  ?          |||
163900020719?3e? C                   endif                                                  ?F--------03||
164000020719?2e? C                   endif                                                  ?F---------02|
164100020719?1e? C                   enddo                                                  ?F----------01
164200020719     ?*- DATOS POR DEFECTO EN ENDOSOS Y PRIMERA ENTRADA
164300020719     ?*- DEL PROGRAMA...
164400020719     ?*- DATOS DEL PAHEC0...
164500020719     C                   eval      x1fing = *zeros
164600020719     ?*- DATOS DEL PAHEC1...
164700020719     C                   eval      x1mone = c1mone
164800020719     C                   movel     c1come        x1come
164900020719     C                   movel     c1asen        x1asen
165000020719     C                   movel     c1asen        @@asen
165100020719     C                   movel     c1asen        @1asen
165200020719     C                   movel     c1asen        @2asen
165300020719     C                   movel     c1asen        @3asen
165400020719     C                   movel     c1civa        x1civa
165500141107     c                   if        t@ma52 = '1'
165600141114     c     k1t901        chain     set901
165700141114     c                   if        %found(set901) and
165800150807?3b? C                             xxmar5 = '1'                                 ?P--------03||
165900141107     c     x1asen        chain     s1hase01
166000141107     c                   if        %found(sehase01)
166100141107     c                   eval      x1civa = ASCIVA
166200141107     c                   endif
166300141114     c                   endif
166400141107     c                   endif
166500020719     C                   movel     c1opag        x1opag
166600020719     C                   eval      p@faÑo = c1fioa
166700020719     C                   eval      p@fmes = c1fiom
166800020719     C                   eval      p@fdia = c1fiod
166900020719     C                   eval      x1desd = p@fdma
167000020719     C                   eval      p@1dia = p@fdia
167100020719     C                   eval      p@1mes = p@fmes
167200020719     C                   eval      p@1aÑo = p@faÑo
167300020719     C                   eval      @3desd = p@famd
167400020719     C                   movel     c1dupe        x1dupe
167500020719     C                   eval      x1mar5 = c1mar5
167600020719     C                   eval      p@faÑo = c1fvoa
167700020719     C                   eval      p@fmes = c1fvom
167800020719     C                   eval      p@fdia = c1fvod
167900020719     C                   eval      x1hast = p@fdma
168000020719     C                   movel     c1nivt        x1nivt
168100020719     C                   movel     c1nivc        x1nivc
168200020719     C                   eval      @@nivt = c1nivt
168300020719     C                   eval      @@nivc = c1nivc
168400020719     C                   movel     c1cfpg        x1cfpg
168500020719     C                   eval      x1conr = *zeros
168600020719     C                   eval      x1strg = 'N'
168700020719     C                   eval      x1cocp = '0'
168800020719     C                   movel     c1cbrn        x1cbrn
168900020719     C                   movel     c1czco        x1czco
169000020719     C                   eval      x1nrla = c1nrla
169100020719     C                   movel     c1nrln        x1nrln
169200020719     C                   movel     c1ctcu        x1ctcu
169300020719     C                   movel     c1nrtc        x1nrtc
169400020719     C                   movel     c1nrct        x1nrct
169500020719     C                   movel     c1ivbc        x1ivbc
169600020719     C                   movel     c1ivsu        x1ivsu
169700020719     C                   movel     c1tcta        x1tcta
169800020719     C                   eval      x1ncta = c1ncta
169900020719     C                   movel     c1wcoa        x1wcoa
170000020719     C                   eval      p@faÑo = c1fioa
170100020719     C                   eval      p@fmes = c1fiom
170200020719     C                   eval      p@fdia = c1fiod
170300020719     C                   eval      x1desd = p@fdma
170400020719     C                   eval      p@faÑo = c1fvoa
170500020719     C                   eval      p@fmes = c1fvom
170600020719     C                   eval      p@fdia = c1fvod
170700020719     C                   eval      x1hast = p@fdma
170800020719     C                   movel     c1dupe        x1dupe
170900020719     C                   eval      x1mar5 = c1mar5
171000020719     C                   eval      x1nit1 = h1nivt
171100020719     C                   eval      x1nic1 = h1nivc
171200020719     C                   eval      x1ncre = c1ncre
171300020719     C                   eval      p@faÑo = c1ffca
171400020719     C                   eval      p@fmes = c1ffcm
171500020719     C                   eval      p@fdia = c1ffcd
171600020719     C                   eval      x1fvto = p@fdma
171700020719     C                   eval      x1ccuo = c1ccuo
171800020719     C                   eval      nc(01) = c1niv1
171900020719     C                   eval      nc(02) = c1niv2
172000020719     C                   eval      nc(03) = c1niv3
172100020719     C                   eval      nc(04) = c1niv4
172200020719     C                   eval      nc(05) = c1niv5
172300020719     C                   eval      nc(06) = c1niv6
172400020719     C                   eval      nc(07) = c1niv7
172500020719     C                   eval      nc(08) = c1niv8
172600020719     C                   eval      nc(09) = c1niv9
172700020719     ?*- FORMA DE REFACTURACION AUTOMATICA/MANUAL...
172800020719     C     k2@ec0        chain(n)  p1hec0                             20
172900020719     C  n20              eval      x1mar1 = c0mar1
173000020719     ?* RUTINA PARA DETERMINAR EL INICIO DE VIGENCIA EN
173100020719     ?* LOS ENDOSOS...
173200020719     C                   exsr      srvide
173300020719     ?** COBERTURA Y PROPUESTA...
173400020719     C                   eval      x1cobn = *zeros
173500020719     C                   eval      x1soln = *zeros
173600020719     ?** CODIGO DE SUBARTÍCULO...
173700020719     C     k2@ec4        chain     p1hec4                             20
173800020719     C  n20              eval      x1sarc = c4sarc
173900020719     C   20              eval      x1sarc = *zeros
174000020719     ?*- CARGAR ASEGURADOS ADICIONALES...
174100100906     C     k2@ec5        setll     pahec5
174200020719     C                   exsr      sf4car
174300020719     ?*- DESCRIPCIONES...
174400020719     C                   exsr      desc01
174500020719     C     k1@ec6        chain     p1hec6                             22
174600020719     C                   eval      x1pmas = c6por1
174700020719     C                   eval      x1paco = c6por2
174800020719     C                   eval      x1paas = c6por3
174900020719     C                   z-add     c6imp1        x1cmas
175000020719     C                   endsr
175100000904     ?******************************************************
175200020719     C     defe38        begsr
175300020719     ?** BUSCAR DATOS POR DEFECTO EN ENDOSOS---------------
175400020719     ?** DE AJUSTE DE PERIODOS CERRADOS--------------------
175500020719     C                   eval      x1spol = @@spol
175600020719     C     k3@ec1        chain(n)  p1hec1                             20
175700020719?1b? C                   if        not *in20                                    ?P----------01
175800020719     ?*- DATOS POR DEFECTO EN ENDOSOS Y PRIMERA ENTRADA                         ?            |
175900020719     ?*- DEL PROGRAMA...                                                        ?            |
176000020719     ?*- DATOS DEL PAHEC0...                                                    ?            |
176100020719     C                   eval      x1fing = *zeros                              ?            |
176200020719     ?*- DATOS DEL PAHEC1...                                                    ?            |
176300020719     C                   eval      x1mone = c1mone                              ?            |
176400020719     C                   movel     c1come        x1come                         ?            |
176500020719     C                   movel     c1asen        x1asen                         ?            |
176600020719     C                   movel     c1asen        @@asen                         ?            |
176700020719     C                   movel     c1asen        @1asen                         ?            |
176800020719     C                   movel     c1asen        @2asen                         ?            |
176900020719     C                   movel     c1asen        @3asen                         ?            |
177000020719     C                   movel     c1civa        x1civa                         ?            |
177100020719     C                   movel     c1opag        x1opag                         ?            |
177200020719     C                   eval      p@faÑo = c1fioa                              ?            |
177300020719     C                   eval      p@fmes = c1fiom                              ?            |
177400020719     C                   eval      p@fdia = c1fiod                              ?            |
177500020719     C                   eval      x1desd = p@fdma                              ?            |
177600020719     C                   eval      p@1dia = p@fdia                              ?            |
177700020719     C                   eval      p@1mes = p@fmes                              ?            |
177800020719     C                   eval      p@1aÑo = p@faÑo                              ?            |
177900020719     C                   eval      @3desd = p@famd                              ?            |
178000020719     C                   movel     c1dupe        x1dupe                         ?            |
178100020719     C                   eval      x1mar5 = c1mar5                              ?            |
178200020719     C                   eval      p@faÑo = c1fvoa                              ?            |
178300020719     C                   eval      p@fmes = c1fvom                              ?            |
178400020719     C                   eval      p@fdia = c1fvod                              ?            |
178500020719     C                   eval      x1hast = p@fdma                              ?            |
178600020719     C                   movel     c1nivt        x1nivt                         ?            |
178700020719     C                   movel     c1nivc        x1nivc                         ?            |
178800020719     C                   eval      @@nivt = c1nivt                              ?            |
178900020719     C                   eval      @@nivc = c1nivc                              ?            |
179000020719     C                   movel     c1cfpg        x1cfpg                         ?            |
179100020719     C                   eval      x1conr = *zeros                              ?            |
179200020719     C                   eval      x1strg = 'N'                                 ?            |
179300020719     C                   eval      x1cocp = '0'                                 ?            |
179400020719     C                   movel     c1cbrn        x1cbrn                         ?            |
179500020719     C                   movel     c1czco        x1czco                         ?            |
179600020719     C                   eval      x1nrla = c1nrla                              ?            |
179700020719     C                   movel     c1nrln        x1nrln                         ?            |
179800020719     C                   movel     c1ctcu        x1ctcu                         ?            |
179900020719     C                   movel     c1nrtc        x1nrtc                         ?            |
180000020719     C                   movel     c1nrct        x1nrct                         ?            |
180100020719     C                   movel     c1ivbc        x1ivbc                         ?            |
180200020719     C                   movel     c1ivsu        x1ivsu                         ?            |
180300020719     C                   movel     c1tcta        x1tcta                         ?            |
180400020719     C                   eval      x1ncta = c1ncta                              ?            |
180500020719     C                   movel     c1wcoa        x1wcoa                         ?            |
180600020719     C                   eval      p@faÑo = c1fioa                              ?            |
180700020719     C                   eval      p@fmes = c1fiom                              ?            |
180800020719     C                   eval      p@fdia = c1fiod                              ?            |
180900020719     C                   eval      x1desd = p@fdma                              ?            |
181000020719     C                   eval      p@faÑo = c1fvoa                              ?            |
181100020719     C                   eval      p@fmes = c1fvom                              ?            |
181200020719     C                   eval      p@fdia = c1fvod                              ?            |
181300020719     C                   eval      x1hast = p@fdma                              ?            |
181400020719     C                   movel     c1dupe        x1dupe                         ?            |
181500020719     C                   eval      x1mar5 = c1mar5                              ?            |
181600020719     C                   eval      x1nit1 = h1nivt                              ?            |
181700020719     C                   eval      x1nic1 = h1nivc                              ?            |
181800020719     C                   eval      x1ncre = c1ncre                              ?            |
181900020719     C                   eval      p@faÑo = c1ffca                              ?            |
182000020719     C                   eval      p@fmes = c1ffcm                              ?            |
182100020719     C                   eval      p@fdia = c1ffcd                              ?            |
182200020719     C                   eval      x1fvto = p@fdma                              ?            |
182300020719     C                   eval      x1ccuo = c1ccuo                              ?            |
182400020719     C                   eval      nc(01) = c1niv1                              ?            |
182500020719     C                   eval      nc(02) = c1niv2                              ?            |
182600020719     C                   eval      nc(03) = c1niv3                              ?            |
182700020719     C                   eval      nc(04) = c1niv4                              ?            |
182800020719     C                   eval      nc(05) = c1niv5                              ?            |
182900020719     C                   eval      nc(06) = c1niv6                              ?            |
183000020719     C                   eval      nc(07) = c1niv7                              ?            |
183100020719     C                   eval      nc(08) = c1niv8                              ?            |
183200020719     C                   eval      nc(09) = c1niv9                              ?            |
183300020719     ?*- FORMA DE REFACTURACION AUTOMATICA/MANUAL...                            ?            |
183400020719     C     k2@ec0        chain(n)  p1hec0                             20        ?            |
183500020719     C  n20              eval      x1mar1 = c0mar1                              ?            |
183600020719     ?** COBERTURA Y PROPUESTA...                                               ?            |
183700020719     C                   eval      x1cobn = *zeros                              ?            |
183800020719     C                   eval      x1soln = *zeros                              ?            |
183900020719     ?** CODIGO DE SUBARTÍCULO...                                               ?            |
184000020719     C     k2@ec4        chain     p1hec4                             20        ?            |
184100020719     C  n20              eval      x1sarc = c4sarc                              ?            |
184200020719     C   20              eval      x1sarc = *zeros                              ?            |
184300020719     ?*- CARGAR ASEGURADOS ADICIONALES...                                       ?            |
184400020719     C                   exsr      sf4car                                       ?            |
184500020719     ?*- DESCRIPCIONES...                                                       ?            |
184600020719     C                   exsr      desc01                                       ?            |
184700020719?1e? C                   endif                                                  ?F----------01
184800020719     C                   eval      x1pmas = c6por1
184900020719     C                   eval      x1paco = c6por2
185000020719     C                   eval      x1paas = c6por3
185100020719     C                   z-add     c6imp1        x1cmas
185200020719     C                   endsr
185300000904     ?******************************************************
185400020719     C     defe05        begsr
185500020719     ?** BUSCAR DATOS POR DEFECTO EN REHABILITACION--------
185600020719     C                   exsr      defe03
185700020719     C                   endsr
185800000904     ?******************************************************
185900020719     C     srvide        begsr
186000020719     ?** SUBRUTINA PARA VIGENCIA DESDE---------------------
186100020719     ?* el inicio de vigencia en los endosos se basa en la
186200020719     ?* siguiente regla:
186300020719     ?* a) si estoy en una refacturación la vigencia desde
186400020719     ?*    es la fecha hasta facturada del ultimo endoso
186500020719     ?*    de refacturación, de una rehabilitación, o de la
186600020719     ?*    póliza original, el primero que aparezca...
186700020719     ?* b) si estoy en cualquier otro endoso es la vigencia
186800020719     ?*    desde de la ultima refacturación vigente...
186900020719     ?* c) esta vigencia no se puede modificar en este pro-
187000020719     ?*    grama pero si se puede modificar en el par310d
187100020719     C                   setoff                                           98
187200021031     C                   setoff                                           27
187300021031     C                   setoff                                           28
187400020719     C     k4@ed0        setgt     p1hed003
187500020719?1b? C                   dow       1 = 1                                        ?P----------01
187600020719     C     k4@ed0        readpe    p1hed003                               99    ?            |
187700020719?2b? C                   if        not *in98                                    ?P---------02|
187800021031     C                   eval      wwempr = c1empr                              ?           ||
187900021031     C                   eval      wwsucu = c1sucu                              ?           ||
188000021031     C                   eval      wwarcd = c1arcd                              ?           ||
188100021031     C                   eval      wwspol = c1spol                              ?           ||
188200021031     C                   eval      wwsspo = c1sspo                              ?           ||
188300021031     C     keyec1        chain     pahec1                             27        ?           ||
188400021031     C                   seton                                        28        ?           ||
188500020719?3b? C                   if        d0tiou = 1  or                               ?P--------03||
188600020719     C                             d0tiou = 2  or                               ?          |||
188700020719     C                             d0tiou = 5  or                               ?          |||
188800020719     C                             d0tiou = 3  and                              ?          |||
188900021031     C                             d0stos = 01 and                              ?          |||
189000021031     C                             c1fboa = 0                                   ?          |||
189100020719?4b? C                   select                                                 ?P-------04|||
189200020719     ?* si estou en una refacturacion...                                        ?         ||||
189300020719?4x? C                   when      w0tiou = 3  and                              ?w-------04|||
189400020719     C                             w0stos = 01                                  ?         ||||
189500020719     C                   eval      p@faÑo = d0fhfa                              ?         ||||
189600020719     C                   eval      p@fmes = d0fhfm                              ?         ||||
189700020719     C                   eval      p@fdia = d0fhfd                              ?         ||||
189800020719     ?* si tomo las vigencias desde las 0 a las 24 horas                        ?         ||||
189900020719     ?* debo sumar un día a la vigencia que obtengo...                          ?         ||||
190000020719?5b? C                   if        c0mar3 = '1'                                 ?P------05||||
190100020719     C                   eval      p@fdia = 1                                   ?        |||||
190200020719     C                   add       1             p@fmes                         ?        |||||
190300020719?6b? C                   if        p@fmes > 12                                  ?P-----06|||||
190400020719     C                   eval      p@fmes = 1                                   ?       ||||||
190500020719     C                   add       1             p@faÑo                         ?       ||||||
190600020719?6e? C                   endif                                                  ?F-----06|||||
190700020719?5e? C                   endif                                                  ?F------05||||
190800020719     C                   eval      x1desd = p@fdma                              ?         ||||
190900020719     C                   eval      p@1dia = p@fdia                              ?         ||||
191000020719     C                   eval      p@1mes = p@fmes                              ?         ||||
191100020719     C                   eval      p@1aÑo = p@faÑo                              ?         ||||
191200020719     C                   eval      @3desd = p@famd                              ?         ||||
191300020719     ?* otros endosos...                                                        ?         ||||
191400020719?4x? C                   other                                                  ?w-------04|||
191500020719     C                   eval      p@faÑo = d0fioa                              ?         ||||
191600020719     C                   eval      p@fmes = d0fiom                              ?         ||||
191700020719     C                   eval      p@fdia = d0fiod                              ?         ||||
191800020719     C                   eval      x1desd = p@fdma                              ?         ||||
191900020719     C                   eval      p@1dia = p@fdia                              ?         ||||
192000020719     C                   eval      p@1mes = p@fmes                              ?         ||||
192100020719     C                   eval      p@1aÑo = p@faÑo                              ?         ||||
192200020719     C                   eval      @3desd = p@famd                              ?         ||||
192300020719?4e? C                   endsl                                                  ?F-------04|||
192400020719?1v? C                   leave                                                  ?          |||
192500020719?3e? C                   endif                                                  ?F--------03||
192600020719?2e? C                   endif                                                  ?F---------02|
192700020719?1e? C                   enddo                                                  ?F----------01
192800021031     ?*
192900021031     C   28k1yec1        chain     pahec1                             27
193000021031     C                   setoff                                           27
193100021031     C                   setoff                                           28
193200020719     C                   endsr
193300000904     ?******************************************************
193400020719     C     prot01        begsr
193500020719     ?** PROTEJER DATOS NO MODIFICADOS DEL ARTICULO--------
193600020719     ?*- CAMPOS DE PROTECCION...
193700040120     ?* Nota: El *IN08 (por_parametros), protege los campos que
193800040120     ?*       el usuario no puede modificar. Es seteado desde el
193900040120     ?*       llamador.
194000020719     C                   setoff                                       031917
194100020719     C                   setoff                                       1804
194200020719     ?*- RECUPERA DE TABLAS...
194300020719     C     k1t621        chain     s1t621                             20
194400020719     C     k1t620        chain     s1t620                             20
194500020719     C     k1t630        chain     s1t630                             20
194600020719     ?*- PROTECCION GENERAL CUANDO ES ENDOSO/REHABILITACION
194700020719?1b? C                   if        w0tiou = 3  or                               ?P----------01
194800020719     C                             w0tiou = 5                                   ?            |
194900020719     C                   seton                                        03        ?            |
195000020719?1e? C                   endif                                                  ?F----------01
195100020719     ?*- PROTECCION COTIZACION...
195200020719?1b? C                   if        t@ma41 = '1'                                 ?P----------01
195300020719     C                   seton                                        19        ?            |
195400020719?1e? C                   endif                                                  ?F----------01
195500020719     ?*- IDENTIFICAR DONDE SE PUEDE CAMBIAR LA CADENA
195600020719     ?*- COMERCIAL...
195700020719?1b? C                   if        w0tiou = 3  and                              ?P----------01
195800020719     C                             w0stos = 88  or                              ?            |
195900020719     C                             w0tiou = 5                                   ?            |
196000020719     C                   seton                                        17        ?            |
196100020719?1e? C                   endif                                                  ?F----------01
196200020719     ?*- PROTECCION DE LA VIGENCIA DESDE EN ENDOSOS...
196300020719?1b? C                   if        w0tiou = 3                                   ?P----------01
196400020719     C                   seton                                        18        ?            |
196500020719?1e? C                   endif                                                  ?F----------01
196600020719     ?*- IDENTIFICO POLIZA NUEVA/REFACTURACION...
196700020719?1b? C                   if        w0tiou = 1  or                               ?P----------01
196800020719     C                             w0tiou = 2  or                               ?            |
196900020719     C                             w0tiou = 3  and                              ?            |
197000020719     C                             w0stos = 01                                  ?            |
197100020719     C                   seton                                        04        ?            |
197200020719?1e? C                   endif                                                  ?F----------01
197300020719     C                   endsr
197400000904     ?******************************************************
197500040120     ?* Cuando se lo llama con parámetros, el usuario no puede
197600040120     ?* modificar los datos que llegan desde el llamador.
197700040120     ?* Esta rutina debe ejecutarse cuando se trata de una
197800040120     ?* operación que aun no haya cumplido el Paso "1" ya que
197900040120     ?* una vez hecho esto, se recuperarán los datos desde los
198000040817     ?* archivos de suspendidas (PAWEC1, etc.)
198100040120     ?* -------------------------------------------------- *
198200040120     Csr   exte00        begsr
198300040120     C                   eval      x1asen = p@asen
198400040817     C                   eval      @1asen = p@asen
198500040120     C                   eval      x1nivt = 1
198600040120     C                   eval      x1nivc = p@nivc
198700040120     ?* Fecha Desde.
198800040120     C                   eval      p@famd = p@fvde
198900040120     C                   eval      x1desd = (p@1dia * 1000000) +
199000040120     C                                      (p@1mes * 10000) + p@1aÑo
199100040120     ?* Fecha Propuesta.
199200040120     C                   eval      p@famd = p@fpro
199300040120     C                   eval      x1fing = (p@1dia * 1000000) +
199400040120     C                                      (p@1mes * 10000) + p@1aÑo
199500040824     ?* Para Renovaciones, Fecha Hasta se calcula.
199600040902?1b? C                   if        w0tiou = 2
199700040824     C                   eval      x1hast =  +
199800040824     C                             fecha_hasta(x1desd : x1mar5 : x1dupe : +
199900040824     C                                         x1asen)
200000040902?1e? C                   endif
200100040120     Csr                 endsr
200200040120     ?******************************************************
200300020719     C     desc01        begsr
200400020719     ?** BUSCAR DESCRIPCIONES------------------------------
200500020719     ?*- MONEDA...
200600020719     C     x1mone        chain     g1tmon                             20
200700020719     C   20              eval      x1nmol = *blanks
200800020719     C  n20              eval      x1nmol = monmol
200900020719     ?*- ASEGURADO...
201000020719     C     x1asen        chain     s1hase01                           20
201100020719     C  n20x1asen        chain     g1hdaf                             20
201200020719?1b? C                   if        not *in20                                    ?P----------01
201300020719     C                   eval      x1asno = dfnomb                              ?            |
201400041025     ?* Número de R.U.T.A...
201500041025     C                   eval      x1ruta = asruta
201600020719     ?*- CODIGO DE IVA...                                                       ?            |
201700020719?2b? C                   select                                                 ?P---------02|
201800020719?2x? C                   when      x1civa = 01                                  ?w---------02|
201900020719     C                   eval      x1diva = $$c001                              ?           ||
202000020719?2x? C                   when      x1civa = 02                                  ?w---------02|
202100020719     C                   eval      x1diva = $$c002                              ?           ||
202200020719?2x? C                   when      x1civa = 03                                  ?w---------02|
202300020719     C                   eval      x1diva = $$c003                              ?           ||
202400020719?2x? C                   when      x1civa = 04                                  ?w---------02|
202500020719     C                   eval      x1diva = $$c004                              ?           ||
202600020719?2x? C                   when      x1civa = 05                                  ?w---------02|
202700020719     C                   eval      x1diva = $$c005                              ?           ||
202800020719?2x? C                   when      x1civa = 06                                  ?w---------02|
202900020719     C                   eval      x1diva = $$c006                              ?           ||
203000020719?2x? C                   when      x1civa = 07                                  ?w---------02|
203100020719     C                   eval      x1diva = $$c007                              ?           ||
203200020719?2e? C                   endsl                                                  ?F---------02|
203300020719     ?*- NUMERO DE CUIT...                                                      ?            |
203400020719?2b? C                   if        dfcuit <> *blanks                            ?P---------02|
203500020719     C                   eval      d@0102 = c@0102                              ?           ||
203600020719     C                   eval      d@0303 = '-'                                 ?           ||
203700020719     C                   eval      d@0411 = c@0310                              ?           ||
203800020719     C                   eval      d@1212 = '-'                                 ?           ||
203900020719     C                   eval      d@1313 = c@1111                              ?           ||
204000020719?2x? C                   else                                                   ?X.........02|
204100020719     C                   eval      x1cuit = *blanks                             ?           ||
204200020719?2e? C                   endif                                                  ?F---------02|
204300020719?1x? C                   else                                                   ?X..........01
204400020719     C                   eval      x1asno = *blanks                             ?            |
204500020719     C                   eval      x1civa = *zeros                              ?            |
204600020719     C                   eval      x1diva = *blanks                             ?            |
204700020719     C                   eval      x1cuit = *blanks                             ?            |
204800041025     C                   eval      x1ruta = *zeros
204900020719?1e? C                   endif                                                  ?F----------01
205000020719     ?*- CODIGO DE FORMA DE PAGO...
205100020719?1b? C                   select                                                 ?P----------01
205200020719?1x? C                   when      x1cfpg = 1                                   ?w----------01
205300020719     C                   eval      x1dfpg = $$e001                              ?            |
205400020719?1x? C                   when      x1cfpg = 2                                   ?w----------01
205500020719     C                   eval      x1dfpg = $$e002                              ?            |
205600020719?1x? C                   when      x1cfpg = 3                                   ?w----------01
205700020719     C                   eval      x1dfpg = $$e003                              ?            |
205800020719?1x? C                   when      x1cfpg = 4                                   ?w----------01
205900020719     C                   eval      x1dfpg = $$e004                              ?            |
206000020719?1x? C                   when      x1cfpg = 5                                   ?w----------01
206100020719     C                   eval      x1dfpg = $$e005                              ?            |
206200020719?1x? C                   when      x1cfpg = 6                                   ?w----------01
206300020719     C                   eval      x1dfpg = $$e006                              ?            |
206400020719?1x? C                   when      x1cfpg = 7                                   ?w----------01
206500020719     C                   eval      x1dfpg = $$e007                              ?            |
206600020719?1x? C                   other                                                  ?w----------01
206700020719     C                   eval      x1dfpg = *blanks                             ?            |
206800020719?1e? C                   endsl                                                  ?F----------01
206900020719     ?*- CODIGO OPERACION GARANTIZADA...
207000020719?1b? C                   select                                                 ?P----------01
207100020719?1x? C                   when      x1cocp = '0'                                 ?w----------01
207200020719     C                   eval      x1sino = $$no                                ?            |
207300020719?1x? C                   when      x1cocp = '1'                                 ?w----------01
207400020719     C                   eval      x1sino = $$si                                ?            |
207500020719?1x? C                   other                                                  ?w----------01
207600020719     C                   eval      x1sino = *blanks                             ?            |
207700020719?1e? C                   endsl                                                  ?F----------01
207800020719     ?*- EMPRESA DE TARJETA...
207900020719?1b? C                   if        x1ctcu <> *zeros                             ?P----------01
208000020719     C     x1ctcu        chain     g1ttc101                           20        ?            |
208100020719     C  n20              movel     dfnomb        x1emta                         ?            |
208200020719     C   20              eval      x1emta = *blanks                             ?            |
208300020719?1x? C                   else                                                   ?X..........01
208400020719     C                   eval      x1emta = *blanks                             ?            |
208500020719?1e? C                   endif                                                  ?F----------01
208600020719     ?*- EDICION DEL NUMERO DE TARJETA...
208700020719?1b? C                   if        x1nrtc <> *zeros                             ?P----------01
208800020719     C                   movel     x1nrtc        p@0120                         ?            |
208900020719     C                   eval      p@2145 = t1ment                              ?            |
209000020719     C                   call      'SPEDI1'                                     ?            |
209100020719     C                   parm                    p@0170                         ?            |
209200020719     C                   eval      x1ment = p@4670                              ?            |
209300020719?1x? C                   else                                                   ?X..........01
209400020719     C                   eval      x1ment = *blanks                             ?            |
209500020719?1e? C                   endif                                                  ?F----------01
209600020719     ?*- INTERMEDIARIO...
209700020719     C     k1@ni2        chain     s1hni201                           20
209800020719     C   20              eval      x1nino = *blanks
209900020719     C  n20              eval      x1nino = dfnomb
210000020719     ?*- COBRADOR...
210100020719     C     k1@ni3        chain     s1hni301                           20
210200020719     C   20              eval      x1cono = *blanks
210300020719     C  n20              eval      x1cono = dfnomb
210400020719     ?*- SOPORTE DE COMERCIALIZACION...
210500020719     C     k4@ni2        chain     s1hni201                           20
210600020719     C   20              eval      x1nin1 = *blanks
210700020719     C  n20              eval      x1nin1 = dfnomb
210800020719     ?*- CODIGO DE SUBARTICULO...
210900020719     C     k1t605        chain     s1t605                             20
211000020719     C   20              eval      x1sard = *blanks
211100020719     C  n20              eval      x1sard = t@sard
211200020719     C                   endsr
211300000904     ?******************************************************
211400020719     C     soli01        begsr
211500020719     ?** SOLICITUD EN PANTALLA 00--------------------------
211600020719     ?*- MONEDA...
211700020719?1b? C                   if        @@camp = 'X1MONE'                            ?P----------01
211800020719     C                   call      'PGG630'                                     ?            |
211900020719     C                   parm                    x1mone                         ?            |
212000020719     C                   parm                    x1nmol                         ?            |
212100020719?1e? C                   endif                                                  ?F----------01
212200020719     ?*- ASEGURADO...
212300040120?1b? C                   if        @@camp = 'X1ASEN' and                        ?P----------01
212400040426     C                                not por_parametros and                    ?            |
212500040426     C                                not spdwy_v1                              ?            |
212600020719     C                   call      'PRO030R'                                    ?            |
212700020719     C                   parm                    x1asen                         ?            |
212800020719     C                   parm      'RT'          @@@end            2            ?            |
212900020719?2b? C                   if        x1asen <> *zeros                             ?P---------02|
213000020719     C     x1asen        chain     g1hdaf                             20        ?           ||
213100020719     C   20              eval      x1asno = *blanks                             ?           ||
213200020719     C  n20              eval      x1asno = dfnomb                              ?           ||
213300020719?2e? C                   endif                                                  ?F---------02|
213400020719?1e? C                   endif                                                  ?F----------01
213500020719     ?*- PAGADOR...
213600020719?1b? C                   if        @@camp = 'X1OPAG'                            ?P----------01
213700020719     C                   call      'PAR034'                                     ?            |
213800020719     C                   parm                    x1opag                         ?            |
213900020719     C                   parm      *blanks       @@opno           40            ?            |
214000020719     C                   parm      '2'           @@reto            1            ?            |
214100020719?1e? C                   endif                                                  ?F----------01
214200020719     ?*- CODIGO DE NIVEL DE INTERMEDIACION...
214300040120?1b? C                   if        (@@camp = 'X1NIVC'  or                       ?P----------01
214400040120     C                             @@camp = 'X1NIVT') and                       ?            |
214500040120     C                               not por_parametros                         ?            |
214600020719     C                   call      'PAR3011'                                    ?            |
214700020719     C                   parm                    x1nivt                         ?            |
214800020719     C                   parm                    x1nivc                         ?            |
214900020719     C                   parm                    x1nino                         ?            |
215000020719     C                   parm      *blanks       endpgm                         ?            |
215100020719?1e? C                   endif                                                  ?F----------01
215200020719     ?*- CODIGO DE COBRADOR...
215300020719?1b? C                   if        @@camp = 'X1CBRN'                            ?P----------01
215400020719     C                   call      'PAR032A2'                                   ?            |
215500020719     C                   parm                    x1cbrn                         ?            |
215600020719     C                   parm                    @@ncbr           40            ?            |
215700020719?1e? C                   endif                                                  ?F----------01
215800020719     ?*- TARJETAS DE CREDITO...
215900020719?1b? C                   if        @@camp = 'X1CTCU'  and                       ?P----------01
216000020719     C                             not *in23                                    ?            |
216100020719     C                   call      'PGG726'                                     ?            |
216200020719     C                   parm                    x1ctcu                         ?            |
216300020719?1e? C                   endif                                                  ?F----------01
216400020719     ?*- CODIGO DE BANCO...
216500020719?1b? C                   if        @@camp = 'X1IVBC'                            ?P----------01
216600020719     C                   call      'PGG666'                                     ?            |
216700020719     C                   parm                    x1ivbc                         ?            |
216800020719     C                   parm                    bcnomb                         ?            |
216900020719     C                   parm      'P'           xxmepg                         ?            |
217000020719?1e? C                   endif                                                  ?F----------01
217100020719     ?*- CODIGO DE SUCURSAL...
217200020719?1b? C                   if        @@camp = 'X1IVSU'                            ?P----------01
217300020719     C                   call      'PGG667'                                     ?            |
217400020719     C                   parm                    x1ivbc                         ?            |
217500020719     C                   parm                    x1ivsu                         ?            |
217600020719     C                   parm                    sbnomb                         ?            |
217700020719     C                   parm      'P'           xxmepg            1            ?            |
217800020719?1e? C                   endif                                                  ?F----------01
217900020719     ?*- CODIGO DE NIVEL DE INTERMEDIACION...
218000020719?1b? C                   if        @@camp = 'X1NIT1'  or                        ?P----------01
218100020719     C                             @@camp = 'X1NIC1'                            ?            |
218200020719     C                   call      'PAR3011'                                    ?            |
218300020719     C                   parm                    x1nit1                         ?            |
218400020719     C                   parm                    x1nic1                         ?            |
218500020719     C                   parm                    x1nin1                         ?            |
218600020719     C                   parm      *blanks       endpgm                         ?            |
218700020719?1e? C                   endif                                                  ?F----------01
218800020719     ?*- CODIGO DE SUBARTICULO...
218900020719?1b? C                   if        @@camp = 'X1SARC'                            ?P----------01
219000020719     C                   call      'DBA605'                                     ?            |
219100020719     C                   parm                    @@arcd                         ?            |
219200020719     C                   parm                    t@arno                         ?            |
219300020719     C                   parm                    x1sarc                         ?            |
219400020719     C                   parm                    x1sard                         ?            |
219500020719?1e? C                   endif                                                  ?F----------01
219600020719     C                   endsr
219700000904     ?******************************************************
219800020719     C     vali01        begsr
219900020719     ?** GRABACION PANTALLA 00-----------------------------
220000020719     C                   clear                   x1xopr
220100020719     C                   clear                   x1copr
220200020719     ?** MONEDA...
220300020719     C     x1mone        chain     g1tmon                             20
220400020719     C   20              z-add     61            @e                   50
220500020719     ?** VALIDACION DEL ASEGURADO...
220600020719     ?* Toda vez que se cambie el asegurado se refrescan
220700020719     ?* los datos que pueden ser dependientes del mismo,
220800020719     ?* esto es, código de iva, número de cuit, nivel de
220900020719     ?* intermediación asociado y datos del cobrador, luego
221000020719     ?* puede ser que por distinto tipo de cobranza el
221100020719     ?* cobrador deba ser eliminado...
221200020719?1b? C                   if        not *in50                                    ?P----------01
221300020719     C     x1asen        chain     s1hase01                           20        ?            |
221400020719     C  n20x1asen        chain     g1hdaf                             20        ?            |
221500020719?2b? C                   if        *in20                                        ?P---------02|
221600020719     C                   z-add     51            @e                   50        ?           ||
221700020719?2x? C                   else                                                   ?X.........02|
221800020719     ?* mostrar pendiente por asegurado...                                      ?           ||
221900020719?3b? C                   if        w0tiou = 2  and                              ?P--------03||
222000020719     C                             @@ma29 = '1'  and                            ?          |||
222100020719     C                             x1asen <> @4asen  or                         ?          |||
222200020719     C                             w0tiou = 3  and                              ?          |||
222300020719     C                             w0stos = 01  and                             ?          |||
222400020719     C                             @@ma29 = '1'  and                            ?          |||
222500020719     C                             x1asen <> @4asen                             ?          |||
222600020719     ?* mostrar pendiente por asegurado...                                      ?          |||
222700020719     C                   call      'PAR310B'                                    ?          |||
222800020719     C                   parm                    x1asen                         ?          |||
222900020719     ?* mostrar siniestros por aegurado...                                      ?          |||
223000020719     C                   call      'PAR310S'                                    ?          |||
223100020719     C                   parm                    x1asen                         ?          |||
223200020719     ?* guardar asegurado para no repetir la muestra...                         ?          |||
223300020719     C                   eval      @4asen = x1asen                              ?          |||
223400020719?3e? C                   endif                                                  ?F--------03||
223500020719     ?* refrescar el codigo de iva y el cuit...                                 ?           ||
223600020719?3b? C                   if        x1civa = *zeros  or                          ?P--------03||
223700020719     C                             x1asen <> @@asen                             ?          |||
223800020719     C                   eval      x1civa = asciva                              ?          |||
223900020719     C                   eval      @@asen = x1asen                              ?          |||
224000020719?3e? C                   endif                                                  ?F--------03||
224100020719     ?* refrescar el nivel de intermediación...                                 ?           ||
224200020719?3b? C                   if        x1nivt = *zeros  and                         ?P--------03||
224300020719     C                             x1nivc = *zeros  and                         ?          |||
224400020719     C                             asnivt <> *zeros  and                        ?          |||
224500020719     C                             asnivc <> *zeros  or                         ?          |||
224600020719     C                             x1asen <> @1asen  and                        ?          |||
224700020719     C                             asnivt <> *zeros  and                        ?          |||
224800020719     C                             asnivc <> *zeros                             ?          |||
224900020719     C                   eval      x1nivt = asnivt                              ?          |||
225000020719     C                   eval      x1nivc = asnivc                              ?          |||
225100020719     C                   eval      @1asen = x1asen                              ?          |||
225200020719?3e? C                   endif                                                  ?F--------03||
225300020719     ?* refrescar datos del cobrador...                                         ?           ||
225400020719?3b? C                   if        x1asen <> @2asen  and                        ?P--------03||
225500020719     C                             ascbrn <> *zeros                             ?          |||
225600020719     C                   eval      x1cbrn = ascbrn                              ?          |||
225700020719     C                   eval      @2asen = x1asen                              ?          |||
225800020719?3e? C                   endif                                                  ?F--------03||
225900020719     ?* refrescar datos de zona de cobranza...                                  ?           ||
226000020719?3b? C                   if        x1asen <> @3asen  and                        ?P--------03||
226100020719     C                             asczco <> *zeros                             ?          |||
226200020719     C                   eval      x1czco = asczco                              ?          |||
226300020719     C                   eval      @3asen = x1asen                              ?          |||
226400020719?3e? C                   endif                                                  ?F--------03||
226500020719?2e? C                   endif                                                  ?F---------02|
226600020719?1e? C                   endif                                                  ?F----------01
226700040715     ?*- CODIGO BLOQUEO DE IVA...                          |
226800040715?1b? C                   if        not *in50                                    |
226900040715     C     x1civa        chain     gntiv1                             20        |
227000040715?2b? C                   if        not *in20
227100040715?3b? C                   if        i1bloq = 'B'
227200040715     C                   seton                                        5073      |
227300040715?3e? C                   endif                                                  |
227400040715?2e? C                   endif                                                  |
227500040715?1e? C                   endif                                                  |
227600141021     ?*- Persona Jurídica, no puede ser Consumidor Final...
227700141021?1b? C                   if        not *in50                                    |
227800141021     C     x1asen        chain     gnhdaf
227900141021     C                   if        dftiso <> 98 and dftiso <> 80 and
228000141021     C                             dftiso <> 81 and x1civa = 5
228100141021     C                   z-add     48            @e                   50        ?           ||
228200141021     C                   endif
228300141021?1e? C                   endif                                                  |
228400020719     ?** ASEGURADO BLOQUEADO...
228500020719?1b? C                   if        not *in50                                    ?P----------01
228600020719?2b? C                   select                                                 ?P---------02|
228700020719?2x? C                   when      asbloq = '1'  and                            ?w---------02|
228800020719     C                             w0tiou = 1                                   ?           ||
228900140905     C                   z-add     13            @e                   50        ?           ||
229000020719?2x? C                   when      asbloq = '2'  and                            ?w---------02|
229100020719     C                             w0tiou <= 2                                  ?           ||
229200140905     C                   z-add     13            @e                   50        ?           ||
229300020719?2x? C                   when      asbloq = '3'  and                            ?w---------02|
229400020719     C                             w0tiou <= 3                                  ?           ||
229500140905     C                   z-add     13            @e                   50        ?           ||
229600020719?2e? C                   endsl                                                  ?F---------02|
229700020719?1e? C                   endif                                                  ?F----------01
229800020719     ?** ASEGURADO CON DATOS INCOMPLETOS...
229900020719?1b? C                   if        not *in50                                    ?P----------01
230000020719     C                   clear                   dffnaa                         ?            |
230100020719     C     x1asen        chain     g1hda1                             20        ?            |
230200020719?2b? C                   select                                                 ?P---------02|
230300020719?2x? C                   when      dftiso = *zeros                              ?w---------02|
230400020719     C                   z-add     62            @e                   50        ?           ||
230500020719?2x? C                   when      dftiso = 98                                  ?w---------02|
230600020719?3b? C                   if        dftido = *zeros  and                         ?P--------03||
230700020719     C                             dfnrdo = *zeros  or                          ?          |||
230800041022     C                             es_vida(z0rama) and
230900020719     C                             dffnaa = *zeros                              ?          |||
231000020719     C                   z-add     62            @e                   50        ?          |||
231100020719?3e? C                   endif                                                  ?F--------03||
231200020719?2x? C                   when      dftiso = 99                                  ?w---------02|
231300090202?2x? C                   when      dftiso = 81                                  ?w---------02|
231400020719?2x? C                   other                                                  ?w---------02|
231500020719?3b? C                   if        dfcuit = *blanks                             ?P--------03||
231600020719     C                   z-add     62            @e                   50        ?          |||
231700020719?3e? C                   endif                                                  ?F--------03||
231800020719?2e? C                   endsl                                                  ?F---------02|
231900020719?1e? C                   endif                                                  ?F----------01
232000020719     ?** ASEGURADO CON ANULACIONES POR FALTA DE PAGO
232100020719     ?* borrar mensaje de aviso cuando cambia el asegurado
232200020719?1b? C                   if        not *in50  and                               ?P----------01
232300020719     C                             x1asen <> @5asen                             ?            |
232400020719     C                   eval      @@in91 = *zeros                              ?            |
232500020719     C                   eval      @5asen = x1asen                              ?            |
232600020719?1e? C                   endif                                                  ?F----------01
232700020719     ?** ASEGURADO CON ANULACIONES POR FALTA DE PAGO...
232800020719?1b? C                   if        not *in50  and                               ?P----------01
232900020719     C                             w0tiou <= 2  and                             ?            |
233000020719     C                             @@ma40 = '1'  and                            ?            |
233100150810     C                             @@in91 <= 1                                  ?            |
233200100712     C                   call      'SPANXFP'
233300100712     C                   parm                    @@empr
233400100712     C                   parm                    @@sucu
233500100712     C                   parm                    x1asen
233600100712     C                   parm                    @@sino
233700100712     C                   parm      *blanks       endpgm
233800100712     C                   if        @@sino
233900100712     C                   z-add     91            @e                   50
234000100712     C                   add       1             @@in91
234100020719?1e? C                   endif                                                  ?F----------01
234200100712?1e? C                   endif                                                  ?F----------01
234300020719     ?** CODIGO DE IVA...
234400020719?1b? C                   if        not *in50  and                               ?P----------01
234500020719     C                             x1civa <> 1  and                             ?            |
234600020719     C                             x1civa <> 2  and                             ?            |
234700020719     C                             x1civa <> 3  and                             ?            |
234800020719     C                             x1civa <> 4  and                             ?            |
234900020719     C                             x1civa <> 5  and                             ?            |
235000020719     C                             x1civa <> 6  and                             ?            |
235100020719     C                             x1civa <> 7                                  ?            |
235200020719     C                   z-add     86            @e                   50        ?            |
235300020719?1e? C                   endif                                                  ?F----------01
235400020719     ?** OTRA DEL CODIGO DE IVA...
235500020719?1b? C                   if        not *in50                                    ?P----------01
235600020719?2b? C                   select                                                 ?P---------02|
235700020719?2x? C                   when      @@ma30 = '0'                                 ?w---------02|
235800020719?2x? C                   when      @@ma30 = '5'  and                            ?w---------02|
235900020719     C                             x1civa <> 5                                  ?           ||
236000020719     C                   z-add     86            @e                   50        ?           ||
236100020719?2e? C                   endsl                                                  ?F---------02|
236200020719?1e? C                   endif                                                  ?F----------01
236300020719     ?*- OTRA DEL CODIGO DE IVA...
236400020719?1b? C                   if        not *in50                                    ?P----------01
236500020719?2b? C                   if        x1civa = 1  and                              ?P---------02|
236600020719     C                             dfcuit = *blanks  or                         ?           ||
236700020719     C                             x1civa = 2  and                              ?           ||
236800020719     C                             dfcuit = *blanks  or                         ?           ||
236900020719     C                             x1civa = 6  and                              ?           ||
237000020719     C                             dfcuit = *blanks                             ?           ||
237100020719     C                   z-add     87            @e                   50        ?           ||
237200020719?2e? C                   endif                                                  ?F---------02|
237300020719?1e? C                   endif                                                  ?F----------01
237400020719     ?** PAGADOR...
237500020719     ?*- ESTA VALIDACION DEBE HACERSE DESPUES DE TODAS LAS
237600020719     ?*- VALIDACIONES DE ASEGURADO PORQUE CAMBIA EL REGIS-
237700020719     ?*- TRO DEL GNHDAF...
237800020719?1b? C                   if        not *in50                                    ?P----------01
237900020719     ?*- NO PAGADOR PROPONER ASEGURADO...                                       ?            |
238000020719?2b? C                   if        x1opag = *zeros                              ?P---------02|
238100020719     C                   eval      x1opag = x1asen                              ?           ||
238200020719?2e? C                   endif                                                  ?F---------02|
238300020719     C     x1opag        chain     g1hdaf                             20        ?            |
238400020719     C   20              z-add     52            @e                   50        ?            |
238500020719?1e? C                   endif                                                  ?F----------01
238600020719     ?*- NUEVA VALIDACION SI ES DISTINTO EL PAGADOR AL
238700020719     ?*- ASEGURADO...
238800020719?1b? C                   if        not *in50  and                               ?P----------01
238900020719     C                             x1opag <> x1asen                             ?            |
239000020719     C     k1@ni8        chain     s1hni8                             20        ?            |
239100020719     C   20              z-add     52            @e                   50        ?            |
239200020719?1e? C                   endif                                                  ?F----------01
239300020719     ?*- FECHA DE INGRESO DE PROPUESTA...
239400020719?1b? C                   if        not *in50  and                               ?P----------01
239500020719     C                             x1fing <> *zeros                             ?            |
239600020719     C                   eval      p@flap = *zeros                              ?            |
239700020719     C                   eval      p@ffec = x1fing                              ?            |
239800020719     C                   call      'SPFECH'                                     ?            |
239900020719     C                   parm                    p@fech                         ?            |
240000020719?2b? C                   if        p@flap = *zeros                              ?P---------02|
240100020719     C                   seton                                        50        ?           ||
240200020719     C                   eval      @e = 53                                      ?           ||
240300020719?2x? C                   else                                                   ?X.........02|
240400020719     C                   eval      x1fing = p@ffec                              ?           ||
240500020719?2e? C                   endif                                                  ?F---------02|
240600020719?1e? C                   endif                                                  ?F----------01
240700020902     ?** FECHA DE INICIO DE PROPUESTA VALIDA ...
240800020719?1b? C                   if        not *in50                                    ?P----------01
240900020918?2b? C                   if        w0tiou <= 2                                  ?P---------02|
241000020719     C                   eval      p@flap = *zeros                              ?           ||
241100020902     C                   eval      p@ffec = x1fing                              ?           ||
241200020719     C                   call      'SPFECH'                                     ?           ||
241300020719     C                   parm                    p@fech                         ?           ||
241400020719?3b? C                   if        p@flap = *zeros                              ?P--------03||
241500020719     C                   seton                                        50        ?          |||
241600020902     C                   eval      @e = 53                                      ?          |||
241700020719?3x? C                   else                                                   ?X........03||
241800020902     C                   eval      x1fing = p@ffec                              ?          |||
241900020719?3e? C                   endif                                                  ?F--------03||
242000020918?2e? C                   endif                                                  ?F---------02|
242100020719?1e? C                   endif                                                  ?F----------01
242200020902     ?** FECHA DE INICIO DE VIGENCIA...
242300020902?1b? C                   if        not *in50                                    ?P----------01
242400020902     C                   eval      p@flap = *zeros                              ?            |
242500020902     C                   eval      p@ffec = x1desd                              ?            |
242600020902     C                   call      'SPFECH'                                     ?            |
242700020902     C                   parm                    p@fech                         ?            |
242800020902?2b? C                   if        p@flap = *zeros                              ?P---------02|
242900020902     C                   seton                                        50        ?           ||
243000020902     C                   eval      @e = 54                                      ?           ||
243100020902?2x? C                   else                                                   ?X.........02|
243200020902     C                   eval      x1desd = p@ffec                              ?           ||
243300020902?2e? C                   endif                                                  ?F---------02|
243400020902?1e? C                   endif                                                  ?F----------01
243500020719     ?*- FECHA DE INICIO DE VIGENCIA DE REHABILITACION
243600020719     ?*- DEBE SER MAYOR O IGUAL A INICIO DE VIGENCIA
243700020719     ?*- PROPUESTO...
243800020719?1b? C                   if        not *in50  and                               ?P----------01
243900020719     C                             w0tiou = 5                                   ?            |
244000020719     C                   eval      p@fdma = x1desd                              ?            |
244100020719     C                   eval      p@1aÑo = p@faÑo                              ?            |
244200020719     C                   eval      p@1mes = p@fmes                              ?            |
244300020719     C                   eval      p@1dia = p@fdia                              ?            |
244400020719     C                   eval      @4desd = p@famd                              ?            |
244500020719?2b? C                   if        @4desd < @3desd                              ?P---------02|
244600020719     C                   z-add     54            @e                   50        ?           ||
244700020719?2e? C                   endif                                                  ?F---------02|
244800020719?1e? C                   endif                                                  ?F----------01
244900020719     ?*- DURACION DEL PERIODO...
245000020719?1b? C                   if        not *in50  and                               ?P----------01
245100020719     C                             x1dupe = *zeros                              ?            |
245200050117     C                   eval      @e = 56                                      ?            |
245300020719?1e? C                   endif                                                  ?F----------01
245400050117     ?*- SI DUPE = 99, FECHA HASTA DEBE SER 99/99/9999...
245500050121     ?*- Solo en nuevas/renovaciones...
245600050117     C                   if        not *in50 and
245700050117     C                             x1dupe = 99 and
245800050121     C                             x1hast <> 99999999 and
245900050121     C                             w0tiou <= 2
246000050117     C                   z-add     94            @e                   50        ?           ||
246100050117     C                   endif
246200050117     ?*- SI FECHA HASTA = 99/99/9999, DUPE DEBE SER 99...
246300050121     ?*- SOLO EN NUEVAS Y RENOVACIONES...
246400050117     C                   if        not *in50 and
246500050117     C                             x1dupe <> 99 and
246600050121     C                             x1hast = 99999999 and
246700050121     C                             w0tiou <= 2
246800050117     C                   z-add     95            @e                   50        ?           ||
246900050117     C                   endif
247000020719     ?*- FECHA DE FIN DE VIGENCIA...
247100020719?1b? C                   if        not *in50                                    ?P----------01
247200020719     ?*  VIGENCIA HASTA SE CALCULA SOLO EN POLIZA NUEVA                         ?            |
247300020719     ?*  Y CUANDO LA MISMA ESTÀ EN CERO O BIEN TODA VEZ                         ?            |
247400020719     ?*  QUE CAMBIA LA VIGENCIA DESDE, Y EN EL CASO DE                          ?            |
247500020719     ?*  VIDA ENTERA SIEMPRE AJUSTA EN BASE A LA FECHA DE                       ?            |
247600020719     ?*  NACIMIENTO...                                                          ?            |
247700020719?2b? C                   if        w0tiou <= 2  and                             ?P---------02|
247800020719     C                             x1hast = *zeros  or                          ?           ||
247900020719     C                             w0tiou <= 2  and                             ?           ||
248000020719     C                             x1desd <> @1desd  and                        ?           ||
248100020719     C                             x1hast <> 99999999  and                      ?           ||
248200020719     C                             x1hast = *zeros  or                          ?           ||
248300020719     C                             w0tiou <= 2  and                             ?           ||
248400020719     C                             x1mar5 = '3'                                 ?           ||
248500020719     C                   eval      @1desd = x1desd                              ?           ||
248600020719     C                   eval      x1hast = x1desd                              ?           ||
248700020719?3b? C                   select                                                 ?P--------03||
248800020719?3x? C                   when      x1mar5 = '1'                                 ?w--------03||
248900020719     C                   call      'SP0001'                                     ?          |||
249000020719     C                   parm                    x1hast                         ?          |||
249100020719     C                   parm                    x1dupe                         ?          |||
249200020719?3x? C                   when      x1mar5 = '2'                                 ?w--------03||
249300020719     C                   eval      p@fdma = x1desd                              ?          |||
249400020719     C                   add       x1dupe        p@faÑo                         ?          |||
249500020719     C                   eval      x1hast = p@fdma                              ?          |||
249600020719     ?*- EXPRESADA EN AÑOS HASTA CANTIDAD DE MESES...                           ?          |||
249700020719?3x? C                   when      x1mar5 = '3'                                 ?w--------03||
249800020719     C     x1asen        chain     g1hda1                             20        ?          |||
249900020719?4b? C                   if        not *in20                                    ?P-------04|||
250000020719     C                   eval      p@fdia = dffnad                              ?         ||||
250100020719     C                   eval      p@fmes = dffnam                              ?         ||||
250200020719     C     dffnaa        add       x1dupe        p@faÑo                         ?         ||||
250300020719     C                   eval      x1hast = p@fdma                              ?         ||||
250400020719?4x? C                   else                                                   ?X.......04|||
250500020719     C                   eval      x1hast = *zeros                              ?         ||||
250600020719?4e? C                   endif                                                  ?F-------04|||
250700020719?3e? C                   endsl                                                  ?F--------03||
250800020719?2e? C                   endif                                                  ?F---------02|
250900020719     ?*- AHORA VALIDAR LA FECHA...                                              ?            |
251000020719?2b? C                   if        x1hast <> 99999999                           ?P---------02|
251100020719     C                   eval      p@flap = *zeros                              ?           ||
251200020719     C                   eval      p@ffec = x1hast                              ?           ||
251300020719     C                   call      'SPFECH'                                     ?           ||
251400020719     C                   parm                    p@fech                         ?           ||
251500020719?3b? C                   if        p@flap = *zeros                              ?P--------03||
251600020719     C                   seton                                        50        ?          |||
251700020719     C                   eval      @e = 55                                      ?          |||
251800020719?3x? C                   else                                                   ?X........03||
251900020719     C                   eval      x1hast = p@ffec                              ?          |||
252000020719?3e? C                   endif                                                  ?F--------03||
252100020719?2e? C                   endif                                                  ?F---------02|
252200020719?1e? C                   endif                                                  ?F----------01
252300020719     ?*- COMPARACION DE LAS FECHAS...
252400020719?1b? C                   if        not *in50                                    ?P----------01
252500020719     C                   eval      p@fdma = x1desd                              ?            |
252600020719     C                   eval      p@1aÑo = p@faÑo                              ?            |
252700020719     C                   eval      p@1mes = p@fmes                              ?            |
252800020719     C                   eval      p@1dia = p@fdia                              ?            |
252900020719     C                   eval      @2desd = p@famd                              ?            |
253000020719     C                   eval      p@fdma = x1hast                              ?            |
253100020719     C                   eval      p@1aÑo = p@faÑo                              ?            |
253200020719     C                   eval      p@1mes = p@fmes                              ?            |
253300020719     C                   eval      p@1dia = p@fdia                              ?            |
253400020719     C                   eval      @2hast = p@famd                              ?            |
253500050117?2b? C                   if        @2desd >= @2hast                             ?P---------02|
253600020719     C                   z-add     57            @e                   50        ?           ||
253700020719?2e? C                   endif                                                  ?F---------02|
253800020719?1e? C                   endif                                                  ?F----------01
253900020719     ?** COTIZACION MONEDA...
254000020719?1b? C                   if        not *in50                                    ?P----------01
254100020719     ?*- VERIFICA QUE DEBE HACER...                                             ?            |
254200020719?2b? C                   select                                                 ?P---------02|
254300020719     ?*- SI SE TRATA DE MONEDA EXTRANJERA...                                    ?           ||
254400020719?2x? C                   when      momoeq <> 'AU'                               ?w---------02|
254500020719     ?*- RECALCULA CUANDO NO TIENE VALOR O CUANDO HAN                           ?           ||
254600020719     ?*- CAMBIADO LA MONEDA O LA FECHA DESDE, ES DECIR                          ?           ||
254700020719     ?*- LOS PARAMETROS PARA LA BUSQUEDA DE COTIZACION...                       ?           ||
254800020719     ?*          X1COME    IFEQ *ZEROS                                          ?           ||
254900020719     ?*          X1MONE    ORNE $$MONE                                          ?           ||
255000020719     ?*          X1DESD    ORNE $$DESD                                          ?           ||
255100020719     ?*                    CALL 'SP0052'                                        ?           ||
255200020719     ?*                    PARM           X1MONE                                ?           ||
255300020719     ?*                    PARM X1DESD    @@DESD                                ?           ||
255400020719     ?*                    PARM           X1COME                                ?           ||
255500020719     ?*                    PARM 'C'       @@TIPC  1                             ?           ||
255600020719     ?*                    END                                                  ?           ||
255700020719     C                   call      'PAR310X3'                                   ?           ||
255800020719     C                   parm                    usempr                         ?           ||
255900020719     C                   parm      *zeros        @1fema            4 0          ?           ||
256000020719     C                   parm      *zeros        @1femm            2 0          ?           ||
256100020719     C                   parm      *zeros        @1femd            2 0          ?           ||
256200020719     C                   eval      @@fema = @1fema                              ?           ||
256300020719     C                   eval      @@femm = @1femm                              ?           ||
256400020719     C                   eval      @@femd = @1femd                              ?           ||
256500020719     C                   call      'SP0052'                                     ?           ||
256600020719     C                   parm                    x1mone                         ?           ||
256700020719     C                   parm      @@fech        @@desd                         ?           ||
256800020719     C                   parm                    x1come                         ?           ||
256900040426     C                   parm      'V'           @@tipc            1            ?           ||
257000020719     ?*- SI AUN ESTA EN CERO ES ERROR...                                        ?           ||
257100020719?3b? C                   if        x1come = *zeros                              ?P--------03||
257200020719     C                   z-add     63            @e                   50        ?          |||
257300020719?3e? C                   endif                                                  ?F--------03||
257400020719     ?*- SI SE TRATA DE MONEDA LOCAL...                                         ?           ||
257500020719?2x? C                   when      momoeq = 'AU'                                ?w---------02|
257600020719?3b? C                   if        x1come <> *zeros  or                         ?P--------03||
257700020719     C                             x1mone <> $$mone  or                         ?          |||
257800020719     C                             x1desd <> $$desd                             ?          |||
257900020719     C                   eval      x1come = *zeros                              ?          |||
258000020719?3e? C                   endif                                                  ?F--------03||
258100020719     ?*- SI AUN ESTA TIENE VALOR ES ERROR...                                    ?           ||
258200020719?3b? C                   if        x1come <> *zeros                             ?P--------03||
258300020719     C                   z-add     63            @e                   50        ?          |||
258400020719?3e? C                   endif                                                  ?F--------03||
258500020719?2e? C                   endsl                                                  ?F---------02|
258600020719?1e? C                   endif                                                  ?F----------01
258700020719     ?** TIPO DE INTERMEDIARIO...
258800020719?1b? C                   if        not *in50                                    ?P----------01
258900020719     C     k1@ni1        chain     s1hni1                             20        ?            |
259000020719     C   20              z-add     58            @e                   50        ?            |
259100020719?1e? C                   endif                                                  ?F----------01
259200020719     ?** NUMERO DE INTERMEDIARIO...
259300020719?1b? C                   if        not *in50                                    ?P----------01
259400020719     C     k1@ni2        chain     s1hni201                           20        ?            |
259500020719     C   20              z-add     59            @e                   50        ?            |
259600020719?1e? C                   endif                                                  ?F----------01
259700020719     ?** BLOQUEO INTERMEDIARIO...
259800020719?1b? C                   if        not *in50                                    ?P----------01
259900020719?2b? C                   select                                                 ?P---------02|
260000020719?2x? C                   when      n2bloq = '1'  and                            ?w---------02|
260100020719     C                             w0tiou = 1                                   ?           ||
260200020719     C                   z-add     60            @e                   50        ?           ||
260300020719?2x? C                   when      n2bloq = '2'  and                            ?w---------02|
260400020719     C                             w0tiou <= 2                                  ?           ||
260500020719     C                   z-add     60            @e                   50        ?           ||
260600020719?2x? C                   when      n2bloq = '3'  and                            ?w---------02|
260700020719     C                             w0tiou <= 3                                  ?           ||
260800020719     C                   z-add     60            @e                   50        ?           ||
260900020719?2e? C                   endsl                                                  ?F---------02|
261000020719?1e? C                   endif                                                  ?F----------01
261100020719     ?** BLOQUEADO ALGUNO DE LA CADENA...
261200020719?1b? C                   if        not *in50                                    ?P----------01
261300020719     C                   exsr      verblo                                       ?            |
261400020719?1e? C                   endif                                                  ?F----------01
261500020719     ?** CODIGO DE FORMA DE PAGO...
261600020719?1b? C                   if        not *in50                                    ?P----------01
261700020719?2b? C                   if        x1cfpg <> 1  and                             ?P---------02|
261800020719     C                             x1cfpg <> 2  and                             ?           ||
261900020719     C                             x1cfpg <> 3  and                             ?           ||
262000020719     C                             x1cfpg <> 4  and                             ?           ||
262100020719     C                             x1cfpg <> 5  and                             ?           ||
262200020719     C                             x1cfpg <> 6  and                             ?           ||
262300020719     C                             x1cfpg <> 7                                  ?           ||
262400020719     C                   z-add     70            @e                   50        ?           ||
262500020719?2x? C                   else                                                   ?X.........02|
262600020719     C                   eval      @@cfpg = x1cfpg                              ?           ||
262700020719?2e? C                   endif                                                  ?F---------02|
262800020719?1e? C                   endif                                                  ?F----------01
262900020719     ?** CODIGO DE RECIBO/SOLICITUD...
263000020719?1b? C                   if        not *in50  and                               ?P----------01
263100020719     C                             x1strg <> 'R'  and                           ?            |
263200020719     C                             x1strg <> 'S'  and                           ?            |
263300020719     C                             x1strg <> 'N'                                ?            |
263400020719     C                   z-add     36            @e                   50        ?            |
263500020719?1e? C                   endif                                                  ?F----------01
263600020719     ?** CODIGO DE RECIBO/SOLICITUD ES OBLIGATORIO SEGUN
263700020719     ?** FORMAS DE PAGO, CUANDO ES SUSPENDIDA ESPECIAL Y
263800020719     ?** ES SUPERPOLIZA NUEVA...
263900020719?1b? C                   if        not *in50  and                               ?P----------01
264000020719     C                             @@sspo = *zeros                              ?            |
264100020719?2b? C                   if        @@mar2 = '1'  or                             ?P---------02|
264200020719     C                             @@mar2 = '2'                                 ?           ||
264300020719?3b? C                   if        x1cfpg = 4  or                               ?P--------03||
264400020719     C                             x1cfpg = 5                                   ?          |||
264500020719?4b? C                   if        x1strg <> 'R'  and                           ?P-------04|||
264600020719     C                             x1strg <> 'S'                                ?         ||||
264700020719     C                   z-add     27            @e                   50        ?         ||||
264800020719?4e? C                   endif                                                  ?F-------04|||
264900020719?3e? C                   endif                                                  ?F--------03||
265000020719?2e? C                   endif                                                  ?F---------02|
265100020719?1e? C                   endif                                                  ?F----------01
265200020719     ?** CODIGO DE SOLICITUD...
265300020719?1b? C                   if        not *in50  and                               ?P----------01
265400020719     C                             x1strg = 'S'  and                            ?            |
265500020719     C                             x1conr = *zeros                              ?            |
265600020719     C                   z-add     37            @e                   50        ?            |
265700020719?1e? C                   endif                                                  ?F----------01
265800020719     ?** CODIGO DE RECIBO DEBE EXISTIR CUANDO ES FORMA DE
265900020719     ?** PAGO 6...
266000020719?1b? C                   if        not *in50  and                               ?P----------01
266100020719     C                             x1cfpg = 6  and                              ?            |
266200020719     C                             x1strg <> 'R'                                ?            |
266300020719     C                   z-add     24            @e                   50        ?            |
266400020719?1e? C                   endif                                                  ?F----------01
266500020719     ?** CODIGO DE RECIBO/SOLICITUD NO APLICABLE...
266600020719?1b? C                   if        not *in50  and                               ?P----------01
266700020719     C                             x1strg = 'N'  and                            ?            |
266800020719     C                             x1conr <> *zeros                             ?            |
266900020719     C                   z-add     38            @e                   50        ?            |
267000020719?1e? C                   endif                                                  ?F----------01
267100020719     ?** CODIGO DE RECIBO DEBE EXISTIR...
267200020719?1b? C                   if        not *in50  and                               ?P----------01
267300020719     C                             x1strg = 'R'                                 ?            |
267400020719     C                   z-add     x1conr        @@conr                         ?            |
267500020719     C     k1@cr0        setll     p1hcr002                               98    ?            |
267600020719     C   98k2@cr0        reade     p1hcr002                               99    ?            |
267700020719     C  n98k2@cr0        readpe    p1hcr002                               99    ?            |
267800020719?2b? C                   if        *in99  and                                   ?P---------02|
267900020719     C                             $zma03 <> '0'                                ?           ||
268000020719     C                   z-add     49            @e                   50        ?           ||
268100020719?2x? C                   else                                                   ?X.........02|
268200020719?3b? C                   if        x1conr > r0ivnh  and                         ?P--------03||
268300020719     C                             not *in99  and                               ?          |||
268400020719     C                             $zma03 <> '0'                                ?          |||
268500020719     C                   z-add     49            @e                   50        ?          |||
268600020719?3e? C                   endif                                                  ?F--------03||
268700020719?2e? C                   endif                                                  ?F---------02|
268800020719?1e? C                   endif                                                  ?F----------01
268900020719     ?** QUE EL RECIBO NO ESTE COBRADO..
269000020719     ?*          *IN50     IFEQ '0'
269100020719     ?*          X1STRG    ANDEQ'R'
269200020719     ?*          K1@CR1    CHAINP1HCR1               20
269300020719     ?* N20                Z-ADD48        @E         50
269400020719     ?*                    END
269500040818     ?* El Cobrador y el Vendedor deben ser el mismo...
269600040818     ?* Forma de Pago COBRADORES...
269700040818?1b? C                   if        not *in50
269800040818     C                                 and (x1cfpg = 4 or x1cfpg =5)
269900040818     C                                 and x1nivc <> x1cbrn
270000040818     C                   z-add     64            @e                   50
270100040818?1e? C                   endif
270200020719     ?** VALIDACIONES PARA FORMA DE PAGO=4/5/6 COBRADOR...
270300020719     ?** REGISTRO EN ARCHIVO COBRADORES...
270400020719?1b? C                   if        not *in50                                    ?P----------01
270500020719?2b? C                   if        x1cfpg = 4  or                               ?P---------02|
270600020719     C                             x1cfpg = 5                                   ?           ||
270700020719     C     k1@ni3        chain     s1hni301                           20        ?           ||
270800020719     C   20              z-add     72            @e                   50        ?           ||
270900020719?2e? C                   endif                                                  ?F---------02|
271000020719?1e? C                   endif                                                  ?F----------01
271100000904     ?** COBRADORES/ZONA DE COBRANZA...
271200020719?1b? C                   if        not *in50                                    ?P----------01
271300020719?2b? C                   if        x1cfpg = 4  or                               ?P---------02|
271400020719     C                             x1cfpg = 5                                   ?           ||
271500020719     C     k1@ni4        chain     s1hni4                             20        ?           ||
271600020719     C   20              z-add     74            @e                   50        ?           ||
271700020719?2e? C                   endif                                                  ?F---------02|
271800020719?1e? C                   endif                                                  ?F----------01
271900020719     ?** COBRADORES Y CODIGO DE PAGO...
272000020719?1b? C                   if        not *in50                                    ?P----------01
272100020719     ?* Cobrador mutual y codigo de pago de cobrador comun                      ?            |
272200020719?2b? C                   if        x1cfpg = 4  and                              ?P---------02|
272300020719     C                             n3csts = '1'                                 ?           ||
272400020719     C                   z-add     40            @e                   50        ?           ||
272500020719?2e? C                   endif                                                  ?F---------02|
272600020719?1e? C                   endif                                                  ?F----------01
272700020719     ?** COBRADORES Y CODIGO DE PAGO...
272800020719?1b? C                   if        not *in50                                    ?P----------01
272900020719     ?* Cobrador no mutual y codigo de pago 5 de mutual                         ?            |
273000020719?2b? C                   if        x1cfpg = 5  and                              ?P---------02|
273100020719     C                             n3csts <> '1'                                ?           ||
273200020719     C                   z-add     40            @e                   50        ?           ||
273300020719?2e? C                   endif                                                  ?F---------02|
273400020719?1e? C                   endif                                                  ?F----------01
273500020719     ?** COBRADORES Y NUMERO DE LEGAJO...
273600020719?1b? C                   if        not *in50                                    ?P----------01
273700020719     ?* Cobrador no mutual y informa codigo de legajo...                        ?            |
273800020719?2b? C                   if        x1cfpg = 4  and                              ?P---------02|
273900020719     C                             n3csts = '0'  and                            ?           ||
274000020719     C                             x1nrln <> *zeros                             ?           ||
274100020719     C                   z-add     75            @e                   50        ?           ||
274200020719?2e? C                   endif                                                  ?F---------02|
274300020719     ?* Cobrador es mutual y falta numero de legajo                             ?            |
274400020719?2b? C                   if        x1cfpg = 5  and                              ?P---------02|
274500020719     C                             n3csts = '1'  and                            ?           ||
274600020719     C                             x1nrln = *zeros                              ?           ||
274700020719     C                   z-add     75            @e                   50        ?           ||
274800020719?2e? C                   endif                                                  ?F---------02|
274900020719?1e? C                   endif                                                  ?F----------01
275000110131     ?** Validacion por Vida Obligatorio...
275100110623?1b? C*                  if        not *in50                                    ?P----------01
275200110623     C*    k1t621        chain     s1t621                             20
275300110623?1b? C*                  if        not *in20                                    ?P----------01
275400110623     C*                  if        t@rama = 89
275500110623     C*                  if        x1cfpg = 1 or
275600110623     C*                            x1cfpg = 2 or
275700110623     C*                            x1cfpg = 3 or
275800110623     C*                            x1cfpg = 5 or
275900110623     C*                            x1cfpg = 6 or
276000110623     C*                            x1cfpg = 7
276100110623     C*                  z-add     15            @e                   50        ?           ||
276200110623     C*                  endif
276300110623     C*                  endif
276400110623     C*                  endif
276500110623     C*                  endif
276600020719     ?** OPERACION GARANTIZADA...
276700020719?1b? C                   if        not *in50                                    ?P----------01
276800020719?2b? C                   select                                                 ?P---------02|
276900020719?2x? C                   when      x1cocp = '0'                                 ?w---------02|
277000020719     C                   eval      x1sino = $$no                                ?           ||
277100020719?2x? C                   when      x1cocp = '1'                                 ?w---------02|
277200020719     C                   eval      x1sino = $$si                                ?           ||
277300020719?2x? C                   other                                                  ?w---------02|
277400020719     C                   eval      x1sino = *blanks                             ?           ||
277500020719     C                   z-add     76            @e                   50        ?           ||
277600020719?2e? C                   endsl                                                  ?F---------02|
277700020719?1e? C                   endif                                                  ?F----------01
277800020719     ?** OPERACION DEBERIA ESTAR GARANTIZADA...
277900020719     ?* borrar mensaje de aviso cuando cambia la forma
278000020719     ?* de pago...
278100020719?1b? C                   if        not *in50  and                               ?P----------01
278200020719     C                             x1cfpg <> @@cfpg                             ?            |
278300020719     C                   eval      @@in33 = *zeros                              ?            |
278400020719?1e? C                   endif                                                  ?F----------01
278500020719     ?* el mensaje de aviso de operación no garantizada
278600020719     ?* se manda cuando la forma de pago es cobrador común
278700020719     ?* código 4 y no se cobró la primera cuota, es decir
278800020719     ?* que no se informó número de recibo y ademas la
278900020719     ?* tabla set630 dice que se valida la operación
279000020719     ?* garantizada...
279100020719?1b? C                   if        not *in50  and                               ?P----------01
279200020719     C                             @@ma23 = '1'  and                            ?            |
279300020719     C                             w0tiou <= 2                                  ?            |
279400020719?2b? C                   if        x1cfpg = 4  and                              ?P---------02|
279500020719     C                             x1strg <> 'R'                                ?           ||
279600020719?3b? C                   if        x1cocp = '0'  and                            ?P--------03||
279700020719     C                             @@in33 <= 1                                  ?          |||
279800020719     C                   z-add     33            @e                   50        ?          |||
279900020719     C                   add       1             @@in33                         ?          |||
280000020719?3e? C                   endif                                                  ?F--------03||
280100020719?2e? C                   endif                                                  ?F---------02|
280200020719?1e? C                   endif                                                  ?F----------01
280300020719     ?** VALIDACIONES PARA FORMA DE PAGO=1/7 TARJETA...
280400020719     ?** EMPRESA DE TARJETA...
280500020719?1b? C                   if        not *in50                                    ?P----------01
280600020719?2b? C                   if        x1cfpg = 1  or                               ?P---------02|
280700020719     C                             x1cfpg = 7                                   ?           ||
280800020719     C     x1ctcu        chain     g1ttc101                           20        ?           ||
280900020719     C   20              z-add     80            @e                   50        ?           ||
281000020719?2e? C                   endif                                                  ?F---------02|
281100020719?1e? C                   endif                                                  ?F----------01
281200020719     ?*- EMPRESA BLOQUEADA...
281300020719?1b? C                   if        not *in50                                    ?P----------01
281400020719?2b? C                   if        x1cfpg = 1  or                               ?P---------02|
281500020719     C                             x1cfpg = 7                                   ?           ||
281600020719?3b? C                   if        t1bloq = 'B'                                 ?P--------03||
281700020719     C                   eval      @e = 80                                      ?          |||
281800020719?3e? C                   endif                                                  ?F--------03||
281900020719?2e? C                   endif                                                  ?F---------02|
282000020719?1e? C                   endif                                                  ?F----------01
282100020719     ?** NUMERO DE TARJETA 1...
282200020719?1b? C                   if        not *in50                                    ?P----------01
282300020719?2b? C                   if        x1cfpg = 1  or                               ?P---------02|
282400020719     C                             x1cfpg = 7                                   ?           ||
282500020719?3b? C                   if        x1nrtc = *zeros                              ?P--------03||
282600020719     C                   z-add     81            @e                   50        ?          |||
282700020719?3e? C                   endif                                                  ?F--------03||
282800020719?2e? C                   endif                                                  ?F---------02|
282900020719?1e? C                   endif                                                  ?F----------01
283000020719     ?** NUMERO DE TARJETA 2...
283100020719?1b? C                   if        not *in50                                    ?P----------01
283200020719?2b? C                   if        x1cfpg = 1  or                               ?P---------02|
283300020719     C                             x1cfpg = 7                                   ?           ||
283400020719     C                   movel     x1nrtc        p@0120                         ?           ||
283500020719     C                   eval      p@2145 = t1ment                              ?           ||
283600020719     C                   call      'SPEDI1'                                     ?           ||
283700020719     C                   parm                    p@0170                         ?           ||
283800020719     C                   eval      x1ment = p@4670                              ?           ||
283900020719     C                   movea     x1ment        wrk                            ?           ||
284000020719     C                   eval      x = *zeros                                   ?           ||
284100020719     C                   eval      y = *zeros                                   ?           ||
284200020719?3b? C                   do        25            x                              ?P--------03||
284300020719     C     wrk(x)        lookup    @di                                    20    ?          |||
284400020719     C   20              add       1             y                              ?          |||
284500020719?3e? C                   enddo                                                  ?F--------03||
284600020719     ?** NUMERO DE TARJETA BLOQUEADO                                            ?           ||
284700020719     C     k1@dtc        chain     g1hdtc                             20        ?           ||
284800020719?3b? C                   if        not *in20                                    ?P--------03||
284900020719?4b? C                   if        dfbloq = 'F'  or                             ?P-------04|||
285000030805     C                             dfbloq = 'T'                                 ?         ||||
285100040120     C                   z-add     79            @e                   50        ?         ||||
285200020719?4e? C                   endif                                                  ?F-------04|||
285300040202?3x? C                   else                                                   ?X........03||
285400040202     C                   z-add     42            @e                   50        ?          |||
285500020719?3e? C                   endif                                                  ?F--------03||
285600020719     ?** CONTROLAR CANTIDAD DE DIGITOS...                                       ?           ||
285700020719?3b? C                   if        y <> t1cdnt                                  ?P--------03||
285800020719     C                   seton                                        50        ?          |||
285900020719     C                   eval      @e = 81                                      ?          |||
286000020719?3e? C                   endif                                                  ?F--------03||
286100020719?2e? C                   endif                                                  ?F---------02|
286200020719?1e? C                   endif                                                  ?F----------01
286300020719     ?** PRIMER DIGITO SIGNIFICATIVO NO DEBE SER CERO...
286400020719?1b? C                   if        not *in50                                    ?P----------01
286500020719?2b? C                   if        x1cfpg = 1  or                               ?P---------02|
286600020719     C                             x1cfpg = 7                                   ?           ||
286700020719     C                   movea     p@0120        wr1                            ?           ||
286800020719     C                   eval      @cd = t1cdnt - 1                             ?           ||
286900020719     C                   eval      @cd = 20 - @cd                               ?           ||
287000020719?3b? C                   if        wr1(@cd) = '0'                               ?P--------03||
287100020719     C                   seton                                        50        ?          |||
287200020719     C                   eval      @e = 81                                      ?          |||
287300020719?3e? C                   endif                                                  ?F--------03||
287400020719?2e? C                   endif                                                  ?F---------02|
287500020719?1e? C                   endif                                                  ?F----------01
287600020719     ?** NUMERO DE CUPON TOTAL...
287700020719?1b? C                   if        not *in50  and                               ?P----------01
287800020719     C                             x1cfpg = 7  and                              ?            |
287900020719     C                             x1nrct = *zeros                              ?            |
288000020719     C                   z-add     88            @e                   50        ?            |
288100020719?1e? C                   endif                                                  ?F----------01
288200020719     ?** CODIGO DE BANCO...
288300020719?1b? C                   if        not *in50                                    ?P----------01
288400020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
288500020719     C                             x1cfpg = 3                                   ?           ||
288600020719     C     k1tbco        chain     c1tbco                             20        ?           ||
288700020719     C   20              z-add     84            @e                   50        ?           ||
288800020719?2e? C                   endif                                                  ?F---------02|
288900020719?1e? C                   endif                                                  ?F----------01
289000020719     ?** CODIGO DE SUCURSAL...
289100020719?1b? C                   if        not *in50                                    ?P----------01
289200020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
289300020719     C                             x1cfpg = 3                                   ?           ||
289400020719     C     k1tbcs        chain     c1tbcs                             20        ?           ||
289500020719     C   20              z-add     85            @e                   50        ?           ||
289600020719?2e? C                   endif                                                  ?F---------02|
289700020719?1e? C                   endif                                                  ?F----------01
289800020719     ?** TIPO DE CUENTA CUENTA CORRIENTE...
289900020719     ?*          *IN50     IFEQ '0'
290000020719     ?*          X1CFPG    ANDEQ2
290100020719     ?*          X1TCTA    ANDNE1
290200020719     ?*                    Z-ADD82        @E         50
290300020719     ?*                    END
290400020719     ?** TIPO DE CUENTA CAJA DE AHORROS...
290500020719     ?*          *IN50     IFEQ '0'
290600020719     ?*          X1CFPG    ANDEQ3
290700020719     ?*          X1TCTA    ANDNE2
290800020719     ?*                    Z-ADD82        @E         50
290900020719     ?*                    END
291000020719     ?** TIPO DE CUENTA CUENTA ...
291100020719     ?*          *IN50     IFEQ '0'
291200020719     ?*          X1CFPG    ANDEQ2
291300020719     ?*          X1TCTA    ANDEQ0
291400020719     ?*          *IN50     OREQ '0'
291500020719     ?*          X1CFPG    ANDEQ3
291600020719     ?*          X1TCTA    ANDEQ0
291700020719     ?*                    Z-ADD82        @E         50
291800020719     ?*                    END
291900020719     ?** TIPO DE CUENTA CUENTA ...
292000020719?1b? C                   if        not *in50                                    ?P----------01
292100020719     C     x1ivbc        setll     c1tbct                                       ?            |
292200020719     C     x1ivbc        reade     c1tbct                                 20    ?            |
292300020719?2b? C                   if        not *in20                                    ?P---------02|
292400020719     C     k1tbct        chain     c1tbct                             20        ?           ||
292500020719     C   20              z-add     82            @e                   50        ?           ||
292600020719?2e? C                   endif                                                  ?F---------02|
292700020719?1e? C                   endif                                                  ?F----------01
292800020719     ?** NUMERO DE CUENTA...
292900020719?1b? C                   if        not *in50                                    ?P----------01
293000020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
293100020719     C                             x1cfpg = 3                                   ?           ||
293200020719?3b? C                   if        x1ncta = *blanks                             ?P--------03||
293300020719     C                   z-add     83            @e                   50        ?          |||
293400020719?3e? C                   endif                                                  ?F--------03||
293500020719?2e? C                   endif                                                  ?F---------02|
293600020719?1e? C                   endif                                                  ?F----------01
293700020719     ?*- VALIDA CBU...
293800020719?1b? C                   if        not *in50  and                               ?P----------01
293900020719     C                             $zma34 <> 'N'                                ?            |
294000020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
294100020719     C                             x1cfpg = 3                                   ?           ||
294200020719     C                   call      'SP0064'                                     ?           ||
294300020719     C                   parm                    x1ivbc                         ?           ||
294400020719     C                   parm                    x1ivsu                         ?           ||
294500020719     C                   parm                    x1tcta                         ?           ||
294600020719     C                   parm                    x1ncta                         ?           ||
294700020719     C                   parm      *blanks       @@erro            1            ?           ||
294800020719?3b? C                   if        @@erro <> *blanks                            ?P--------03||
294900020719     C                   z-add     83            @e                   50        ?          |||
295000020719?3e? C                   endif                                                  ?F--------03||
295100020719?2e? C                   endif                                                  ?F---------02|
295200020719?1e? C                   endif                                                  ?F----------01
295300030307     ?** NUMERO DE CUENTA BANCARIA BLOQUEADO
295400030307?1b? C                   if        not *in50                                    ?P----------01
295500030307?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
295600030307     C                             x1cfpg = 3                                   ?           ||
295700030307     C     k1@dcb        setll     g1hdcb                                       ?           ||
295800030307     C     k1@dcb        reade     g1hdcb                                 78    ?           ||
295900030307?3b? C                   dow       not *in78                                    ?P--------03||
296000030307?4b? C                   if        x1ivbc = dfivbc  and                         ?P-------04|||
296100030307     C                             x1ivsu = dfivsu  and                         ?         ||||
296200030307     C                             x1tcta = dftcta  and                         ?         ||||
296300030307     C                             x1ncta = dfncta                              ?         ||||
296400030307?5b? C                   if        dfbloq = 'F'  or                             ?P------05||||
296500030805     C                             dfbloq = 'T'                                 ?        |||||
296600030307     C                   z-add     77            @e                   50        ?        |||||
296700030307?5e? C                   endif                                                  ?F------05||||
296800030307?4e? C                   endif                                                  ?F-------04|||
296900030307     C     k1@dcb        reade     g1hdcb                                 78    ?          |||
297000030307?3e? C                   enddo                                                  ?F--------03||
297100030307?2e? C                   endif                                                  ?F---------02|
297200030307?1e? C                   endif                                                  ?F----------01
297300040202     ?** NUMERO DE CUENTA BANCARIA INEXISTENTE
297400040202?1b? C                   if        not *in50                                    ?P----------01
297500040202?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
297600040202     C                             x1cfpg = 3                                   ?           ||
297700040202     C     k2@dcb        chain     gnhdcb                                       ?           ||
297800040202?3b? C                   if        not %found(gnhdcb)                           ?P--------03||
297900040202     C                   z-add     43            @e                   50        ?          |||
298000040202?3e? C                   endif                                                  ?F--------03||
298100040202?2e? C                   endif                                                  ?F---------02|
298200040202?1e? C                   endif                                                  ?F----------01
298300020719     ?*- VALIDA CUENTA...
298400020719?1b? C                   if        not *in50  and                               ?P----------01
298500020719     C                             $zma34 = 'N'                                 ?            |
298600020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
298700020719     C                             x1cfpg = 3                                   ?           ||
298800020719     C                   call      'SP0066'                                     ?           ||
298900020719     C                   parm                    x1ivbc                         ?           ||
299000020719     C                   parm                    x1ivsu                         ?           ||
299100020719     C                   parm                    x1tcta                         ?           ||
299200020719     C                   parm                    x1ncta                         ?           ||
299300020719     C                   parm      *blanks       @@erro                         ?           ||
299400020719?3b? C                   if        @@erro <> *blanks                            ?P--------03||
299500020719     C                   z-add     83            @e                   50        ?          |||
299600020719?3e? C                   endif                                                  ?F--------03||
299700020719?2e? C                   endif                                                  ?F---------02|
299800020719?1e? C                   endif                                                  ?F----------01
299900020719     ?** INCONSISTENCIA CON CODIGO DE PAGO 1
300000020719     ?*- TARJETA DE CREDITO PAGO POR DEBITO AUTOMATICO...
300100020719?1b? C                   if        not *in50  and                               ?P----------01
300200020719     C                             x1cfpg = 1                                   ?            |
300300020719?2b? C                   if        x1nrct <> *zeros  or                         ?P---------02|
300400020719     C                             x1cbrn <> *zeros  or                         ?           ||
300500020719     C                             x1czco <> *zeros  or                         ?           ||
300600020719     C                             x1cocp <> '0'  or                            ?           ||
300700020719     C                             x1nrla <> *blanks  or                        ?           ||
300800020719     C                             x1nrln <> *zeros  or                         ?           ||
300900020719     C                             x1ivbc <> *zeros  or                         ?           ||
301000020719     C                             x1ivsu <> *zeros  or                         ?           ||
301100020719     C                             x1tcta <> *zeros  or                         ?           ||
301200020719     C                             x1ncta <> *blanks                            ?           ||
301300020719     C                   z-add     65            @e                   50        ?           ||
301400020719?2e? C                   endif                                                  ?F---------02|
301500020719?1e? C                   endif                                                  ?F----------01
301600020719     ?** INCONSISTENCIA CON CODIGO DE PAGO 7
301700020719     ?*- TARJETA DE CREDITO PAGO POR CUPONES...
301800020719?1b? C                   if        not *in50  and                               ?P----------01
301900020719     C                             x1cfpg = 7                                   ?            |
302000020719?2b? C                   if        x1cbrn <> *zeros  or                         ?P---------02|
302100020719     C                             x1czco <> *zeros  or                         ?           ||
302200020719     C                             x1cocp <> '0'  or                            ?           ||
302300020719     C                             x1nrla <> *blanks  or                        ?           ||
302400020719     C                             x1nrln <> *zeros  or                         ?           ||
302500020719     C                             x1ivbc <> *zeros  or                         ?           ||
302600020719     C                             x1ivsu <> *zeros  or                         ?           ||
302700020719     C                             x1tcta <> *zeros  or                         ?           ||
302800020719     C                             x1ncta <> *blanks                            ?           ||
302900020719     C                   z-add     66            @e                   50        ?           ||
303000020719?2e? C                   endif                                                  ?F---------02|
303100020719?1e? C                   endif                                                  ?F----------01
303200020719     ?** INCONSISTENCIA CON CODIGO DE PAGO 2/3
303300020719     ?*- DEBITO BANCARIO: CTA.CTE O CAJA AHORROS...
303400020719?1b? C                   if        not *in50                                    ?P----------01
303500020719?2b? C                   if        x1cfpg = 2  or                               ?P---------02|
303600020719     C                             x1cfpg = 3                                   ?           ||
303700020719?3b? C                   if        x1cbrn <> *zeros  or                         ?P--------03||
303800020719     C                             x1czco <> *zeros  or                         ?          |||
303900020719     C                             x1cocp <> '0'  or                            ?          |||
304000020719     C                             x1ctcu <> *zeros  or                         ?          |||
304100020719     C                             x1nrtc <> *zeros  or                         ?          |||
304200020719     C                             x1nrct <> *zeros  or                         ?          |||
304300020719     C                             x1nrla <> *blanks  or                        ?          |||
304400020719     C                             x1nrln <> *zeros                             ?          |||
304500020719     C                   z-add     67            @e                   50        ?          |||
304600020719?3e? C                   endif                                                  ?F--------03||
304700020719?2e? C                   endif                                                  ?F---------02|
304800020719?1e? C                   endif                                                  ?F----------01
304900020719     ?** INCONSISTENCIA CON CODIGO DE PAGO 4/6
305000020719     ?*- COBRADOR COMUN...
305100020719?1b? C                   if        not *in50  and                               ?P----------01
305200020719     C                             x1cfpg = 4  or                               ?            |
305300020719     C                             not *in50  and                               ?            |
305400020719     C                             x1cfpg = 6                                   ?            |
305500020719?2b? C                   if        x1ctcu <> *zeros  or                         ?P---------02|
305600020719     C                             x1nrtc <> *zeros  or                         ?           ||
305700020719     C                             x1nrct <> *zeros  or                         ?           ||
305800020719     C                             x1nrla <> *blanks  or                        ?           ||
305900020719     C                             x1nrln <> *zeros  or                         ?           ||
306000020719     C                             x1ivbc <> *zeros  or                         ?           ||
306100020719     C                             x1ivsu <> *zeros  or                         ?           ||
306200020719     C                             x1tcta <> *zeros  or                         ?           ||
306300020719     C                             x1ncta <> *blanks                            ?           ||
306400020719     C                   z-add     68            @e                   50        ?           ||
306500020719?2e? C                   endif                                                  ?F---------02|
306600020719?1e? C                   endif                                                  ?F----------01
306700020719     ?** INCONSISTENCIA CON CODIGO DE PAGO 5...
306800020719     ?*- COBRADOR MUTUAL: COMUN O DEBITO AUTOMATICO...
306900020719?1b? C                   if        not *in50                                    ?P----------01
307000020719?2b? C                   if        x1cfpg = 5                                   ?P---------02|
307100020719?3b? C                   if        x1ivbc <> *zeros  or                         ?P--------03||
307200020719     C                             x1ivsu <> *zeros  or                         ?          |||
307300020719     C                             x1tcta <> *zeros  or                         ?          |||
307400020719     C                             x1ncta <> *blanks  or                        ?          |||
307500020719     C                             x1ctcu <> *zeros  or                         ?          |||
307600020719     C                             x1nrtc <> *zeros  or                         ?          |||
307700020719     C                             x1nrct <> *zeros                             ?          |||
307800020719     C                   z-add     69            @e                   50        ?          |||
307900020719?3e? C                   endif                                                  ?F--------03||
308000020719?2e? C                   endif                                                  ?F---------02|
308100020719?1e? C                   endif                                                  ?F----------01
308200020719     ?** CODIGO DE COASEGURO...
308300020719?1b? C                   if        not *in50                                    ?P----------01
308400020719?2b? C                   select                                                 ?P---------02|
308500020719?2x? C                   when      x1wcoa = 0                                   ?w---------02|
308600020719?2x? C                   when      x1wcoa = 2  and                              ?w---------02|
308700020719     C                             t@free = '1'                                 ?           ||
308800020719?2x? C                   other                                                  ?w---------02|
308900020719     C                   z-add     89            @e                   50        ?           ||
309000020719?2e? C                   endsl                                                  ?F---------02|
309100020719?1e? C                   endif                                                  ?F----------01
309200020719     ?** NUMERO DE COBERTURA PROVISORIA...
309300020719?1b? C                   if        not *in50  and                               ?P----------01
309400020719     C                             x1cobn <> *zeros  and                        ?            |
309500020719     C                             x1cobn <> @@cobn                             ?            |
309600020719     C     k1@cp0        chain     p1hcp0                             20        ?            |
309700020719?2b? C                   select                                                 ?P---------02|
309800020719?2x? C                   when      *in20                                        ?w---------02|
309900020719     C                   z-add     28            @e                   50        ?           ||
310000020719?2x? C                   other                                                  ?w---------02|
310100020719?3b? C                   if        p0arcd <> @@arcd  or                         ?P--------03||
310200020719     C                             p0asen <> x1asen  or                         ?          |||
310300020719     C                             p0mar2 <> '0'                                ?          |||
310400020719     C                   z-add     28            @e                   50        ?          |||
310500020719?3e? C                   endif                                                  ?F--------03||
310600020719?2e? C                   endsl                                                  ?F---------02|
310700020719?1e? C                   endif                                                  ?F----------01
310800020719     ?** NUMERO DE SOPORTE COMERCIALIZACION...
310900020719?1b? C                   if        not *in50  and                               ?P----------01
311000020719     C                             x1nit1 <> *zeros  or                         ?            |
311100020719     C                             not *in50  and                               ?            |
311200020719     C                             x1nic1 <> *zeros                             ?            |
311300020719     C     k4@ni2        chain     s1hni201                           20        ?            |
311400020719     C   20              z-add     25            @e                   50        ?            |
311500020719?1e? C                   endif                                                  ?F----------01
311600020719     ?** BLOQUEO SOPORTE COMERCIALIZACION...
311700020719?1b? C                   if        not *in50  and                               ?P----------01
311800020719     C                             x1nit1 <> *zeros  or                         ?            |
311900020719     C                             not *in50  and                               ?            |
312000020719     C                             x1nic1 <> *zeros                             ?            |
312100020719?2b? C                   select                                                 ?P---------02|
312200020719?2x? C                   when      n2bloq = '1'  and                            ?w---------02|
312300020719     C                             w0tiou = 1                                   ?           ||
312400020719     C                   z-add     25            @e                   50        ?           ||
312500020719?2x? C                   when      n2bloq = '2'  and                            ?w---------02|
312600020719     C                             w0tiou <= 2                                  ?           ||
312700020719     C                   z-add     25            @e                   50        ?           ||
312800020719?2x? C                   when      n2bloq = '3'  and                            ?w---------02|
312900020719     C                             w0tiou <= 3                                  ?           ||
313000020719     C                   z-add     25            @e                   50        ?           ||
313100020719?2e? C                   endsl                                                  ?F---------02|
313200020719?1e? C                   endif                                                  ?F----------01
313300020719     ?** SI EXISTE SOPORTE BUSCAR COMISION...
313400020719?1b? C                   if        not *in50  and                               ?P----------01
313500020719     C                             x1nit1 <> *zeros  and                        ?            |
313600020719     C                             x1nic1 <> *zeros                             ?            |
313700020719     C     k1t611        chain     s1t6119                            20        ?            |
313800020719     C   20k2t611        chain     s1t6119                            20        ?            |
313900020719     C  n20              eval      x1xopr = t@xopr                              ?            |
314000020719     C  n20              eval      x1copr = t@copr                              ?            |
314100020719?1e? C                   endif                                                  ?F----------01
314200020719     ?** DATOS DEL CREDITO INCONSISTENCIA...
314300020719?1b? C                   if        not *in50                                    ?P----------01
314400020719?2b? C                   if        x1fvto <> *zeros  or                         ?P---------02|
314500020719     C                             x1ccuo <> *zeros                             ?           ||
314600020719?3b? C                   if        x1fvto = *zeros                              ?P--------03||
314700020719     C                   z-add     26            @e                   50        ?          |||
314800020719?3e? C                   endif                                                  ?F--------03||
314900020719?2e? C                   endif                                                  ?F---------02|
315000020719?1e? C                   endif                                                  ?F----------01
315100020719     ?** DATOS DEL CREDITO FECHA...
315200020719?1b? C                   if        not *in50  and                               ?P----------01
315300020719     C                             x1fvto <> *zeros                             ?            |
315400020719     C                   eval      p@flap = *zeros                              ?            |
315500020719     C                   eval      p@ffec = x1fvto                              ?            |
315600020719     C                   call      'SPFECH'                                     ?            |
315700020719     C                   parm                    p@fech                         ?            |
315800020719?2b? C                   if        p@flap = *zeros                              ?P---------02|
315900020719     C                   z-add     26            @e                   50        ?           ||
316000020719?2x? C                   else                                                   ?X.........02|
316100020719     C                   eval      x1fvto = p@ffec                              ?           ||
316200020719?2e? C                   endif                                                  ?F---------02|
316300020719?1e? C                   endif                                                  ?F----------01
316400020719     ?** CODIGO DE REFACTURACION...
316500020719?1b? C                   if        not *in50  and                               ?P----------01
316600020719     C                             x1mar1 <> '0'  and                           ?            |
316700020719     C                             x1mar1 <> '1'  and                           ?            |
316800020719     C                             x1mar1 <> '9'                                ?            |
316900020719     C                   z-add     41            @e                   50        ?            |
317000020719?1e? C                   endif                                                  ?F----------01
317100020719     ?** CODIGO DE SUBARTICULO...
317200020719?1b? C                   if        not *in50                                    ?P----------01
317300020719?2b? C                   if        x1sarc <> *zeros                             ?P---------02|
317400020719     C     k1t605        chain     s1t605                             20        ?           ||
317500020719     C  n20              eval      x1sard = t@sard                              ?           ||
317600020719     C   20              eval      x1sard = *blanks                             ?           ||
317700020719     C   20              z-add     41            @e                   50        ?           ||
317800020719?2x? C                   else                                                   ?X.........02|
317900020719     C                   eval      x1sard = *blanks                             ?           ||
318000020719?2e? C                   endif                                                  ?F---------02|
318100020719?1e? C                   endif                                                  ?F----------01
318200020719     ?** RECIBOS/SOLICITUDES DUPLICADAS...
318300020719?1b? C                   if        not *in50                                    ?P----------01
318400020719?2b? C                   if        x1strg = 'S'  or                             ?P---------02|
318500020719     C                             x1strg = 'R'                                 ?           ||
318600020719?3b? C                   if        x1strg <> $$strg  or                         ?P--------03||
318700020719     C                             x1conr <> $$conr                             ?          |||
318800020719     C                   call      'PAR310I'                                    ?          |||
318900020719     C                   parm                    x1strg                         ?          |||
319000020719     C                   parm                    x1conr                         ?          |||
319100020719     C                   parm                    @@arcd                         ?          |||
319200020719     C                   parm                    @@spol                         ?          |||
319300020719     C                   parm                    @@sspo                         ?          |||
319400020719?3e? C                   endif                                                  ?F--------03||
319500020719?2e? C                   endif                                                  ?F---------02|
319600020719?1e? C                   endif                                                  ?F----------01
319700101227     ?** VALIDACION POR VIDA OBLIGATORIO...
319800101227     ?** PARA POLIZAS NUEVAS O RENOVACIONES...
319900101227     ?** FECHA DE INICIO DE VIGENCIA (DIA) NO PUEDE SER DISTINTO DE 1...
320000101227     ?** POR FECHA DE ARRANQUE 01/01/2011...
320100101229     C                   if        not *in50
320200101229     C     k1t621        chain     s1t621                             20
320300101229?1b? C                   if        not *in20                                    ?P----------01
320400101229     C                   if        t@rama = 89
320500101229     C                   call      'PAR310X3'                                   ?           ||
320600101229     C                   parm                    usempr                         ?           ||
320700101229     C                   parm      *zeros        @1fema            4 0          ?           ||
320800101229     C                   parm      *zeros        @1femm            2 0          ?           ||
320900101229     C                   parm      *zeros        @1femd            2 0          ?           ||
321000101229     C                   eval      @@fema = @1fema                              ?           ||
321100101229     C                   eval      @@femm = @1femm                              ?           ||
321200101229     C                   eval      @@femd = @1femd                              ?           ||
321300101229     C                   eval      p1fdma = *zeros
321400101228     C                   eval      p1fdma = x1desd
321500101229     C                   if        @@fech >= ctlvida_fecha
321600101228     C                   if        w0tiou <= 2 and p1fdia <> 1
321700101229     C                   z-add     97            @e                   50        ?           ||
321800101227     C                   endif
321900101228     C                   endif
322000101229     C                   endif
322100101229     C                   endif
322200101229     C                   endif
322300020719     ?** BUSCAR DESCRIPCIONES (LAS QUE SE PUEDA)...
322400020719     C                   exsr      desc01
322500020719     ?** SI NO EXISTEN ERRORES AVANZA...
322600020719?1b? C                   if        not *in50                                    ?P----------01
322700020719     ?*- COMPARACION DE CAMPOS...                                               ?            |
322800020719?2b? C                   if        x1mone = $$mone  and                         ?P---------02|
322900020719     C                             x1come = $$come  and                         ?           ||
323000020719     C                             x1asen = $$asen  and                         ?           ||
323100020719     C                             x1civa = $$civa  and                         ?           ||
323200020719     C                             x1opag = $$opag  and                         ?           ||
323300020719     C                             x1fing = $$fing  and                         ?           ||
323400020719     C                             x1desd = $$desd  and                         ?           ||
323500020719     C                             x1dupe = $$dupe  and                         ?           ||
323600020719     C                             x1hast = $$hast  and                         ?           ||
323700020719     C                             x1nivt = $$nivt  and                         ?           ||
323800020719     C                             x1nivc = $$nivc  and                         ?           ||
323900020719     C                             x1cfpg = $$cfpg  and                         ?           ||
324000020719     C                             x1conr = $$conr  and                         ?           ||
324100020719     C                             x1strg = $$strg  and                         ?           ||
324200020719     C                             x1cbrn = $$cbrn  and                         ?           ||
324300020719     C                             x1czco = $$czco  and                         ?           ||
324400020719     C                             x1cocp = $$cocp  and                         ?           ||
324500020719     C                             x1nrla = $$nrla  and                         ?           ||
324600020719     C                             x1nrln = $$nrln  and                         ?           ||
324700020719     C                             x1ctcu = $$ctcu  and                         ?           ||
324800020719     C                             x1nrtc = $$nrtc  and                         ?           ||
324900020719     C                             x1nrct = $$nrct  and                         ?           ||
325000020719     C                             x1ivbc = $$ivbc  and                         ?           ||
325100020719     C                             x1ivsu = $$ivsu  and                         ?           ||
325200020719     C                             x1tcta = $$tcta  and                         ?           ||
325300020719     C                             x1ncta = $$ncta  and                         ?           ||
325400020719     C                             x1wcoa = $$wcoa  and                         ?           ||
325500020719     C                             x1nit1 = $$nit1  and                         ?           ||
325600020719     C                             x1nic1 = $$nic1  and                         ?           ||
325700020719     C                             x1ncre = $$ncre  and                         ?           ||
325800020719     C                             x1fvto = $$fvto  and                         ?           ||
325900020719     C                             x1ccuo = $$ccuo  and                         ?           ||
326000020719     C                             x1cobn = $$cobn  and                         ?           ||
326100020719     C                             x1soln = $$soln  and                         ?           ||
326200020719     C                             x1sarc = $$sarc  and                         ?           ||
326300020719     C                             x1cmas = $$cmas  and                         ?           ||
326400020719     C                             x1pmas = $$pmas  and                         ?           ||
326500020719     C                             x1paco = $$paco  and                         ?           ||
326600020719     C                             x1paas = $$paas                              ?           ||
326700020719     C                   eval      xxiden = 1                                   ?           ||
326800020719     C                   exsr      grab01                                       ?           ||
326900020719     C                   setoff                                           90    ?           ||
327000020719?2x? C                   else                                                   ?X.........02|
327100020719     C                   eval      $$mone = x1mone                              ?           ||
327200020719     C                   eval      $$come = x1come                              ?           ||
327300020719     C                   eval      $$asen = x1asen                              ?           ||
327400020719     C                   eval      $$civa = x1civa                              ?           ||
327500020719     C                   eval      $$opag = x1opag                              ?           ||
327600020719     C                   eval      $$fing = x1fing                              ?           ||
327700020719     C                   eval      $$desd = x1desd                              ?           ||
327800020719     C                   eval      $$dupe = x1dupe                              ?           ||
327900020719     C                   eval      $$hast = x1hast                              ?           ||
328000020719     C                   eval      $$nivt = x1nivt                              ?           ||
328100020719     C                   eval      $$nivc = x1nivc                              ?           ||
328200020719     C                   eval      $$cfpg = x1cfpg                              ?           ||
328300020719     C                   eval      $$conr = x1conr                              ?           ||
328400020719     C                   eval      $$strg = x1strg                              ?           ||
328500020719     C                   eval      $$cbrn = x1cbrn                              ?           ||
328600020719     C                   eval      $$czco = x1czco                              ?           ||
328700020719     C                   eval      $$cocp = x1cocp                              ?           ||
328800020719     C                   eval      $$nrla = x1nrla                              ?           ||
328900020719     C                   eval      $$nrln = x1nrln                              ?           ||
329000020719     C                   eval      $$ctcu = x1ctcu                              ?           ||
329100020719     C                   eval      $$nrtc = x1nrtc                              ?           ||
329200020719     C                   eval      $$nrct = x1nrct                              ?           ||
329300020719     C                   eval      $$ivbc = x1ivbc                              ?           ||
329400020719     C                   eval      $$ivsu = x1ivsu                              ?           ||
329500020719     C                   eval      $$tcta = x1tcta                              ?           ||
329600020719     C                   eval      $$ncta = x1ncta                              ?           ||
329700020719     C                   eval      $$wcoa = x1wcoa                              ?           ||
329800020719     C                   eval      $$nit1 = x1nit1                              ?           ||
329900020719     C                   eval      $$nic1 = x1nic1                              ?           ||
330000020719     C                   eval      $$ncre = x1ncre                              ?           ||
330100020719     C                   eval      $$fvto = x1fvto                              ?           ||
330200020719     C                   eval      $$ccuo = x1ccuo                              ?           ||
330300020719     C                   eval      $$cobn = x1cobn                              ?           ||
330400020719     C                   eval      $$soln = x1soln                              ?           ||
330500020719     C                   eval      $$sarc = x1sarc                              ?           ||
330600020719     C                   eval      $$cmas = x1cmas                              ?           ||
330700020719     C                   eval      $$pmas = x1pmas                              ?           ||
330800020719     C                   eval      $$paco = x1paco                              ?           ||
330900020719     C                   eval      $$paas = x1paas                              ?           ||
331000020719     C                   seton                                            90    ?           ||
331100020719?2e? C                   endif                                                  ?F---------02|
331200020719?1e? C                   endif                                                  ?F----------01
331300020719     ?*- SI EXISTEN ERRORES...
331400020719?1b? C                   if        *in50  and                                   ?P----------01
331500020719     C                             @e <> *zeros                                 ?            |
331600020719     C                   setoff                                           90    ?            |
331700020719     C                   write     par31001                                     ?            |
331800020719     C                   eval      *in(@e) = '1'                                ?            |
331900020719?1e? C                   endif                                                  ?F----------01
332000020719     C                   endsr
332100001116     ?******************************************************
332200020719     C     verblo        begsr
332300020719     ?*- VER BLOQUEOS EN ALGUN INTERMEDIARIO DE LA CADENA--
332400020719?1b? C                   if        x1nivt > *zeros                              ?P----------01
332500020719     C                   eval      nc = *zeros                                  ?            |
332600020719     C                   eval      @@t = x1nivt                                 ?            |
332700020719     C                   eval      @@c = x1nivc                                 ?            |
332800020719     C                   eval      nc(@@t) = x1nivc                             ?            |
332900020719?2b? C                   do        10            x                              ?P---------02|
333000020719     C     k2@ni2        chain     s1hni201                           21        ?           ||
333100020719?3b? C                   if        not *in21                                    ?P--------03||
333200020719?4b? C                   select                                                 ?P-------04|||
333300020719?4x? C                   when      n2bloq = '1'  and                            ?w-------04|||
333400020719     C                             w0tiou = 1                                   ?         ||||
333500020719     C                   z-add     60            @e                   50        ?         ||||
333600020719?2v? C                   leave                                                  ?         ||||
333700020719?4x? C                   when      n2bloq = '2'  and                            ?w-------04|||
333800020719     C                             w0tiou <= 2                                  ?         ||||
333900020719     C                   z-add     60            @e                   50        ?         ||||
334000020719?2v? C                   leave                                                  ?         ||||
334100020719?4x? C                   when      n2bloq = '3'  and                            ?w-------04|||
334200020719     C                             w0tiou <= 3                                  ?         ||||
334300020719     C                   z-add     60            @e                   50        ?         ||||
334400020719?2v? C                   leave                                                  ?         ||||
334500020719?4x? C                   when      n3nivc <> *zeros                             ?w-------04|||
334600020719     C                   eval      @@t = n3nivt                                 ?         ||||
334700020719     C                   eval      @@c = n3nivc                                 ?         ||||
334800020719     C                   eval      nc(@@t) = n3nivc                             ?         ||||
334900020719?4e? C                   endsl                                                  ?F-------04|||
335000020719?3e? C                   endif                                                  ?F--------03||
335100020719?2e? C                   enddo                                                  ?F---------02|
335200020719?1e? C                   endif                                                  ?F----------01
335300020719     C                   endsr
335400000904     ?******************************************************
335500020719     C     grab01        begsr
335600020719     ?** GRABACION PANTALLA 01-----------------------------
335700020719     ?** POLIZA NUEVA/RENOVACION---------------------------
335800020719?1b? C                   if        w0tiou <= 2                                  ?P----------01
335900020719     ?*- PAHEC0...                                                              ?            |
336000020719     C     k1@ec0        chain     p1hec0                             20        ?            |
336100020719     C                   eval      c0empr = @@empr                              ?            |
336200020719     C                   eval      c0sucu = @@sucu                              ?            |
336300020719     C                   eval      c0arcd = @@arcd                              ?            |
336400020719     C                   eval      c0spol = @@spol                              ?            |
336500020719     C                   eval      c0mone = x1mone                              ?            |
336600020719     C                   eval      p@fdma = x1fing                              ?            |
336700020719     C                   eval      c0fipa = p@faÑo                              ?            |
336800020719     C                   eval      c0fipm = p@fmes                              ?            |
336900020719     C                   eval      c0fipd = p@fdia                              ?            |
337000020719     C                   eval      p@fdma = x1desd                              ?            |
337100020719     C                   eval      c0fioa = p@faÑo                              ?            |
337200020719     C                   eval      c0fiom = p@fmes                              ?            |
337300020719     C                   eval      c0fiod = p@fdia                              ?            |
337400020719     C                   eval      p@fdma = x1hast                              ?            |
337500020719     C                   eval      c0fvoa = p@faÑo                              ?            |
337600020719     C                   eval      c0fvom = p@fmes                              ?            |
337700020719     C                   eval      c0fvod = p@fdia                              ?            |
337800020719     C                   eval      c0dupe = x1dupe                              ?            |
337900020719     C                   eval      c0mar5 = x1mar5                              ?            |
338000020719     C                   eval      c0asen = x1asen                              ?            |
338100020719     C                   eval      c0cfpg = x1cfpg                              ?            |
338200020719     C                   eval      c0opag = x1opag                              ?            |
338300020719     C                   eval      c0ctcu = x1ctcu                              ?            |
338400020719     C                   eval      c0nrtc = x1nrtc                              ?            |
338500020719     C                   eval      c0ivbc = x1ivbc                              ?            |
338600020719     C                   eval      c0ivsu = x1ivsu                              ?            |
338700020719     C                   eval      c0tcta = x1tcta                              ?            |
338800020719     C                   eval      c0ncta = x1ncta                              ?            |
338900020719     C                   eval      c0nrct = x1nrct                              ?            |
339000020719     C                   eval      c0nrla = x1nrla                              ?            |
339100020719     C                   eval      c0nrln = x1nrln                              ?            |
339200020719     C                   eval      c0cbrn = x1cbrn                              ?            |
339300020719     C                   eval      c0czco = x1czco                              ?            |
339400020719     C                   eval      c0cocp = x1cocp                              ?            |
339500020719     C                   eval      c0nivt = x1nivt                              ?            |
339600020719     C                   eval      c0nivc = x1nivc                              ?            |
339700020719     C                   eval      c0wcoa = x1wcoa                              ?            |
339800020719     C                   eval      h0nivt = x1nit1                              ?            |
339900020719     C                   eval      h0nivc = x1nic1                              ?            |
340000020719     C                   eval      c0ncre = x1ncre                              ?            |
340100020719     C                   eval      p@fdma = x1fvto                              ?            |
340200020719     C                   eval      c0ffca = p@faÑo                              ?            |
340300020719     C                   eval      c0ffcm = p@fmes                              ?            |
340400020719     C                   eval      c0ffcd = p@fdia                              ?            |
340500020719     C                   eval      c0ccuo = x1ccuo                              ?            |
340600020719     ?*- MARCAS Y OTRAS YERBAS...                                               ?            |
340700020719     C                   eval      c0mar1 = x1mar1                              ?            |
340800020719     C                   eval      c0mar2 = @@mar2                              ?            |
340900020719     C                   eval      c0mar3 = @@ma16                              ?            |
341000020719     C                   eval      c0mar4 = '0'                                 ?            |
341100020719     C                   eval      c0strg = '0'                                 ?            |
341200020719     C                   eval      c0user = vsuser                              ?            |
341300020719     C                   time                    c0time                         ?            |
341400020719     C                   eval      c0date = udate                               ?            |
341500020719     ?*- CAMPOS QUE NO SE ACTUALIZAN POR LA EMISION                             ?            |
341600020719     ?*- INTERACTIVA...                                                         ?            |
341700020719     C                   eval      c0ivr2 = *zeros                              ?            |
341800020719     C                   eval      c0nrrt = *zeros                              ?            |
341900020719     C                   eval      c0nrlo = *zeros                              ?            |
342000020719     C                   eval      c0econ = '0'                                 ?            |
342100020719     C                   eval      c0fboa = *zeros                              ?            |
342200020719     C                   eval      c0fbom = *zeros                              ?            |
342300020719     C                   eval      c0fbod = *zeros                              ?            |
342400020719     ?*- CAMPOS QUE SE ACTUALIZAN CUANDO SE CONCRETA LA                         ?            |
342500020719     ?*- OPERACION...                                                           ?            |
342600020719     C                   eval      c0cert = *zeros                              ?            |
342700020719     C                   eval      c0suas = *zeros                              ?            |
342800020719     C                   eval      c0saca = *zeros                              ?            |
342900020719     C                   eval      c0sacr = *zeros                              ?            |
343000020719     C                   eval      c0sast = *zeros                              ?            |
343100020719     C                   eval      c0fema = *zeros                              ?            |
343200020719     C                   eval      c0femm = *zeros                              ?            |
343300020719     C                   eval      c0femd = *zeros                              ?            |
343400020719     C                   eval      c0spoa = *zeros                              ?            |
343500020719     C                   eval      c0spon = *zeros                              ?            |
343600020719     C                   eval      c0sema = *zeros                              ?            |
343700020719     C                   eval      c0xpro = *zeros                              ?            |
343800020719     C                   eval      c0fhfa = *zeros                              ?            |
343900020719     C                   eval      c0fhfm = *zeros                              ?            |
344000020719     C                   eval      c0fhfd = *zeros                              ?            |
344100020719     ?*- GRABACION...                                                           ?            |
344200020719     C   20              write     p1hec0                                       ?            |
344300020719     C  n20              update    p1hec0                                       ?            |
344400020719?1e? C                   endif                                                  ?F----------01
344500020719     ?** SUPLEMENTO/REHABILITACION-------------------------
344600020719?1b? C                   if        w0tiou = 3  or                               ?P----------01
344700020719     C                             w0tiou = 5                                   ?            |
344800020719     C     k1@ec0        chain     p1hec0                             20        ?            |
344900020719     C  n20              eval      c0mar1 = x1mar1                              ?            |
345000020719     C  n20              update    p1hec0                                       ?            |
345100020719?1e? C                   endif                                                  ?F----------01
345200020719     ?** TODOS LOS MOVIMIENTOS-----------------------------
345300020719     ?*- PAHEC1...
345400020719     C     k1@ec1        chain     p1hec1                             20
345500020719     C                   eval      c1empr = @@empr
345600020719     C                   eval      c1sucu = @@sucu
345700020719     C                   eval      c1arcd = @@arcd
345800020719     C                   eval      c1spol = @@spol
345900020719     C                   eval      c1sspo = @@sspo
346000020719     C                   eval      c1tiou = w0tiou
346100020719     C                   eval      c1stou = w0stou
346200020719     C                   eval      c1stos = w0stos
346300020719     C                   eval      c1mone = x1mone
346400020719     C                   eval      c1come = x1come
346500020719     C                   eval      c1civa = x1civa
346600020719     C                   eval      p@fdma = x1desd
346700020719     C                   eval      c1fioa = p@faÑo
346800020719     C                   eval      c1fiom = p@fmes
346900020719     C                   eval      c1fiod = p@fdia
347000020719     C                   eval      p@fdma = x1hast
347100020719     C                   eval      c1fvoa = p@faÑo
347200020719     C                   eval      c1fvom = p@fmes
347300020719     C                   eval      c1fvod = p@fdia
347400020719     C                   eval      c1dupe = x1dupe
347500020719     C                   eval      c1mar5 = x1mar5
347600020719     C                   eval      c1asen = x1asen
347700020719     C                   movel     x1cfpg        c1cfpg
347800020719     C                   movel     x1conr        c1conr
347900020719     C                   eval      c1strg = x1strg
348000020719     C                   eval      c1opag = x1opag
348100020719     C                   eval      c1ctcu = x1ctcu
348200020719     C                   eval      c1nrtc = x1nrtc
348300020719     C                   eval      c1ivbc = x1ivbc
348400020719     C                   eval      c1ivsu = x1ivsu
348500020719     C                   eval      c1tcta = x1tcta
348600020719     C                   eval      c1ncta = x1ncta
348700020719     C                   eval      c1nrct = x1nrct
348800020719     C                   eval      c1ivr2 = *zeros
348900020719     C                   eval      c1nrrt = *zeros
349000020719     C                   eval      c1nrlo = *zeros
349100020719     C                   eval      c1nrla = x1nrla
349200020719     C                   eval      c1nrln = x1nrln
349300020719     C                   eval      c1cbrn = x1cbrn
349400020719     C                   eval      c1czco = x1czco
349500020719     C                   eval      c1xcco = *zeros
349600020719     C                   eval      c1cocp = x1cocp
349700020719     C                   eval      c1nivt = x1nivt
349800020719     C                   eval      c1nivc = x1nivc
349900020719     C                   eval      c1wcoa = x1wcoa
350000020719     C                   eval      c1suas = *zeros
350100020719     C                   eval      c1saca = *zeros
350200020719     C                   eval      c1sacr = *zeros
350300020719     C                   eval      c1sast = *zeros
350400020719     C                   eval      h1nivt = x1nit1
350500020719     C                   eval      h1nivc = x1nic1
350600020719     C                   eval      h1xopr = x1xopr
350700020719     C                   eval      h1copr = x1copr
350800020719     C                   eval      c1ncre = x1ncre
350900020719     C                   eval      p@fdma = x1fvto
351000020719     C                   eval      c1ffca = p@faÑo
351100020719     C                   eval      c1ffcm = p@fmes
351200020719     C                   eval      c1ffcd = p@fdia
351300020719     C                   eval      c1ccuo = x1ccuo
351400020719     ?*- CAMPOS QUE NO SE ACTUALIZAN POR LA EMISION
351500020719     ?*- INTERACTIVA...
351600020719     C                   eval      c1econ = '0'
351700020719     C                   eval      c1fboa = *zeros
351800020719     C                   eval      c1fbom = *zeros
351900020719     C                   eval      c1fbod = *zeros
352000020719     ?*- CAMPO ESPECIAL...
352100020719     ?* en los endosos de ajustes de períodos cerrados
352200020719     ?* 3/08 se actualiza este campo con el número de
352300020719     ?* suplemento SSPO que se está ajustando solo en
352400020719     ?* la primera entrada del programa...
352500020719?1b? C                   select                                                 ?P----------01
352600020719?1x? C                   when      w0tiou = 3  and                              ?w----------01
352700020719     C                             w0stos = 08  and                             ?            |
352800020719     C                             w0wp01 = *zeros                              ?            |
352900020719     C                   eval      c1xpro = x0sspo                              ?            |
353000020719?1x? C                   when      w0tiou = 3  and                              ?w----------01
353100020719     C                             w0stos = 08  and                             ?            |
353200020719     C                             w0wp01 <> *zeros                             ?            |
353300020719?1x? C                   other                                                  ?w----------01
353400020719     C                   eval      c1xpro = *zeros                              ?            |
353500020719?1e? C                   endsl                                                  ?F----------01
353600020719     ?*- CAMPOS QUE SE ACTUALIZAN CUANDO SE CONCRETA LA
353700020719     ?*- OPERACION...
353800020719     C                   eval      c1cert = *zeros
353900020719     C                   eval      c1fema = *zeros
354000020719     C                   eval      c1femm = *zeros
354100020719     C                   eval      c1femd = *zeros
354200020719     C                   clear                   c1prim
354300020719     C                   clear                   c1bpri
354400020719     C                   clear                   c1refi
354500020719     C                   clear                   c1read
354600020719     C                   clear                   c1dere
354700020719     C                   clear                   c1seri
354800020719     C                   clear                   c1seem
354900020719     C                   clear                   c1impi
355000020719     C                   clear                   c1sers
355100020719     C                   clear                   c1tssn
355200020719     C                   clear                   c1ipr1
355300020719     C                   clear                   c1ipr3
355400020719     C                   clear                   c1ipr4
355500020719     C                   clear                   c1ipr2
355600020719     C                   clear                   c1ipr5
355700020719     C                   clear                   c1ipr6
355800020719     C                   clear                   c1ipr7
355900020719     C                   clear                   c1ipr8
356000020719     C                   clear                   c1ipr9
356100020719     C                   clear                   c1prem
356200020719     C                   clear                   c1bpre
356300020719     C                   clear                   c1prco
356400020719     C                   clear                   c1depp
356500020719     ?*- CAMPOS QUE SALEN DE CALCULO...
356600020719     C                   eval      c1free = t@free
356700020719?1b? C                   if        w0tiou = 1  or                               ?P----------01
356800020719     C                             w0tiou = 2  or                               ?            |
356900020719     C                             w0tiou = 3  and                              ?            |
357000020719     C                             x1nivt <> @@nivt  or                         ?            |
357100020719     C                             w0tiou = 3  and                              ?            |
357200020719     C                             x1nivt = @@nivt  and                         ?            |
357300020719     C                             x1nivc <> @@nivc  or                         ?            |
357400020719     C                             w0tiou = 5  and                              ?            |
357500020719     C                             x1nivt <> @@nivt  or                         ?            |
357600020719     C                             w0tiou = 5  and                              ?            |
357700020719     C                             x1nivt = @@nivt  and                         ?            |
357800020719     C                             x1nivc <> @@nivc                             ?            |
357900020719     C                   exsr      cadena                                       ?            |
358000020719?1e? C                   endif                                                  ?F----------01
358100020719     C                   eval      c1niv1 = nc(01)
358200020719     C                   eval      c1niv2 = nc(02)
358300020719     C                   eval      c1niv3 = nc(03)
358400020719     C                   eval      c1niv4 = nc(04)
358500020719     C                   eval      c1niv5 = nc(05)
358600020719     C                   eval      c1niv6 = nc(06)
358700020719     C                   eval      c1niv7 = nc(07)
358800020719     C                   eval      c1niv8 = nc(08)
358900020719     C                   eval      c1niv9 = nc(09)
359000020719     ?*- STATUS INGRESO...
359100020719     C                   eval      c1ivsi = '1'
359200020719     ?*- MARCAS Y OTRAS YERBAS...
359300020719     C                   eval      c1mar1 = '0'
359400020719     C                   eval      c1mar2 = '0'
359500020719     C                   eval      c1mar3 = '0'
359600020719     C                   eval      c1mar4 = '0'
359700020719     C                   eval      c1user = vsuser
359800020719     C                   time                    c1time
359900020719     C                   eval      c1date = udate
360000041025     ?* Número de R.U.T.A. del asegurado...
360100041025     C                   eval      c1ruta = x1ruta
360200020719     ?*- GRABACION...
360300020719     C   20              write     p1hec1
360400020719     C  n20              update    p1hec1
360500020719     ?*- PAHEC4...
360600020719     C     k1@ec4        chain     p1hec4                             20
360700020719     ?* veo si tengo que producir efectos en el archivo de
360800020719     ?* coberturas provisorias...
360900020719?1b? C                   if        not *in20  and                               ?P----------01
361000020719     C                             c4cobn <> x1cobn                             ?            |
361100020719     ?* se está cambiando la cobertura por lo que tengo                         ?            |
361200020719     ?* que producir la liberación de la anterior...                            ?            |
361300020719     C     k2@cp0        chain     p1hcp0                             21        ?            |
361400020719?2b? C                   if        not *in21                                    ?P---------02|
361500020719     ?* si fue generada por emisión la anulo, si fue                            ?           ||
361600020719     ?* generada por el módulo de coberturas la libero...                       ?           ||
361700020719?3b? C                   select                                                 ?P--------03||
361800020719?3x? C                   when      p0mar1 = '0'                                 ?w--------03||
361900020719     C                   eval      p0mar2 = '0'                                 ?          |||
362000020719?3x? C                   when      p0mar1 = '1'                                 ?w--------03||
362100020719     C                   eval      p0mar2 = '2'                                 ?          |||
362200020719?3e? C                   endsl                                                  ?F--------03||
362300020719     C                   eval      p0spol = *zeros                              ?           ||
362400020719     C                   eval      p0sspo = *zeros                              ?           ||
362500020719     C                   update    p1hcp0                                       ?           ||
362600020719?2e? C                   endif                                                  ?F---------02|
362700020719?1e? C                   endif                                                  ?F----------01
362800020719     ?* Si tengo informado número de cobertura tengo que
362900020719     ?* asignarla a esta superpóliza...
363000020719?1b? C                   if        x1cobn <> *zeros                             ?P----------01
363100020719     C     k1@cp0        chain     p1hcp0                             21        ?            |
363200020719?2b? C                   if        not *in21                                    ?P---------02|
363300020719     C                   eval      p0mar2 = '1'                                 ?           ||
363400020719     C                   eval      p0spol = @@spol                              ?           ||
363500020719     C                   eval      p0sspo = @@sspo                              ?           ||
363600020719     C                   update    p1hcp0                                       ?           ||
363700020719?2e? C                   endif                                                  ?F---------02|
363800020719?1e? C                   endif                                                  ?F----------01
363900020719     C                   unlock    pahcp0
364000020719     ?* sigo con la grabación del archivo...
364100020719     C                   eval      c4empr = @@empr
364200020719     C                   eval      c4sucu = @@sucu
364300020719     C                   eval      c4arcd = @@arcd
364400020719     C                   eval      c4spol = @@spol
364500020719     C                   eval      c4sspo = @@sspo
364600020719     C                   eval      c4cert = *zeros
364700020719     C                   eval      c4cobn = x1cobn
364800020719     C                   eval      c4soln = x1soln
364900020719     C                   eval      c4sarc = x1sarc
365000020719     C                   eval      c4mar1 = '0'
365100020719     C                   eval      c4mar2 = '0'
365200020719     C                   eval      c4mar3 = '0'
365300020719     C                   eval      c4mar4 = '0'
365400020719     C                   eval      c4mar5 = '0'
365500020719     C                   eval      c4strg = '0'
365600020719     C                   eval      c4user = vsuser
365700020719     C                   time                    c4time
365800020719     C                   eval      c4date = udate
365900020719     C   20              eval      c4ref1 = *zeros
366000020719     C   20              eval      c4ref2 = *zeros
366100020719     C   20              eval      c4ref3 = *blanks
366200020719     C   20              eval      c4ref4 = *blanks
366300020719     ?*- GRABACION...
366400020719     C   20              write     p1hec4
366500020719     C  n20              update    p1hec4
366600020719     C                   unlock    pahec4
366700020719     ?*- PAHEC5...
366800020719     ?* solo si existen registros en el subarchivo...
366900020719?1b? C                   if        *in30                                        ?P----------01
367000020719     C                   setoff                                           99    ?            |
367100020719     C     k1@ec5        setll     p1hec5                                       ?            |
367200020719?2b? C                   dou       *in99                                        ?P---------02|
367300020719     C     k1@ec5        reade     p1hec5                                 99    ?           ||
367400020719?3b? C                   if        not *in99                                    ?P--------03||
367500020719     C                   delete    p1hec5                                       ?          |||
367600020719?3e? C                   endif                                                  ?F--------03||
367700020719?2e? C                   enddo                                                  ?F---------02|
367800020719     C                   unlock    pahec5                                       ?            |
367900020719     C                   eval      @@x = *zeros                                 ?            |
368000020719?2b? C                   do        20            sf2rrn                         ?P---------02|
368100020719     C     sf2rrn        chain     par310s2                           20        ?           ||
368200020719?3b? C                   if        x5asen > *zeros  and                         ?P--------03||
368300020719     C                             not *in20                                    ?          |||
368400020719     C                   add       1             @@x                            ?          |||
368500020719     C                   eval      c5empr = c1empr                              ?          |||
368600020719     C                   eval      c5sucu = c1sucu                              ?          |||
368700020719     C                   eval      c5arcd = c1arcd                              ?          |||
368800020719     C                   eval      c5spol = c1spol                              ?          |||
368900020719     C                   eval      c5sspo = c1sspo                              ?          |||
369000020719     C                   eval      c5nord = @@x                                 ?          |||
369100020719     C                   eval      c5asen = x5asen                              ?          |||
369200020719     C                   eval      c5mar1 = '0'                                 ?          |||
369300020719     C                   eval      c5mar2 = '0'                                 ?          |||
369400020719     C                   eval      c5mar3 = '0'                                 ?          |||
369500020719     C                   eval      c5mar4 = '0'                                 ?          |||
369600020719     C                   eval      c5mar5 = '0'                                 ?          |||
369700020719     C                   eval      c5strg = '0'                                 ?          |||
369800020719     C                   eval      c5date = udate                               ?          |||
369900020719     C                   time                    c5time                         ?          |||
370000020719     C                   eval      c5user = vsuser                              ?          |||
370100020719     C                   write     p1hec5                                       ?          |||
370200020719?3e? C                   endif                                                  ?F--------03||
370300020719?2e? C                   enddo                                                  ?F---------02|
370400020719?1e? C                   endif                                                  ?F----------01
370500020719     ?*- Revisar grabaciòn del pahec2...
370600020719     C                   exsr      graec2
370700020719     ?* Cuando no hay coaseguro el archivo PAHPD0 se graba
370800020719     ?* con la primera entrada del programa y no se puede
370900020719     ?* volver a modificar ya que las ramas/secuencias no
371000020719     ?* son negociables al momento de la emision...
371100020719     ?*- GRABACION DEL ARCHIVO PAWPD0...
371200020719?1b? C                   select                                                 ?P----------01
371300020719     ?*- No es coaseguro y no solicita intermediario de                         ?            |
371400020719     ?*- nivel superior o solicita pero no es poliza nueva                      ?            |
371500020719?1x? C                   when      x1wcoa = 0  and                              ?w----------01
371600020719     C                             @@ma05 = '0'  or                             ?            |
371700020719     C                             x1wcoa = 0  and                              ?            |
371800020719     C                             @@ma05 = '1'  and                            ?            |
371900020719     C                             *in03  or                                    ?            |
372000020719     C                             x1wcoa = 0  and                              ?            |
372100020719     C                             @@ma05 = '2'  and                            ?            |
372200020719     C                             *in03                                        ?            |
372300020719     ?*- Verifica si es primera entrada...                                      ?            |
372400020719?2b? C     w0wp01        caseq     *zeros        grpd0a                         ?P---------02|
372500020719?2e? C                   endcs                                                  ?F---------02|
372600020719     ?*- Actualizar marca de paso realizado...                                  ?            |
372700020719     C     k1@pc0        chain     p1wpc0                             20        ?            |
372800020719     C  n20              eval      w0wp01 = 1                                   ?            |
372900020719     C  n20              update    p1wpc0                                       ?            |
373000020719     ?*- Finaliza el programa...                                                ?            |
373100020719     C                   eval      @@mand = 'KA'                                ?            |
373200020719     C                   eval      *inkc = '1'                                  ?            |
373300020719     ?*- No es coaseguro y SI solicita intermediario de                         ?            |
373400020719     ?*- nivel superior...                                                      ?            |
373500020719?1x? C                   when      x1wcoa = 0  and                              ?w----------01
373600020719     C                             @@ma05 = '1'  and                            ?            |
373700020719     C                             not *in03                                    ?            |
373800020719?2b? C     w0wp01        caseq     *zeros        grpd0a                         ?P---------02|
373900020719?2e? C                   endcs                                                  ?F---------02|
374000020719     C                   exsr      borr03                                       ?            |
374100020719     C                   eval      xxiden = 3                                   ?            |
374200020719     ?*- No es coaseguro y SI solicita cadena...                                ?            |
374300020719?1x? C                   when      x1wcoa = 0  and                              ?w----------01
374400020719     C                             @@ma05 = '2'  and                            ?            |
374500020719     C                             not *in03                                    ?            |
374600020719?2b? C     w0wp01        caseq     *zeros        grpd0a                         ?P---------02|
374700020719?2e? C                   endcs                                                  ?F---------02|
374800020719     C                   exsr      borr05                                       ?            |
374900020719     C                   exsr      carg05                                       ?            |
375000020719     C                   eval      xxiden = 5                                   ?            |
375100020719     ?*- Si hay coaseguro sigue la joda...                                      ?            |
375200020719?1x? C                   when      x1wcoa = 2                                   ?w----------01
375300020719?2b? C     w0wp01        caseq     0             sf1car                         ?P---------02|
375400020719     C     w0wp01        caseq     1             sf2car                         ?           ||
375500020719?2e? C                   endcs                                                  ?F---------02|
375600020719     C                   eval      xxiden = 2                                   ?            |
375700020719?1e? C                   endsl                                                  ?F----------01
375800020719     C     k1@ec6        chain     p1hec6                             22
375900020719?1b? C                   if        not *in22                                    ?P----------01
376000020719     C                   eval      c6empr = @@empr                              ?            |
376100020719     C                   eval      c6sucu = @@sucu                              ?            |
376200020719     C                   eval      c6arcd = @@arcd                              ?            |
376300020719     C                   eval      c6spol = @@spol                              ?            |
376400020719     C                   eval      c6sspo = @@sspo                              ?            |
376500020719     C                   eval      c6mone = x1mone                              ?            |
376600020719     C                   eval      c6imp1 = x1cmas                              ?            |
376700020719     C                   eval      c6por1 = x1pmas                              ?            |
376800020719     C                   eval      c6por2 = x1paco                              ?            |
376900020719     C                   eval      c6por3 = x1paas                              ?            |
377000020719?2b? C                   if        c6imp1 <> *zeros  or                         ?P---------02|
377100020719     C                             c6por1 <> *zeros  or                         ?           ||
377200020719     C                             c6por2 <> *zeros  or                         ?           ||
377300020719     C                             c6por3 <> *zeros                             ?           ||
377400020719     C                   update    p1hec6                                       ?           ||
377500020719?2e? C                   endif                                                  ?F---------02|
377600020719?1x? C                   else                                                   ?X..........01
377700020719     C                   eval      c6empr = @@empr                              ?            |
377800020719     C                   eval      c6sucu = @@sucu                              ?            |
377900020719     C                   eval      c6arcd = @@arcd                              ?            |
378000020719     C                   eval      c6spol = @@spol                              ?            |
378100020719     C                   eval      c6sspo = @@sspo                              ?            |
378200020719     C                   eval      c6mone = x1mone                              ?            |
378300020719     C                   eval      c6imp1 = x1cmas                              ?            |
378400020719     C                   eval      c6por1 = x1pmas                              ?            |
378500020719     C                   eval      c6por2 = x1paco                              ?            |
378600020719     C                   eval      c6por3 = x1paas                              ?            |
378700020719?2b? C                   if        c6imp1 <> *zeros  or                         ?P---------02|
378800020719     C                             c6por1 <> *zeros  or                         ?           ||
378900020719     C                             c6por2 <> *zeros  or                         ?           ||
379000020719     C                             c6por3 <> *zeros                             ?           ||
379100020719     C                   write     p1hec6                                       ?           ||
379200020719?2e? C                   endif                                                  ?F---------02|
379300020719?1e? C                   endif                                                  ?F----------01
379400020719     C                   endsr
379500000904     ?******************************************************
379600020719     C     graec2        begsr
379700020719     ?** BORRATINA DEL PAHEC2------------------------------
379800020719     ?* si la forma de pago no es 4 o 5 hay que borrar por
379900020719     ?* precauciòn el pahec2 que puede haber quedado gene-
380000020719     ?* rado de una pasada anterior del programa...
380100020719?1b? C                   if        x1cfpg <> 4  and                             ?P----------01
380200020719     C                             x1cfpg <> 5                                  ?            |
380300020719     C                   setoff                                           93    ?            |
380400020719     C     k1@ec1        setll     p1hec2                                       ?            |
380500020719?2b? C                   dou       *in93                                        ?P---------02|
380600020719     C     k1@ec1        reade     p1hec2                                 93    ?           ||
380700020719?3b? C                   if        not *in93                                    ?P--------03||
380800020719     C                   delete    p1hec2                                       ?          |||
380900020719?3e? C                   endif                                                  ?F--------03||
381000020719?2e? C                   enddo                                                  ?F---------02|
381100020719?1e? C                   endif                                                  ?F----------01
381200020719     C                   unlock    pahec2
381300020719     C                   endsr
381400000904     ?******************************************************
381500020719     C     cadena        begsr
381600020719     ?** ARMAR LA CADENA DE NIVELES DE INTERMEDIACION------
381700020719     ?* No se usa el indicador 20 para chain porque esta
381800020719     ?* rutina está dentro de la GRAB01 con lo cual el
381900020719     ?* indicador está reservado para separa altas de
382000020719     ?* cambios...
382100020719?1b? C                   select                                                 ?P----------01
382200020719     ?*- SI EL ORDEN ES JERARQUICO...                                           ?            |
382300020719?1x? C                   when      @@ma05 = '0'  or                             ?w----------01
382400020719     C                             @@ma05 = '1'                                 ?            |
382500020719     C                   eval      nc = *zeros                                  ?            |
382600020719     C                   eval      @@t = c1nivt                                 ?            |
382700020719     C                   eval      @@c = c1nivc                                 ?            |
382800020719     C                   eval      nc(@@t) = c1nivc                             ?            |
382900020719?2b? C                   do        10            x                              ?P---------02|
383000020719     C     k2@ni2        chain     s1hni201                           21        ?           ||
383100020719?3b? C                   if        not *in21  and                               ?P--------03||
383200020719     C                             n3nivc <> *zeros                             ?          |||
383300020719     C                   eval      @@t = n3nivt                                 ?          |||
383400020719     C                   eval      @@c = n3nivc                                 ?          |||
383500020719     C                   eval      nc(@@t) = n3nivc                             ?          |||
383600020719?3e? C                   endif                                                  ?F--------03||
383700020719?2e? C                   enddo                                                  ?F---------02|
383800020719     ?*- SI ARMA CADENA EL USUARIO SOLO SI ES NUEVA Y ES                        ?            |
383900020719     ?*- LA PRIMERA VEZ...                                                      ?            |
384000020719?1x? C                   when      @@ma05 = '2'  and                            ?w----------01
384100020719     C                             w0tiou = 1  and                              ?            |
384200020719     C                             w0wp01 = 0  or                               ?            |
384300020719     C                             @@ma05 = '2'  and                            ?            |
384400020719     C                             w0tiou = 2  and                              ?            |
384500020719     C                             w0wp01 = 0                                   ?            |
384600020719     C                   eval      nc = *zeros                                  ?            |
384700020719     C                   eval      @@t = c1nivt                                 ?            |
384800020719     C                   eval      @@c = c1nivc                                 ?            |
384900020719     C                   eval      nc(@@t) = c1nivc                             ?            |
385000020719?2b? C                   do        10            x                              ?P---------02|
385100020719     C     k2@ni2        chain     s1hni201                           21        ?           ||
385200020719?3b? C                   if        not *in21  and                               ?P--------03||
385300020719     C                             n3nivc <> *zeros                             ?          |||
385400020719     C                   eval      @@t = n3nivt                                 ?          |||
385500020719     C                   eval      @@c = n3nivc                                 ?          |||
385600020719     C                   eval      nc(@@t) = n3nivc                             ?          |||
385700020719?3e? C                   endif                                                  ?F--------03||
385800020719?2e? C                   enddo                                                  ?F---------02|
385900020719?1e? C                   endsl                                                  ?F----------01
386000020719     C                   endsr
386100000904     ?******************************************************
386200020719     C     grpd0a        begsr
386300020719     ?** GRABACION DEL PAWPD0------------------------------
386400020719     ?** SIN COASEGURO-------------------------------------
386500020719     C                   setoff                                           99
386600020719     C     k1t621        setll     s1t621
386700020719?1b? C                   dou       *in99                                        ?P----------01
386800020719     C     k1t621        reade     s1t621                                 99    ?            |
386900020719?2b? C                   if        not *in99                                    ?P---------02|
387000040416     ?* PAWPD0.                                                                 ?           ||
387100020719     C                   eval      z0empr = @@empr                              ?           ||
387200020719     C                   eval      z0sucu = @@sucu                              ?           ||
387300020719     C                   eval      z0arcd = @@arcd                              ?           ||
387400020719     C                   eval      z0spo1 = @@spo1                              ?           ||
387500020719     C                   eval      z0spol = @@spol                              ?           ||
387600020719     C                   eval      z0sspo = @@sspo                              ?           ||
387700020719     C                   eval      z0rama = t@rama                              ?           ||
387800020719     C                   eval      z0arse = t@arse                              ?           ||
387900040416     ?* PAWP310.                                                                ?           ||
388000040416     C                   eval      z0emprlk = z0empr                            ?           ||
388100040416     C                   eval      z0suculk = z0sucu                            ?           ||
388200040416     C                   eval      z0arcdlk = z0arcd                            ?           ||
388300040416     C                   eval      z0spo1lk = z0spo1                            ?           ||
388400040416     C                   eval      z0spollk = z0spol                            ?           ||
388500040416     C                   eval      z0sspolk = z0sspo                            ?           ||
388600040416     C                   eval      z0ramalk = z0rama                            ?           ||
388700040416     C                   eval      z0arselk = z0arse                            ?           ||
388800040416                                                                                ?           ||
388900020719     C     k3@pd0        setll     p1wpd0                                 20    ?           ||
389000020719?3b? C                   if        not *in20                                    ?P--------03||
389100020719     C                   exsr      busope                                       ?          |||
389200040416     ?* PAWPD0.                                                                 ?          |||
389300020719     C                   eval      z0oper = @@oper                              ?          |||
389400020719     C                   eval      z0suop = @@suop                              ?          |||
389500020719     C                   eval      z0tiou = w0tiou                              ?          |||
389600020719     C                   eval      z0stou = w0stou                              ?          |||
389700020719     C                   eval      z0stos = w0stos                              ?          |||
389800020719     C                   eval      z0wp01 = *zeros                              ?          |||
389900020719     C                   eval      z0wp02 = *zeros                              ?          |||
390000020719     C                   eval      z0wp03 = *zeros                              ?          |||
390100020719     C                   eval      z0wp04 = *zeros                              ?          |||
390200020719     C                   eval      z0wp05 = *zeros                              ?          |||
390300020719     C                   eval      z0wp06 = *zeros                              ?          |||
390400020719     C                   eval      z0wp07 = *zeros                              ?          |||
390500020719     C                   eval      z0wp08 = *zeros                              ?          |||
390600020719     C                   eval      z0wp09 = *zeros                              ?          |||
390700020719     C                   eval      z0wp10 = *zeros                              ?          |||
390800020719     C                   eval      z0wp11 = *zeros                              ?          |||
390900020719     C                   eval      z0wp12 = *zeros                              ?          |||
391000020719     C                   eval      z0wp13 = *zeros                              ?          |||
391100020719     C                   eval      z0wp14 = *zeros                              ?          |||
391200020719     C                   eval      z0wp15 = *zeros                              ?          |||
391300040416     C                   eval      z0user = vsuser                              ?          |||
391400040416     C                   time                    z0time                         ?          |||
391500040416     C                   eval      z0date = udate                               ?          |||
391600040416     ?* PAWP310.                                                                ?          |||
391700040416     C                   eval      z0operlk = z0oper                            ?          |||
391800040416     C                   eval      z0suoplk = z0suop                            ?          |||
391900040416     C                   eval      z0wp01lk = *zeros                            ?          |||
392000040416     C                   eval      z0wp02lk = *zeros                            ?          |||
392100040416     C                   eval      z0wp03lk = *zeros                            ?          |||
392200040416     C                   eval      z0wp04lk = *zeros                            ?          |||
392300040416     C                   eval      z0wp05lk = *zeros                            ?          |||
392400040416     C                   eval      z0wp06lk = *zeros                            ?          |||
392500040416     C                   eval      z0wp07lk = *zeros                            ?          |||
392600040416     C                   eval      z0wp08lk = *zeros                            ?          |||
392700040416     C                   eval      z0wp09lk = *zeros                            ?          |||
392800040416     C                   eval      z0wp10lk = *zeros                            ?          |||
392900040416     C                   eval      z0wp11lk = *zeros                            ?          |||
393000040416     C                   eval      z0wp12lk = *zeros                            ?          |||
393100040416     C                   eval      z0wp13lk = *zeros                            ?          |||
393200040416     C                   eval      z0wp14lk = *zeros                            ?          |||
393300040416     C                   eval      z0wp15lk = *zeros                            ?          |||
393400040416     C                   eval      z0userlk = z0user                            ?          |||
393500040416     C                   time                    z0timelk                       ?          |||
393600040416     C                   eval      z0datelk = udate                             ?          |||
393700040416                                                                                ?          |||
393800020719     C                   exsr      buscia                                       ?          |||
393900020719     C                   eval      z0copg = *zeros                              ?          |||
394000020719     C                   eval      z0gpil = *zeros                              ?          |||
394100020719     C                   eval      z0marp = '0'                                 ?          |||
394200020719     C                   write     p1wpd0                                       ?          |||
394300040416     ?* Graba PAWP310.                                                          ?          |||
394400040416     C     k3@pd0        setll     pawp310                                20    ?          |||
394500040416?4b? C                   if        not *in20                                    ?P-------04|||
394600040416     C                   write     p1wp310                                      ?         ||||
394700020719?4e? C                   endif                                                  ?F-------04|||
394800040416?3e? C                   endif                                                  ?F--------03||
394900020719?2e? C                   endif                                                  ?F---------02|
395000020719?1e? C                   enddo                                                  ?F----------01
395100020719     C                   endsr
395200000904     ?******************************************************
395300020719     C     busope        begsr
395400020719     ?** BUSCAR NUMERO DE OPERACION------------------------
395500020719?1b? C                   select                                                 ?P----------01
395600020719?1x? C                   when      w0tiou <= 2                                  ?w----------01
395700020719     C                   eval      t@tnum = '2'                                 ?            |
395800020719     C     t@tnum        chain     s1t902                             20        ?            |
395900020719     C  n20              add       1             t@nres                         ?            |
396000020719     C  n20              update    s1t902                                       ?            |
396100020719     C  n20              eval      @@oper = t@nres                              ?            |
396200020719     C  n20              eval      @@suop = *zeros                              ?            |
396300020719?1x? C                   when      w0tiou >= 3                                  ?w----------01
396400020719     C                   eval      @1sspo = z0sspo - 1                          ?            |
396500020719     C     k3@ed0        setgt     p1hed0                                       ?            |
396600020719     C     k3@ed0        readpe    p1hed0                                 98    ?            |
396700020719     C  n98              eval      @@oper = d0oper                              ?            |
396800020719     C  n98d0suop        add       1             @@suop                         ?            |
396900020719?1e? C                   endsl                                                  ?F----------01
397000020719     C                   endsr
397100000904     ?******************************************************
397200020719     C     buscia        begsr
397300020719     ?** BUSCAR DATOS DE COMPAÑIA DE SEGUROS---------------
397400020719?1b? C                   select                                                 ?P----------01
397500020719?1x? C                   when      w0tiou <= 2                                  ?w----------01
397600020719     C                   eval      z0ncoc = t@ncoc                              ?            |
397700020719     C     k1t120        chain     s1t12003                           20        ?            |
397800020719     C  n20              eval      z0ciap = t@ciap                              ?            |
397900020719     C   20              eval      z0ciap = '0'                                 ?            |
398000020719     C                   eval      z0part = 100                                 ?            |
398100020719     C                   eval      z0cpar = '1'                                 ?            |
398200020719     C                   eval      z0copc = '0'                                 ?            |
398300020719?1x? C                   when      w0tiou >= 3                                  ?w----------01
398400020719     C                   eval      @1sspo = z0sspo - 1                          ?            |
398500020719     C     k3@ed0        setgt     p1hed0                                       ?            |
398600020719     C     k3@ed0        readpe    p1hed0                                 98    ?            |
398700020719     C  n98              eval      z0ncoc = d0ncoc                              ?            |
398800020719     C  n98              eval      z0ciap = d0ciap                              ?            |
398900020719     C  n98              eval      z0part = d0part                              ?            |
399000020719     C  n98              eval      z0cpar = d0cpar                              ?            |
399100020719     C  n98              eval      z0copc = d0copc                              ?            |
399200020719?1e? C                   endsl                                                  ?F----------01
399300020719     C                   endsr
399400000904     ?******************************************************
399500020719     C     sf1bor        begsr
399600020719     ?** BORRADO DE SUBARCHIVO PRIMERA ENTRADA-------------
399700020719     C                   setoff                                         3031
399800020719     C                   seton                                            32
399900020719     C                   write     par310c1
400000020719     C                   setoff                                           32
400100020719     C                   seton                                            31
400200020719     C                   clear                   sf1rrn
400300020719     C                   endsr
400400000904     ?******************************************************
400500020719     C     sf1car        begsr
400600020719     ?** CARGA DEL SUBARCHIVO------------------------------
400700020719     ?*- PRIMERO BORRAR...
400800020719     C                   exsr      sf1bor
400900020719     ?*- LUEGO CARGAR...
401000020719?1b? C                   select                                                 ?P----------01
401100020719     ?*- POLIZA NUEVA...                                                        ?            |
401200020719?1x? C                   when      w0tiou = 1                                   ?w----------01
401300020719?2b? C                   do        10            sf1rrn                         ?P---------02|
401400020719     C                   eval      x2ncoc = *zeros                              ?           ||
401500020719     C                   eval      x2nacc = *blanks                             ?           ||
401600020719     C                   eval      x2ciap = *blanks                             ?           ||
401700020719     C                   eval      x2part = *zeros                              ?           ||
401800020719     C                   eval      x2cpar = *blanks                             ?           ||
401900020719     C                   eval      x2copc = *blanks                             ?           ||
402000020719     C                   eval      x2copg = *zeros                              ?           ||
402100020719     C                   eval      x2gpil = *zeros                              ?           ||
402200020719     C                   setoff                                           39    ?           ||
402300020719     C                   eval      x2in39 = '0'                                 ?           ||
402400020719?3b? C                   if        sf1rrn = 1                                   ?P--------03||
402500020719     C                   exsr      comdef                                       ?          |||
402600020719?3e? C                   endif                                                  ?F--------03||
402700020719     C                   write     par310s1                                     ?           ||
402800020719     C                   setoff                                           39    ?           ||
402900020719     C                   eval      x2in39 = '0'                                 ?           ||
403000020719     C                   seton                                            30    ?           ||
403100020719?2e? C                   enddo                                                  ?F---------02|
403200020719     ?*- RENOVACIONES/ENDOSOS MISMA FORMA DE CARGA...                           ?            |
403300020719?1x? C                   when      w0tiou = 2  or                               ?w----------01
403400020719     C                             w0tiou = 3  or                               ?            |
403500020719     C                             w0tiou = 5                                   ?            |
403600020719     C     k2@ec1        setgt     p1hec1                                       ?            |
403700020719     C     k2@ec1        readpe(n) p1hec1                                 98    ?            |
403800020719     C                   setoff                                           98    ?            |
403900020719     C     k2@ed0        setll     p1hed0                                 98    ?            |
404000020719?2b? C                   do        10            sf1rrn                         ?P---------02|
404100020719     C     k2@ed0        reade     p1hed0                                 98    ?           ||
404200020719?3b? C                   if        not *in98                                    ?P--------03||
404300020719     C                   eval      x2ncoc = d0ncoc                              ?          |||
404400020719     C                   eval      x2ciap = d0ciap                              ?          |||
404500020719     C     k2t120        chain     s1t12003                           20        ?          |||
404600020719     C   20              eval      x2nacc = *blanks                             ?          |||
404700020719     C  n20              eval      x2nacc = t@nacc                              ?          |||
404800020719     C                   eval      x2part = d0part                              ?          |||
404900020719     C                   eval      x2cpar = d0cpar                              ?          |||
405000020719     C                   eval      x2copc = d0copc                              ?          |||
405100020719     C                   eval      x2copg = d0copg                              ?          |||
405200020719     C                   eval      x2gpil = d0gpil                              ?          |||
405300020719?3x? C                   else                                                   ?X........03||
405400020719     C                   eval      x2ncoc = *zeros                              ?          |||
405500020719     C                   eval      x2nacc = *blanks                             ?          |||
405600020719     C                   eval      x2ciap = *blanks                             ?          |||
405700020719     C                   eval      x2part = *zeros                              ?          |||
405800020719     C                   eval      x2cpar = *blanks                             ?          |||
405900020719     C                   eval      x2copc = *blanks                             ?          |||
406000020719     C                   eval      x2copg = *zeros                              ?          |||
406100020719     C                   eval      x2gpil = *zeros                              ?          |||
406200020719?3e? C                   endif                                                  ?F--------03||
406300020719     C                   setoff                                           39    ?           ||
406400020719     C                   eval      x2in39 = '0'                                 ?           ||
406500020719     C                   write     par310s1                                     ?           ||
406600020719     C                   seton                                            30    ?           ||
406700020719?2e? C                   enddo                                                  ?F---------02|
406800020719?1e? C                   endsl                                                  ?F----------01
406900020719     C                   endsr
407000001020     ?******************************************************
407100020719     C     comdef        begsr
407200020719     ?** COMPAÑIA COEASEGURADORA PROPIA--------------------
407300020719     C                   setoff                                           99
407400020719     C     k3t120        setll     s1t12003
407500020719?1b? C                   dou       *in99                                        ?P----------01
407600020719     C     k3t120        reade     s1t12003                               99    ?            |
407700020719?2b? C                   if        not *in99  and                               ?P---------02|
407800020719     C                             t@ciap = '1'                                 ?           ||
407900020719     C                   seton                                            39    ?           ||
408000020719     C                   eval      x2in39 = '1'                                 ?           ||
408100020719     C                   eval      x2ncoc = t@ncoc                              ?           ||
408200020719     C                   eval      x2nacc = t@nacc                              ?           ||
408300020719     C                   eval      x2ciap = t@ciap                              ?           ||
408400020719?2e? C                   endif                                                  ?F---------02|
408500020719?1e? C                   enddo                                                  ?F----------01
408600020719     C                   endsr
408700000904     ?******************************************************
408800020719     C     sf2bor        begsr
408900020719     ?** BORRADO DE SUBARCHIVO SEGUNDA ENTRADA-------------
409000020719     C                   setoff                                         3031
409100020719     C                   seton                                            32
409200020719     C                   write     par310c1
409300020719     C                   setoff                                           32
409400020719     C                   seton                                            31
409500020719     C                   clear                   sf1rrn
409600020719     C                   endsr
409700000904     ?******************************************************
409800020719     C     sf2car        begsr
409900020719     ?** CARGA DEL SUBARCHIVO------------------------------
410000020719     ?*- PRIMERO BORRAR...
410100020719     C                   exsr      sf2bor
410200020719     C                   setoff                                           98
410300020719     ?*- LUEGO CARGAR...
410400020719     C     k2@pd0        setll     p1wpd0
410500020719?1b? C                   do        10            sf1rrn                         ?P----------01
410600020719     C     k2@pd0        reade(n)  p1wpd0                                 98    ?            |
410700020719?2b? C                   if        not *in98                                    ?P---------02|
410800020719     C                   eval      x2ncoc = z0ncoc                              ?           ||
410900020719     C                   eval      x2ciap = z0ciap                              ?           ||
411000020719     C     k2t120        chain     s1t12003                           20        ?           ||
411100020719     C   20              eval      x2nacc = *blanks                             ?           ||
411200020719     C  n20              eval      x2nacc = t@nacc                              ?           ||
411300020719     C                   eval      x2part = z0part                              ?           ||
411400020719     C                   eval      x2cpar = z0cpar                              ?           ||
411500020719     C                   eval      x2copc = z0copc                              ?           ||
411600020719     C                   eval      x2copg = z0copg                              ?           ||
411700020719     C                   eval      x2gpil = z0gpil                              ?           ||
411800020719?2x? C                   else                                                   ?X.........02|
411900020719     C                   eval      x2ncoc = *zeros                              ?           ||
412000020719     C                   eval      x2nacc = *blanks                             ?           ||
412100020719     C                   eval      x2part = *zeros                              ?           ||
412200020719     C                   eval      x2cpar = *blanks                             ?           ||
412300020719     C                   eval      x2copc = *blanks                             ?           ||
412400020719     C                   eval      x2copg = *zeros                              ?           ||
412500020719     C                   eval      x2gpil = *zeros                              ?           ||
412600020719?2e? C                   endif                                                  ?F---------02|
412700020719     C                   seton                                            39    ?            |
412800020719     C                   eval      x2in39 = '1'                                 ?            |
412900020719     C                   write     par310s1                                     ?            |
413000020719     C                   seton                                            30    ?            |
413100020719?1e? C                   enddo                                                  ?F----------01
413200020719     C                   endsr
413300000904     ?******************************************************
413400020719     C     sf3bor        begsr
413500020719     ?** BORRADO DE SUBARCHIVO PRIMERA ENTRADA-------------
413600020719     C                   setoff                                         3031
413700020719     C                   seton                                            32
413800020719     C                   write     par310c2
413900020719     C                   setoff                                           32
414000020719     C                   seton                                            31
414100020719     C                   clear                   sf2rrn
414200020719     C                   clear                   xxasen
414300020719     C                   clear                   xxnomb
414400020719     C                   endsr
414500000904     ?******************************************************
414600020719     C     sf3car        begsr
414700020719     ?** CARGA DEL SUBARCHIVO------------------------------
414800020719     ?*- PRIMERO BORRAR...
414900020719     C                   exsr      sf3bor
415000020719     ?*- LUEGO CARGAR...
415100020719     C                   setoff                                           98
415200020719?1b? C                   dou       *in98                                        ?P----------01
415300020719     C     k1@ec5        reade     p1hec5                                 98    ?            |
415400020719?2b? C                   if        not *in98  and                               ?P---------02|
415500020719     C                             sf2rrn < 20                                  ?           ||
415600020719     C                   clear                   x5opci                         ?           ||
415700020719     C                   eval      x5asen = c5asen                              ?           ||
415800020719     C     x5asen        chain     g1hdaf                             20        ?           ||
415900020719     C  n20              eval      x5nomb = dfnomb                              ?           ||
416000020719     C   20              eval      x5nomb = *blanks                             ?           ||
416100020719     C                   add       1             sf2rrn                         ?           ||
416200020719     C                   seton                                            30    ?           ||
416300020719     C                   write     par310s2                                     ?           ||
416400020719?2e? C                   endif                                                  ?F---------02|
416500020719?1e? C                   enddo                                                  ?F----------01
416600020719     C                   endsr
416700000904     ?******************************************************
416800020719     C     sf4bor        begsr
416900020719     ?** BORRADO DE SUBARCHIVO PRIMERA ENTRADA-------------
417000020719     C                   setoff                                         3031
417100020719     C                   seton                                            32
417200020719     C                   write     par310c2
417300020719     C                   setoff                                           32
417400020719     C                   seton                                            31
417500020719     C                   clear                   sf2rrn
417600020719     C                   clear                   xxasen
417700020719     C                   clear                   xxnomb
417800020719     C                   endsr
417900000904     ?******************************************************
418000020719     C     sf4car        begsr
418100020719     ?** CARGA DEL SUBARCHIVO------------------------------
418200020719     ?*- PRIMERO BORRAR...
418300020719     C                   exsr      sf4bor
418400020719     ?*- LUEGO CARGAR...
418500020719?1b? C                   select                                                 ?P----------01
418600020719     ?* POLIZA NUEVA...                                                         ?            |
418700020719?1x? C                   when      w0tiou = 1                                   ?w----------01
418800020719     ?* OTROS MOVIMIENTOS...                                                    ?            |
418900020719?1x? C                   when      w0tiou <> 1                                  ?w----------01
419000020719     C                   setoff                                           98    ?            |
419100020719?2b? C                   dou       *in98                                        ?P---------02|
419200020719     C     k2@ec5        reade     p1hec5                                 98    ?           ||
419300020719?3b? C                   if        not *in98  and                               ?P--------03||
419400020719     C                             sf2rrn < 20                                  ?          |||
419500020719     C                   clear                   x5opci                         ?          |||
419600020719     C                   eval      x5asen = c5asen                              ?          |||
419700020719     C     x5asen        chain     g1hdaf                             20        ?          |||
419800020719     C  n20              eval      x5nomb = dfnomb                              ?          |||
419900020719     C   20              eval      x5nomb = *blanks                             ?          |||
420000020719     C                   add       1             sf2rrn                         ?          |||
420100020719     C                   seton                                            30    ?          |||
420200020719     C                   write     par310s2                                     ?          |||
420300020719?3e? C                   endif                                                  ?F--------03||
420400020719?2e? C                   enddo                                                  ?F---------02|
420500020719?1e? C                   endsl                                                  ?F----------01
420600020719     C                   endsr
420700000904     ?******************************************************
420800020719     C     pant02        begsr
420900020719     ?** PROCESO DE PANTALLA 02----------------------------
421000020719     C                   exfmt     par310c1
421100020719     ?*- CORRIGE SITUACIONES DE ERROR ...
421200020719     C                   exsr      apagar
421300020719     ?*- PROCESA TECLAS DE FUNCION...
421400020719?1b? C                   select                                                 ?P----------01
421500020719     ?*- F3=SALIR...                                                            ?            |
421600020719?1x? C                   when      *inkc                                        ?w----------01
421700020719     C                   eval      xxiden = 2                                   ?            |
421800020719     ?*- F4=SOLICITUD...                                                        ?            |
421900020719?1x? C                   when      *inkd                                        ?w----------01
422000020719     C                   exsr      soli02                                       ?            |
422100020719     ?*- F12=RETORNAR...                                                        ?            |
422200020719?1x? C                   when      *inkl                                        ?w----------01
422300020719     C                   eval      xxiden = 1                                   ?            |
422400020719     ?*- AYUDA...                                                               ?            |
422500020719?1x? C                   when      *in80                                        ?w----------01
422600020719     ?*- PULSA INTRO...                                                         ?            |
422700020719?1x? C                   when      not *in29                                    ?w----------01
422800020719     C                   exsr      vali02                                       ?            |
422900020719?1e? C                   endsl                                                  ?F----------01
423000020719     C                   endsr
423100000904     ?******************************************************
423200020719     C     soli02        begsr
423300020719     ?** SOLICITUD PANTALLA 02-----------------------------
423400020719     C                   endsr
423500000904     ?******************************************************
423600020719     C     vali02        begsr
423700020719     ?** VALIDACIONES PANTALLA 02--------------------------
423800020719     ?*- CODIGOS DE COASEGURADORAS...
423900020719?1b? C                   do        10            sf1rrn                         ?P----------01
424000020719     C     sf1rrn        chain     par310s1                           20        ?            |
424100020719?2b? C                   if        not *in20  and                               ?P---------02|
424200020719     C                             x2ncoc <> *zeros                             ?           ||
424300020719     C     k2t120        chain     s1t12003                           20        ?           ||
424400020719     C   20              eval      x2nacc = *blanks                             ?           ||
424500020719     C   20              z-add     51            @e                   50        ?           ||
424600000904     C   20                                                                     ?           ||
424700020719     Can 50              update    par310s1                                     ?           ||
424800000904     C   20                                                                     ?           ||
424900020719?1v? Can 50              leave                                                  ?           ||
425000020719     C  n20              eval      x2nacc = t@nacc                              ?           ||
425100020719     C  n20              eval      x2ciap = t@ciap                              ?           ||
425200020719     C  n20              update    par310s1                                     ?           ||
425300020719?2e? C                   endif                                                  ?F---------02|
425400020719?1e? C                   enddo                                                  ?F----------01
425500020719     ?*- NINGUNA COMPAÑIA PROPIA...
425600020719?1b? C                   if        not *in50                                    ?P----------01
425700020719     C                   eval      @@ciap = '0'                                 ?            |
425800020719?2b? C                   do        10            sf1rrn                         ?P---------02|
425900020719     C     sf1rrn        chain     par310s1                           20        ?           ||
426000020719?3b? C                   if        not *in20  and                               ?P--------03||
426100020719     C                             x2ncoc <> *zeros                             ?          |||
426200020719     C     k2t120        chain     s1t12003                           20        ?          |||
426300020719?4b? C                   if        not *in20  and                               ?P-------04|||
426400020719     C                             t@ciap = '1'                                 ?         ||||
426500020719     C                   eval      @@ciap = t@ciap                              ?         ||||
426600020719?4e? C                   endif                                                  ?F-------04|||
426700020719?3e? C                   endif                                                  ?F--------03||
426800020719?2e? C                   enddo                                                  ?F---------02|
426900020719?2b? C                   if        @@ciap = '0'                                 ?P---------02|
427000020719     C                   z-add     52            @e                   50        ?           ||
427100020719?2e? C                   endif                                                  ?F---------02|
427200020719?1e? C                   endif                                                  ?F----------01
427300020719     ?*- CODIGO DE COBRANZA...
427400020719?1b? C                   if        not *in50                                    ?P----------01
427500020719?2b? C                   do        10            sf1rrn                         ?P---------02|
427600020719     C     sf1rrn        chain     par310s1                           20        ?           ||
427700020719?3b? C                   if        not *in20  and                               ?P--------03||
427800020719     C                             x2ncoc <> *zeros  and                        ?          |||
427900020719     C                             x2cpar <> '1'  and                           ?          |||
428000020719     C                             x2cpar <> '2'                                ?          |||
428100020719     C                   z-add     53            @e                   50        ?          |||
428200020719     C   50              update    par310s1                                     ?          |||
428300020719?2v? C                   leave                                                  ?          |||
428400020719?3e? C                   endif                                                  ?F--------03||
428500020719?2e? C                   enddo                                                  ?F---------02|
428600020719?1e? C                   endif                                                  ?F----------01
428700020719     ?*- CODIGO DE COMISIONES...
428800020719?1b? C                   if        not *in50                                    ?P----------01
428900020719?2b? C                   do        10            sf1rrn                         ?P---------02|
429000020719     C     sf1rrn        chain     par310s1                           20        ?           ||
429100020719?3b? C                   if        not *in20  and                               ?P--------03||
429200020719     C                             x2ncoc <> *zeros                             ?          |||
429300020719     C     k2t120        chain     s1t12003                           20        ?          |||
429400020719?4b? C                   if        t@ciap = '1'  and                            ?P-------04|||
429500020719     C                             x2copc <> '0'  or                            ?         ||||
429600020719     C                             t@ciap = '0'  and                            ?         ||||
429700020719     C                             x2copc <> '1'  and                           ?         ||||
429800020719     C                             x2copc <> '2'                                ?         ||||
429900020719     C                   z-add     54            @e                   50        ?         ||||
430000020719     C   50              update    par310s1                                     ?         ||||
430100020719?2v? C                   leave                                                  ?         ||||
430200020719?4e? C                   endif                                                  ?F-------04|||
430300020719?3e? C                   endif                                                  ?F--------03||
430400020719?2e? C                   enddo                                                  ?F---------02|
430500020719?1e? C                   endif                                                  ?F----------01
430600020719     ?*- PORCENTAJE O IMPORTE DE PILOTAJE...
430700020719?1b? C                   if        not *in50                                    ?P----------01
430800020719?2b? C                   do        10            sf1rrn                         ?P---------02|
430900020719     C     sf1rrn        chain     par310s1                           20        ?           ||
431000020719?3b? C                   if        not *in20  and                               ?P--------03||
431100020719     C                             x2ncoc <> *zeros  and                        ?          |||
431200020719     C                             x2gpil <> *zeros  and                        ?          |||
431300020719     C                             x2copg <> *zeros                             ?          |||
431400020719     C                   z-add     55            @e                   50        ?          |||
431500020719     C   50              update    par310s1                                     ?          |||
431600020719?2v? C                   leave                                                  ?          |||
431700020719?3e? C                   endif                                                  ?F--------03||
431800020719?2e? C                   enddo                                                  ?F---------02|
431900020719?1e? C                   endif                                                  ?F----------01
432000020719     ?*- REPETICION DE LA COMPAÑIA...
432100020719?1b? C                   if        not *in50                                    ?P----------01
432200020719     C                   eval      com = *zeros                                 ?            |
432300020719?2b? C                   do        10            sf1rrn                         ?P---------02|
432400020719     C     sf1rrn        chain     par310s1                           20        ?           ||
432500020719?3b? C                   if        not *in20  and                               ?P--------03||
432600020719     C                             x2ncoc <> *zeros                             ?          |||
432700020719     C                   eval      x = 1                                        ?          |||
432800020719     C     x2ncoc        lookup    com(x)                                 20    ?          |||
432900020719     C   20              z-add     56            @e                   50        ?          |||
433000000904     C   20                                                                     ?          |||
433100020719     Can 50              update    par310s1                                     ?          |||
433200020719?2v? C   20              leave                                                  ?          |||
433300020719     C  n20*zeros        lookup    com(x)                                 20    ?          |||
433400020719     C   20              eval      com(x) = x2ncoc                              ?          |||
433500020719?3e? C                   endif                                                  ?F--------03||
433600020719?2e? C                   enddo                                                  ?F---------02|
433700020719?1e? C                   endif                                                  ?F----------01
433800020719     ?*- SUMA DE PORCENTAJES...
433900020719?1b? C                   if        not *in50                                    ?P----------01
434000020719     C                   eval      @@part = *zeros                              ?            |
434100020719?2b? C                   do        10            sf1rrn                         ?P---------02|
434200020719     C     sf1rrn        chain     par310s1                           20        ?           ||
434300020719?3b? C                   if        not *in20  and                               ?P--------03||
434400020719     C                             x2ncoc <> *zeros                             ?          |||
434500020719     C                   add       x2part        @@part                         ?          |||
434600020719?3e? C                   endif                                                  ?F--------03||
434700020719?2e? C                   enddo                                                  ?F---------02|
434800020719?2b? C                   if        @@part <> 100                                ?P---------02|
434900020719     C                   z-add     57            @e                   50        ?           ||
435000020719?2e? C                   endif                                                  ?F---------02|
435100020719?1e? C                   endif                                                  ?F----------01
435200020719     ?*- BORRAR DATOS CUANDO NO HAY CODIGO DE CIA...
435300020719?1b? C                   do        10            sf1rrn                         ?P----------01
435400020719     C     sf1rrn        chain     par310s1                           20        ?            |
435500020719?2b? C                   if        not *in20  and                               ?P---------02|
435600020719     C                             x2ncoc = *zeros                              ?           ||
435700020719     C                   eval      x2nacc = *blanks                             ?           ||
435800020719     C                   eval      x2part = *zeros                              ?           ||
435900020719     C                   eval      x2cpar = *blanks                             ?           ||
436000020719     C                   eval      x2copc = *blanks                             ?           ||
436100020719     C                   eval      x2copg = *zeros                              ?           ||
436200020719     C                   eval      x2gpil = *zeros                              ?           ||
436300020719     C                   update    par310s1                                     ?           ||
436400020719?2e? C                   endif                                                  ?F---------02|
436500020719?1e? C                   enddo                                                  ?F----------01
436600020719     ?*- POR ERROR O MODIFICACION APAGAR EL *IN90...
436700020719?1b? C                   if        *in50  or                                    ?P----------01
436800020719     C                             *in92                                        ?            |
436900020719     C                   setoff                                           90    ?            |
437000020719?1e? C                   endif                                                  ?F----------01
437100020719     ?*- SI NO EXISTEN ERRORES AVANZA...
437200020719?1b? C                   if        not *in50                                    ?P----------01
437300020719?2b? C                   if        not *in92  and                               ?P---------02|
437400020719     C                             *in90                                        ?           ||
437500020719     C                   setoff                                           90    ?           ||
437600020719     C                   exsr      grab02                                       ?           ||
437700020719?2x? C                   else                                                   ?X.........02|
437800020719     C                   seton                                            90    ?           ||
437900020719?2e? C                   endif                                                  ?F---------02|
438000020719?1e? C                   endif                                                  ?F----------01
438100020719     ?*- SI EXISTEN ERRORES...
438200020719?1b? C                   if        *in50  and                                   ?P----------01
438300020719     C                             @e <> *zeros                                 ?            |
438400020719     C                   write     par310c1                                     ?            |
438500020719     C                   eval      *in(@e) = '1'                                ?            |
438600020719?1e? C                   endif                                                  ?F----------01
438700020719     C                   endsr
438800000904     ?******************************************************
438900020719     C     grab02        begsr
439000020719     ?** GRABACION PANTALLA 02-----------------------------
439100020719     C                   exsr      grpd0b
439200020719     ?*- Analiza que debe hacer...
439300020719?1b? C                   select                                                 ?P----------01
439400020719?1x? C                   when      @@ma05 = '0'  or                             ?w----------01
439500020719     C                             @@ma05 = '1'  and                            ?            |
439600020719     C                             *in03  or                                    ?            |
439700020719     C                             @@ma05 = '2'  and                            ?            |
439800020719     C                             *in03                                        ?            |
439900020719     ?*- Actualizar marca de paso realizado...                                  ?            |
440000020719     C     k1@pc0        chain     p1wpc0                             20        ?            |
440100020719     C  n20              eval      w0wp01 = 1                                   ?            |
440200020719     C  n20              update    p1wpc0                                       ?            |
440300020719     ?*- Finaliza el programa...                                                ?            |
440400020719     C                   eval      @@mand = 'KA'                                ?            |
440500020719     C                   eval      *inkc = '1'                                  ?            |
440600020719     ?*- si por el contrario valida pasa a pantalla 03...                       ?            |
440700020719?1x? C                   when      @@ma05 = '1'  and                            ?w----------01
440800020719     C                             not *in03                                    ?            |
440900020719     C                   exsr      borr03                                       ?            |
441000020719     C                   eval      xxiden = 3                                   ?            |
441100020719     ?*- si por el contrario valida pasa a pantalla 05...                       ?            |
441200020719?1x? C                   when      @@ma05 = '2'  and                            ?w----------01
441300020719     C                             not *in03                                    ?            |
441400020719     C                   exsr      borr05                                       ?            |
441500020719     C                   exsr      carg05                                       ?            |
441600020719     C                   eval      xxiden = 5                                   ?            |
441700020719?1e? C                   endsl                                                  ?F----------01
441800020719     C                   endsr
441900000904     ?******************************************************
442000020719     C     grpd0b        begsr
442100020719     ?** GRABACION PANTALLA 02-----------------------------
442200020719?1b? C                   select                                                 ?P----------01
442300020719     ?*- primera entrada del programa...                                        ?            |
442400020719?1x? C                   when      w0wp01 = 0                                   ?w----------01
442500020719     C                   eval      z0arse = *zeros                              ?            |
442600020719     C     k1t621        chain     s1t621                             20        ?            |
442700020719?2b? C                   do        20            sf1rrn                         ?P---------02|
442800020719     C     sf1rrn        chain     par310s1                           20        ?           ||
442900020719?3b? C                   if        not *in20  and                               ?P--------03||
443000020719     C                             x2ncoc <> *zeros                             ?          |||
443100040416     ?* PAWPD0.                                                                 ?          |||
443200020719     C                   eval      z0empr = @@empr                              ?          |||
443300020719     C                   eval      z0sucu = @@sucu                              ?          |||
443400020719     C                   eval      z0arcd = @@arcd                              ?          |||
443500020719     C                   eval      z0spo1 = @@spo1                              ?          |||
443600020719     C                   eval      z0spol = @@spol                              ?          |||
443700020719     C                   eval      z0sspo = @@sspo                              ?          |||
443800020719     C                   eval      z0rama = t@rama                              ?          |||
443900020719     C                   add       1             z0arse                         ?          |||
444000040416     ?* PAWP310.                                                                ?          |||
444100040416     C                   eval      z0emprlk = z0empr                            ?          |||
444200040416     C                   eval      z0suculk = z0sucu                            ?          |||
444300040416     C                   eval      z0arcdlk = z0arcd                            ?          |||
444400040416     C                   eval      z0spo1lk = z0spo1                            ?          |||
444500040416     C                   eval      z0spollk = z0spol                            ?          |||
444600040416     C                   eval      z0sspolk = z0sspo                            ?          |||
444700040416     C                   eval      z0ramalk = z0rama                            ?          |||
444800040416     C                   eval      z0arselk = z0arse                            ?          |||
444900040416                                                                                ?          |||
445000020719     C                   exsr      busope                                       ?          |||
445100040416     ?* PAWPD0.                                                                 ?          |||
445200020719     C                   eval      z0oper = @@oper                              ?          |||
445300020719     C                   eval      z0suop = @@suop                              ?          |||
445400020719     C                   eval      z0tiou = w0tiou                              ?          |||
445500020719     C                   eval      z0stou = w0stou                              ?          |||
445600020719     C                   eval      z0stos = w0stos                              ?          |||
445700020719     C                   eval      z0wp01 = *zeros                              ?          |||
445800020719     C                   eval      z0wp02 = *zeros                              ?          |||
445900020719     C                   eval      z0wp03 = *zeros                              ?          |||
446000020719     C                   eval      z0wp04 = *zeros                              ?          |||
446100020719     C                   eval      z0wp05 = *zeros                              ?          |||
446200020719     C                   eval      z0wp06 = *zeros                              ?          |||
446300020719     C                   eval      z0wp07 = *zeros                              ?          |||
446400020719     C                   eval      z0wp08 = *zeros                              ?          |||
446500020719     C                   eval      z0wp09 = *zeros                              ?          |||
446600020719     C                   eval      z0wp10 = *zeros                              ?          |||
446700020719     C                   eval      z0wp11 = *zeros                              ?          |||
446800020719     C                   eval      z0wp12 = *zeros                              ?          |||
446900020719     C                   eval      z0wp13 = *zeros                              ?          |||
447000020719     C                   eval      z0wp14 = *zeros                              ?          |||
447100020719     C                   eval      z0wp15 = *zeros                              ?          |||
447200040416     C                   eval      z0user = vsuser                              ?          |||
447300040416     C                   time                    z0time                         ?          |||
447400040416     C                   eval      z0date = udate                               ?          |||
447500020719     C                   eval      z0ncoc = x2ncoc                              ?          |||
447600020719     C                   eval      z0ciap = x2ciap                              ?          |||
447700020719     C                   eval      z0part = x2part                              ?          |||
447800020719     C                   eval      z0cpar = x2cpar                              ?          |||
447900020719     C                   eval      z0copc = x2copc                              ?          |||
448000020719     C                   eval      z0copg = x2copg                              ?          |||
448100020719     C                   eval      z0gpil = x2gpil                              ?          |||
448200020719     C                   eval      z0marp = '0'                                 ?          |||
448300040416     ?* PAWP310.                                                                ?          |||
448400040416     C                   eval      z0operlk = z0oper                            ?          |||
448500040416     C                   eval      z0suoplk = z0suop                            ?          |||
448600040416     C                   eval      z0wp01lk = *zeros                            ?          |||
448700040416     C                   eval      z0wp02lk = *zeros                            ?          |||
448800040416     C                   eval      z0wp03lk = *zeros                            ?          |||
448900040416     C                   eval      z0wp04lk = *zeros                            ?          |||
449000040416     C                   eval      z0wp05lk = *zeros                            ?          |||
449100040416     C                   eval      z0wp06lk = *zeros                            ?          |||
449200040416     C                   eval      z0wp07lk = *zeros                            ?          |||
449300040416     C                   eval      z0wp08lk = *zeros                            ?          |||
449400040416     C                   eval      z0wp09lk = *zeros                            ?          |||
449500040416     C                   eval      z0wp10lk = *zeros                            ?          |||
449600040416     C                   eval      z0wp11lk = *zeros                            ?          |||
449700040416     C                   eval      z0wp12lk = *zeros                            ?          |||
449800040416     C                   eval      z0wp13lk = *zeros                            ?          |||
449900040416     C                   eval      z0wp14lk = *zeros                            ?          |||
450000040416     C                   eval      z0wp15lk = *zeros                            ?          |||
450100040416     C                   eval      z0userlk = vsuser                            ?          |||
450200040416     C                   time                    z0timelk                       ?          |||
450300040416     C                   eval      z0datelk = udate                             ?          |||
450400020719     C     k1@pd0        setll     p1wpd0                                 20    ?          |||
450500020719     C  n20              write     p1wpd0                                       ?          |||
450600040416     C     k1@pd0        setll     pawp310                                20    ?          |||
450700040416     C  n20              write     p1wp310                                      ?          |||
450800020719?3e? C                   endif                                                  ?F--------03||
450900020719?2e? C                   enddo                                                  ?F---------02|
451000020719     ?*- segunda entrada del programa...                                        ?            |
451100020719?1x? C                   when      w0wp01 = 1                                   ?w----------01
451200020719     C                   setoff                                           98    ?            |
451300020719     C                   eval      sf1rrn = *zeros                              ?            |
451400020719     C     k2@pd0        setll     p1wpd0                                       ?            |
451500020719?2b? C                   dou       *in98                                        ?P---------02|
451600020719     C     k2@pd0        reade     p1wpd0                                 98    ?           ||
451700020719?3b? C                   if        not *in98                                    ?P--------03||
451800020719     C                   add       1             sf1rrn                         ?          |||
451900020719     C     sf1rrn        chain     par310s1                           20        ?          |||
452000020719?4b? C                   if        not *in20                                    ?P-------04|||
452100020719     C                   eval      z0ncoc = x2ncoc                              ?         ||||
452200020719     C                   eval      z0ciap = x2ciap                              ?         ||||
452300020719     C                   eval      z0part = x2part                              ?         ||||
452400020719     C                   eval      z0cpar = x2cpar                              ?         ||||
452500020719     C                   eval      z0copc = x2copc                              ?         ||||
452600020719     C                   eval      z0copg = x2copg                              ?         ||||
452700020719     C                   eval      z0gpil = x2gpil                              ?         ||||
452800020719     C                   update    p1wpd0                                       ?         ||||
452900020719?4e? C                   endif                                                  ?F-------04|||
453000020719?3e? C                   endif                                                  ?F--------03||
453100020719?2e? C                   enddo                                                  ?F---------02|
453200020719?1e? C                   endsl                                                  ?F----------01
453300020719     C                   endsr
453400000904     ?******************************************************
453500020719     C     borr03        begsr
453600020719     ?** BORRADO DE PANTALLA 03----------------------------
453700020719     C                   clear                   x3nivt
453800020719     C                   clear                   x3nivc
453900020719     C                   clear                   x3nomb
454000020719     C                   setoff                                           90
454100020719     C                   endsr
454200000904     ?******************************************************
454300020719     C     pant03        begsr
454400020719     ?** PROCESO DE PANTALLA 03----------------------------
454500020719     C                   exfmt     par31003
454600020719     ?* apagar indicadores de error...
454700020719     C                   exsr      apagar
454800020719     ?* procesar teclas de funcion...
454900020719?1b? C                   select                                                 ?P----------01
455000020719     ?*- F3=SALIR...                                                            ?            |
455100020719?1x? C                   when      *inkc                                        ?w----------01
455200020719     C                   eval      xxiden = 3                                   ?            |
455300020719     ?*- F4=SOLICITUD...                                                        ?            |
455400020719?1x? C                   when      *inkd                                        ?w----------01
455500020719     C                   exsr      soli03                                       ?            |
455600020719     ?*- F12=RETORNAR...                                                        ?            |
455700020719?1x? C                   when      *inkl                                        ?w----------01
455800020719     C                   eval      xxiden = 1                                   ?            |
455900020719     ?*- AYUDA...                                                               ?            |
456000020719?1x? C                   when      *in80                                        ?w----------01
456100020719     ?*- PULSA INTRO...                                                         ?            |
456200020719?1x? C                   when      not *in29                                    ?w----------01
456300020719     C                   exsr      vali03                                       ?            |
456400020719?1e? C                   endsl                                                  ?F----------01
456500020719     C                   endsr
456600000904     ?******************************************************
456700020719     C     soli03        begsr
456800020719     ?** SOLICITUD EN PANTALLA 03--------------------------
456900020719     ?*- TIPO DE NIVEL DE INTERMEDIACION...
457000020719?1b? C                   if        @@camp = 'X3NIVT'                            ?P----------01
457100020719     C                   call      'PAR300'                                     ?            |
457200020719     C                   parm                    x3nivt                         ?            |
457300020719?1e? C                   endif                                                  ?F----------01
457400020719     ?*- CODIGO DE NIVEL DE INTERMEDIACION...
457500020719?1b? C                   if        @@camp = 'X3NIVC'                            ?P----------01
457600020719     C                   call      'PAR301A2'                                   ?            |
457700020719     C                   parm      '1'           @@reto                         ?            |
457800020719     C                   parm                    x3nivt                         ?            |
457900020719     C                   parm                    x3nivc                         ?            |
458000020719?2b? C                   if        x3nivt <> *zeros  and                        ?P---------02|
458100020719     C                             x3nivc <> *zeros                             ?           ||
458200020719     C     k3@ni2        chain     s1hni201                           20        ?           ||
458300020719     C  n20              eval      x3nomb = dfnomb                              ?           ||
458400020719?2e? C                   endif                                                  ?F---------02|
458500020719?1e? C                   endif                                                  ?F----------01
458600020719     C                   endsr
458700000904     ?******************************************************
458800020719     C     vali03        begsr
458900020719     ?** VALIDACION PANTALLA 03----------------------------
459000020719     ?*- EL INTERMEDIARIO DEBE EXISTIR...
459100020719     C                   eval      x3nomb = *blanks
459200020719     C     k3@ni2        chain     s1hni201                           20
459300020719     C  n20              eval      x3nomb = dfnomb
459400020719     C   20              z-add     51            @e                   50
459500020719     ?*- EL INTERMEDIARIO DEBE SER EL DE MAYOR NIVEL...
459600020719?1b? C                   if        not *in50                                    ?P----------01
459700020719     C     k1@ec1        chain(n)  p1hec1                             20        ?            |
459800020719?2b? C                   if        not *in20                                    ?P---------02|
459900020719?3b? C                   select                                                 ?P--------03||
460000020719?3x? C                   when      c1niv9 <> *zeros                             ?w--------03||
460100020719     C                   eval      @1nivt = 9                                   ?          |||
460200020719     C                   eval      @1nivc = c1niv9                              ?          |||
460300020719?3x? C                   when      c1niv8 <> *zeros                             ?w--------03||
460400020719     C                   eval      @1nivt = 8                                   ?          |||
460500020719     C                   eval      @1nivc = c1niv8                              ?          |||
460600020719?3x? C                   when      c1niv7 <> *zeros                             ?w--------03||
460700020719     C                   eval      @1nivt = 7                                   ?          |||
460800020719     C                   eval      @1nivc = c1niv7                              ?          |||
460900020719?3x? C                   when      c1niv6 <> *zeros                             ?w--------03||
461000020719     C                   eval      @1nivt = 6                                   ?          |||
461100020719     C                   eval      @1nivc = c1niv6                              ?          |||
461200020719?3x? C                   when      c1niv5 <> *zeros                             ?w--------03||
461300020719     C                   eval      @1nivt = 5                                   ?          |||
461400020719     C                   eval      @1nivc = c1niv5                              ?          |||
461500020719?3x? C                   when      c1niv4 <> *zeros                             ?w--------03||
461600020719     C                   eval      @1nivt = 4                                   ?          |||
461700020719     C                   eval      @1nivc = c1niv4                              ?          |||
461800020719?3x? C                   when      c1niv3 <> *zeros                             ?w--------03||
461900020719     C                   eval      @1nivt = 3                                   ?          |||
462000020719     C                   eval      @1nivc = c1niv3                              ?          |||
462100020719?3x? C                   when      c1niv2 <> *zeros                             ?w--------03||
462200020719     C                   eval      @1nivt = 2                                   ?          |||
462300020719     C                   eval      @1nivc = c1niv2                              ?          |||
462400020719?3x? C                   when      c1niv1 <> *zeros                             ?w--------03||
462500020719     C                   eval      @1nivt = 1                                   ?          |||
462600020719     C                   eval      @1nivc = c1niv1                              ?          |||
462700020719?3e? C                   endsl                                                  ?F--------03||
462800020719     ?*- COMPARAR...                                                            ?           ||
462900020719?3b? C                   if        x3nivt = @1nivt  and                         ?P--------03||
463000020719     C                             x3nivc = @1nivc                              ?          |||
463100020719?3x? C                   else                                                   ?X........03||
463200020719     C                   z-add     52            @e                   50        ?          |||
463300020719?3e? C                   endif                                                  ?F--------03||
463400020719?2e? C                   endif                                                  ?F---------02|
463500020719?1e? C                   endif                                                  ?F----------01
463600020719     ?*- SI NO EXISTEN ERRORES AVANZAR...
463700020719?1b? C                   if        not *in50                                    ?P----------01
463800020719?2b? C                   if        x3nivt = $3nivt  and                         ?P---------02|
463900020719     C                             x3nivc = $3nivc  and                         ?           ||
464000020719     C                             *in90                                        ?           ||
464100020719     C                   exsr      grab03                                       ?           ||
464200020719?2x? C                   else                                                   ?X.........02|
464300020719     C                   eval      $3nivt = x3nivt                              ?           ||
464400020719     C                   eval      $3nivc = x3nivc                              ?           ||
464500020719     C                   seton                                        90        ?           ||
464600020719?2e? C                   endif                                                  ?F---------02|
464700020719?1e? C                   endif                                                  ?F----------01
464800020719     ?*- SI EXISTEN ERRORES...
464900020719?1b? C                   if        *in50  and                                   ?P----------01
465000020719     C                             @e <> *zeros                                 ?            |
465100020719     C                   write     par31003                                     ?            |
465200020719     C                   eval      *in(@e) = '1'                                ?            |
465300020719?1e? C                   endif                                                  ?F----------01
465400020719     C                   endsr
465500000904     ?******************************************************
465600020719     C     grab03        begsr
465700020719     ?** GRABACION DE PANTALLA 03--------------------------
465800020719     ?*- Si permite modificar la cadena sigue la joda...
465900020719?1b? C                   if        @@ma05 = '2'                                 ?P----------01
466000020719     C                   exsr      borr05                                       ?            |
466100020719     C                   exsr      carg05                                       ?            |
466200020719     C                   eval      xxiden = 5                                   ?            |
466300020719     ?*- dejar mandato de programa finalizado...                                ?            |
466400020719?1x? C                   else                                                   ?X..........01
466500020719     ?*- Actualizar marca de paso realizado...                                  ?            |
466600020719     C     k1@pc0        chain     p1wpc0                             20        ?            |
466700020719     C  n20              eval      w0wp01 = 1                                   ?            |
466800020719     C  n20              update    p1wpc0                                       ?            |
466900020719     ?*- Finaliza el programa...                                                ?            |
467000020719     C                   eval      @@mand = 'KA'                                ?            |
467100020719     C                   eval      *inkc = '1'                                  ?            |
467200020719?1e? C                   endif                                                  ?F----------01
467300020719     C                   endsr
467400000904     ?******************************************************
467500020719     C     pant04        begsr
467600020719     ?** PROCESO DE PANTALLA 04----------------------------
467700020719     C                   exfmt     par310c2
467800020719     ?*- CORRIGE SITUACIONES DE ERROR ...
467900020719     C                   exsr      apagar
468000020719     ?*- PROCESA TECLAS DE FUNCION...
468100020719?1b? C                   select                                                 ?P----------01
468200020719     ?*- F3=SALIR...                                                            ?            |
468300020719?1x? C                   when      *inkc                                        ?w----------01
468400020719     C                   eval      xxiden = 1                                   ?            |
468500020719     ?*- F4=SOLICITUD...                                                        ?            |
468600020719?1x? C                   when      *inkd                                        ?w----------01
468700020719     C                   exsr      soli04                                       ?            |
468800020719     ?*- F12=RETORNAR...                                                        ?            |
468900020719?1x? C                   when      *inkl                                        ?w----------01
469000020719     C                   eval      xxiden = 1                                   ?            |
469100020719     ?*- PULSA INTRO...                                                         ?            |
469200020719?1x? C                   when      not *in29                                    ?w----------01
469300020719?2b? C                   if        xxasen <> *zeros                             ?P---------02|
469400020719     C                   exsr      vali04                                       ?           ||
469500020719?2x? C                   else                                                   ?X.........02|
469600020719?3b? C                   if        *in30                                        ?P--------03||
469700020719     C                   exsr      opci04                                       ?          |||
469800020719?3e? C                   endif                                                  ?F--------03||
469900020719?2e? C                   endif                                                  ?F---------02|
470000020719?1e? C                   endsl                                                  ?F----------01
470100020719     C                   endsr
470200000904     ?******************************************************
470300020719     C     soli04        begsr
470400020719     ?** SOLICITUD PANTALLA 02-----------------------------
470500020719     ?*- ASEGURADO...
470600020719?1b? C                   if        @@camp = 'XXASEN'                            ?P----------01
470700020719     C                   call      'PRO030R'                                    ?            |
470800020719     C                   parm                    xxasen                         ?            |
470900020719     C                   parm      'RT'          @@@end                         ?            |
471000020719?2b? C                   if        xxasen <> *zeros                             ?P---------02|
471100020719     C     xxasen        chain     g1hdaf                             20        ?           ||
471200020719     C   20              eval      xxnomb = *blanks                             ?           ||
471300020719     C  n20              eval      xxnomb = dfnomb                              ?           ||
471400020719?2e? C                   endif                                                  ?F---------02|
471500020719?1e? C                   endif                                                  ?F----------01
471600020719     C                   endsr
471700000904     ?******************************************************
471800020719     C     vali04        begsr
471900020719     ?** VALIDACION PANTALLA 04----------------------------
472000020719     ?*- ASEGURADO...
472100020719     C     xxasen        chain     s1hase01                           20
472200020719     C  n20              eval      xxnomb = dfnomb
472300020719     C   20              eval      xxnomb = *blanks
472400020719     C   20              z-add     51            @e                   50
472500020719     ?*- NO DEBE REPETIR ASEGURADO PRINCIPAL...
472600020719?1b? C                   if        not *in50  and                               ?P----------01
472700020719     C                             xxasen = x1asen                              ?            |
472800020719     C                   z-add     53            @e                   50        ?            |
472900020719?1e? C                   endif                                                  ?F----------01
473000020719     ?*- YA EXISTE REGISTRO...
473100020719?1b? C                   if        not *in50  and                               ?P----------01
473200020719     C                             *in30                                        ?            |
473300020719?2b? C                   do        20            sf2rrn                         ?P---------02|
473400020719     C     sf2rrn        chain     par310s2                           20        ?           ||
473500020719?3b? C                   if        not *in20                                    ?P--------03||
473600020719?4b? C                   if        xxasen = x5asen                              ?P-------04|||
473700020719     C                   z-add     52            @e                   50        ?         ||||
473800020719?2v? C                   leave                                                  ?         ||||
473900020719?4e? C                   endif                                                  ?F-------04|||
474000020719?3x? C                   else                                                   ?X........03||
474100020719?2v? C                   leave                                                  ?          |||
474200020719?3e? C                   endif                                                  ?F--------03||
474300020719?2e? C                   enddo                                                  ?F---------02|
474400020719?1e? C                   endif                                                  ?F----------01
474500020719     ?** SI NO EXISTEN ERRORES AVANZA...
474600020719?1b? C                   if        not *in50                                    ?P----------01
474700020719?2b? C                   if        xxasen = $5asen                              ?P---------02|
474800020719     C                   exsr      grab04                                       ?           ||
474900020719     C                   clear                   xxasen                         ?           ||
475000020719     C                   clear                   xxnomb                         ?           ||
475100020719     C                   setoff                                           90    ?           ||
475200020719?2x? C                   else                                                   ?X.........02|
475300020719     C                   eval      $5asen = xxasen                              ?           ||
475400020719     C                   seton                                            90    ?           ||
475500020719?2e? C                   endif                                                  ?F---------02|
475600020719?1e? C                   endif                                                  ?F----------01
475700020719     ?*- SI EXISTEN ERRORES...
475800020719?1b? C                   if        *in50  and                                   ?P----------01
475900020719     C                             @e <> *zeros                                 ?            |
476000020719     C                   setoff                                           90    ?            |
476100020719     C                   write     par310c2                                     ?            |
476200020719     C                   eval      *in(@e) = '1'                                ?            |
476300020719?1e? C                   endif                                                  ?F----------01
476400020719     C                   endsr
476500000904     ?******************************************************
476600020719     C     grab04        begsr
476700020719     ?** CARGAR EL ALTA EN EL SUBARCHIVO-------------------
476800020719     ?* subarchivo activo...
476900020719?1b? C                   if        *in30                                        ?P----------01
477000020719?2b? C                   do        20            sf2rrn                         ?P---------02|
477100020719     C     sf2rrn        chain     par310s2                           20        ?           ||
477200020719?3b? C                   if        *in20                                        ?P--------03||
477300020719     C                   clear                   x5opci                         ?          |||
477400020719     C                   eval      x5asen = xxasen                              ?          |||
477500020719     C                   eval      x5nomb = xxnomb                              ?          |||
477600020719     C                   write     par310s2                                     ?          |||
477700020719?2v? C                   leave                                                  ?          |||
477800020719?3e? C                   endif                                                  ?F--------03||
477900020719?2e? C                   enddo                                                  ?F---------02|
478000020719     ?* subarchivo inactivo...                                                  ?            |
478100020719?1x? C                   else                                                   ?X..........01
478200020719     C                   clear                   x5opci                         ?            |
478300020719     C                   eval      x5asen = xxasen                              ?            |
478400020719     C                   eval      x5nomb = xxnomb                              ?            |
478500020719     C                   eval      sf2rrn = 1                                   ?            |
478600020719     C                   write     par310s2                                     ?            |
478700020719     C                   seton                                        30        ?            |
478800020719?1e? C                   endif                                                  ?F----------01
478900020719     C                   endsr
479000000904     ?******************************************************
479100020719     C     opci04        begsr
479200020719     ?** BAJAS DEL SUBARCHIVO------------------------------
479300020719     C                   eval      ase = *blanks
479400020719     C                   eval      @w = *zeros
479500020719?1b? C                   do        20            sf2rrn                         ?P----------01
479600020719     C     sf2rrn        chain     par310s2                           20        ?            |
479700020719?2b? C                   if        not *in20  and                               ?P---------02|
479800020719     C                             x5opci <> '4'                                ?           ||
479900020719     C                   add       1             @w                             ?           ||
480000020719     C                   movel     x5asen        ase(@w)                        ?           ||
480100020719     C                   move      x5nomb        ase(@w)                        ?           ||
480200020719?2e? C                   endif                                                  ?F---------02|
480300020719?1e? C                   enddo                                                  ?F----------01
480400020719     ?* borro el subarchivo...
480500020719     C                   exsr      sf3bor
480600020719     ?* cargo el subarchivo...
480700020719?1b? C                   do        20            @w                             ?P----------01
480800020719?2b? C                   if        ase(@w) <> *blanks                           ?P---------02|
480900020719     C                   movel     ase(@w)       x5asen                         ?           ||
481000020719     C                   move      ase(@w)       x5nomb                         ?           ||
481100020719     C                   clear                   x5opci                         ?           ||
481200020719     C                   eval      sf2rrn = @w                                  ?           ||
481300020719     C                   seton                                            30    ?           ||
481400020719     C                   write     par310s2                                     ?           ||
481500020719?2e? C                   endif                                                  ?F---------02|
481600020719?1e? C                   enddo                                                  ?F----------01
481700020719     C                   endsr
481800000904     ?******************************************************
481900020719     C     pant05        begsr
482000020719     ?** PROCESO DE PANTALLA 02----------------------------
482100020719     C                   exfmt     par31005
482200020719     ?*- CORRIGE SITUACIONES DE ERROR ...
482300020719     C                   exsr      apagar
482400020719     ?*- PROCESA TECLAS DE FUNCION...
482500020719?1b? C                   select                                                 ?P----------01
482600020719     ?*- F3=SALIR...                                                            ?            |
482700020719?1x? C                   when      *inkc                                        ?w----------01
482800020719     C                   eval      xxiden = 1                                   ?            |
482900020719     ?*- F4=SOLICITUD...                                                        ?            |
483000020719?1x? C                   when      *inkd                                        ?w----------01
483100020719     C                   exsr      soli05                                       ?            |
483200020719     ?*- F12=RETORNAR...                                                        ?            |
483300020719?1x? C                   when      *inkl                                        ?w----------01
483400020719     C                   eval      xxiden = 1                                   ?            |
483500020719     ?*- PULSA INTRO...                                                         ?            |
483600020719?1x? C                   when      not *in29                                    ?w----------01
483700020719     C                   exsr      vali05                                       ?            |
483800020719?1e? C                   endsl                                                  ?F----------01
483900020719     C                   endsr
484000000904     ?******************************************************
484100020719     C     soli05        begsr
484200020719     ?** SOLICITUD PANTALLA 02-----------------------------
484300020719     ?*- NIVEL 1...
484400020719?1b? C                   if        @@camp = 'X5NIV1'  or                        ?P----------01
484500020719     C                             @@camp = 'X5NIV2'  or                        ?            |
484600020719     C                             @@camp = 'X5NIV3'  or                        ?            |
484700020719     C                             @@camp = 'X5NIV4'  or                        ?            |
484800020719     C                             @@camp = 'X5NIV5'  or                        ?            |
484900020719     C                             @@camp = 'X5NIV6'  or                        ?            |
485000020719     C                             @@camp = 'X5NIV7'  or                        ?            |
485100020719     C                             @@camp = 'X5NIV8'  or                        ?            |
485200020719     C                             @@camp = 'X5NIV9'                            ?            |
485300020719     C                   call      'PAR3011'                                    ?            |
485400020719     C                   parm      *zeros        @@niv1                         ?            |
485500020719     C                   parm      *zeros        @@nic1                         ?            |
485600020719     C                   parm      *blanks       @@nom1                         ?            |
485700020719     C                   parm      *blanks       endpgm                         ?            |
485800020719     ?*- VERIFICA NIVEL RECUPERADO...                                           ?            |
485900020719?2b? C                   select                                                 ?P---------02|
486000020719?2x? C                   when      @@niv1 = 1                                   ?w---------02|
486100020719     C                   eval      x5niv1 = @@nic1                              ?           ||
486200020719     C                   eval      x5nom1 = @@nom1                              ?           ||
486300020719?2x? C                   when      @@niv1 = 2                                   ?w---------02|
486400020719     C                   eval      x5niv2 = @@nic1                              ?           ||
486500020719     C                   eval      x5nom2 = @@nom1                              ?           ||
486600020719?2x? C                   when      @@niv1 = 3                                   ?w---------02|
486700020719     C                   eval      x5niv3 = @@nic1                              ?           ||
486800020719     C                   eval      x5nom3 = @@nom1                              ?           ||
486900020719?2x? C                   when      @@niv1 = 4                                   ?w---------02|
487000020719     C                   eval      x5niv4 = @@nic1                              ?           ||
487100020719     C                   eval      x5nom4 = @@nom1                              ?           ||
487200020719?2x? C                   when      @@niv1 = 5                                   ?w---------02|
487300020719     C                   eval      x5niv5 = @@nic1                              ?           ||
487400020719     C                   eval      x5nom5 = @@nom1                              ?           ||
487500020719?2x? C                   when      @@niv1 = 6                                   ?w---------02|
487600020719     C                   eval      x5niv6 = @@nic1                              ?           ||
487700020719     C                   eval      x5nom6 = @@nom1                              ?           ||
487800020719?2x? C                   when      @@niv1 = 7                                   ?w---------02|
487900020719     C                   eval      x5niv7 = @@nic1                              ?           ||
488000020719     C                   eval      x5nom7 = @@nom1                              ?           ||
488100020719?2x? C                   when      @@niv1 = 8                                   ?w---------02|
488200020719     C                   eval      x5niv8 = @@nic1                              ?           ||
488300020719     C                   eval      x5nom8 = @@nom1                              ?           ||
488400020719?2x? C                   when      @@niv1 = 9                                   ?w---------02|
488500020719     C                   eval      x5niv9 = @@nic1                              ?           ||
488600020719     C                   eval      x5nom9 = @@nom1                              ?           ||
488700020719?2e? C                   endsl                                                  ?F---------02|
488800020719?1e? C                   endif                                                  ?F----------01
488900020719     C                   endsr
489000000904     ?******************************************************
489100020719     C     vali05        begsr
489200020719     ?** VALIDACION PANTALLA 05. --------------------------
489300020719     ?** NUMERO DE INTERMEDIARIO 1...
489400020719?1b? C                   if        not *in50                                    ?P----------01
489500020719?2b? C                   if        x5niv1 <> *zeros                             ?P---------02|
489600020719     C                   eval      @@niv1 = 1                                   ?           ||
489700020719     C                   eval      @@nic1 = x5niv1                              ?           ||
489800020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
489900020719     C  n20              eval      x5nom1 = dfnomb                              ?           ||
490000020719     C   20              eval      x5nom1 = *blanks                             ?           ||
490100020719     C   20              z-add     51            @e                   50        ?           ||
490200020719?2x? C                   else                                                   ?X.........02|
490300020719     C                   eval      x5nom9 = *blanks                             ?           ||
490400020719?2e? C                   endif                                                  ?F---------02|
490500020719?1e? C                   endif                                                  ?F----------01
490600020719     ?** NUMERO DE INTERMEDIARIO 2...
490700020719?1b? C                   if        not *in50                                    ?P----------01
490800020719?2b? C                   if        x5niv2 <> *zeros                             ?P---------02|
490900020719     C                   eval      @@niv1 = 2                                   ?           ||
491000020719     C                   eval      @@nic1 = x5niv2                              ?           ||
491100020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
491200020719     C  n20              eval      x5nom2 = dfnomb                              ?           ||
491300020719     C   20              eval      x5nom2 = *blanks                             ?           ||
491400020719     C   20              z-add     52            @e                   50        ?           ||
491500020719?2x? C                   else                                                   ?X.........02|
491600020719     C                   eval      x5nom9 = *blanks                             ?           ||
491700020719?2e? C                   endif                                                  ?F---------02|
491800020719?1e? C                   endif                                                  ?F----------01
491900020719     ?** NUMERO DE INTERMEDIARIO 3...
492000020719?1b? C                   if        not *in50                                    ?P----------01
492100020719?2b? C                   if        x5niv3 <> *zeros                             ?P---------02|
492200020719     C                   eval      @@niv1 = 3                                   ?           ||
492300020719     C                   eval      @@nic1 = x5niv3                              ?           ||
492400020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
492500020719     C  n20              eval      x5nom3 = dfnomb                              ?           ||
492600020719     C   20              eval      x5nom3 = *blanks                             ?           ||
492700020719     C   20              z-add     53            @e                   50        ?           ||
492800020719?2x? C                   else                                                   ?X.........02|
492900020719     C                   eval      x5nom9 = *blanks                             ?           ||
493000020719?2e? C                   endif                                                  ?F---------02|
493100020719?1e? C                   endif                                                  ?F----------01
493200020719     ?** NUMERO DE INTERMEDIARIO 4...
493300020719?1b? C                   if        not *in50                                    ?P----------01
493400020719?2b? C                   if        x5niv4 <> *zeros                             ?P---------02|
493500020719     C                   eval      @@niv1 = 4                                   ?           ||
493600020719     C                   eval      @@nic1 = x5niv4                              ?           ||
493700020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
493800020719     C  n20              eval      x5nom4 = dfnomb                              ?           ||
493900020719     C   20              eval      x5nom4 = *blanks                             ?           ||
494000020719     C   20              z-add     54            @e                   50        ?           ||
494100020719?2x? C                   else                                                   ?X.........02|
494200020719     C                   eval      x5nom9 = *blanks                             ?           ||
494300020719?2e? C                   endif                                                  ?F---------02|
494400020719?1e? C                   endif                                                  ?F----------01
494500020719     ?** NUMERO DE INTERMEDIARIO 5...
494600020719?1b? C                   if        not *in50                                    ?P----------01
494700020719?2b? C                   if        x5niv5 <> *zeros                             ?P---------02|
494800020719     C                   eval      @@niv1 = 5                                   ?           ||
494900020719     C                   eval      @@nic1 = x5niv5                              ?           ||
495000020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
495100020719     C  n20              eval      x5nom5 = dfnomb                              ?           ||
495200020719     C   20              eval      x5nom5 = *blanks                             ?           ||
495300020719     C   20              z-add     55            @e                   50        ?           ||
495400020719?2x? C                   else                                                   ?X.........02|
495500020719     C                   eval      x5nom9 = *blanks                             ?           ||
495600020719?2e? C                   endif                                                  ?F---------02|
495700020719?1e? C                   endif                                                  ?F----------01
495800020719     ?** NUMERO DE INTERMEDIARIO 6...
495900020719?1b? C                   if        not *in50                                    ?P----------01
496000020719?2b? C                   if        x5niv6 <> *zeros                             ?P---------02|
496100020719     C                   eval      @@niv1 = 6                                   ?           ||
496200020719     C                   eval      @@nic1 = x5niv6                              ?           ||
496300020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
496400020719     C  n20              eval      x5nom6 = dfnomb                              ?           ||
496500020719     C   20              eval      x5nom6 = *blanks                             ?           ||
496600020719     C   20              z-add     56            @e                   50        ?           ||
496700020719?2x? C                   else                                                   ?X.........02|
496800020719     C                   eval      x5nom9 = *blanks                             ?           ||
496900020719?2e? C                   endif                                                  ?F---------02|
497000020719?1e? C                   endif                                                  ?F----------01
497100020719     ?** NUMERO DE INTERMEDIARIO 7...
497200020719?1b? C                   if        not *in50                                    ?P----------01
497300020719?2b? C                   if        x5niv7 <> *zeros                             ?P---------02|
497400020719     C                   eval      @@niv1 = 7                                   ?           ||
497500020719     C                   eval      @@nic1 = x5niv7                              ?           ||
497600020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
497700020719     C  n20              eval      x5nom7 = dfnomb                              ?           ||
497800020719     C   20              eval      x5nom7 = *blanks                             ?           ||
497900020719     C   20              z-add     57            @e                   50        ?           ||
498000020719?2x? C                   else                                                   ?X.........02|
498100020719     C                   eval      x5nom9 = *blanks                             ?           ||
498200020719?2e? C                   endif                                                  ?F---------02|
498300020719?1e? C                   endif                                                  ?F----------01
498400020719     ?** NUMERO DE INTERMEDIARIO 8...
498500020719?1b? C                   if        not *in50                                    ?P----------01
498600020719?2b? C                   if        x5niv8 <> *zeros                             ?P---------02|
498700020719     C                   eval      @@niv1 = 8                                   ?           ||
498800020719     C                   eval      @@nic1 = x5niv8                              ?           ||
498900020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
499000020719     C  n20              eval      x5nom8 = dfnomb                              ?           ||
499100020719     C   20              eval      x5nom8 = *blanks                             ?           ||
499200020719     C   20              z-add     58            @e                   50        ?           ||
499300020719?2x? C                   else                                                   ?X.........02|
499400020719     C                   eval      x5nom9 = *blanks                             ?           ||
499500020719?2e? C                   endif                                                  ?F---------02|
499600020719?1e? C                   endif                                                  ?F----------01
499700020719     ?** NUMERO DE INTERMEDIARIO 9...
499800020719?1b? C                   if        not *in50                                    ?P----------01
499900020719?2b? C                   if        x5niv9 <> *zeros                             ?P---------02|
500000020719     C                   eval      @@niv1 = 9                                   ?           ||
500100020719     C                   eval      @@nic1 = x5niv9                              ?           ||
500200020719     C     k5@ni2        chain     s1hni201                           20        ?           ||
500300020719     C  n20              eval      x5nom9 = dfnomb                              ?           ||
500400020719     C   20              eval      x5nom9 = *blanks                             ?           ||
500500020719     C   20              z-add     59            @e                   50        ?           ||
500600020719?2x? C                   else                                                   ?X.........02|
500700020719     C                   eval      x5nom9 = *blanks                             ?           ||
500800020719?2e? C                   endif                                                  ?F---------02|
500900020719?1e? C                   endif                                                  ?F----------01
501000020719     ?** SI NO EXISTEN ERRORES AVANZA...
501100020719?1b? C                   if        not *in50                                    ?P----------01
501200020719?2b? C                   if        x5niv1 = $5niv1  and                         ?P---------02|
501300020719     C                             x5niv2 = $5niv2  and                         ?           ||
501400020719     C                             x5niv3 = $5niv3  and                         ?           ||
501500020719     C                             x5niv4 = $5niv4  and                         ?           ||
501600020719     C                             x5niv5 = $5niv5  and                         ?           ||
501700020719     C                             x5niv6 = $5niv6  and                         ?           ||
501800020719     C                             x5niv7 = $5niv7  and                         ?           ||
501900020719     C                             x5niv8 = $5niv8  and                         ?           ||
502000020719     C                             x5niv9 = $5niv9                              ?           ||
502100020719     C                   exsr      grab05                                       ?           ||
502200020719     C                   setoff                                           90    ?           ||
502300020719?2x? C                   else                                                   ?X.........02|
502400020719     C                   eval      $5niv1 = x5niv1                              ?           ||
502500020719     C                   eval      $5niv2 = x5niv2                              ?           ||
502600020719     C                   eval      $5niv3 = x5niv3                              ?           ||
502700020719     C                   eval      $5niv4 = x5niv4                              ?           ||
502800020719     C                   eval      $5niv5 = x5niv5                              ?           ||
502900020719     C                   eval      $5niv6 = x5niv6                              ?           ||
503000020719     C                   eval      $5niv7 = x5niv7                              ?           ||
503100020719     C                   eval      $5niv8 = x5niv8                              ?           ||
503200020719     C                   eval      $5niv9 = x5niv9                              ?           ||
503300020719     C                   seton                                            90    ?           ||
503400020719?2e? C                   endif                                                  ?F---------02|
503500020719?1e? C                   endif                                                  ?F----------01
503600020719     ?*- SI EXISTEN ERRORES...
503700020719?1b? C                   if        *in50                                        ?P----------01
503800020719     C                   setoff                                           90    ?            |
503900020719     C                   eval      *in(@e) = '1'                                ?            |
504000020719?1e? C                   endif                                                  ?F----------01
504100020719     C                   endsr
504200000904     ?******************************************************
504300020719     C     borr05        begsr
504400020719     ?** BORRAR DATOS PANTALLA 05--------------------------
504500020719     C                   clear                   par31005
504600020719     C                   endsr
504700000904     ?******************************************************
504800020719     C     carg05        begsr
504900020719     ?** CARGA LOS DATOS A LA PANTALLA 05. ----------------
505000020719     ?*- RECUPERA DATOS DEL SUPLEMENTO...
505100020719     C     k1@ec1        chain(n)  p1hec1                             20
505200020719     ?*- MUEVE LOS DATOS DEL INTERMEDIARIO QUE EMITE...
505300020719     C                   eval      x5nivt = c1nivt
505400020719     C                   eval      x5nivc = c1nivc
505500020719     C                   eval      x5niv1 = c1niv1
505600020719     C                   eval      x5niv2 = c1niv2
505700020719     C                   eval      x5niv3 = c1niv3
505800020719     C                   eval      x5niv4 = c1niv4
505900020719     C                   eval      x5niv5 = c1niv5
506000020719     C                   eval      x5niv6 = c1niv6
506100020719     C                   eval      x5niv7 = c1niv7
506200020719     C                   eval      x5niv8 = c1niv8
506300020719     C                   eval      x5niv9 = c1niv9
506400020719     ?*- RECUPERA NOMBRE DE PRODUCTOR QUE EMITE...
506500020719     C                   eval      @@niv1 = c1nivt
506600020719     C                   eval      @@nic1 = c1nivc
506700020719     C     k5@ni2        chain     s1hni201                           20
506800020719     C  n20              eval      x5nomb = dfnomb
506900020719     C   20              eval      x5nomb = *blanks
507000020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 1...
507100020719?1b? C                   if        x5niv1 <> *zeros                             ?P----------01
507200020719     C                   eval      @@niv1 = 1                                   ?            |
507300020719     C                   eval      @@nic1 = x5niv1                              ?            |
507400020719     C     k5@ni2        chain     s1hni201                           20        ?            |
507500020719     C  n20              eval      x5nom1 = dfnomb                              ?            |
507600020719     C   20              eval      x5nom1 = *blanks                             ?            |
507700020719?1e? C                   endif                                                  ?F----------01
507800020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 2...
507900020719?1b? C                   if        x5niv2 <> *zeros                             ?P----------01
508000020719     C                   eval      @@niv1 = 2                                   ?            |
508100020719     C                   eval      @@nic1 = x5niv2                              ?            |
508200020719     C     k5@ni2        chain     s1hni201                           20        ?            |
508300020719     C  n20              eval      x5nom2 = dfnomb                              ?            |
508400020719     C   20              eval      x5nom2 = *blanks                             ?            |
508500020719?1e? C                   endif                                                  ?F----------01
508600020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 3...
508700020719?1b? C                   if        x5niv3 <> *zeros                             ?P----------01
508800020719     C                   eval      @@niv1 = 3                                   ?            |
508900020719     C                   eval      @@nic1 = x5niv3                              ?            |
509000020719     C     k5@ni2        chain     s1hni201                           20        ?            |
509100020719     C  n20              eval      x5nom3 = dfnomb                              ?            |
509200020719     C   20              eval      x5nom3 = *blanks                             ?            |
509300020719?1e? C                   endif                                                  ?F----------01
509400020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 4...
509500020719?1b? C                   if        x5niv4 <> *zeros                             ?P----------01
509600020719     C                   eval      @@niv1 = 4                                   ?            |
509700020719     C                   eval      @@nic1 = x5niv4                              ?            |
509800020719     C     k5@ni2        chain     s1hni201                           20        ?            |
509900020719     C  n20              eval      x5nom4 = dfnomb                              ?            |
510000020719     C   20              eval      x5nom4 = *blanks                             ?            |
510100020719?1e? C                   endif                                                  ?F----------01
510200020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 5...
510300020719?1b? C                   if        x5niv5 <> *zeros                             ?P----------01
510400020719     C                   eval      @@niv1 = 5                                   ?            |
510500020719     C                   eval      @@nic1 = x5niv5                              ?            |
510600020719     C     k5@ni2        chain     s1hni201                           20        ?            |
510700020719     C  n20              eval      x5nom5 = dfnomb                              ?            |
510800020719     C   20              eval      x5nom5 = *blanks                             ?            |
510900020719?1e? C                   endif                                                  ?F----------01
511000020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 6...
511100020719?1b? C                   if        x5niv6 <> *zeros                             ?P----------01
511200020719     C                   eval      @@niv1 = 6                                   ?            |
511300020719     C                   eval      @@nic1 = x5niv6                              ?            |
511400020719     C     k5@ni2        chain     s1hni201                           20        ?            |
511500020719     C  n20              eval      x5nom6 = dfnomb                              ?            |
511600020719     C   20              eval      x5nom6 = *blanks                             ?            |
511700020719?1e? C                   endif                                                  ?F----------01
511800020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 7...
511900020719?1b? C                   if        x5niv7 <> *zeros                             ?P----------01
512000020719     C                   eval      @@niv1 = 7                                   ?            |
512100020719     C                   eval      @@nic1 = x5niv7                              ?            |
512200020719     C     k5@ni2        chain     s1hni201                           20        ?            |
512300020719     C  n20              eval      x5nom7 = dfnomb                              ?            |
512400020719     C   20              eval      x5nom7 = *blanks                             ?            |
512500020719?1e? C                   endif                                                  ?F----------01
512600020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 8...
512700020719?1b? C                   if        x5niv8 <> *zeros                             ?P----------01
512800020719     C                   eval      @@niv1 = 8                                   ?            |
512900020719     C                   eval      @@nic1 = x5niv8                              ?            |
513000020719     C     k5@ni2        chain     s1hni201                           20        ?            |
513100020719     C  n20              eval      x5nom8 = dfnomb                              ?            |
513200020719     C   20              eval      x5nom8 = *blanks                             ?            |
513300020719?1e? C                   endif                                                  ?F----------01
513400020719     ?*- RECUPERA NOMBRE DE PRODUCTOR 9...
513500020719?1b? C                   if        x5niv9 <> *zeros                             ?P----------01
513600020719     C                   eval      @@niv1 = 9                                   ?            |
513700020719     C                   eval      @@nic1 = x5niv9                              ?            |
513800020719     C     k5@ni2        chain     s1hni201                           20        ?            |
513900020719     C  n20              eval      x5nom9 = dfnomb                              ?            |
514000020719     C   20              eval      x5nom9 = *blanks                             ?            |
514100020719?1e? C                   endif                                                  ?F----------01
514200020719     ?*- VERIFICA SI DEBE PERMITIR CAMBIOS...
514300020719?1b? C                   if        @@ma05 = '2'                                 ?P----------01
514400020719     C                   eval      *in16 = *off                                 ?            |
514500020719?1x? C                   else                                                   ?X..........01
514600020719     C                   eval      *in16 = *on                                  ?            |
514700020719?1e? C                   endif                                                  ?F----------01
514800020719     C                   endsr
514900000904     ?******************************************************
515000020719     C     grab05        begsr
515100020719     ?** GRABA LOS DATOS DE LA PANTALLA 05. ---------------
515200020719     ?* VALORES AL ARCHIVO FISICO...
515300020719     C     k1@ec1        chain     p1hec1                             20
515400020719?1b? C                   if        not *in20                                    ?P----------01
515500020719     C                   eval      c1niv1 = x5niv1                              ?            |
515600020719     C                   eval      c1niv2 = x5niv2                              ?            |
515700020719     C                   eval      c1niv3 = x5niv3                              ?            |
515800020719     C                   eval      c1niv4 = x5niv4                              ?            |
515900020719     C                   eval      c1niv5 = x5niv5                              ?            |
516000020719     C                   eval      c1niv6 = x5niv6                              ?            |
516100020719     C                   eval      c1niv7 = x5niv7                              ?            |
516200020719     C                   eval      c1niv8 = x5niv8                              ?            |
516300020719     C                   eval      c1niv9 = x5niv9                              ?            |
516400020719     C                   update    p1hec1                                       ?            |
516500020719?1e? C                   endif                                                  ?F----------01
516600020719     ?*- Actualizar marca de paso realizado...
516700020719     C     k1@pc0        chain     p1wpc0                             20
516800020719     C  n20              eval      w0wp01 = 1
516900020719     C  n20              update    p1wpc0
517000020719     ?*- POR AHORA ESTE ES EL FIN...
517100020719     C                   eval      @@mand = 'KA'
517200020719     C                   eval      *inkc = '1'
517300020719     C                   endsr
517400000927     ?******************************************************
517500020719     C     pant06        begsr
517600020719     ?** PROCESO DE PANTALLA 02----------------------------
517700020719?1b? C                   if        t@cn01 <> *zeros  or                         ?P----------01
517800020719     C                             t@cn02 <> *zeros  or                         ?            |
517900020719     C                             t@cn03 <> *zeros  or                         ?            |
518000020719     C                             t@cn04 <> *zeros                             ?            |
518100020719     C                   call      'PAR310L'                                    ?            |
518200020719     C                   parm                    @@empr                         ?            |
518300020719     C                   parm                    @@sucu                         ?            |
518400020719     C                   parm                    @@arcd                         ?            |
518500020719     C                   parm                    @@spo1                         ?            |
518600020719     C                   parm                    @@spol                         ?            |
518700020719     C                   parm                    @@sspo                         ?            |
518800020719     C                   parm                    @@mand                         ?            |
518900020719     C                   parm                    endpgm                         ?            |
519000020719?1e? C                   endif                                                  ?F----------01
519100020719     C                   endsr
519200010314     ?******************************************************
519300020719     C     bormsg        begsr
519400020719     ?** BORRAR MENSAJE DE AUDITORIA-----------------------
519500020719     C                   eval      msempr = w0empr
519600020719     C                   eval      mssucu = w0sucu
519700020719     C                   eval      msarcd = w0arcd
519800020719     C                   eval      msspol = w0spol
519900020719     C                   eval      mssspo = w0sspo
520000020719     C                   eval      msrama = *zeros
520100020719     C                   eval      msarse = *zeros
520200020719     C                   eval      msoper = *zeros
520300020719     C                   eval      mssuop = *zeros
520400020719     ?* borrar mensajes de este mismo programa...
520500020719     C                   setoff                                           96
520600020719     C     k1@msg        setll     p1hmsg
520700020719?1b? C                   dou       *in96                                        ?P----------01
520800020719     C     k1@msg        reade     p1hmsg                                 96    ?            |
520900020719?2b? C                   if        not *in96  and                               ?P---------02|
521000020719     C                             mscpgm = $$q001                              ?           ||
521100020719     C                   delete    p1hmsg                                       ?           ||
521200020719?2e? C                   endif                                                  ?F---------02|
521300020719?1e? C                   enddo                                                  ?F----------01
521400020719     C                   unlock    pahmsg
521500020719     C                   endsr
521600010314     ?******************************************************
521700020719     C     gramsg        begsr
521800020719     ?** GRABAR MENSAJE DE AUDITORIA-----------------------
521900020719     C                   exsr      bormsg
522000020719     ?* campos de clave...
522100020719     C                   eval      msempr = w0empr
522200020719     C                   eval      mssucu = w0sucu
522300020719     C                   eval      msarcd = w0arcd
522400020719     C                   eval      msspol = w0spol
522500020719     C                   eval      mssspo = w0sspo
522600020719     C                   eval      msrama = *zeros
522700020719     C                   eval      msarse = *zeros
522800020719     C                   eval      msoper = *zeros
522900020719     C                   eval      mssuop = *zeros
523000020719     ?* buscar secuencia...
523100020719     C     k1@msg        setgt     p1hmsg
523200020719     C     k1@msg        readpe(n) p1hmsg                                 96
523300020719     C  n96              add       1             msivse
523400020719     C   96              eval      msivse = 1
523500020719     C                   eval      mssuse = *zeros
523600020719     ?* restantes campos del archivo...
523700020719     C                   eval      mscpgm = *blanks
523800020719     C                   eval      mscpgm = $$q001
523900020719     ?* armar campo del mensaje...
524000020719     C                   eval      mstxmg = *blanks
524100020719     C                   movel     $$q002        mstxmg
524200020719     ?* marcas de proceso...
524300140603     C                   eval      msmarp = '1'
524400020719     ?* marca de si es suspendida o es poliza emitida...
524500020719     C                   eval      msmar1 = '1'
524600020719     C                   eval      msmar2 = '0'
524700020719     C                   eval      msmar3 = '0'
524800020719     C                   eval      msmar4 = '0'
524900020719     C                   eval      msmar5 = '0'
525000020719     C                   eval      msstrg = '0'
525100020719     C                   eval      msuser = vsuser
525200020719     C                   time                    mstime
525300020719     C                   eval      msdate = udate
525400020719     ?* grabar...
525500020719     C                   write     p1hmsg                               96
525600020719     C                   unlock    pahmsg
525700020719     C                   endsr
525800000904     ?******************************************************
525900020719     C     apag01        begsr
526000020719     ?** APAGAR MENSAJES DE AVISO--------------------------
526100020719     C                   eval      @@in33 = *zeros
526200020719     C                   eval      @@in91 = *zeros
526300020719     C                   endsr
526400000904     ?******************************************************
526500020719     C     apagar        begsr
526600020719     ?** APAGAR INDICADORES DE ERROR-----------------------
526700020719     C                   eval      @e = *zeros
526800110201     C                   setoff                                         1522
526900020719     C                   setoff                                       242526
527000020719     C                   setoff                                         2728
527100020719     C                   setoff                                       333435
527200020719     C                   setoff                                       363738
527300020719     C                   setoff                                       404142
527400020719     C                   setoff                                       434445
527500020719     C                   setoff                                       464748
527600020719     C                   setoff                                           49
527700020719     C                   setoff                                       505152
527800020719     C                   setoff                                       535455
527900020719     C                   setoff                                       565758
528000020719     C                   setoff                                       596061
528100020719     C                   setoff                                       626364
528200020719     C                   setoff                                       656667
528300020719     C                   setoff                                       686970
528400020719     C                   setoff                                       717273
528500020719     C                   setoff                                       747576
528600020719     C                   setoff                                       777879
528700020719     C                   setoff                                       808182
528800020719     C                   setoff                                       838485
528900020719     C                   setoff                                       868788
529000020719     C                   setoff                                         9189
529100101229     C                   setoff                                       979495
529200140905     C                   setoff                                       13
529300020719     C                   endsr
529400000904     ?******************************************************
529500020719     C     srclos        begsr
529600020719     ?** FINAL DE PROGRAMA---------------------------------
529700020719     C                   call      'PRO030R'
529800020719     C                   parm                    x1asen
529900020719     C                   parm      'LR'          @@@end
530000020719     ?*-
530100020719     ?*                    CALL 'PRO320R'
530200020719     ?*                    PARM           X1ASEN
530300020719     ?*                    PARM *BLANKS   @@NOMB 40
530400020719     ?*                    PARM *BLANKS   @@DOMI 35
530500020719     ?*                    PARM *ZEROS    @@COPO  50
530600020719     ?*                    PARM *ZEROS    @@COPS  10
530700020719     ?*                    PARM 'LR'      @@@END
530800020719     C                   call      'PAR3011'
530900020719     C                   parm                    x1nivt
531000020719     C                   parm                    x1nivc
531100020719     C                   parm                    x1nino
531200020719     C                   parm      'FIN'         endpgm
531300020719     C                   call      'PAR310L'
531400020719     C                   parm                    @@empr
531500020719     C                   parm                    @@sucu
531600020719     C                   parm                    @@arcd
531700020719     C                   parm                    @@spo1
531800020719     C                   parm                    @@spol
531900020719     C                   parm                    @@sspo
532000020719     C                   parm                    @@mand
532100020719     C                   parm      'FIN'         endpgm
532200100712     C                   call      'SPANXFP'
532300100712     C                   parm                    @@empr
532400100712     C                   parm                    @@sucu
532500100712     C                   parm                    x1asen
532600100712     C                   parm                    @@sino
532700100712     C                   parm      'FIN'         endpgm
532800020719     C                   endsr
532900040824     ?*****************************************************************
533000040824     ?* Procedure name: fecha_hasta                                   *
533100040824     ?* Purpose:        Calcular la fecha hasta según parámetros. Base*
533200040824     ?*                 fecha desde recibida.                         *
533300040824     ?*                                                               *
533400040824     ?* Returns:        Fecha Hasta calculada.                        *
533500040824     ?* Parameter:      fh_desde => Fecha desde DDMMAAAA              *
533600040824     ?* Parameter:      fh_mar5 => Contenido de la variable X!MAR5    *
533700040824     ?* Parameter:      fh_dupe => Duración del perodo base para calculo.
533800040824     ?* Parameter:      fh_asen => Asegurado a chequear               *
533900040824     ?*****************************************************************
534000040824     P fecha_hasta     b
534100040824     D fecha_hasta     pi                  like(x1desd)
534200040824     D  fh_desde                           like(x1desd)
534300040824     D  fh_mar5                            like(x1mar5)
534400040824     D  fh_dupe                            like(x1dupe)
534500040824     D  fh_asen                            like(x1asen)
534600040824
534700040824
534800040824     ?* Local fields
534900040824     D                 ds             8    inz
535000040824     Dds_fecha                 1      8  0
535100040824     D ds_dia                  1      2  0
535200040824     D ds_mes                  3      4  0
535300040824     D ds_aÑo                  5      8  0
535400040824     ?* Campos independientes.
535500040824     D retfield        s                   like(x1desd)
535600040824
535700040824     C                   eval      ds_fecha = fh_desde
535800040824?1b? C                   if        fh_dupe <> 99                                ?P----------01
535900040824?2b? C                   select                                                 ?P---------02|
536000040824?2x? C                   when      fh_mar5 = '1'                                ?w---------02|
536100040824     C                   call      'SP0001'                                     ?           ||
536200040824     C                   parm      ds_fecha      retfield                       ?           ||
536300040824     C                   parm                    fh_dupe                        ?           ||
536400040824?2x? C                   when      fh_mar5 = '2'                                ?w---------02|
536500040824     C                   eval      ds_fecha= fh_desde                           ?           ||
536600040824     C                   add       fh_dupe       ds_aÑo                         ?           ||
536700040824     C                   eval      retfield = ds_fecha                          ?           ||
536800040824     ?*- EXPRESADA EN AÑOS HASTA CANTIDAD DE MESES...                           ?           ||
536900040824?2x? C                   when      fh_mar5 = '3'                                ?w---------02|
537000040824     C     fh_asen       chain     gnhda1                                       ?           ||
537100040824?3b? C                   if        %found                                       ?P--------03||
537200040824     C                   eval      ds_dia = dffnad                              ?          |||
537300040824     C                   eval      ds_mes = dffnam                              ?          |||
537400040824     C     dffnaa        add       fh_dupe       ds_aÑo                         ?          |||
537500040824     C                   eval      retfield = ds_fecha                          ?          |||
537600040824?3x? C                   else                                                   ?X........03||
537700040824     C                   eval      retfield = *zeros                            ?          |||
537800040824?3e? C                   endif                                                  ?F--------03||
537900040824?2e? C                   endsl                                                  ?F---------02|
538000040824?1x? C                   else                                                   ?X..........01
538100040824     C                   eval      retfield = 99999999                          ?            |
538200040824?1e? C                   endif                                                  ?F----------01
538300040824
538400040824     C                   return    retfield
538500040824
538600040824     P fecha_hasta     e
538700040824     ?*****************************************************************
538800041022     P* Procedure name: es_vida
538900041022     P* Purpose:        Determina Rama de Vida
539000041022     P* Returns:        Es o no vida
539100041022     P* Parameter:      pr_rama => Rama a chequear.
539200041022     P*--------------------------------------
539300041022     P es_vida         B
539400041022     D es_vida         PI              N
539500041022     D pr_rama                             LIKE(d0rama)
539600041022
539700041022     D* Local fields
539800041022     D retField        S               N
539900041022
540000041022     C                   eval      retfield = *off
540100041022     C     pr_rama       chain     set001
540200041022     C                   if        %found
540300041022     C                   eval      retfield =(t01_rame = 19 or
540400041022     C                                        t01_rame = 16 or
540500041022     C                                        t01_rame = 18 or
540600041022     C                                        t01_rame = 21)
540700041022     C                   endif
540800041022
540900041022     C                   RETURN    retField
541000041022     P es_vida         E
541100041022     ?*****************************************************************
541200000904**
5413000009040123456789
