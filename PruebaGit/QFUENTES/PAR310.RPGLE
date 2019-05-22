000100140908     H decedit(',') datedit(*dmy/) debug(*yes)
000200140904     H actgrp(*caller) dftactgrp(*no) bnddir('HDIILE/HDIBDIR')
000300130827     H copyright('HDI Seguros S.A.') option(*nodebugio)  INDENT('|')
000400991217     ?*****************************************************************
000500991217     ?*  PAR310  : LLAMADOR PRINCIPAL DE EMISION DE SUPERPOLIZAS      *
000600991217     ?*          : MODULO DE PRODUCCION ORIENTADO A ARTICULOS         *
000700991217     ?*                                                               *
000800991217     ?*  FECHA   : 03/12/96                                           *
000900991217     ?*  AUTOR   : ALEJANDRO RODRIGUEZ                                *
001000991217     ?*****************************************************************
001100991217     ?*                   M O D I F I C A C I O N E S
001200991217     ?* hdt hdt-25/09/97 -También buscar en pgm móudlo 01.
001300020301     ?* NWN NWN-31/01/02 -Arreglo de busqueda de Cotizacion
001400020301     ?*                   (Ver sentencia NWN01)
001500020301     ?* NWN NWN-01/03/02 -Aviso de polizas con Saldo en las
001600020301     ?*                   Renovaciones (Ver sentencia NWN02)
001700021205     ?* NWN NWN-03/05/02 -SPEEDWAY - Control de Operaciones.
001800021205     ?*                              (Ver sentencia NWN03)
001900020510     ?* SLU SLU-10/05/02 -Se agrega en pantalla de suspendidas el campo que
002000020510     ?*                   indica la Propuesta o la Póliza afectada por alguna tarea
002100021204     ?*                   del "speedway". Si este campo no contiene algún valor dicho
002200021204     ?*                   movimiento NO ES "speedway".
002300030122     ?* NWN NWN-21/01/03 -Se arreglo campo de pantalla X2fech. Traia mal la
002400030116     ?*                  -fecha en Subfile.
002500030218     ?* NWN NWN-18/02/03 -Se arreglo para que no muestre las Anulaciones o
002600030218     ?*                   Rehabilitaciones que se hacen por el PAR320.
002700040204     ?* SLU SLU-04/02/04 -Si este programa es llamado desde Speedway (Web)
002800040204     ?*                   protege los campos de pantalla y toma los valores que
002900040204     ?*                   le llegan desde el llamador y realiza la lógica normal
003000040204     ?*                   como si el usuario hubiese seleccionado los valores para
003100040204     ?*                   los mismos.
003200040204     ?*                   Una cosa a tener en cuenta es que si se lo llama para
003300040204     ?*                   Póliza Nueva y con Número de Superpóliza (que no pasa
003400040204     ?*                   normalmente) se intenta relacionar esta nueva Superpóliza
003500040204     ?*                   con otra ya existente. Esta relación se hace usando el
003600040204     ?*                   archivo PAHEC0C que usa GAUS para relacionar pólizas de
003700040204     ?*                   DISTINTOS artículos sólo que esta vez se trata del mismo.
003800040420     ?* SLU SLU-20/04/04 -Nueva función "Ir a..." que permite saltar a un paso ya
003900040419     ?*                   cumplido por la emisión. Dicho paso será llamado por este
004000040419     ?*                   programa o bien (si el usuario da F12 en la pantalla de
004100040419     ?*                   salto) se retorna a aquel paso en el que se encontraba.
004200040419     ?*                   Una vez realizado el salto se deshabilitan los pasos
004300040419     ?*                   posteriores al que se eligió para obligar al usuario a
004400040419     ?*                   pasar por pasos posteriores por si se realizaron
004500040419     ?*                   cambios.
004600040423     ?* SGF SGF 23/04/04 - Cambio valor de parámetro para llamar a la SP0052
004700040423     ?*                    Ahora va Vendedor. ("V").
004800040514     ?* SLU SLU 14/05/04 -La PTF03052002 creaba problemas para los movimientos que
004900040514     ?*                   se bloqueban desde GTI001. Si bien no dejaba emitir, cuando
005000040514     ?*                   se los quería retomar para el caso de (p.ej.) las Renovaciones
005100040514     ?*                   en Spwdy V1, evitaba que se lo haga. Se corrige
005200040514     ?*                   el uso de la G1MAR4 para todos los movimientos.
005300040514     ?*                   Si esta marca es = '1', y la operación es Speedway,
005400040514     ?*                   puede retomarse sólo si ya está en GTI980 (Speedway V1).
005500040805     ?* SGF SGF 05/08/2004 -Artículo de Vida Marcado como V2 SpeedWay no pue
005600040805     ?*                     de emitir endosos desde "verde".
005700070308     ?* SLU SLU 08/03/2007 -Si la propuesta recibida desde Speedway está en
005800070308     ?*                   GTI980 como ya emitida (existe en GTI98009) se devuelve
005900070308     ?*                   error ya que ha habido algún problema desde el SPW que
006000070308     ?*                   permitió que se volviese a usar la misma propuesta.
006100040419     ?*
006200111125      * 25/11/2011 Inf1Marc
006300111125      *  Se agrega inicialización de campos TMAT NMAT "Tipo y nro de Ma-
006400111125      * trícula o patente" del PAHCP0
006500130606     ?* SGF SGF 06/06/2004 -Cuando llega con parámetros desde SpeedWay vali-
006600130606     ?*                     dar que el número de solicitud sea distinto de
006700130606     ?*                     cero.
006800130815      *
006900130815      * INF1MARC 14/08/2013 Pedido de desarrollo 3032
007000130815      *  Se agrega llamada al PAR310N
007100130815      *
007200140213      * INF1MARC 13/02/2014 Pedido de desarrollo 3303
007300140213      *
007400140904     ?* SGF SGF 05/09/2014 - Nuevas validaciones para SpeedWay V2:
007500140904     ?*                      - Cuando es Refa, el desde que llega debe
007600140904     ?*                        ser igual al hasta facturado de la última
007700140904     ?*                        facturación (nueva, renovación o refa).
007800140904     ?*                        Podríamos pisar lo que llega de SPW (que lo
007900140904     ?*                        ha mandado mal en más de una ocasión), pero
008000140904     ?*                        a pedido (hablado) de Fernando Brienza se
008100140904     ?*                        rebota el movimiento (para tener los mismos
008200140904     ?*                        valores en ambos sistemas).
008300140904     ?*                      - Duplicidad de propuesta: SpeedWay V2 Autos
008400140904     ?*                        permite asignar la misma solicitud mas de
008500140904     ?*                        una vez. Acá se validaba versus GTI98009,
008600140904     ?*                        pero como SPW 2 graba 980 al final no se
008700140904     ?*                        validaba correctamente que una solicitud
008800140904     ?*                        estuviera en PAWPC0, lo que provocaba que
008900140904     ?*                        al llamar SPW dos veces con funcion 1 y la
009000140904     ?*                        misma propuesta, ésta quedara enganchada a
009100140904     ?*                        N superpólizas diferentes. Ejemplo:
009200140904     ?*
009300140904     ?*                        SOLN   FUNC   SPOL   ESTADO
009400140904     ?*                         01     1      01    SUSPENDIDA
009500140904     ?*                         01     1      02    EMITIDA
009600140904     ?*                         01     1      03    BAJA DE SUSPENDIDA
009700140904     ?*
009800140904     ?*                        A partir de ahora, cuando función = 1, la
009900140904     ?*                        SOLN no debe existir en 98009 (validación
010000140904     ?*                        existente) ni debe estar en PAWPC0.
010100140908      *
010200140908      * INF1MARC 08/09/2014 Pedido de desarrollo 3692
010300140908      *  Se agregan parámetros a la llamada del PAR310
010400140910     ?* SGF SGF 10/09/2014 - Enviar copia del mail por error en adonde_voy
010500140910     ?*                      al Proc.Robot para que tengan acceso los chicos
010600140910     ?*                      de SpeedWay.
010700140927     ?* SGF SGF 29/09/2014 - Paso el PAHCP0 a Input Full Add.
010800150223     ?* SGF SGF 23/02/2015 - Unifico acceso a dtaara que contiene la fecha
010900150223     ?*                      de arranque de SpeedWay V2 llamando a SPINISPW.
011000150223     ?*                      Esto es un error histórico que hacía cancelar
011100150223     ?*                      el programa por lock de la dtaara (estaba
011200150223     ?*                      definida como uds).
011300150312     ?* SGF SGF 12/03/2015 - Al validar el primer punto de la PTF
011400150312     ?*                      05/09/2014, tener en cuenta los 3/90.
011500150407     ?* SFA SFA 06/04/2015 - Cambio logica de obtencion de fecha hasta
011600150407     ?*                      facturado Speedway.
011700150407     ?*                      Cuando es nueva o renovacion o refacturacion y
011800150407     ?*                      estado de contrato en 0 tomo esa fecha.
011900150407     ?*                      Si es refacutarcion y estado de contrato <> 0,
012000150407     ?*                      si el componente que lo afecta es anulacion o
012100150407     ?*                      anulacion de endoso tomo esa fecha
012200150410     ?* SFA SFA 10/04/2015 - Se corrige logica en obtencion de fecha hasta
012300150410     ?*                      facturado Speedway. El funcionamiento es como
012400150410     ?*                      se describio en la PTF de 06/04/2015.
012500180528     ?* JSN JSN 02/10/2017 - Inclusión de Programas Internacionales
012600180528     ?*                      (Planes mundiales) PAR310P.
012700180911     ?* NWN NWN 11/09/2018 - Agregado de Categoría a Parámetros PAR311D
012800150407     ?*
012900991217     ?******************************************************************
013000991217     Fpar310am  cf   e             workstn
013100991217     F                                     sfile(par310s1:sf1rrn)
013200991217     Fpawpc001  uf a e           k disk
013300991217     Fpawpc002  if   e           k disk
013400040204     Fpawpc098  if   e           k disk    prefix(sp_)
013500040419     Fpawp31001 uf   e           k disk
013600991217     Fpawkl1    if   e           k disk
013700991217     Fpawemi01  if   e           k disk
013800991217     Fpawpd0    if   e           k disk
013900991217     Fpahec0    if   e           k disk
014000991217     Fpahed004  if   e           k disk
014100991217     Fpahed0    if   e           k disk
014200991217     Fpahec1    if   e           k disk
014300991217     Fpahec4    uf a e           k disk
014400991217     Fset902    uf a e           k disk
014500991217     Fset901    if   e           k disk
014600991217     Fset620    if   e           k disk
014700020506     Fset990    uf a e           k disk
014800991217     Fset001    if   e           k disk
014900991217     Fset630    if   e           k disk
015000000929     Fset6301   if   e           k disk
015100150810     Fset62104  if   e           k disk    prefix(t$:2)
015200991217     Fgntpgm    if   e           k disk
015300991217     Fgnhdaf    if   e           k disk
015400040204     Fgti98001  if   e           k disk
015500070308     Fgti98009  if   e           k disk    prefix(g09:2)
015600021204     Fgti001    if   e           k disk
015700140927     Fpahcp0    if a e           k disk
015800040204     ?******************************************************************
015900040204     ?* *ENTRY -> Se usa área de comunicación ILE para el uso de paráme*
016000040204     ?*           tros condicionales.                                  *
016100040204     ?* soln: Número de solicitud (p.ej. Speedway) a relacionar con la *
016200040204     ?*       póliza.                                                  *
016300040204     ?* spol: Superpóliza. Puede ser CERO para cuando se trata de      *
016400040204     ?*       FUNCión Nueva (1) o puede ser <> de CERO cuando, siendo  *
016500040204     ?*       Nueva, se la quiere relacionar con otra ya existente.    *
016600040204     ?* arcd: Artículo. Viene informado. Valor necesario.              *
016700040204     ?* tiou: Tipo de Operación a realizar. Valor necesario.           *
016800040204     ?* stou: Subtipo de Operación, idem TIOU.                         *
016900040204     ?* asen: Código de Asegurado. Necesario para pólizas nuevas y endo*
017000040204     ?*       sos de Cambio de Asegurado.                              *
017100040204     ?* nivc: Productor. Idem ASEN pero para el Productor.             *
017200040204     ?* fvde: Fecha de Vigencia Desde informada para el movimiento.    *
017300040204     ?*       Valor necesario.                                         *
017400040204     ?* fpro: Fecha de Vigencia Hasta idem FVDE.                       *
017500040204     ?* func: Puede tener los siguientes valores:                      *
017600040204     ?*       1: Movimiento Nuevo.                                     *
017700040204     ?*       2: Recuperar desde suspendidas.                          *
017800040204     ?*       3: Eliminar desde Suspendidas.                           *
017900040204     ?*                                                                *
018000040204     ?*----------------------------------------------------------------*
018100040204     Dpar310           pr                  extpgm('PAR310')
018200040204     D soln                                like(g0soln) options(*nopass)
018300040204     D spol                                like(g0spol) options(*nopass)
018400040204     D arcd                                like(g0arcd) options(*nopass)
018500040204     D tiou                                like(t@tiou) options(*nopass)
018600040204     D stou                                like(t@stou) options(*nopass)
018700040204     D asen                                like(dfnrdf) options(*nopass)
018800040204     D nivc                                like(c1nivc) options(*nopass)
018900040204     D fvde                           8p 0 options(*nopass)
019000040204     D fpro                           8p 0 options(*nopass)
019100040204     D func                           1p 0 options(*nopass)
019200040204
019300040204     Dpar310           pi
019400040204     D iisoln                              like(g0soln) options(*nopass)
019500040204     D iispol                              like(g0spol) options(*nopass)
019600040204     D iiarcd                              like(g0arcd) options(*nopass)
019700040204     D iitiou                              like(t@tiou) options(*nopass)
019800040204     D iistou                              like(t@stou) options(*nopass)
019900040204     D iiasen                              like(dfnrdf) options(*nopass)
020000040204     D iinivc                              like(c1nivc) options(*nopass)
020100040204     D iifvde                         8p 0 options(*nopass)
020200040204     D iifpro                         8p 0 options(*nopass)
020300040204     D iifunc                         1p 0 options(*nopass)
020400040419     ?*--------------------------------------
020500040419     ?* Prototype for procedure: ira_prc
020600040419     ?*--------------------------------------
020700040419     D ira_prc         pr                  like(xxiden)
020800040419     D prmand                              like(@@mand)
020900040419     D priden                              like(xxiden)
021000040419     D priden_kl                           like(xxiden) value
021100040805     ?*--------------------------------------
021200040805     ?* Prototype for procedure: es_vida
021300040805     ?*--------------------------------------
021400040805     D es_vida         pr                  like(*in50)
021500130814      *--------------------------------------------------
021600130814      * Parámetros de llamada del PAR310N
021700130814      *--------------------------------------------------
021800130814     D PAR310N         pr                  extpgm('PAR310N')
021900130814     D  P_empr                        1A
022000130814     D  P_sucu                        2A
022100130814     D  P_arcd                        6  0
022200130814     D  P_rama                        2  0
022300130814     D  P_soln                        7  0
022400140908     D  P_spol                        9  0
022500140908     D  P_tiou                        1  0
022600140908     D  P_stou                        2  0
022700140908     D  P_func                        1  0
022800140908     D  P_sspo                        3  0
022900130814     D  P_Error                      80
023000130814     D  P_Error        s             80
023100040419
023200140905      * ------------------------------------------------------------ *
023300140905      * Reportar errores en parámetros spw (rutina adonde_voy)       *
023400140905      * Los parámetros no se reciben CONST porque el que definió el  *
023500140905      * prototipo del procedimiento principal no los definió así y   *
023600140905      * el compilador dará error, pero los parámetros son de input   *
023700140905      * y ADEMAS los últimos 3 estoy obligado a definirlos "p"....   *
023800140905      * ------------------------------------------------------------ *
023900140905     D PAR310_reportErrorSpw...
024000140905     D                 pr
024100140905     D  peSoln                        7  0
024200140905     D  peSpol                        9  0
024300140905     D  peArcd                        6  0
024400140905     D  peTiou                        1  0
024500140905     D  peStou                        2  0
024600140905     D  peAsen                        7  0
024700140905     D  peNivc                        5  0
024800140905     D  peFvde                        8p 0
024900140905     D  peFpro                        8p 0
025000140905     D  peFunc                        1p 0
025100140905     D  peEcod                       10a   const
025200140905
025300150407     D ultFac          pr              n
025400150407
025500150407     D SPAFANU         pr                  extpgm('SPAFANU')
025600150407     D  empr                          1
025700150407     D  sucu                          2
025800150407     D  arcd                          6  0
025900150407     D  spol                          9  0
026000150407     D  sspo                          3  0
026100150407     D  retu                           n
026200150407
026300040204     ?*- Renombremos indicadores para uso en lógica...
026400040204     ?* Tabla de Indicadores. Nombramos Indicadores.                     *
026500040204     ?* Renombra Indicadores. -------------------------------------------*
026600040204     D puntinds        s               *   inz(%addr(*in))
026700040204     D                 ds                  based(puntinds)
026800040204     D por_parametros          8      8n
026900991217     ?*- INICIALIZAR CONSTANTES...
027000040419     ?* DS para poder copiar SALTO y mover los campos a la salida
027100040419     D                 ds                  inz
027200040419     Ddssalto                  1     17a
027300040419     D dspaso                  1      2s 0
027400040419     D dsmar01                 3      3s 0
027500040419     D dsmar02                 4      4s 0
027600040419     D dsmar03                 5      5s 0
027700040419     D dsmar04                 6      6s 0
027800040419     D dsmar05                 7      7s 0
027900040419     D dsmar06                 8      8s 0
028000040419     D dsmar07                 9      9s 0
028100040419     D dsmar08                10     10s 0
028200040419     D dsmar09                11     11s 0
028300040419     D dsmar10                12     12s 0
028400040419     D dsmar11                13     13s 0
028500040419     D dsmar12                14     14s 0
028600040419     D dsmar13                15     15s 0
028700040419     D dsmar14                16     16s 0
028800040419     D dsmar15                17     17s 0
028900991217     ?*- AGRUPACION DIA-MES-AÑO EN UN SOLO CAMPO...
029000991217     D                 ds
029100020510     D  p@fdma                01     08  0
029200991217     D  p@fdia                01     02  0
029300991217     D  p@fmes                03     04  0
029400020510     D  p@faÑo                05     08  0
029500020510     D  p@faÑo2               07     08  0
029600991217     ?*- AGRUPACION AÑO-MES-DIA EN UN SOLO CAMPO...
029700991217     D                 ds
029800991217     D  p@famd                01     08  0
029900991217     D  p@1aÑo                01     04  0
030000991217     D  p@1mes                05     06  0
030100991217     D  p@1dia                07     08  0
030200020123NWN  ?*- AGRUPACION AÑO-MES-DIA EN UN SOLO CAMPO...
030300020123NWN  D                 ds
030400020123NWN  D  @@fech                01     08  0
030500020123NWN  D  @@femd                01     02  0
030600020123NWN  D  @@femm                03     04  0
030700020123NWN  D  @@fema                05     08  0
030800040204     ?* Area de control de fecha de arranque de Speedway V2.
030900150220     D fecha_spdwy     s              8  0
031000021205     ?*- AREA DEL PROGRAMA...
031100021205     D                sds
031200021205     D  vsuser               254    263
031300021205     ?*- AREA LOCAL DE DATOS...
031400021205     D                uds
031500021205     D  usempr               401    401
031600021205     D  ussucu               402    403
031700020510     ?* Campos independientes...
031800020510     D $$arcd          s                   like(x1arcd)
031900020510     D $$poli          s                   like(x5poli)
032000020510     D $$rama          s                   like(x5rama)
032100020510     D $$spo1          s                   like(x1spo1)
032200020510     D $$stou          s                   like(x1stou)
032300020510     D $$tiou          s                   like(x1tiou)
032400020510     D $7arcd          s                   like(x7arcd)
032500020510     D $7spol          s                   like(x7spol)
032600040204     D @@aux1          s             29  9
032700020510     D @@cbrn          s                   like(c1cbrn)
032800020510     D @@czco          s                   like(c1czco)
032900020510     D @@flag          s              1  0
033000020510     D @@lsf1          s              9  0
033100020510     D @@mand          s              2
033200040204     D @@modo          s              3
033300020510     D @@mone          s                   like(c1mone)
033400020510     D @@paso          s              2  0
033500020510     D @e              s              2  0
033600040419     D @in             s                   like(@e)
033700020510     D c901            s              1                                         ?            |
033800020510     D endpgm          s              3
033900020510     D p310c           s              1
034000020510     D p310d           s              1
034100020510     D p310e           s              1                                         ?            |
034200020510     D p310f           s              1                                         ?            |
034300171002     D p310p           s              1
034400020510     D p310r           s              1                                         ?            |
034500020510     D p310w           s              1                                         ?           ||
034600020510     D p310x           s              1                                         ?        |||||
034700020510     D p310y           s              1                                         ?          |||
034800020510     D p311c           s              1                                         ?            |
034900020510     D p312c           s              1
035000020510     D p312f           s              1
035100020510     D p313c           s              1                                         ?            |
035200020510     D p314c           s              1                                         ?            |
035300020510     D p319            s              1                                         ?          |||
035400020510     D sf1rrn          s              9  0
035500020510     D zarcd           s                   like(c1arcd)
035600020510     D zarse           s                   like(z0arse)
035700020510     D zasen           s                   like(c1asen)
035800020510     D zcbrn           s                   like(c1cbrn)
035900020510     D zcert           s                   like(c1cert)
036000020510     D zczco           s                   like(c1czco)
036100020510     D zmepg           s              1
036200020510     D znomb           s             40
036300020510     D znrcu           s              2  0
036400020510     D znrsc           s              2  0
036500020510     D zoper           s                   like(z0oper)
036600020510     D zorde           s              1
036700020510     D zpoli           s              7  0
036800020510     D zpsec           s              2  0
036900020510     D zrama           s                   like(z0rama)
037000020510     D zretn           s              1
037100020510     D zspol           s                   like(c1spol)
037200020510     D zsspo           s                   like(c1sspo)
037300020510     D zsuop           s                   like(z0suop)
037400040204     D antes_spdwy     s                   like(*in50)
037500040204     D no_es_spdwy     s                   like(*in50)
037600040204     D es_version1     s                   like(*in50)
037700040204     D es_version2     s                   like(*in50)
037800040204     D testspol        s                   like(t@spol)
037900040204     ?* HAY_ERROR_PARM : Bandera para indicar a la lógica que se ha
038000040204     ?* detectado un error cuando se validaban ciertas funciones de
038100040204     ?* los parámetros cuando "POR_PARAMETROS = *ON".
038200040204     D hay_error_parm  s                   like(*in50)
038300040204     ?* DEJAR_SUSPEN   : Esta bandera sirve para NO VOLVER a la rutina
038400040204     ?* "ADONDE_VOY" cuando se ha detenido la emisión y se desea Suspen-
038500040204     ?* der la Operación.
038600040204     D dejar_suspen    s                   like(*in50)
038700040419     ?* PASO: Este array se llena con los campos de los pasos cumplidos en
038800040419     ?*       la emisión.
038900040419     D paso            s                   like(w0wp01) dim(15)
039000040419     ?* PASO_P: Este array se llena con los campos de los pasos en pantalla
039100040419     ?*       para proceder al salto.
039200040419     D paso_p          s              1a   dim(16)
039300040419     ?* SALTO: Tiene, según la selección del paso "Ir a...".
039400040419     ?*        Cada entrada 1/2 : Paso al que saltar.
039500040419     ?*                     3/17: Seteo de pasos en PAWP310.
039600040419     D salto           s             17a   dim(16) ctdata perrcd(1)
039700140213      *
039800140904     D ufact           s              8  0
039900140905     D e_code          s             10a
040000140905     D ufact_spol      s              9  0
040100140905
040200140905      *
040300140411      /copy HDIILE/qcpybooks,SVPVRENO_H
040400140905      /copy hdiile/qcpybooks,mail_h
040500140213      *
040600021205     ?*****************************************************************
040700020506     Ip1wemi01
040800020506     I              x1empr                      m1empr
040900020506     I              x1sucu                      m1sucu
041000020506     I              x1npro                      m1npro
041100020506     I              x1arcd                      m1arcd
041200020506     I              x1spo1                      m1spo1
041300020506     I              x1arcn                      m1arcn
041400020506     I              x1spol                      m1spol
041500020506     I              x1tiou                      m1tiou
041600040419     ?*-
041700040419     Ipar310lk
041800040419     I              xlwp00                      paso_p(01)
041900040419     I              xlwp01                      paso_p(02)
042000040419     I              xlwp02                      paso_p(03)
042100040419     I              xlwp03                      paso_p(04)
042200040419     I              xlwp04                      paso_p(05)
042300040419     I              xlwp05                      paso_p(06)
042400040419     I              xlwp06                      paso_p(07)
042500040419     I              xlwp07                      paso_p(08)
042600040419     I              xlwp08                      paso_p(09)
042700040419     I              xlwp09                      paso_p(10)
042800040419     I              xlwp10                      paso_p(11)
042900040419     I              xlwp11                      paso_p(12)
043000040419     I              xlwp12                      paso_p(13)
043100040419     I              xlwp13                      paso_p(14)
043200040419     I              xlwp14                      paso_p(15)
043300040419     I              xlwp15                      paso_p(16)
043400021205     ?*-
043500040419     Ip1wp310
043600040419     I              z0wp01lk                    paso(01)
043700040419     I              z0wp02lk                    paso(02)
043800040419     I              z0wp03lk                    paso(03)
043900040419     I              z0wp04lk                    paso(04)
044000040419     I              z0wp05lk                    paso(05)
044100040419     I              z0wp06lk                    paso(06)
044200040419     I              z0wp07lk                    paso(07)
044300040419     I              z0wp08lk                    paso(08)
044400040419     I              z0wp09lk                    paso(09)
044500040419     I              z0wp10lk                    paso(10)
044600040419     I              z0wp11lk                    paso(11)
044700040419     I              z0wp12lk                    paso(12)
044800040419     I              z0wp13lk                    paso(13)
044900040419     I              z0wp14lk                    paso(14)
045000040419     I              z0wp15lk                    paso(15)
045100150810     ?*-
045200150810     Is1t901
045300150810     I              t@date                      x@date
045400021205     ?*****************************************************************
045500021205      /SPACE
045600021205     ?*****************************************************************
045700021205     ?*----------------------------------------------------|
045800020506?1b? C                   dou       *inkc                                        ?P----------01
045900040204     ?* Los chequeos que se realizan acá son los siguientes:                    ?            |
046000040204     ?* ADONDE_VOY, preparará la pantalla PANT01 si no se hace algo para que    ?            |
046100040204     ?* el loop no continúe. Hay ciertos casos que no deben provocar el DOU     ?            |
046200040204     ?* si no que deben salir del programa y retornar al llamador.              ?            |
046300040204     ?* Con XXIDEN = 3, 4 o 6 se evita loopear cuando se ha finalizado hasta    ?            |
046400040204     ?* la confirmación y (sea con Suspendida Especial o Finalización OK)       ?            |
046500040204     ?* hay que volver a llamador; las correspondientes rutinas hacen el        ?            |
046600040204     ?* *ON de *INKC para que se corte el DOU.                                  ?            |
046700040204     ?* DEJAR_SUSPEN indica que desde la lógica de emisión el usuario salió     ?            |
046800040204     ?* con F3 y desea dejar Suspendida la Operación, este es otro caso         ?            |
046900040204     ?* corte del DOU.                                                          ?            |
047000040204?2b? C                   if        por_parametros and                           ?P---------02|
047100040204     C                               xxiden <> 3  and                           ?           ||
047200040204     C                               xxiden <> 4  and                           ?           ||
047300040204     C                               xxiden <> 6  and                           ?           ||
047400040204     C                               not dejar_suspen                           ?           ||
047500040204     C                   exsr      adonde_voy                                   ?           ||
047600040204?2e? C                   endif                                                  ?F---------02|
047700040204?2b? C                   if        not *inkc                                    ?P---------02|
047800020506?3b? C     xxiden        caseq     1             pant01                         ?P--------03||
047900020506     C     xxiden        caseq     2             pant02                         ?          |||
048000020506     C     xxiden        caseq     3             pant03                         ?          |||
048100020506     C     xxiden        caseq     4             pant04                         ?          |||
048200020506     C     xxiden        caseq     5             pant05                         ?          |||
048300020506     C     xxiden        caseq     6             pant06                         ?          |||
048400020506     C     xxiden        caseq     7             pant07                         ?          |||
048500020506?3e? C                   endcs                                                  ?F--------03||
048600040204?2e? C                   endif                                                  ?F---------02|
048700020506?1e? C                   enddo                                                  ?F----------01
048800020506     ?*- FIN DE PROGRAMA...
048900020506     C                   exsr      srclos
049000020506     C                   seton                                            lr
049100140213     C                   return
049200021205     ?*----------------------------------------------------|
049300991217     ?******************************************************
049400021205      /SPACE
049500021205     ?******************************************************
049600020506     C     *inzsr        begsr
049700020506     ?** INICIO DE PROGRAMA -------------------------------
049800040204     ?* Listas de parámetros.
049900040204     ?* PAR310C/X - Version estándar (SIN PARAMETROS ADICIONALES)
050000040204     ?*             Speedway.
050100040204     C     $l310cstd     plist
050200040204     C                   parm                    usempr
050300040204     C                   parm                    ussucu
050400040204     C                   parm                    w0arcd
050500040204     C                   parm                    w0spo1
050600040204     C                   parm                    w0spol
050700040204     C                   parm                    w0sspo
050800040204     C                   parm      *blanks       @@mand
050900040204     C                   parm      *blanks       endpgm
051000040204     ?* PAR310C/X - Version Speedway (CON PARAMETROS ADICIONALES)
051100040204     ?*             Speedway.
051200040204     C     $l310cpar     plist
051300040204     C                   parm                    usempr
051400040204     C                   parm                    ussucu
051500040204     C                   parm                    w0arcd
051600040204     C                   parm                    w0spo1
051700040204     C                   parm                    w0spol
051800040204     C                   parm                    w0sspo
051900040204     C                   parm      *blanks       @@mand
052000040204     C                   parm      *blanks       endpgm
052100040204     C                   parm                    por_parametros
052200040204     C                   parm                    iinivc
052300040204     C                   parm                    iiasen
052400040204     C                   parm                    iifvde
052500040204     C                   parm                    iifpro
052600020506     ?*- DEFINICION DE CAMPOS...
052700020506     ?*- DEFINICIONES GENERALES...
052800020506     C                   eval      sf1rrn = *zeros
052900020506     C                   eval      @@lsf1 = 10
053000020506     ?*- CAMPOS DE PANTALLA 01...
053100020506     ?*- CAMPOS DE PANTALLA 05...
053200020506     ?*- CAMPOS DE PANTALLA 07...
053300020506     ?*- OTROS CAMPOS...
053400020506     ?*- CAMPOS PARA LA CONSULTA DE PRODUCCION...
053500020506     C                   eval      znomb = *blanks
053600020506     C                   eval      zpoli = *zeros
053700020506     C                   eval      znrcu = *zeros
053800020506     C                   eval      znrsc = *zeros
053900020506     C                   eval      zorde = *blanks
054000020506     C                   eval      zmepg = 'A'
054100020506     C                   eval      zpsec = *zeros
054200020506     C                   eval      zretn = *blanks
054300020506     ?*- DEFINICION DE CLAVES P/ACCESO A ARCHIVOS ...
054400020506     ?*- GNTPGM...
054500020506     C     k1@pgm        klist
054600020506     C                   kfld                    pgausu
054700020506     C                   kfld                    pgtsbs
054800020506     C                   kfld                    pgipgm
054900020506     C     k1t620        klist
055000020506     C                   kfld                    x1arcd
055100020506     C     k1t630        klist
055200020506     C                   kfld                    x1arcd
055300020506     C     k16301        klist
055400020506     C                   kfld                    x1arcd
055500020506     C                   kfld                    vsuser
055600020506     C     k1t901        klist
055700020506     C                   kfld                    x1tiou
055800020506     C                   kfld                    x1stou
055900020506     C     k1t990        klist
056000020506     C                   kfld                    usempr
056100020506     C                   kfld                    ussucu
056200020506     C                   kfld                    x1arcd
056300020506     C     k1t001        klist
056400020506     C                   kfld                    z0rama
056500020506     C     k1@ec0        klist
056600020506     C                   kfld                    usempr
056700020506     C                   kfld                    ussucu
056800020506     C                   kfld                    x1arcd
056900020506     C                   kfld                    x1spo1
057000040204     C     k2@ec0        klist
057100040204     C                   kfld                    usempr
057200040204     C                   kfld                    ussucu
057300040204     C                   kfld                    x1arcd
057400040204     C                   kfld                    iispol
057500040204     C     ktestpc0      klist
057600040204     C                   kfld                    usempr
057700040204     C                   kfld                    ussucu
057800040204     C                   kfld                    x1arcd
057900040204     C                   kfld                    testspol
058000040204     C     k1pawpc098    klist
058100040204     C                   kfld                    iisoln
058200040204     C                   kfld                    usempr
058300040204     C                   kfld                    ussucu
058400040204     C                   kfld                    iiarcd
058500020506     C     k1@ec1        klist
058600020506     C                   kfld                    usempr
058700020506     C                   kfld                    ussucu
058800020506     C                   kfld                    x1arcd
058900020506     C                   kfld                    x1spo1
059000020506     C     k2@ec1        klist
059100020506     C                   kfld                    w0empr
059200020506     C                   kfld                    w0sucu
059300020506     C                   kfld                    w0arcd
059400020506     C                   kfld                    w0spol
059500020506     C                   kfld                    w0sspo
059600150313     C     k3@ec1        klist
059700150313     C                   kfld                    d0empr
059800150313     C                   kfld                    d0sucu
059900150313     C                   kfld                    d0arcd
060000150313     C                   kfld                    d0spol
060100150313     C                   kfld                    d0sspo
060200020506     C     k1@ec4        klist
060300020506     C                   kfld                    w0empr
060400020506     C                   kfld                    w0sucu
060500020506     C                   kfld                    w0arcd
060600020506     C                   kfld                    w0spol
060700020506     C                   kfld                    w0sspo
060800020506     C     k1@pc0        klist
060900020506     C                   kfld                    usempr
061000020506     C                   kfld                    ussucu
061100020506     C                   kfld                    w0arcd
061200020506     C                   kfld                    w0spo1
061300020506     C     k2@pc0        klist
061400020506     C                   kfld                    usempr
061500020506     C                   kfld                    ussucu
061600020506     C                   kfld                    x2arcd
061700020506     C                   kfld                    x2spo1
061800020506     C     k3@pc0        klist
061900020506     C                   kfld                    usempr
062000020506     C                   kfld                    ussucu
062100020506     C     k4@pc0        klist
062200020506     C                   kfld                    usempr
062300020506     C                   kfld                    ussucu
062400020506     C                   kfld                    xxarcd
062500020506     C                   kfld                    xxspo1
062600020506     C     k5@pc0        klist
062700020506     C                   kfld                    usempr
062800020506     C                   kfld                    ussucu
062900020506     C                   kfld                    x7arcd
063000020506     C                   kfld                    x7spol
063100020506     C     k6@pc0        klist
063200020506     C                   kfld                    usempr
063300020506     C                   kfld                    ussucu
063400020506     C                   kfld                    m1arcn
063500020506     C                   kfld                    m1spol
063600020506     C     k1@pd0        klist
063700020506     C                   kfld                    w0empr
063800020506     C                   kfld                    w0sucu
063900020506     C                   kfld                    w0arcd
064000020506     C                   kfld                    w0spo1
064100020506     C                   kfld                    w0spol
064200020506     C                   kfld                    w0sspo
064300020506     C     k2@pd0        klist
064400020506     C                   kfld                    w0empr
064500020506     C                   kfld                    w0sucu
064600020506     C                   kfld                    w0arcd
064700020506     C                   kfld                    w0spo1
064800020506     C                   kfld                    w0spol
064900020506     C                   kfld                    w0sspo
065000020506     C                   kfld                    z0rama
065100020506     C                   kfld                    z0arse
065200020506     C                   kfld                    z0oper
065300020506     C                   kfld                    z0suop
065400150810     C     k3@pd0        klist
065500150810     C                   kfld                    w0empr
065600150810     C                   kfld                    w0sucu
065700150810     C                   kfld                    w0arcd
065800150810     C                   kfld                    w0spo1
065900150810     C                   kfld                    w0spol
066000150810     C                   kfld                    w0sspo
066100150811     C                   kfld                    t$rama
066200150811     C                   kfld                    t$arse
066300020506     ?*- PAWKL1...
066400020506     C     k1@kl1        klist
066500020506     C                   kfld                    usempr
066600020506     C                   kfld                    ussucu
066700020506     C                   kfld                    x1arcd
066800020506     C                   kfld                    x1spo1
066900020506     ?*- PAHED004...
067000020506     C     k1@ed0        klist
067100020506     C                   kfld                    usempr
067200020506     C                   kfld                    ussucu
067300020506     C                   kfld                    x5rama
067400020506     C                   kfld                    x5poli
067500020506     C     k2@ed0        klist
067600020506     C                   kfld                    w0empr
067700020506     C                   kfld                    w0sucu
067800020506     C                   kfld                    w0arcd
067900020506     C                   kfld                    w0spol
068000020506     C                   kfld                    w0sspo
068100140904     ?* Clave para buscar la última fecha de facturación. Usada solo para
068200140904     ?* speedway v2 en refacturaciones
068300140904     C     k3@ed0        klist
068400140904     C                   kfld                    usempr
068500140904     C                   kfld                    ussucu
068600140904     C                   kfld                    iiarcd
068700140905     C                   kfld                    ufact_spol
068800020510     ?* GTI98001...
068900020510     C     k1gti98001    klist
069000020510     C                   kfld                    w0empr
069100020510     C                   kfld                    w0sucu
069200020510     C                   kfld                    w0arcd
069300020510     C                   kfld                    w0spol
069400020510     C                   kfld                    w0sspo
069500030122     ?* GTI98001...
069600030122     C     k1t980        klist
069700030122     C                   kfld                    usempr
069800030122     C                   kfld                    ussucu
069900030122     C                   kfld                    x1arcd
070000030122     C                   kfld                    x1spo1
070100070308     ?* GTI98009...
070200070308     C     k1t98009      klist
070300070308     C                   kfld                    usempr
070400070308     C                   kfld                    ussucu
070500070308     C                   kfld                    iiarcd
070600070308     C                   kfld                    iisoln
070700140927     ?* PAHCP0...
070800140927     C     k1hcp0        klist
070900140927     C                   kfld                    p0empr
071000140927     C                   kfld                    p0sucu
071100140927     C                   kfld                    p0cobn
071200020506     ?*- TESTEO DE LA SEGURIDAD DEL PROGRAMA...
071300020506     C                   eval      pgausu = vsuser
071400020506     C                   eval      pgtsbs = 21
071500020506     C                   movel     'PAR310A'     pgipgm
071600020506     C     k1@pgm        chain     g1tpgm                             20
071700020506     C   20              eval      pgtsbs = 01
071800020506     C   20k1@pgm        chain     g1tpgm                             20
071900020506     ?*- SI NO ENCUENTRA REGISTRO PRESUPONE HABILITADO...
072000020506     ?*- SOLO PARA CONSULTAS...
072100020506?1b? C                   if        *in20                                        ?P----------01
072200020506     C                   eval      pgtalt = 'N'                                 ?            |
072300020506     C                   eval      pgtbaj = 'N'                                 ?            |
072400020506     C                   eval      pgtcam = 'N'                                 ?            |
072500020506     C                   eval      pgtcon = 'S'                                 ?            |
072600020506     ?*- NIVEL DE SEGURIDAD...                                                  ?            |
072700020506     C     pgnaut        comp      5                                  05  05    ?            |
072800020506?1e? C                   endif                                                  ?F----------01
072900040204     ?*- Determina si trabaja por parámetros (p.ej. SPDWY) o no.
073000040204     C                   eval      por_parametros = (%parms > *zeros)
073100040204     ?* Recupera fecha de arranque SPDWY V2.
073200150223     C                   call      'SPINISPW'
073300150220     C                   parm                    fecha_spdwy
073400040204     ?* Bandera para ver si ya arrancó Speedway Versión 2.
073500040204     C                   call      'PAR310X3'
073600040204     C                   parm                    usempr
073700040204     C                   parm      *zeros        @1fema
073800040204     C                   parm      *zeros        @1femm
073900040204     C                   parm      *zeros        @1femd
074000040204
074100040204     C                   eval      p@1aÑo = @1fema
074200040204     C                   eval      p@1mes = @1femm
074300040204     C                   eval      p@1dia = @1femd
074400040204     C                   eval      antes_spdwy = (p@famd < fecha_spdwy)
074500020506     ?*- PARA EMITIR PANTALLA 0...
074600020506     ?*- INGRESAR POR OPERACION NUEVA...
074700020506     C                   exsr      borr01
074800020506     C                   exsr      defe01
074900020506     C                   seton                                            09
075000020506     C                   eval      xxiden = 1
075100020506     ?*- NOMBRE DE EMPRESA/SUCURSAL...
075200020506     C                   call      'SP0000'
075300020506     C                   parm                    @@emsu           80
075400020506     C                   movel     @@emsu        xxemsu
075500020506     ?*-
075600020506     C                   endsr
075700991217     ?******************************************************
075800021205      /SPACE
075900021205     ?******************************************************
076000020506     C     pant01        begsr
076100020506     ?** PROCESO PANTALLA '1' -----------------------------
076200020506     ?*- ENTRADA/SALIDA PANTALLA '1' ...
076300020506     C                   exfmt     par31001
076400020506     ?*- CORRIGE SITUACIONES DE ERROR ...
076500140213     C                   EVAL      *IN07 = '0'
076600020506     C                   exsr      apagar
076700040204     ?* Si hubo errores en los parámetros (subrutina ADONDE_VOY)
076800040204     ?* se fuerza F3 para finalizar.
076900040204?1b? C                   if        hay_error_parm                               ?P----------01
077000040204     C                   eval      *inkc = *on                                  ?            |
077100040204?1e? C                   endif                                                  ?F----------01
077200020506     ?*- PROCESA TECLAS DE FUNCION...
077300020506?1b? C                   select                                                 ?P----------01
077400020506     ?*- F3=SALIR...                                                            ?            |
077500020506?1x? C                   when      *inkc                                        ?w----------01
077600020506     ?*- F4=SOLICITUD...                                                        ?            |
077700020506?1x? C                   when      *inkd                                        ?w----------01
077800020506     C                   exsr      soli01                                       ?            |
077900020506     ?*- F8=RAMA/POLIZA...                                                      ?            |
078000020506?1x? C                   when      *inkh                                        ?w----------01
078100020506     C                   clear                   x5rama                         ?            |
078200020506     C                   clear                   x5ramd                         ?            |
078300020506     C                   clear                   x5poli                         ?            |
078400020506     C                   eval      xxiden = 5                                   ?            |
078500020506     ?*- F9=CAMBIAR FORMA DE INGRESO...                                         ?            |
078600020506?1x? C                   when      *inki                                        ?w----------01
078700020506     C                   exsr      camb01                                       ?            |
078800020506     ?*- PULSA INTRO...                                                         ?            |
078900020506?1x? C                   when      not *in29                                    ?w----------01
079000020506     C                   exsr      vali01                                       ?            |
079100020506?1e? C                   endsl                                                  ?F----------01
079200020506     ?*
079300020506     C                   endsr
079400991217     ?******************************************************
079500021205      /SPACE
079600021205     ?******************************************************
079700020506     C     camb01        begsr
079800020506     ?** CAMBIAR FORMA DE INGRESO--------------------------
079900020506?1b? C                   select                                                 ?P----------01
080000020506?1x? C                   when      *in09                                        ?w----------01
080100020506     C                   setoff                                           09    ?            |
080200020506?1x? C                   when      not *in09                                    ?w----------01
080300020506     C                   seton                                            09    ?            |
080400020506?1e? C                   endsl                                                  ?F----------01
080500020506     ?*- BORRAR Y REEMITIR PANTALLA...
080600020506     C                   exsr      borr01
080700020506     C                   exsr      defe01
080800020506     ?*-
080900020506     C                   endsr
081000991217     ?******************************************************
081100021205      /SPACE
081200021205     ?******************************************************
081300020506     C     borr01        begsr
081400020506     ?** BORRADO PANTALLA 01-------------------------------
081500020506     C                   clear                   x1tiou
081600020506     C                   clear                   x1stou
081700020506     C                   clear                   x1arcd
081800020506     C                   clear                   x1arno
081900020506     C                   clear                   x1spo1
082000020506     ?*-
082100020506     C                   clear                   $$tiou
082200020506     C                   clear                   $$stou
082300020506     C                   clear                   $$arcd
082400020506     C                   clear                   $$spo1
082500020506     ?*-
082600020506     C                   setoff                                           90
082700020506     ?*-
082800020506     C                   endsr
082900021205     ?******************************************************
083000021205      /SPACE
083100991217     ?******************************************************
083200020506     C     soli01        begsr
083300020506     ?** SOLICITUD EN PANTALLA 01--------------------------
083400020506     ?* solicitud en operación nueva y función endosos...
083500020506?1b? C                   if        @@camp = 'X1ARCD'  and                       ?P----------01
083600020506     C                             *in09  and                                   ?            |
083700020506     C                             x1tiou = 3  or                               ?            |
083800020506     C                             @@camp = 'X1SPO1'  and                       ?            |
083900020506     C                             *in09  and                                   ?            |
084000020506     C                             x1tiou = 3  or                               ?            |
084100020506     C                             @@camp = 'X1ARCD'  and                       ?            |
084200020506     C                             *in09  and                                   ?            |
084300020506     C                             x1tiou = 5  or                               ?            |
084400020506     C                             @@camp = 'X1SPO1'  and                       ?            |
084500020506     C                             *in09  and                                   ?            |
084600020506     C                             x1tiou = 5                                   ?            |
084700020506     C                   call      'PAR100'                                     ?            |
084800020506     C                   parm      *zeros        x1arcd                         ?            |
084900020506     C                   parm      *zeros        x1spo1                         ?            |
085000020506     C                   parm      *zeros        zsspo                          ?            |
085100020506     C                   parm      *zeros        zrama                          ?            |
085200020506     C                   parm      *zeros        zarse                          ?            |
085300020506     C                   parm      *zeros        zoper                          ?            |
085400020506     C                   parm      *zeros        zsuop                          ?            |
085500020506     C                   parm      *blanks       znomb                          ?            |
085600020506     C                   parm      *zeros        zcert                          ?            |
085700020506     C                   parm      *zeros        zpoli                          ?            |
085800020506     C                   parm      *zeros        znrcu                          ?            |
085900020506     C                   parm      *zeros        znrsc                          ?            |
086000020506     C                   parm      *blanks       zorde                          ?            |
086100020506     C                   parm      'A'           zmepg                          ?            |
086200020506     C                   parm      *zeros        zpsec                          ?            |
086300020506     C                   parm      *zeros        zasen                          ?            |
086400020506     C                   parm      *zeros        zcbrn                          ?            |
086500020506     C                   parm      *zeros        zczco                          ?            |
086600020506     C                   parm      *blanks       zretn                          ?            |
086700020506?1e? C                   endif                                                  ?F----------01
086800020506     ?* tipo de operación...
086900020506?1b? C                   if        @@camp = 'X1TIOU'  or                        ?P----------01
087000020506     C                             @@camp = 'X1STOU'  and                       ?            |
087100020506     C                             *in09                                        ?            |
087200020506     C                   eval      c901 = 'L'                                   ?            |
087300020506     C                   call      'DBA9011'                                    ?            |
087400020506     C                   parm                    x1tiou                         ?            |
087500020506     C                   parm                    x1stou                         ?            |
087600020506     C                   parm                    p@stos            2 0          ?            |
087700020506     C                   parm                    p@dsop           20            ?            |
087800020506     C                   parm      *blanks       endpgm                         ?            |
087900020506?1e? C                   endif                                                  ?F----------01
088000020506     ?* artículos...
088100020506?1b? C                   if        @@camp = 'X1ARCD'  and                       ?P----------01
088200020506     C                             *in09  and                                   ?            |
088300020506     C                             x1tiou <> 3                                  ?            |
088400020506     C                   call      'DBA620A2'                                   ?            |
088500020506     C                   parm                    x1arcd                         ?            |
088600020506     C                   parm                    x1arno                         ?            |
088700020506?1e? C                   endif                                                  ?F----------01
088800020506     ?* operaciones suspendidas...
088900020506?1b? C                   if        @@camp = 'X1SPO1'  and                       ?P----------01
089000020506     C                             not *in09  or                                ?            |
089100020506     C                             @@camp = 'X1ARCD'  and                       ?            |
089200020506     C                             not *in09                                    ?            |
089300020506     C     k3@pc0        setll     p1wpc001                                     ?            |
089400020506     C                   exsr      sf1car                                       ?            |
089500020506     C   30              eval      xxiden = 2                                   ?            |
089600020506     C  n30              eval      xxiden = 1                                   ?            |
089700020506     C  n30              z-add     70            @e                   50        ?            |
089800020506     ?*- SI EXISTEN ERRORES...                                                  ?            |
089900020506?2b? C                   if        *in50  and                                   ?P---------02|
090000020506     C                             @e <> *zeros                                 ?           ||
090100020506     C                   setoff                                           90    ?           ||
090200020506     C                   write     par31001                                     ?           ||
090300020506     C                   eval      *in(@e) = '1'                                ?           ||
090400020506?2e? C                   endif                                                  ?F---------02|
090500020506?1e? C                   endif                                                  ?F----------01
090600020506     ?*-
090700020506     C                   endsr
090800991217     ?******************************************************
090900021205      /SPACE
091000021205     ?******************************************************
091100020506     C     defe01        begsr
091200020506     ?** DATOS POR DEFECTO PANTALLA 01---------------------
091300040204?1b? C                   select                                                 ?P----------01
091400040204?1x? C                   when      por_parametros                               ?w----------01
091500040204     C                   eval      x1tiou = iitiou                              ?            |
091600040204     C                   eval      x1stou = iistou                              ?            |
091700040204?1x? C                   other                                                  ?w----------01
091800020506     C                   eval      x1tiou = 1                                   ?            |
091900020506     C                   eval      x1stou = *zeros                              ?            |
092000040204?1e? C                   endsl                                                  ?F----------01
092100020506     ?*-
092200020506     C                   endsr
092300991217     ?******************************************************
092400021205      /SPACE
092500021205     ?******************************************************
092600020506     C     vali01        begsr
092700020506     ?** GRABACION PANTALLA 00-----------------------------
092800020508     ?*- VALIDACION FUNCION DE EMISION...
092900040204     C                   eval      no_es_spdwy = *off
093000040204     C                   eval      es_version1 = *off
093100040204     C                   eval      es_version2 = *off
093200020508     ?*- SOLO OPERACIONES NUEVAS...
093300020506?1b? C                   if        *in09                                        ?P----------01
093400020506?2b? C                   if        x1tiou <> 1  and                             ?P---------02|
093500020506     C                             x1tiou <> 2  and                             ?           ||
093600020506     C                             x1tiou <> 3  and                             ?           ||
093700020506     C                             x1tiou <> 5                                  ?           ||
093800020506     C                   seton                                        50        ?           ||
093900020506     C                   eval      @e = 51                                      ?           ||
094000020506?2e? C                   endif                                                  ?F---------02|
094100020506?1e? C                   endif                                                  ?F----------01
094200020506     ?*- SUBTIPO DE OPERACION DEBE CORRESPONDER...
094300020506     ?*- SOLO OPERACIONES NUEVAS...
094400020506?1b? C                   if        not *in50  and                               ?P----------01
094500020506     C                             *in09  and                                   ?            |
094600020506     C                             x1tiou <= 2  and                             ?            |
094700020506     C                             x1stou > *zeros                              ?            |
094800020506     C                   seton                                        50        ?            |
094900020506     C                   eval      @e = 52                                      ?            |
095000020506?1e? C                   endif                                                  ?F----------01
095100020506     ?*- SUBTIPO DE OPERACION DEBE EXISTIR...
095200020506     ?*- SOLO OPERACIONES NUEVAS...
095300020506?1b? C                   if        not *in50  and                               ?P----------01
095400020506     C                             *in09  and                                   ?            |
095500020506     C                             x1tiou >= 3                                  ?            |
095600020506     C     k1t901        chain     s1t901                             20        ?            |
095700020506     C   20              seton                                        50        ?            |
095800020506     C   20              eval      @e = 53                                      ?            |
095900020506?1e? C                   endif                                                  ?F----------01
096000020506     ?*- SUBTIPO DE OPERACION NO DEBE SER ENDOSO DE
096100020506     ?*- ANULACION DE ENDOSO...
096200020506     ?*- SOLO OPERACIONES NUEVAS...
096300020506?1b? C                   if        not *in50  and                               ?P----------01
096400020506     C                             *in09  and                                   ?            |
096500020506     C                             x1tiou = 3  and                              ?            |
096600020506     C                             t@stos = 09                                  ?            |
096700020506     C                   seton                                        50        ?            |
096800020506     C                   eval      @e = 81                                      ?            |
096900020506?1e? C                   endif                                                  ?F----------01
097000020506     ?*- CODIGO DE ARTICULO...
097100020506     ?*- NUEVAS Y SUSPENDIDAS...
097200020506?1b? C                   if        not *in50                                    ?P----------01
097300020506     C     k1t620        chain     s1t620                             20        ?            |
097400020506     C   20              eval      x1arno = *blanks                             ?            |
097500020506     C   20              seton                                        50        ?            |
097600020506     C   20              eval      @e = 54                                      ?            |
097700020506     C  n20              eval      x1arno = t@arno                              ?            |
097800020506     C  n20t@opsn        comp      'N'                                    20    ?            |
097900020506     C   20              seton                                        50        ?            |
098000020506     C   20              eval      @e = 54                                      ?            |
098100020506?1e? C                   endif                                                  ?F----------01
098200040204     ?* Busco parámetros del Artículo.
098300020506?1b? C                   if        not *in50                                    ?P----------01
098400040204     C     k1t630        chain     set630                                       ?            |
098500040204?2b? C                   if        %found(set630)                               ?P---------02|
098600040204     ?* Versiones Speedway.                                                     ?           ||
098700040204     C                   eval      no_es_spdwy = (t@ma44 = '0')                 ?           ||
098800040204     C                   eval      es_version1 = (t@ma44 = '1')                 ?           ||
098900040204     C                   eval      es_version2 = (t@ma44 = '2')                 ?           ||
099000040204     ?*- NO AUTORIZADO PARA EL ARTICULO...                                      ?           ||
099100040204?3b? C                   if        t@ma34 = '1'                                 ?P--------03||
099200040204     C     k16301        chain     set6301                            20        ?          |||
099300040204     C   20              seton                                        50        ?          |||
099400040204     C   20              eval      @e = 54                                      ?          |||
099500040204?3e? C                   endif                                                  ?F--------03||
099600040204     ?* Controles condicionados a que haya o no arrancado Speedway.             ?           ||
099700040204?3b? C                   if        not *in50                                    ?P--------03||
099800040204?4b? C                   select                                                 ?P-------04|||
099900040204     ?* ANTES del comienzo de Speedway                                          ?         ||||
100000040204?4x? C                   when      antes_spdwy                                  ?w-------04|||
100100040204     ?* No empezó V2 aunque el artículo está definido OK, se lo debe            ?         ||||
100200040204     ?* llamar en forma estándar.                                               ?         ||||
100300040204?5b? C                   if        por_parametros and                           ?P------05||||
100400040204     C                             es_version2                                  ?        |||||
100500040204     C                   z-add     69            @e                   50        ?        |||||
100600040204?5e? C                   endif                                                  ?F------05||||
100700040204     ?* DESPUES del comienzo de Speedway                                        ?         ||||
100800040204?4x? C                   other                                                  ?w-------04|||
100900040204     ?* El artículo debe estar habilitado para Speedway versión '2'             ?         ||||
101000040204     ?* si llega con parámetros.                                                ?         ||||
101100040204?5b? C                   if        por_parametros and                           ?P------05||||
101200040204     C                             not es_version2                              ?        |||||
101300040204     C                   z-add     69            @e                   50        ?        |||||
101400040204?5e? C                   endif                                                  ?F------05||||
101500040204     ?* Si se usa desde "verde" estando el artículo marcado como V2,            ?         ||||
101600040204     ?* no pueden hacerse pólizas nuevas (1) ni renovaciones (2).               ?         ||||
101700040204?5b? C                   if        not por_parametros and es_version2           ?P------05||||
101800040204?6b? C                   if        x1tiou = 1 or x1tiou =2                      ?P-----06|||||
101900040204     C                   z-add     87            @e                   50        ?       ||||||
102000040204?6e? C                   endif                                                  ?F-----06|||||
102100040204     ?* Si se usa desde "verde" y se intentan hacer endosos (3), estos no       ?        |||||
102200040204     ?* pueden realizarse si se trata de una póliza que este grabada en         ?        |||||
102300040204     ?* GTI980, ya que la misma debe tratarse desde Speedway.                   ?        |||||
102400040204?6b? C                   if        x1tiou = 3                                   ?P-----06|||||
102500040805     ?* En este punto, no pueden ser VIDA (Ver Procedimiento)                   ?       ||||||
102600040805?7b? C                   if        es_vida                                      ?P----07||||||
102700040805     C                   z-add     86            @e                   50        ?      |||||||
102800040805?7x? C                   else                                                   ?X....07||||||
102900040204     C     k1t980        chain     gti98001                                     ?      |||||||
103000040204?8b? C                   if        %found                                       ?P---08|||||||
103100040204     C                   z-add     86            @e                   50        ?     ||||||||
103200040204?8e? C                   endif                                                  ?F---08|||||||
103300040204?7e? C                   endif                                                  ?F----07||||||
103400040805?6e? C                   endif                                                  ?F-----06|||||
103500040204?5e? C                   endif                                                  ?F------05||||
103600040204?4e? C                   endsl                                                  ?F-------04|||
103700040204?3e? C                   endif                                                  ?F--------03||
103800040204?2e? C                   endif                                                  ?F---------02|
103900040204?1e? C                   endif                                                  ?F----------01
104000020506     ?*- FUNCION=1 NO INGRESA NUMERO DE SUPERPOLIZA...
104100020506     ?*- SOLO OPERACIONES NUEVAS...
104200020506?1b? C                   if        not *in50  and                               ?P----------01
104300020506     C                             *in09  and                                   ?            |
104400020506     C                             x1tiou = 1  and                              ?            |
104500020506     C                             x1spo1 <> *zeros                             ?            |
104600020506     C                   seton                                        50        ?            |
104700020506     C                   eval      @e = 55                                      ?            |
104800020506?1e? C                   endif                                                  ?F----------01
104900020506     ?*- VALIDACIONES PARA FUNCION 2/3...
105000020506     ?*- SOLO OPERACIONES NUEVAS...
105100020506?1b? C                   if        not *in50  and                               ?P----------01
105200020506     C                             *in09  and                                   ?            |
105300020506     C                             x1tiou = 2  or                               ?            |
105400020506     C                             not *in50  and                               ?            |
105500020506     C                             *in09  and                                   ?            |
105600020506     C                             x1tiou = 3                                   ?            |
105700020506     C     k1@ec0        chain     p1hec0                             20        ?            |
105800020506?2b? C                   select                                                 ?P---------02|
105900020506     ?*- NO EXISTE SUPERPOLIZA...                                               ?           ||
106000020506?2x? C                   when      *in20                                        ?w---------02|
106100020506     C                   seton                                        50        ?           ||
106200020506     C                   eval      @e = 56                                      ?           ||
106300020506     ?*- YA ESTA RENOVADA...                                                    ?           ||
106400020506     ?* solo controlo para función 2...                                         ?           ||
106500020506?2x? C                   when      not *in20  and                               ?w---------02|
106600020506     C                             c0spon > *zeros  and                         ?           ||
106700020506     C                             x1tiou = 2                                   ?           ||
106800020506     C                   seton                                        50        ?           ||
106900020506     C                   eval      @e = 57                                      ?           ||
107000020506     ?*- YA ESTA ANULADA...                                                     ?           ||
107100020506?2x? C                   when      not *in20  and                               ?w---------02|
107200020506     C                             c0econ <> '0'                                ?           ||
107300020506     C                   seton                                        50        ?           ||
107400020506     C                   eval      @e = 58                                      ?           ||
107500020506?2e? C                   endsl                                                  ?F---------02|
107600020506?1e? C                   endif                                                  ?F----------01
107700020506     ?*- VALIDACIONES PARA FUNCION 2...
107800140213      * Verifica si es renovable.
107900140213     c                   if        not *in50 and x1tiou = 2
108000140214     c                   if        not SVPVRENO_SuperPolizaRenovable(usempr:
108100140214     c                                                               ussucu:
108200140218     C                                                               x1arcd:
108300140214     C                                                               x1spo1)
108400140213     c                   eval      *in50 = '1'
108500140214     C                   eval      @e = 7                                       ?           ||
108600140213     c                   endif
108700140213     c                   endif
108800020506     ?*- SE INFORMA POLIZA A RENOVAR CON SALDO PENDIENTE DE
108900020506     ?*- PAGO...
109000020506?1b? C                   if        not *in50                                    ?P----------01
109100020508?2b? C                   if        x1tiou = 2                                   ?P---------02|
109200020506     C                   call      'SP00195'                                    ?           ||
109300020506     C                   parm                    x1arcd                         ?           ||
109400020506     C                   parm                    x1spo1                         ?           ||
109500020506     C                   parm      *zeros        @@sald           15 2          ?           ||
109600020506     C                   parm                    @@finp            3            ?           ||
109700020506?3b? C                   if        @@sald > 0                                   ?P--------03||
109800020506     C                   seton                                        64        ?          |||
109900020506?3e? C                   endif                                                  ?F--------03||
110000020506?2e? C                   endif                                                  ?F---------02|
110100020508?1e? C                   endif                                                  ?F----------01
110200020506     ?*
110300020506     ?*- VALIDACIONES PARA FUNCION 5...
110400020506     ?*- SOLO OPERACIONES NUEVAS...
110500020506?1b? C                   if        not *in50  and                               ?P----------01
110600020506     C                             *in09  and                                   ?            |
110700020506     C                             x1tiou = 5                                   ?            |
110800020506     C     k1@ec0        chain     p1hec0                             20        ?            |
110900020506?2b? C                   select                                                 ?P---------02|
111000020506     ?*- NO EXISTE SUPERPOLIZA...                                               ?           ||
111100020506?2x? C                   when      *in20                                        ?w---------02|
111200020506     C                   z-add     56            @e                   50        ?           ||
111300020506     ?*- NO ESTA ANULADA...                                                     ?           ||
111400020506?2x? C                   when      not *in20  and                               ?w---------02|
111500020506     C                             c0econ = '0'                                 ?           ||
111600020506     C                   z-add     82            @e                   50        ?           ||
111700020506?2e? C                   endsl                                                  ?F---------02|
111800020506?1e? C                   endif                                                  ?F----------01
111900020506     ?*- LA OPERACION ESTA ACTUALMENTE SUSPENDIDA...
112000040204     ?*- FUNCION=1 ¡¡ERROR GRAVE!!, No puede existir una Superpóliza
112100040204     ?*            si nos basamos en el contador del SET990.
112200040204     ?*            Este error fue detectado en Speedway y sirve para
112300040204     ?*            evitar cualquier inconveniente que pueda generar una
112400040204     ?*            cancelación no prevista.
112500040204     ?*- SOLO OPERACIONES NUEVAS...
112600040204?1b? C                   if        not *in50                                    ?P----------01
112700040204     C                             and *in09                                    ?            |
112800040204     C                             and x1tiou = 1                               ?            |
112900040204     C     k1t990        chain(n)  set990                                       ?            |
113000040204?2b? C                   if        %found                                       ?P---------02|
113100040204     C                   eval      testspol = t@spol + 1                        ?           ||
113200040204     C     ktestpc0      setll     pawpc001                               50    ?           ||
113300040204?3b? C                   if        *in50                                        ?P--------03||
113400040204     C                   eval      @e = 77                                      ?          |||
113500040204?3e? C                   endif                                                  ?F--------03||
113600040204?2e? C                   endif                                                  ?F---------02|
113700040204?1e? C                   endif                                                  ?F----------01
113800040204     ?*- Resto de Operaciones. PRUEBA POR EL PAWPC001...
113900020506?1b? C                   if        not *in50  and                               ?P----------01
114000020506     C                             *in09  and                                   ?            |
114100020506     C                             x1tiou <> 1                                  ?            |
114200020506     C     k1@ec0        chain(n)  p1wpc001                           20        ?            |
114300020506     C  n20              eval      @e = 59                                      ?            |
114400020506     C  n20              seton                                        50        ?            |
114500020506?1e? C                   endif                                                  ?F----------01
114600020506     ?*- LA OPERACION ESTA ACTUALMENTE SUSPENDIDA...
114700020506     ?*- PRUEBA POR EL PAWPC002...
114800020506?1b? C                   if        not *in50  and                               ?P----------01
114900020506     C                             *in09  and                                   ?            |
115000020506     C                             x1tiou <> 1                                  ?            |
115100020506     C     k1@ec0        chain     p1wpc002                           20        ?            |
115200020506     C  n20              eval      @e = 59                                      ?            |
115300020506     C  n20              seton                                        50        ?            |
115400020506?1e? C                   endif                                                  ?F----------01
115500020506     ?*- LA OPERACION ESTA ACTUALMENTE SUSPENDIDA...
115600020506     ?*- PRUEBA POR EL PAWEMI01...
115700020506?1b? C                   if        not *in50  and                               ?P----------01
115800020506     C                             *in09  and                                   ?            |
115900020506     C                             x1tiou <> 1                                  ?            |
116000020506     C                   setoff                                           99    ?            |
116100020506     C     k1@ec0        setll     p1wemi01                                     ?            |
116200020506?2b? C                   dou       *in99                                        ?P---------02|
116300020506     C     k1@ec0        reade     p1wemi01                               99    ?           ||
116400020506?3b? C                   if        not *in99  and                               ?P--------03||
116500020506     C                             m1tiou = 1                                   ?          |||
116600020506     C     k6@pc0        chain     p1wpc002                           20        ?          |||
116700020506?4b? C                   if        not *in20  and                               ?P-------04|||
116800020506     C                             m1npro = w0npro                              ?         ||||
116900020506     C                   eval      @e = 73                                      ?         ||||
117000020506     C                   seton                                        50        ?         ||||
117100020506?2v? C                   leave                                                  ?         ||||
117200020506?4e? C                   endif                                                  ?F-------04|||
117300020506?3e? C                   endif                                                  ?F--------03||
117400020506?2e? C                   enddo                                                  ?F---------02|
117500020506?1e? C                   endif                                                  ?F----------01
117600020506     ?*- NO EXISTE OPERACION SUSPENDIDA...
117700020506     ?*- SOLO SUSPENDIDAS...
117800020506?1b? C                   if        not *in50  and                               ?P----------01
117900020506     C                             not *in09                                    ?            |
118000020506     C     k1@ec0        chain(n)  p1wpc001                           20        ?            |
118100020506     C   20              seton                                        50        ?            |
118200020506     C   20              eval      @e = 60                                      ?            |
118300020506?1e? C                   endif                                                  ?F----------01
118400020506     ?*- EXISTE PERO ESTA TOMADA POR OTRO TRABAJO...
118500020506     ?*- SOLO SUSPENDIDAS...
118600020506?1b? C                   if        not *in50  and                               ?P----------01
118700020506     C                             not *in09                                    ?            |
118800020506     C     k1@ec0        chain(n)  p1wpc001                           20        ?            |
118900020506?2b? C                   if        not *in20  and                               ?P---------02|
119000020506     C                             w0marp = '3'  or                             ?           ||
119100020506     C                             not *in20  and                               ?           ||
119200020506     C                             w0marp = '4'                                 ?           ||
119300020506     C                   seton                                        50        ?           ||
119400020506     C                   eval      @e = 63                                      ?           ||
119500020506?2e? C                   endif                                                  ?F---------02|
119600020506?1e? C                   endif                                                  ?F----------01
119700020506     ?*- OPERACION TOMADA POR EL PROCESO DE ANULACIONES
119800020506     ?*- CUANDO ESTA SUSPENDIDA...
119900020506?1b? C                   if        not *in50  and                               ?P----------01
120000020506     C                             not *in09                                    ?            |
120100020506     C     k1@kl1        chain     p1wkl1                             20        ?            |
120200020506?2b? C                   if        not *in20                                    ?P---------02|
120300020506     C                   seton                                        50        ?           ||
120400020506     C                   eval      @e = 63                                      ?           ||
120500020506?2e? C                   endif                                                  ?F---------02|
120600020506?1e? C                   endif                                                  ?F----------01
120700020506     ?*- OPERACION TOMADA POR EL PROCESO DE ANULACIONES
120800020506     ?*- SOLO EN ENDOSOS/RENOVACIONES/REHABILITACIONES Y
120900020506     ?*- NO SUSPENDIDAS...
121000020506?1b? C                   if        not *in50  and                               ?P----------01
121100020506     C                             x1tiou >= 2  and                             ?            |
121200020506     C                             *in09                                        ?            |
121300020506     C     k1@kl1        chain     p1wkl1                             20        ?            |
121400020506?2b? C                   if        not *in20                                    ?P---------02|
121500020506     C                   seton                                        50        ?           ||
121600020506     C                   eval      @e = 63                                      ?           ||
121700020506?2e? C                   endif                                                  ?F---------02|
121800020506?1e? C                   endif                                                  ?F----------01
121900020506     ?*- EXISTE PERO NO ESTA AUTORIZADO PARA LA MISMA...
122000020506     ?*- SOLO SUSPENDIDAS QUE NO TENGAN NUMERO DE PROCESO
122100020506     ?* las operaciones suspendidas que tienen numero de
122200020506     ?* proceso son generadas por procesos batch por lo
122300020506     ?* tanto siempre tienen como usuario el operador
122400020506     ?* central por lo que no se puede controlar a nivel
122500020506     ?* de usuario...
122600020506?1b? C                   if        not *in50  and                               ?P----------01
122700020506     C                             not *in09                                    ?            |
122800020506     C     k1@ec0        chain(n)  p1wpc001                           20        ?            |
122900020506?2b? C                   if        not *in20  and                               ?P---------02|
123000020506     C                             w0npro = *zeros  and                         ?           ||
123100020506     C                             vsuser <> w0user  and                        ?           ||
123200020506     C                             pgnaut < 5                                   ?           ||
123300020506     C                   z-add     71            @e                   50        ?           ||
123400020506?2e? C                   endif                                                  ?F---------02|
123500020506?1e? C                   endif                                                  ?F----------01
123600020506     ?*- ARTICULO BLOQUEADO...
123700020506     ?*- NUEVAS Y SUSPENDIDAS...
123800020506?1b? C                   if        not *in50                                    ?P----------01
123900020506?2b? C                   select                                                 ?P---------02|
124000020506?2x? C                   when      t@bloq = '1'                                 ?w---------02|
124100020506     C                   z-add     62            @e                   50        ?           ||
124200020506?2x? C                   when      t@bloq = '2'  and                            ?w---------02|
124300020506     C                             *in09  and                                   ?           ||
124400020506     C                             x1tiou <= 2                                  ?           ||
124500020506     C                   z-add     62            @e                   50        ?           ||
124600020506?2x? C                   when      t@bloq = '2'  and                            ?w---------02|
124700020506     C                             not *in09  and                               ?           ||
124800020506     C                             w0tiou <= 2                                  ?           ||
124900020506     C                   z-add     62            @e                   50        ?           ||
125000020506?2e? C                   endsl                                                  ?F---------02|
125100020506?1e? C                   endif                                                  ?F----------01
125200020506     ?*- OPERACION NO REFACTURABLE...
125300020506     ?*- SOLO NUEVAS...
125400020506?1b? C                   if        not *in50  and                               ?P----------01
125500020506     C                             *in09  and                                   ?            |
125600020506     C                             x1tiou = 3  and                              ?            |
125700020506     C                             t@stos = 01                                  ?            |
125800020506     C     k1@ec0        chain     p1hec0                             20        ?            |
125900020506?2b? C                   if        not *in20  and                               ?P---------02|
126000020506     C                             c0mar1 = '9'                                 ?           ||
126100020506     C                   z-add     72            @e                   50        ?           ||
126200020506?2e? C                   endif                                                  ?F---------02|
126300020506?1e? C                   endif                                                  ?F----------01
126400040204     ?*- VALIDACION SPEEDWAY DE LA SUPERPOLIZA RELACIONADA.
126500040204     ?*  Vemos si la superpóliza con la que se intenta relacionar la actual
126600040204     ?*  existe en PAHEC0. Esto se hace siempre que se haya informado IISPOL
126700040204     ?*  <> *ZEROS lo que indica que se desea relacionar la póliza.
126800040510?1b? C                   if        por_parametros                               ?P----------01
126900040204?2b? C                   if        not *in50 and es_version2                    ?P---------02|
127000040204     C                             and iispol <> *zeros                         ?           ||
127100040204     C     k2@ec0        setll     pahec0                                 50    ?           ||
127200040204?3b? C                   if        *in50                                        ?P--------03||
127300040204     C                   eval      *in50 = *off                                 ?          |||
127400040204?3x? C                   else                                                   ?X........03||
127500040204     C                   eval      x1spo1 = iispol                              ?          |||
127600040204     C                   z-add     84            @e                   50        ?          |||
127700040204?3e? C                   endif                                                  ?F--------03||
127800040204?2e? C                   endif                                                  ?F---------02|
127900040510?1e? C                   endif                                                  ?F----------01
128000030108     ?*- BUSCA EN TABLA DE ARTICULOS HABILITADOS SPEEDWAY
128100040204     ?* Determina qué movimientos están permitidos.
128200040204?1b? C                   if        not *in50 and not es_version2                ?P----------01
128300040204     C     k1t620        chain     gti001                                       ?            |
128400040204?2b? C                   if        %found                                       ?P---------02|
128500040514     ?* Vemos tratamiento especial ¿es Speedway?                                ?           ||
128600040514     ?* Si no hay tratamiento especial chequea movimientos bloqueados.          ?           ||
128700040514?3b? C                   if        g1mar4 = '0'                                 ?P--------03||
128800040204?4b? C                   select                                                 ?P-------04|||
128900040204     ?*- SON OPERACIONES NUEVAS                                                 ?         ||||
129000040204?4x? C                   when      g1mar1 = '1' and x1tiou =1                   ?w-------04|||
129100040204     C                   z-add     87            @e                   50        ?         ||||
129200040204     ?*- SON RENOVACIONES                                                       ?         ||||
129300040204?4x? C                   when      g1mar2 = '1' and                             ?w-------04|||
129400040204     C                             x1tiou = 2   and                             ?         ||||
129500040204     C                             x1spo1 <> *zeros                             ?         ||||
129600040204     C                   z-add     87            @e                   50        ?         ||||
129700040204     ?*- SON ENDOSOS...                                                         ?         ||||
129800040204?4x? C                   when      g1mar3 = '1' and x1tiou = 3                  ?w-------04|||
129900040204     C                                          and x1spo1 <> *zeros            ?         ||||
130000040204     C                   z-add     86            @e                   50        ?         ||||
130100040514?4e? C                   endsl                                                  ?F-------04|||
130200040514     ?* Tratamiento especial con chequeo de Speedway.                           ?          |||
130300040514?3x? C                   else                                                   ?X........03||
130400040514     ?*- SI ES OPERACION DE SPEEDWAY...                                         ?          |||
130500040514     ?* Version 1, no se permiten Operaciones Nuevas.                           ?          |||
130600040514     ?* Versión 1, Endosos deben estar en GTI980 (suspendidas)                  ?          |||
130700040514     ?* Versión 1, Nuevas/Renovaciones debe ser V1 (suspendidas)                ?          |||
130800040514?4b? C                   select                                                 ?P-------04|||
130900040514?4x? C                   when      *in09 and es_version1                        ?w-------04|||
131000040514     C                   z-add     86            @e                   50        ?         ||||
131100040514?4x? C                   when      not *in09 and es_version1                    ?w-------04|||
131200040514?5b? C                   if        x1tiou = 3                                   ?P------05||||
131300040204     C     k1t980        chain     gti98001                                     ?        |||||
131400040514?6b? C                   if        not %found                                   ?P-----06|||||
131500040204     C                   z-add     86            @e                   50        ?       ||||||
131600040204?6e? C                   endif                                                  ?F-----06|||||
131700040514?5e? C                   endif                                                  ?F------05||||
131800040204?4e? C                   endsl                                                  ?F-------04|||
131900040204?3e? C                   endif                                                  ?F--------03||
132000030108?2e? C                   endif                                                  ?F---------02|
132100040514?1e? C                   endif                                                  ?F----------01
132200130814      * Para Speedway V2 Autos verifica archivos de interfaz.
132300130814     c                   if        not *in50  and es_version2
132400150810     c     x1arcd        setll     set62104
132500150810     c     x1arcd        reade     set62104
132600150810     c                   dow       not %eof(SET62104) and t$rama <> 3
132700150810     c     x1arcd        reade     set62104
132800130815     c                   enddo
132900150810     c                   if        not %eof(SET62104) and t$rama = 3
133000130814     c                   eval      P_Error = *all'*'
133100130815     c                   callp     PAR310N(usempr:
133200130815     c                                     ussucu:
133300130815     c                                     x1arcd:
133400130814     c                                     t$rama:
133500130814     c                                     IIsoln:
133600140908     c                                     iispol:
133700140908     c                                     iitiou:
133800140908     c                                     iistou:
133900140908     c                                     iifunc:
134000140908     c                                     W0SSPO:
134100130814     c                                     P_Error)
134200130814     c                   if        P_Error <> *all'*'
134300130814     c                   seton                                        50
134400130814     C                   z-add     88            @e
134500130814     c                   eval      msgdta = %trim(P_Error)
134600130814     c                   endif
134700130814     c                   endif
134800130814     c                   endif
134900020508     ?*- SI NO EXISTEN ERRORES AVANZA...
135000020506?1b? C                   if        not *in50                                    ?P----------01
135100020508     ?*- COMPARACION DE CAMPOS...                                               ?            |
135200020506?2b? C                   if        x1tiou = $$tiou  and                         ?P---------02|
135300020506     C                             x1stou = $$stou  and                         ?           ||
135400020506     C                             x1arcd = $$arcd  and                         ?           ||
135500020506     C                             x1spo1 = $$spo1                              ?           ||
135600020506     C                   setoff                                           90    ?           ||
135700040204     C                   exsr      grab01                                       ?           ||
135800020506?2x? C                   else                                                   ?X.........02|
135900020506     C                   eval      $$tiou = x1tiou                              ?           ||
136000020506     C                   eval      $$stou = x1stou                              ?           ||
136100020506     C                   eval      $$arcd = x1arcd                              ?           ||
136200020506     C                   eval      $$spo1 = x1spo1                              ?           ||
136300020506     C                   seton                                            90    ?           ||
136400020506?2e? C                   endif                                                  ?F---------02|
136500020506?1e? C                   endif                                                  ?F----------01
136600020506     ?*- SI EXISTEN ERRORES...
136700020506?1b? C                   if        *in50  and                                   ?P----------01
136800020506     C                             @e <> *zeros                                 ?            |
136900020506     C                   setoff                                           90    ?            |
137000020506     C                   write     par31001                                     ?            |
137100020506     C                   eval      *in(@e) = '1'                                ?            |
137200020506?1e? C                   endif                                                  ?F----------01
137300020506     ?*-
137400020506     C                   endsr
137500991217     ?******************************************************
137600021205      /SPACE
137700021205     ?******************************************************
137800020506     C     grab01        begsr
137900020506     ?** GRABACION PANTALLA 01-----------------------------
138000020506     ?*- BUSCAR CONFIGURACION DEL ARTICULO...
138100020506     C     k1t630        chain     s1t630                             20
138200020506     ?*- OPERACIONES NUEVAS--------------------------------
138300020506?1b? C                   if        *in09                                        ?P----------01
138400021205     ?*- BUSCAR NUMERO DE SUPERPOLIZA...                   ||                   ?            |
138500020506?2b? C                   if        x1tiou <= 2                                  ?P---------02|
138600020506     C     k1t990        chain     s1t990                             20        ?           ||
138700020506?3b? C                   if        *in20                                        ?P--------03||
138800020506     C                   eval      t@empr = usempr                              ?          |||
138900020506     C                   eval      t@sucu = ussucu                              ?          |||
139000020506     C                   eval      t@arcd = x1arcd                              ?          |||
139100020506     C                   eval      t@spol = 1                                   ?          |||
139200020506     C                   eval      t@cert = *zeros                              ?          |||
139300020506     C                   eval      t@ssin = *zeros                              ?          |||
139400020506     C                   eval      t@user = vsuser                              ?          |||
139500020506     C                   eval      t@date = udate                               ?          |||
139600020506     C                   write     s1t990                                       ?          |||
139700020506?3x? C                   else                                                   ?X........03||
139800020506     C                   add       1             t@spol                         ?          |||
139900020506     C                   update    s1t990                                       ?          |||
140000020506?3e? C                   endif                                                  ?F--------03||
140100020506?2e? C                   endif                                                  ?F---------02|
140200020506     ?*- GRABACION DEL ARCHIVO DE OPERACIONES SUSPENDIDAS..                     ?            |
140300020506     C                   eval      w0empr = usempr                              ?            |
140400020506     C                   eval      w0sucu = ussucu                              ?            |
140500020506     C                   eval      w0arcd = x1arcd                              ?            |
140600020506     ?*- NUMERO DE SUPERPOLIZA...                                               ?            |
140700020506?2b? C                   select                                                 ?P---------02|
140800020506?2x? C                   when      x1tiou = 1                                   ?w---------02|
140900020506     C                   eval      w0spo1 = t@spol                              ?           ||
141000020506     C                   eval      w0spol = t@spol                              ?           ||
141100020506     C                   eval      w0sspo = *zeros                              ?           ||
141200020506?2x? C                   when      x1tiou = 2                                   ?w---------02|
141300020506     C                   eval      w0spo1 = x1spo1                              ?           ||
141400020506     C                   eval      w0spol = t@spol                              ?           ||
141500020506     C                   eval      w0sspo = *zeros                              ?           ||
141600020506?2x? C                   when      x1tiou = 3  or                               ?w---------02|
141700020506     C                             x1tiou = 5                                   ?           ||
141800020506     C                   eval      w0spo1 = x1spo1                              ?           ||
141900020506     C                   eval      w0spol = x1spo1                              ?           ||
142000020506     C     k1@ec1        setgt     p1hec1                                       ?           ||
142100020506     C     k1@ec1        readpe    p1hec1                                 99    ?           ||
142200020506     C  n99c1sspo        add       1             w0sspo                         ?           ||
142300020506?2e? C                   endsl                                                  ?F---------02|
142400020506     C     k1t901        chain     s1t901                             20        ?            |
142500020506     C                   eval      w0tiou = x1tiou                              ?            |
142600020506     C                   eval      w0stou = x1stou                              ?            |
142700020506     C                   eval      w0stos = t@stos                              ?            |
142800020506     C                   eval      w0wp01 = *zeros                              ?            |
142900020506     C                   eval      w0wp02 = *zeros                              ?            |
143000020506     C                   eval      w0wp03 = *zeros                              ?            |
143100020506     C                   eval      w0wp04 = *zeros                              ?            |
143200020506     C                   eval      w0wp05 = *zeros                              ?            |
143300020506     C                   eval      w0wp06 = *zeros                              ?            |
143400020506     C                   eval      w0wp07 = *zeros                              ?            |
143500020506     C                   eval      w0wp08 = *zeros                              ?            |
143600020506     C                   eval      w0wp09 = *zeros                              ?            |
143700020506     C                   eval      w0wp10 = *zeros                              ?            |
143800020506     C                   eval      w0wp11 = *zeros                              ?            |
143900020506     C                   eval      w0wp12 = *zeros                              ?            |
144000020506     C                   eval      w0wp13 = *zeros                              ?            |
144100020506     C                   eval      w0wp14 = *zeros                              ?            |
144200020506     C                   eval      w0wp15 = *zeros                              ?            |
144300020506     C                   eval      w0wipa = *year                               ?            |
144400020506     C                   eval      w0wipm = umonth                              ?            |
144500020506     C                   eval      w0wipd = uday                                ?            |
144600020506     ?*- DEJAR TOMADA POR INTERACTIVO...                                        ?            |
144700020506     C                   eval      w0marp = '3'                                 ?            |
144800020506     C                   eval      w0user = vsuser                              ?            |
144900020506     C                   eval      w0date = udate                               ?            |
145000020506     C                   time                    w0time                         ?            |
145100020506     C                   eval      w0npro = *zeros                              ?            |
145200040204     ?* Guardamos Nro. de solicitud cuando viene desde parámetros.              ?            |
145300040204     ?* Se genera PAHEC0C cuando se desea dejar relacionada la Superpóliza      ?            |
145400040204     ?* con una anterior.                                                       ?            |
145500040204?2b? C                   if        por_parametros                               ?P---------02|
145600040204     C                   eval      w0soln = iisoln                              ?           ||
145700040204?2e? C                   endif                                                  ?F---------02|
145800020506     C                   write     p1wpc001                                     ?            |
145900020506?1e? C                   endif                                                  ?F----------01
146000020506     ?*- RETOMAR OPERACIONES SUSPENDIDAS...
146100020506?1b? C                   if        not *in09                                    ?P----------01
146200020506     C     k1@ec0        chain     p1wpc001                           20        ?            |
146300020506?2b? C                   if        not *in20                                    ?P---------02|
146400020506     C                   eval      w0marp = '3'                                 ?           ||
146500020506     C                   update    p1wpc001                                     ?           ||
146600020506?2e? C                   endif                                                  ?F---------02|
146700020506?1e? C                   endif                                                  ?F----------01
146800020506     ?*- INGRESAR A LOS PROGRAMAS ESPECIFICOS...
146900020506     C                   exsr      pro001
147000020506     ?*-
147100020506     C                   endsr
147200991217     ?******************************************************
147300021205      /SPACE
147400021205     ?******************************************************
147500020506     C     pro001        begsr
147600020506     ?* PROCESO DE INGRESO INTERACTIVO DE OPERACIONES------
147700020506     ?* Definicion del significado de los pasos de trabajo
147800020506     ?* siempre 0=paso no ejecutado 1=paso ejecutado...
147900020506     ?* W0PA01-Grabaciòn de cabecera PAHEC0/PAHEC1/PAWPD0
148000020506     C                   eval      @@mand = *blanks
148100020506     C                   eval      endpgm = *blanks
148200020506     C  n09              eval      @@flag = *zeros
148300040204     ?* La señal de que se ha decidido suspender la Operación
148400040204     ?* para el trabajo por parámetros (Speedway)
148500040204     C                   eval      dejar_suspen = *off
148600020506     ?*- GRABACION DE CABECERAS: ARCHIVOS PAHEC* ...
148700020506     C     cabe01        tag
148800020506     C                   exsr      head01
148900020506     ?*- SALIDA DE GRABACION DE CABECERA...
149000020506?1b? C                   select                                                 ?P----------01
149100020506     ?* salida de grabaciòn de cabecera con 'KA'-----------                     ?            |
149200020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
149300020506     C                   exsr      pro002                                       ?            |
149400020506?2b? C                   select                                                 ?P---------02|
149500020506     ?*    Salida de rutina PRO002 con "KA"----------------                     ?           ||
149600020506     ?*    esto quiere decir que se completaron todos los                       ?           ||
149700020506     ?*    pasos por lo que se presenta pantalla de confir                      ?           ||
149800020506     ?*    maciòn de la operacion o para avisar que queda                       ?           ||
149900020506     ?*    suspendida si es una suspendida especial...                          ?           ||
150000020506?2x? C                   when      @@mand = 'KA'                                ?w---------02|
150100020506     C                   exsr      sa02ka                                       ?           ||
150200020506     ?*    salida de rutina PRO002 CON "KC"----------------                     ?           ||
150300020506     ?*    esto quiere decir que no se completaron todos                        ?           ||
150400020506     ?*    pasos y se quiere dejar la operacion suspendida                      ?           ||
150500020506?2x? C                   when      @@mand = 'KC'                                ?w---------02|
150600020506     C     k1@pc0        chain     p1wpc001                           20        ?           ||
150700020506     C  n20              eval      w0marp = '0'                                 ?           ||
150800020506     C  n20              update    p1wpc001                                     ?           ||
150900020506     C  n20              exsr      borr01                                       ?           ||
151000020506     C  n20              exsr      defe01                                       ?           ||
151100040204     C  n20              eval      dejar_suspen = *on                           ?           ||
151200040204     C  n20              eval      *inkc = *on                                  ?           ||
151300020506     C  n20              eval      xxiden = 1                                   ?           ||
151400020506     ?*    salida de rutina PRO002 CON "KL"----------------                     ?           ||
151500020506     ?*    esto quiere decir que no se completaron todos                        ?           ||
151600020506     ?*    los pasos y se quiere volver a cabecera...                           ?           ||
151700020506?2x? C                   when      @@mand = 'KL'                                ?w---------02|
151800020506?GO? C                   goto      cabe01                                       ?           ||
151900020506?2e? C                   endsl                                                  ?F---------02|
152000020506     ?*  salida de cabecera con "KC"-----------------------                     ?            |
152100020506     ?*  se deja la operacion suspendida...                                     ?            |
152200020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
152300020506     C     k1@pc0        chain     p1wpc001                           20        ?            |
152400020506     C  n20              eval      w0marp = '0'                                 ?            |
152500020506     C  n20              update    p1wpc001                                     ?            |
152600020506     C  n20              exsr      borr01                                       ?            |
152700020506     C  n20              exsr      defe01                                       ?            |
152800040204     C  n20              eval      dejar_suspen = *on                           ?            |
152900040204     C  n20              eval      *inkc = *on                                  ?            |
153000020506     C  n20              eval      xxiden = 1                                   ?            |
153100020506     ?*- salida de cabecera con "KL"-----------------------                     ?            |
153200020506     ?*  se queda en cabecera (esto es una boludez)...                          ?            |
153300020506?1x? C                   when      @@mand = 'KL'                                ?w----------01
153400020506?GO? C                   goto      cabe01                                       ?            |
153500020506?1e? C                   endsl                                                  ?F----------01
153600020506     ?*-
153700020506     C                   endsr
153800991217     ?******************************************************
153900021205      /SPACE
154000021205     ?******************************************************
154100020506     C     sa02ka        begsr
154200020506     ?** SALIDA DE RUTINA PRO002 CON KA--------------------
154300020506     C     w0arcd        chain     s1t620                             20
154400020506     C     w0arcd        chain     s1t630                             20
154500020506     C     k2@ec1        chain     p1hec1                             20
154600020506     C                   exsr      buspre
154700020506?1b? C                   select                                                 ?P----------01
154800020506     ?* no es suspendida especial manda a confirmación...                       ?            |
154900020506?1x? C                   when      t@mar2 = '0'                                 ?w----------01
155000020506     C                   exsr      carg03                                       ?            |
155100020506     C                   eval      xxiden = 3                                   ?            |
155200020506     ?* es suspendida especial de tipo 1 y premio positivo                      ?            |
155300020506     ?* queda en suspendida especial...                                         ?            |
155400020506?1x? C                   when      t@mar2 = '1'  and                            ?w----------01
155500020506     C                             @@aux1 > *zeros                              ?            |
155600020506     C                   exsr      carg04                                       ?            |
155700020506     C                   eval      xxiden = 4                                   ?            |
155800020506     ?* es suspendida especial de tipo 2 y premio positivo                      ?            |
155900020506     ?* analiza si confirma con recibo...                                       ?            |
156000020506?1x? C                   when      t@mar2 = '2'  and                            ?w----------01
156100020506     C                             @@aux1 > *zeros                              ?            |
156200020506?2b? C                   select                                                 ?P---------02|
156300020506     ?* No confirma con recibo dejo en suspendida...                            ?           ||
156400020506?2x? C                   when      t@ma19 = '0'                                 ?w---------02|
156500020506     C                   exsr      carg04                                       ?           ||
156600020506     C                   eval      xxiden = 4                                   ?           ||
156700020506     ?* Si confirma con recibo y tengo recibo entonces                          ?           ||
156800020506     ?* mando a confirmación...                                                 ?           ||
156900020506?2x? C                   when      t@ma19 = '1'  and                            ?w---------02|
157000020506     C                             c1strg = 'R'                                 ?           ||
157100020506     C                   exsr      carg03                                       ?           ||
157200020506     C                   eval      xxiden = 3                                   ?           ||
157300020506     ?* Si confirma con recibo y no tengo recibo entonces                       ?           ||
157400020506     ?* dejar en suspendida especial...                                         ?           ||
157500020506?2x? C                   when      t@ma19 = '1'  and                            ?w---------02|
157600020506     C                             c1strg <> 'R'                                ?           ||
157700020506     C                   exsr      carg04                                       ?           ||
157800020506     C                   eval      xxiden = 4                                   ?           ||
157900020506?2e? C                   endsl                                                  ?F---------02|
158000020506     ?* es suspendida especial de tipo 1/2 y premio nega-                       ?            |
158100020506     ?* tivo o cero avisa que es suspendida especial pero                       ?            |
158200020506     ?* la confirma porque es al dope dejarla...                                ?            |
158300020506?1x? C                   when      t@mar2 <> '0'  and                           ?w----------01
158400020506     C                             @@aux1 <= *zeros                             ?            |
158500020506     C                   exsr      carg06                                       ?            |
158600020506     C                   eval      xxiden = 6                                   ?            |
158700020506?1e? C                   endsl                                                  ?F----------01
158800020506     ?*-
158900020506     C                   endsr
159000991217     ?******************************************************
159100021205      /SPACE
159200021205     ?******************************************************
159300020506     C     buspre        begsr
159400020506     ?** RUTINA DE GRABACION DE CABECERAS------------------
159500020506     C                   eval      @@aux1 = *zeros
159600020506     C                   setoff                                           93
159700020506     C     k2@ed0        setll     p1hed0
159800020506?1b? C                   dou       *in93                                        ?P----------01
159900020506     C     k2@ed0        reade     p1hed0                                 93    ?            |
160000020506?2b? C                   if        not *in93                                    ?P---------02|
160100020506     C                   add       d0prem        @@aux1                         ?           ||
160200020506?2e? C                   endif                                                  ?F---------02|
160300020506?1e? C                   enddo                                                  ?F----------01
160400020506     ?*-
160500020506     C                   endsr
160600991217     ?******************************************************
160700021205      /SPACE
160800021205     ?******************************************************
160900020506     C     head01        begsr
161000020506     ?** RUTINA DE GRABACION DE CABECERAS------------------
161100020506     C                   eval      @@mand = *blanks
161200020506     C                   eval      endpgm = *blanks
161300020506     ?*                    WRITEPAR31001
161400020506     C                   eval      p310c = 'L'
161500040204     ?* Según se trabaje con o sin parámetros se llama con una u
161600040204     ?* otra lista de parámetros.
161700040204?1b? C                   if        por_parametros                               ?P----------01
161800040204     C                   call      'PAR310C'     $l310cpar                      ?            |
161900040204?1x? C                   else                                                   ?X..........01
162000040204     C                   call      'PAR310C'     $l310cstd                      ?            |
162100040204?1e? C                   endif                                                  ?F----------01
162200180528     ?* Planes mundiales AXA y HDI...
162300171002
162400171004     C                   if        @@mand <> 'KC'
162500171002     C     k1@ec4        chain(n)  pahec4
162600171002     C                   if        %found( pahec4 )
162700180528     C                   if        c4ra06 = 'A' or c4ra06 = 'H'
162800171002     C                   eval      p310p = 'L'
162900171002     C                   call      'PAR310P'
163000171002     C                   parm                    usempr                         ?            |
163100171002     C                   parm                    ussucu                         ?            |
163200171002     C                   parm                    w0arcd                         ?            |
163300171002     C                   parm                    w0spo1                         ?            |
163400171002     C                   parm                    w0spol                         ?            |
163500171002     C                   parm                    w0sspo                         ?            |
163600171002     C                   parm                    @@mand                         ?            |
163700171002     C                   parm                    endpgm                         ?            |
163800171004     C                   endif
163900171002?1e? C                   endif                                                  ?F----------01
164000171002     C                   endif
164100020506     ?* el parametro t@ma01 indica si debe ejecutarse la
164200020506     ?* segunda cabecera, solo si es forma de cobranza por
164300020506     ?* cobrador y el chabón salió de la grabación de
164400020506     ?* la primera cabecera con 'KA'. Si no corresponde
164500020506     ?* o saliò de cualquier otro modo se sale de la ru-
164600020506     ?* tina y toma el control la pro001...
164700020506     C     k2@ec1        chain     p1hec1                             20
164800020506?1b? C                   if        t@ma01 = '1'  and                            ?P----------01
164900020506     C                             c1cfpg = 4  and                              ?            |
165000020506     C                             @@mand = 'KA'  or                            ?            |
165100020506     C                             t@ma01 = '1'  and                            ?            |
165200020506     C                             c1cfpg = 5  and                              ?            |
165300020506     C                             @@mand = 'KA'                                ?            |
165400020506     C                   eval      @@mand = *blanks                             ?            |
165500020506     C                   eval      endpgm = *blanks                             ?            |
165600020506     ?*                    WRITEPAR31001                                        ?            |
165700020506     C                   eval      p310r = 'L'                                  ?            |
165800020506     C                   call      'PAR310R'                                    ?            |
165900020506     C                   parm                    usempr                         ?            |
166000020506     C                   parm                    ussucu                         ?            |
166100020506     C                   parm                    w0arcd                         ?            |
166200020506     C                   parm                    w0spo1                         ?            |
166300020506     C                   parm                    w0spol                         ?            |
166400020506     C                   parm                    w0sspo                         ?            |
166500020506     C                   parm      c1mone        @@mone                         ?            |
166600020506     C                   parm      c1cbrn        @@cbrn                         ?            |
166700020506     C                   parm      c1czco        @@czco                         ?            |
166800020506     C                   parm                    @@mand                         ?            |
166900020506     C                   parm                    endpgm                         ?            |
167000020506?1e? C                   endif                                                  ?F----------01
167100020506     ?*-
167200020506     C                   endsr
167300991217     ?******************************************************
167400021205      /SPACE
167500021205     ?******************************************************
167600020506     C     posi01        begsr
167700020506     ?** POSICIONAR EN ULTIMA RAMA/SECUENCIA---------------
167800020506?1b? C                   select                                                 ?P----------01
167900020506?1x? C                   when      @@flag = *zeros                              ?w----------01
168000020506     C                   eval      @@flag = 1                                   ?            |
168100020506     C                   setoff                                         1999    ?            |
168200020506     C     k1@pd0        setgt     p1wpd0                                       ?            |
168300020506?2b? C                   dou       *in99  or                                    ?P---------02|
168400020506     C                             z0wp01 = 1                                   ?           ||
168500020506     C     k1@pd0        readpe    p1wpd0                                 99    ?           ||
168600020506?3b? C                   if        not *in99  and                               ?P--------03||
168700020506     C                             z0wp01 = 1                                   ?          |||
168800020506     C                   seton                                            19    ?          |||
168900020506?2v? C                   leave                                                  ?          |||
169000020506?3e? C                   endif                                                  ?F--------03||
169100020506?2e? C                   enddo                                                  ?F---------02|
169200020506?1x? C                   other                                                  ?w----------01
169300020506     C                   setoff                                           19    ?            |
169400020506?1e? C                   endsl                                                  ?F----------01
169500020506     ?*-
169600020506     C                   endsr
169700991217     ?******************************************************
169800021205      /SPACE
169900021205     ?******************************************************
170000020506     C     pro002        begsr
170100020506     ?** PROCESOS A NIVEL DE RAMA/SECUENCIA----------------
170200020506     ?*- CUANDO RETOMA BUSCAR POSICIONAMIENTO...
170300020506     C  n09              exsr      posi01
170400150810     ?*- LAZO DE LECTURA DEL PAWPD0...
170500150810     C     x1arcd        setll     set62104
170600150810     C     x1arcd        reade     set62104
170700150810     C                   Dow       not %eof
170800150810     C     k3@pd0        chain     p1wpd0                                       ?            |
170900150810?2b? C*                  if        not *in99                                    ?P---------02|
171000150810     C                   if        %found
171100020506     ?*                    WRITEPAR31001                                        ?           ||
171200020506     C                   exsr      pro003                                       ?           ||
171300020506     ?*- ROMPER EL LAZO...                                                      ?           ||
171400020506?3b? C                   if        @@paso = 99                                  ?P--------03||
171500020506?1v? C                   leave                                                  ?          |||
171600020506?3e? C                   endif                                                  ?F--------03||
171700020506?2e? C                   endif                                                  ?F---------02|
171800150810     C     x1arcd        reade     set62104
171900020506?1e? C                   enddo                                                  ?F----------01
172000020506     ?* si sale del lazo de lectura con 'KA' es porque se
172100020506     ?* se completo la grabación de todas las ramas/secuen-
172200020506     ?* cias por lo que lo que sigue es la grabación de las
172300020506     ?* cabeceras finales (o pie si se quiere)...
172400020506?1b? C                   if        @@mand = 'KA'                                ?P----------01
172500020506     ?* comisiones de cobranza cobradores...                                    ?            |
172600020506     C     foot01        tag                                                    ?            |
172700020506?2b? C                   if        c1cfpg = 4  and                              ?P---------02|
172800020506     C                             t@ma01 = '2'  or                             ?           ||
172900020506     C                             c1cfpg = 5  and                              ?           ||
173000020506     C                             t@ma01 = '2'                                 ?           ||
173100020506     C                   call      'PAR310Q'                                    ?           ||
173200020506     C                   parm                    w0arcd                         ?           ||
173300020506     C                   parm                    w0spol                         ?           ||
173400020506     C                   parm                    w0sspo                         ?           ||
173500020506     C                   parm      *blanks       @@mand                         ?           ||
173600020506?2e? C                   endif                                                  ?F---------02|
173700020506     ?* cuotas unificadas...                                                    ?            |
173800020506?2b? C                   if        @@mand = 'KA'                                ?P---------02|
173900020506     C                   eval      p310w = 'L'                                  ?           ||
174000020506     C                   call      'PAR310W'                                    ?           ||
174100020506     C                   parm                    w0empr                         ?           ||
174200020506     C                   parm                    w0sucu                         ?           ||
174300020506     C                   parm                    w0arcd                         ?           ||
174400020506     C                   parm                    w0spo1                         ?           ||
174500020506     C                   parm                    w0spol                         ?           ||
174600020506     C                   parm                    w0sspo                         ?           ||
174700020506     C                   parm      *blanks       @@mand                         ?           ||
174800020506     C                   parm      *blanks       endpgm                         ?           ||
174900020506     C     @@mand        cabeq     'KL'          foot01                         ?           ||
175000020506?2e? C                   endif                                                  ?F---------02|
175100020506?1e? C                   endif                                                  ?F----------01
175200020506     ?*-
175300020506     C                   endsr
175400991217     ?******************************************************
175500021205      /SPACE
175600021205     ?******************************************************
175700020506     C     pro003        begsr
175800020506     ?** PASOS DE TRABAJO PARA CADA RAMA/SECUENCIA---------
175900020506     C                   eval      @@paso = 1
176000020506?1b? C                   dou       @@paso = 99  or                              ?P----------01
176100020506     C                             @@paso = 98                                  ?            |
176200040419?2b? C     @@paso        caseq     0             pro000                         ?P---------02|
176300020506     C     @@paso        caseq     1             pro004                         ?           ||
176400020506     C     @@paso        caseq     2             pro005                         ?           ||
176500020506     C     @@paso        caseq     3             pro006                         ?           ||
176600020506     C     @@paso        caseq     3             pro006                         ?           ||
176700020506     C     @@paso        caseq     4             pro007                         ?           ||
176800020506     C     @@paso        caseq     5             pro008                         ?           ||
176900020506     C     @@paso        caseq     6             pro009                         ?           ||
177000020506?2e? C                   endcs                                                  ?F---------02|
177100020506?1e? C                   enddo                                                  ?F----------01
177200020506     ?*-
177300020506     C                   endsr
177400040419     ?******************************************************
177500040419      /SPACE
177600040419     ?******************************************************
177700040419     Csr   pro000        begsr
177800040419     ?* Esta subrutina sólo se usa cuando el usuario optó por
177900040419     ?* saltar a la cabecera de Superpóliza (PAR310C) desde
178000040419     ?* el "troncal" de RAMA/SECUENCIA.
178100040419     ?* Se setea la lógica para esta situación como si le
178200040419     ?* hubiesen dado F12.
178300040419     C                   eval      @@paso = 99
178400040419     C                   eval      @@mand = 'KL'
178500040419     Csr                 endsr
178600991217     ?******************************************************
178700021205      /SPACE
178800021205     ?******************************************************
178900020506     C     pro004        begsr
179000020506     ?** PROGRAMA DE DETALLE RAMA/SECUENCIA----------------
179100020506     ?** PASO01-EN ARCHIVO CAMPO Z0WP01...
179200020506     C                   eval      p310d = 'L'
179300020506     C                   call      'PAR310D'
179400020506     C                   parm                    z0empr
179500020506     C                   parm                    z0sucu
179600020506     C                   parm                    z0arcd
179700020506     C                   parm                    z0spo1
179800020506     C                   parm                    z0spol
179900020506     C                   parm                    z0sspo
180000020506     C                   parm                    z0rama
180100020506     C                   parm                    z0arse
180200020506     C                   parm                    z0oper
180300020506     C                   parm                    z0suop
180400020506     C                   parm      *blanks       @@mand
180500020506     C                   parm      *blanks       endpgm
180600020506     ?*- ANALIZA MANDATOS DE SALIDA...
180700020506?1b? C                   select                                                 ?P----------01
180800020506     ?*- *INKA=AVANZAR...                                                       ?            |
180900020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
181000020506     C                   eval      @@paso = 2                                   ?            |
181100020506     ?*- *INKC=SALIR...                                                         ?            |
181200020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
181300020506     C                   eval      @@paso = 99                                  ?            |
181400020506     ?*- *INKL=RETORNAR...                                                      ?            |
181500040419     ?*- *INKR=Ir a...                                                          ?            |
181600040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
181700040419     C                             @@mand = 'KR'                                ?            |
181800040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 99)       ?            |
181900020506?1e? C                   endsl                                                  ?F----------01
182000020506     ?*-
182100020506     C                   endsr
182200991217     ?******************************************************
182300021205      /SPACE
182400021205     ?******************************************************
182500020506     C     pro005        begsr
182600020506     ?** PROGRAMA DE TEXTOS POR RAMA/SECUENCIA-------------
182700020506     ?** PASO02-EN ARCHIVO CAMPO Z0WP02...
182800020506     C                   eval      @@mand = *blanks
182900020506?1b? C                   if        t@ma02 = '1'  or                             ?P----------01
183000020506     C                             t@ma02 = '2'                                 ?            |
183100020506     C                   eval      p310e = 'L'                                  ?            |
183200020506     C                   call      'PAR310E'                                    ?            |
183300020506     C                   parm                    z0empr                         ?            |
183400020506     C                   parm                    z0sucu                         ?            |
183500020506     C                   parm                    z0arcd                         ?            |
183600020506     C                   parm                    z0spo1                         ?            |
183700020506     C                   parm                    z0spol                         ?            |
183800020506     C                   parm                    z0sspo                         ?            |
183900020506     C                   parm                    z0rama                         ?            |
184000020506     C                   parm                    z0arse                         ?            |
184100020506     C                   parm                    z0oper                         ?            |
184200020506     C                   parm                    z0suop                         ?            |
184300020506     C                   parm      *blanks       @@mand                         ?            |
184400020506     C                   parm      *blanks       endpgm                         ?            |
184500020506?1x? C                   else                                                   ?X..........01
184600020506     C                   eval      @@mand = 'KA'                                ?            |
184700020506?1e? C                   endif                                                  ?F----------01
184800020506     ?*- ANALIZA MANDATOS DE SALIDA...
184900020506?1b? C                   select                                                 ?P----------01
185000020506     ?*- *INKA=AVANZAR...                                                       ?            |
185100020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
185200020506     C                   eval      @@paso = 3                                   ?            |
185300020506     ?*- *INKC=SALIR...                                                         ?            |
185400020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
185500020506     C                   eval      @@paso = 99                                  ?            |
185600020506     ?*- *INKL=RETORNAR...                                                      ?            |
185700040419     ?*- *INKR=Ir a...                                                          ?            |
185800040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
185900040419     C                             @@mand = 'KR'                                ?            |
186000040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 01)       ?            |
186100020506?1e? C                   endsl                                                  ?F----------01
186200020506     ?*-
186300020506     C                   endsr
186400991217     ?******************************************************
186500021205      /SPACE
186600021205     ?******************************************************
186700020506     C     pro006        begsr
186800020506     ?** PROGRAMA DE CLAUSULAS Y ANEXOS POR RAMA/SECUENCIA-
186900020506     ?** PASO03-EN ARCHIVO CAMPO Z0WP03...
187000020506?1b? C                   if        t@ma03 = '1'  or                             ?P----------01
187100020506     C                             t@ma03 = '2'                                 ?            |
187200020506     C                   eval      p310f = 'L'                                  ?            |
187300020506     C                   call      'PAR310F'                                    ?            |
187400020506     C                   parm                    z0empr                         ?            |
187500020506     C                   parm                    z0sucu                         ?            |
187600020506     C                   parm                    z0arcd                         ?            |
187700020506     C                   parm                    z0spo1                         ?            |
187800020506     C                   parm                    z0spol                         ?            |
187900020506     C                   parm                    z0sspo                         ?            |
188000020506     C                   parm                    z0rama                         ?            |
188100020506     C                   parm                    z0arse                         ?            |
188200020506     C                   parm                    z0oper                         ?            |
188300020506     C                   parm                    z0suop                         ?            |
188400020506     C                   parm      *blanks       @@mand                         ?            |
188500020506     C                   parm      *blanks       endpgm                         ?            |
188600020506?1x? C                   else                                                   ?X..........01
188700020506     C                   eval      @@mand = 'KA'                                ?            |
188800020506?1e? C                   endif                                                  ?F----------01
188900020506     ?*- ANALIZA MANDATOS DE SALIDA...
189000020506?1b? C                   select                                                 ?P----------01
189100020506     ?*- *INKA=AVANZAR...                                                       ?            |
189200020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
189300020506     C                   eval      @@paso = 4                                   ?            |
189400020506     ?*- *INKC=SALIR...                                                         ?            |
189500020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
189600020506     C                   eval      @@paso = 99                                  ?            |
189700020506     ?*- *INKL=RETORNAR...                                                      ?            |
189800040419     ?*- *INKR=Ir a...                                                          ?            |
189900040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
190000040419     C                             @@mand = 'KR'                                ?            |
190100020506?2b? C                   select                                                 ?P---------02|
190200020506?2x? C                   when      t@ma02 = '1'  or                             ?w---------02|
190300020506     C                             t@ma02 = '2'                                 ?           ||
190400040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 02)       ?           ||
190500020506?2x? C                   other                                                  ?w---------02|
190600040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 01)       ?           ||
190700020506?2e? C                   endsl                                                  ?F---------02|
190800020506?1e? C                   endsl                                                  ?F----------01
190900020506     ?*-
191000020506     C                   endsr
191100991217     ?******************************************************
191200021205      /SPACE
191300021205     ?******************************************************
191400020506     C     pro007        begsr
191500020506     ?** PROGRAMA DE BIENES ASEGURADOS---------------------
191600020506     ?** PASO04-EN ARCHIVO CAMPO Z0WP04...
191700020506     C     k1t001        chain     s1t001                             20
191800020506?1b? C                   select                                                 ?P----------01
191900020506?1x? C                   when      t@rame = 04                                  ?w----------01
192000020506     C                   eval      p313c = 'L'                                  ?            |
192100020506     C                   call      'PAR313C'                            20      ?            |
192200020506     C                   parm                    z0empr                         ?            |
192300020506     C                   parm                    z0sucu                         ?            |
192400020506     C                   parm                    z0arcd                         ?            |
192500020506     C                   parm                    z0spo1                         ?            |
192600020506     C                   parm                    z0spol                         ?            |
192700020506     C                   parm                    z0sspo                         ?            |
192800020506     C                   parm                    z0rama                         ?            |
192900020506     C                   parm                    z0arse                         ?            |
193000020506     C                   parm                    z0oper                         ?            |
193100020506     C                   parm                    z0suop                         ?            |
193200020506     C                   parm      *blanks       @@mand                         ?            |
193300020506     C                   parm      *blanks       endpgm                         ?            |
193400020506?1x? C                   when      t@rame = 18  or                              ?w----------01
193500020506     C                             t@rame = 21                                  ?            |
193600020506     C                   eval      p311c = 'L'                                  ?            |
193700020506     C                   call      'PAR311C'                                    ?            |
193800020506     C                   parm                    z0empr                         ?            |
193900020506     C                   parm                    z0sucu                         ?            |
194000020506     C                   parm                    z0arcd                         ?            |
194100020506     C                   parm                    z0spo1                         ?            |
194200020506     C                   parm                    z0spol                         ?            |
194300020506     C                   parm                    z0sspo                         ?            |
194400020506     C                   parm                    z0rama                         ?            |
194500020506     C                   parm                    z0arse                         ?            |
194600020506     C                   parm                    z0oper                         ?            |
194700020506     C                   parm                    z0suop                         ?            |
194800020506     C                   parm      *blanks       @@mand                         ?            |
194900020506     C                   parm      *blanks       endpgm                         ?            |
195000020506?1x? C                   other                                                  ?w----------01
195100020506     C                   eval      p314c = 'L'                                  ?            |
195200020506     C                   call      'PAR314C'                            20      ?            |
195300020506     C                   parm                    z0empr                         ?            |
195400020506     C                   parm                    z0sucu                         ?            |
195500020506     C                   parm                    z0arcd                         ?            |
195600020506     C                   parm                    z0spo1                         ?            |
195700020506     C                   parm                    z0spol                         ?            |
195800020506     C                   parm                    z0sspo                         ?            |
195900020506     C                   parm                    z0rama                         ?            |
196000020506     C                   parm                    z0arse                         ?            |
196100020506     C                   parm                    z0oper                         ?            |
196200020506     C                   parm                    z0suop                         ?            |
196300020506     C                   parm      *blanks       @@mand                         ?            |
196400020506     C                   parm      *blanks       endpgm                         ?            |
196500020506?1e? C                   endsl                                                  ?F----------01
196600020506     ?*- ANALIZA MANDATOS DE SALIDA...
196700020506?1b? C                   select                                                 ?P----------01
196800020506     ?*- *INKA=AVANZAR...                                                       ?            |
196900020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
197000020506     C                   eval      @@paso = 5                                   ?            |
197100020506     ?*- *INKC=SALIR...                                                         ?            |
197200020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
197300020506     C                   eval      @@paso = 99                                  ?            |
197400020506     ?*- *INKL=RETORNAR...                                                      ?            |
197500040419     ?*- *INKR=Ir a...                                                          ?            |
197600040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
197700040419     C                             @@mand = 'KR'                                ?            |
197800020506?2b? C                   select                                                 ?P---------02|
197900020506?2x? C                   when      t@ma03 = '1'  or                             ?w---------02|
198000020506     C                             t@ma03 = '2'                                 ?           ||
198100040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 03)       ?           ||
198200020506?2x? C                   when      t@ma02 = '1'  or                             ?w---------02|
198300020506     C                             t@ma02 = '2'                                 ?           ||
198400040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 02)       ?           ||
198500020506?2x? C                   other                                                  ?w---------02|
198600040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 01)       ?           ||
198700020506?2e? C                   endsl                                                  ?F---------02|
198800020506?1e? C                   endsl                                                  ?F----------01
198900020506     ?*-
199000020506     C                   endsr
199100991217     ?******************************************************
199200021205      /SPACE
199300021205     ?******************************************************
199400020506     C     pro008        begsr
199500020506     ?** PROGRAMA DE CALCULO DE PREMIO---------------------
199600020506     ?** PASO05-EN ARCHIVO CAMPO Z0WP05...
199700020506     C                   eval      p312c = 'L'
199800020506     C                   call      'PAR312C'
199900020506     C                   parm                    z0empr
200000020506     C                   parm                    z0sucu
200100020506     C                   parm                    z0arcd
200200020506     C                   parm                    z0spo1
200300020506     C                   parm                    z0spol
200400020506     C                   parm                    z0sspo
200500020506     C                   parm                    z0rama
200600020506     C                   parm                    z0arse
200700020506     C                   parm                    z0oper
200800020506     C                   parm                    z0suop
200900020506     C                   parm      *blanks       @@mand
201000020506     C                   parm      *blanks       endpgm
201100020506     ?*- ANALIZA MANDATOS DE SALIDA...
201200020506?1b? C                   select                                                 ?P----------01
201300020506     ?*- *INKA=AVANZAR...                                                       ?            |
201400020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
201500020506     C                   eval      @@paso = 6                                   ?            |
201600020506     ?*- *INKC=SALIR...                                                         ?            |
201700020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
201800020506     C                   eval      @@paso = 99                                  ?            |
201900020506     ?*- *INKL=RETORNAR...                                                      ?            |
202000040419     ?*- *INKR=Ir a...                                                          ?            |
202100040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
202200040419     C                             @@mand = 'KR'                                ?            |
202300040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 04)       ?            |
202400020506?1e? C                   endsl                                                  ?F----------01
202500020506     ?*-
202600020506     C                   endsr
202700991217     ?******************************************************
202800021205      /SPACE
202900021205     ?******************************************************
203000020506     C     pro009        begsr
203100020506     ?** PROGRAMA DE CALCULO DE CPOMISIONES----------------
203200020506     ?** PASO06-EN ARCHIVO CAMPO Z0WP06...
203300020506     C                   eval      p312f = 'L'
203400020506     C                   call      'PAR312F'
203500020506     C                   parm                    z0empr
203600020506     C                   parm                    z0sucu
203700020506     C                   parm                    z0arcd
203800020506     C                   parm                    z0spo1
203900020506     C                   parm                    z0spol
204000020506     C                   parm                    z0sspo
204100020506     C                   parm                    z0rama
204200020506     C                   parm                    z0arse
204300020506     C                   parm                    z0oper
204400020506     C                   parm                    z0suop
204500020506     C                   parm      *blanks       @@mand
204600020506     C                   parm      *blanks       endpgm
204700020506     ?*- ANALIZA MANDATOS DE SALIDA...
204800020506?1b? C                   select                                                 ?P----------01
204900020506     ?*- *INKA=AVANZAR...                                                       ?            |
205000020506?1x? C                   when      @@mand = 'KA'                                ?w----------01
205100020506     C                   eval      @@paso = 98                                  ?            |
205200020506     ?*- *INKC=SALIR...                                                         ?            |
205300020506?1x? C                   when      @@mand = 'KC'                                ?w----------01
205400020506     C                   eval      @@paso = 99                                  ?            |
205500020506     ?*- *INKL=RETORNAR...                                                      ?            |
205600040419     ?*- *INKR=Ir a...                                                          ?            |
205700040419?1x? C                   when      @@mand = 'KL' or                             ?w----------01
205800040419     C                             @@mand = 'KR'                                ?            |
205900040419     C                   eval      @@paso = ira_prc(@@mand : @@paso : 05)       ?            |
206000020506?1e? C                   endsl                                                  ?F----------01
206100020506     ?*-
206200020506     C                   endsr
206300991217     ?******************************************************
206400021205      /SPACE
206500021205     ?******************************************************
206600020506     C     sf1bor        begsr
206700020506     ?** BORRAR SUBARCHIVO DE SUSPENDIDAS------------------
206800020506     C                   seton                                            32
206900020506     C                   setoff                                         3031
207000020506     C                   write     par310c1
207100020506     C                   setoff                                           32
207200020506     C                   seton                                            31
207300020506     C                   clear                   xxarcd
207400020506     C                   clear                   xxspo1
207500020506     ?*
207600020506     C                   endsr
207700991217     ?******************************************************
207800021205      /SPACE
207900021205     ?******************************************************
208000020506     C     sf1car        begsr
208100020506     ?** CARGAR SUBARCHIVO DE SUSPENDIDAS------------------
208200020506     ?* primero borrar subarchivo...
208300020506     C                   exsr      sf1bor
208400020506     ?* ahora cargar...
208500020506     C                   eval      sf1rrn = *zeros
208600020506?1b? C                   dou       *in99  or                                    ?P----------01
208700020506     C                             sf1rrn = @@lsf1                              ?            |
208800020506     C     k3@pc0        reade(n)  p1wpc001                               99    ?            |
208900020506?2b? C                   if        not *in99  and                               ?P---------02|
209000030218     C                             sf1rrn < @@lsf1 and                          ?           ||
209100030218     C                             w0tiou < 4                                   ?           ||
209200020506     C                   exsr      moar02                                       ?           ||
209300020506     C                   add       1             sf1rrn                         ?           ||
209400020506     C                   seton                                            30    ?           ||
209500020506     C                   setoff                                         4647    ?           ||
209600020506     C                   setoff                                         4849    ?           ||
209700020506     C     w0user        comp      vsuser                                 49    ?           ||
209800020506     C     w0marp        comp      '3'                                    48    ?           ||
209900020506     C     w0marp        comp      '4'                                    46    ?           ||
210000020506     C     w0marp        comp      '5'                                    47    ?           ||
210100020506     C                   write     par310s1                                     ?           ||
210200020506     C                   setoff                                         4647    ?           ||
210300020506     C                   setoff                                         4849    ?           ||
210400030218?2e? C                   endif                                                  ?F---------02|
210500020506?1e? C                   enddo                                                  ?F----------01
210600020506     ?*
210700020506     C                   endsr
210800991217     ?******************************************************
210900021205      /SPACE
211000021205     ?******************************************************
211100020506     C     moar02        begsr
211200020506     ?** MOVER CAMPOS A PANTALLA 02------------------------
211300020506     C                   eval      x2opci = *blanks
211400020506     C                   eval      x2empr = w0empr
211500020506     C                   eval      x2sucu = w0sucu
211600020506     C                   eval      x2arcd = w0arcd
211700020506     C                   eval      x2spo1 = w0spo1
211800020506     C                   eval      x2spol = w0spol
211900020506     C                   eval      x2sspo = w0sspo
212000020506     C                   eval      x2tiou = w0tiou
212100020506     C                   eval      x2stou = w0stou
212200020506     C                   eval      x2stos = w0stos
212300020506     C                   eval      x2user = w0user
212400020510     C                   eval      p@faÑo = w0wipa
212500020506     C                   eval      p@fmes = w0wipm
212600020506     C                   eval      p@fdia = w0wipd
212700020510     C                   eval      x2fech = (p@fdia * 10000) +
212800030122     C                                      (p@fmes * 100)  + p@faÑo2
212900020506     C                   eval      x2marp = w0marp
213000020506     C                   eval      x2wp14 = w0wp14
213100020506     C                   eval      x2npro = w0npro
213200040204     ?* -------------------------------------------------------------------- *
213300021205     ?* Resuelve datos de Speedway
213400040204     ?* Version 1.
213500040204     ?* *IN21: Alta intensidad o no para marca de Version 1 de SPW y marca de
213600040204     ?*        sus nros. propios.
213700040204     ?* *IN22: Cambia a color Turquesa para marca propuestas SPW V2.
213800040204     C                   eval      *in21 = *off
213900040204     C                   eval      *in22 = *off
214000040204     C                   eval      x2vers= '0'
214100040204     C     k1gti98001    chain     gti98001
214200020510?1b? C                   if        %found                                       ?P----------01
214300040204     C                   eval      *in22 = *off                                 ?            |
214400040204     C                   eval      x2vers = '1'                                 ?            |
214500020510?2b? C                   if        g0poli <> *zeros                             ?P---------02|
214600020510     C                   eval      *in21 = *off                                 ?           ||
214700020510     C                   eval      x2ipoc = g0poli                              ?           ||
214800020510?2x? C                   else                                                   ?X.........02|
214900020510     C                   eval      *in21 = *on                                  ?           ||
215000020510     C                   eval      x2ipoc = g0pol1                              ?           ||
215100020510?2e? C                   endif                                                  ?F---------02|
215200020510?1x? C                   else                                                   ?X..........01
215300020510     C                   eval      x2ipoc = *zeros                              ?            |
215400020510?1e? C                   endif                                                  ?F----------01
215500040204     ?* Version 2.
215600040204?1b? C                   if        x2ipoc = *zeros and w0soln <> *zeros         ?P----------01
215700040204     C                   eval      *in22 = *on                                  ?            |
215800040204     C                   eval      x2vers = '2'                                 ?            |
215900040204     C                   eval      x2ipoc = w0soln                              ?            |
216000040204?1e? C                   endif                                                  ?F----------01
216100040204     ?* -------------------------------------------------------------------- *
216200020506     ?*
216300020506     C                   endsr
216400991217     ?******************************************************
216500021205      /SPACE
216600021205     ?******************************************************
216700020506     C     pant02        begsr
216800020506     ?** PROCESO PANTALLA 02-------------------------------
216900020506     C                   exfmt     par310c1
217000020506     ?*- CORRIGE SITUACIONES DE ERROR ...
217100020506     C                   exsr      apagar
217200020506     ?*- PROCESA TECLAS DE FUNCION...
217300020506?1b? C                   select                                                 ?P----------01
217400020506     ?*- F3=SALIR...                                                            ?            |
217500020506?1x? C                   when      *inkc                                        ?w----------01
217600020506     ?*- F12=RETORNAR...                                                        ?            |
217700020506?1x? C                   when      *inkl                                        ?w----------01
217800020506     C                   eval      xxiden = 1                                   ?            |
217900020506     ?*- F10=BUSCAR...                                                          ?            |
218000020506?1x? C                   when      *inkj                                        ?w----------01
218100020506     C                   exsr      borr07                                       ?            |
218200020506     C                   eval      xxiden = 7                                   ?            |
218300020506     ?*- 91=AVANCE DE PAGINA...                                                 ?            |
218400020506?1x? C                   when      *in91  and                                   ?w----------01
218500020506     C                             *in30                                        ?            |
218600020506     C                   exsr      rollup                                       ?            |
218700020506     ?*- 92=RETROCESO DE PAGINA...                                              ?            |
218800020506?1x? C                   when      *in92  and                                   ?w----------01
218900020506     C                             *in30                                        ?            |
219000020506     C                   exsr      roldwn                                       ?            |
219100020506     ?*- F4=SOLICITUD...                                                        ?            |
219200020506?1x? C                   when      *inkd                                        ?w----------01
219300020506     C                   exsr      soli02                                       ?            |
219400020506     ?*- PULSA INTRO...                                                         ?            |
219500020506?1x? C                   when      not *in29  and                               ?w----------01
219600020506     C                             *in30                                        ?            |
219700020506     C                   exsr      vali02                                       ?            |
219800020506?1e? C                   endsl                                                  ?F----------01
219900020506     ?*
220000020506     C                   endsr
220100991217     ?******************************************************
220200021205      /SPACE
220300021205     ?******************************************************
220400020506     C     soli02        begsr
220500020506     ?** SOLICITUD PANTALLA 02-----------------------------
220600020506     ?*
220700020506     C                   endsr
220800991217     ?******************************************************
220900021205      /SPACE
221000021205     ?******************************************************
221100020506     C     vali02        begsr
221200020506     ?** VALIDACION PANTALLA 02----------------------------
221300020506?1b? C                   select                                                 ?P----------01
221400020506?1x? C                   when      xxarcd <> *zeros  and                        ?w----------01
221500020506     C                             xxspo1 <> *zeros                             ?            |
221600020506     C                   exsr      posi02                                       ?            |
221700020506?1x? C                   other                                                  ?w----------01
221800020506     C                   clear                   xxarcd                         ?            |
221900020506     C                   clear                   xxspo1                         ?            |
222000020506     C                   exsr      sele02                                       ?            |
222100020506?1e? C                   endsl                                                  ?F----------01
222200020506     ?*
222300020506     C                   endsr
222400991217     ?******************************************************
222500021205      /SPACE
222600021205     ?******************************************************
222700020506     C     posi02        begsr
222800020506     ?** POSICIONAR PANTALLA 02----------------------------
222900020506     C     k4@pc0        setll     p1wpc001
223000020506     C     k3@pc0        reade(n)  p1wpc001                               99
223100020506     C  n99k4@pc0        setll     p1wpc001
223200020506     C   99k3@pc0        setgt     p1wpc001
223300020506     C   99k3@pc0        readpe(n) p1wpc001                               98
223400020506     C   99
223500020506     Cann98k3@pc0        readpe(n) p1wpc001                               99
223600020506     C   99
223700020506     Can 98k3@pc0        setll     p1wpc001
223800020506     C                   exsr      sf1car
223900020506     ?*
224000020506     C                   endsr
224100991217     ?******************************************************
224200021205      /SPACE
224300021205     ?******************************************************
224400020506     C     sele02        begsr
224500020506     ?** SELECCIONAR EN PANTALLA 02------------------------
224600020506     C                   readc     par310s1                               98
224700020506?1b? C                   if        not *in98                                    ?P----------01
224800040204     C                   exsr      valsel02                                     ?            |
224900040204     ?* De no haber errores en la selección, procesa el SFL.                    ?            |
225000040204?2b? C                   if        not *in50                                    ?P---------02|
225100020506?3b? C                   select                                                 ?P--------03||
225200020506     ?* Seleccionar SuperPóliza...                                              ?          |||
225300020506?3x? C                   when      x2opci = '1'                                 ?w--------03||
225400020506?4b? C                   if        x2wp14 = *zeros                              ?P-------04|||
225500020506     C                   eval      x1arcd = x2arcd                              ?         ||||
225600020506     C                   eval      x1spo1 = x2spo1                              ?         ||||
225700040204     C                   eval      x1tiou = x2tiou                              ?         ||||
225800040204     C                   eval      x1stou = x2stou                              ?         ||||
225900020506     C     x2arcd        chain     s1t620                             20        ?         ||||
226000020506     C  n20              eval      x1arno = t@arno                              ?         ||||
226100020506     C                   eval      xxiden = 1                                   ?         ||||
226200020506?4x? C                   else                                                   ?X.......04|||
226300020506     ?* recargar el subarchivo...                                               ?         ||||
226400020506     C     k3@pc0        setll     p1wpc001                                     ?         ||||
226500020506     C                   exsr      sf1car                                       ?         ||||
226600020506     C   30              eval      xxiden = 2                                   ?         ||||
226700020506     C  n30              eval      xxiden = 1                                   ?         ||||
226800020506?4e? C                   endif                                                  ?F-------04|||
226900020506     ?* Suprimir SuperPòliza...                                                 ?          |||
227000020506?3x? C                   when      x2opci = '4'                                 ?w--------03||
227100020506?4b? C                   if        x2marp = '0'  and                            ?P-------04|||
227200020506     C                             x2wp14 = *zeros                              ?         ||||
227300020506     C                   eval      p310y = 'L'                                  ?         ||||
227400020506     C                   call      'PAR310Y'                                    ?         ||||
227500020506     C                   parm                    x2empr                         ?         ||||
227600020506     C                   parm                    x2sucu                         ?         ||||
227700020506     C                   parm                    x2arcd                         ?         ||||
227800020506     C                   parm                    x2spo1                         ?         ||||
227900020506     C                   parm                    x2spol                         ?         ||||
228000020506     C                   parm                    x2sspo                         ?         ||||
228100020506     C                   parm      *blanks       endpgm                         ?         ||||
228200020506?4e? C                   endif                                                  ?F-------04|||
228300020506     ?* recargar el subarchivo...                                               ?          |||
228400020506     C     k3@pc0        setll     p1wpc001                                     ?          |||
228500020506     C                   exsr      sf1car                                       ?          |||
228600020506     C   30              eval      xxiden = 2                                   ?          |||
228700020506     C  n30              eval      xxiden = 1                                   ?          |||
228800020506     ?* Concretar SuperPóliza..                                                 ?          |||
228900020506?3x? C                   when      x2opci = '9'                                 ?w--------03||
229000020506     C                   unlock    pawpc001                                     ?          |||
229100020506     C     k2@pc0        chain(n)  p1wpc001                           20        ?          |||
229200020506     ?* se puede concretar en dos casos, cuando se produjo                      ?          |||
229300020506     ?* una terminación anormal del par310x pero alcanzó                        ?          |||
229400020506     ?* a numerar los archivos con lo que el w0wp14 tiene                       ?          |||
229500020506     ?* un 1...                                                                 ?          |||
229600020506     C     k2@ec1        chain     p1hec1                             55        ?          |||
229700020506?4b? C                   if        not *in55                                    ?P-------04|||
229800020506     C                   call      'PAR310X3'                                   ?         ||||
229900020506     C                   parm                    usempr                         ?         ||||
230000020506     C                   parm      *zeros        @1fema            4 0          ?         ||||
230100020506     C                   parm      *zeros        @1femm            2 0          ?         ||||
230200020506     C                   parm      *zeros        @1femd            2 0          ?         ||||
230300020506     ?*                                                                         ?         ||||
230400020506     C                   eval      @@fema = @1fema                              ?         ||||
230500020506     C                   eval      @@femm = @1femm                              ?         ||||
230600020506     C                   eval      @@femd = @1femd                              ?         ||||
230700020506     ?*                                                                         ?         ||||
230800020506     C                   call      'SP0052'                                     ?         ||||
230900020506     C                   parm                    c1mone                         ?         ||||
231000020506     C                   parm      @@fech        @@desd            8 0          ?         ||||
231100020506     C                   parm      *zeros        @@come           15 6          ?         ||||
231200040423     C                   parm      'V'           @@tipc            1            ?         ||||
231300020506?5b? C                   if        @@come <> c1come                             ?P------05||||
231400020506     C                   exfmt     par31008                                     ?        |||||
231500020506?5x? C                   else                                                   ?X......05||||
231600020506?6b? C                   select                                                 ?P-----06|||||
231700020506?6x? C                   when      w0wp14 = 1  and                              ?w-----06|||||
231800020506     C                             w0marp = '0'                                 ?       ||||||
231900020506     C                   eval      p310x = 'L'                                  ?       ||||||
232000040204     ?* Se llama con la lista que corresponda según la                          ?       ||||||
232100040204     ?* modalidad del llamado.                                                  ?       ||||||
232200040204?7b? C                   if        por_parametros                               ?P----07||||||
232300040204     C                   call      'PAR310X'                                    ?      |||||||
232400040204     C                   parm                    x2empr                         ?      |||||||
232500040204     C                   parm                    x2sucu                         ?      |||||||
232600040204     C                   parm                    x2arcd                         ?      |||||||
232700040204     C                   parm                    x2spo1                         ?      |||||||
232800040204     C                   parm                    x2spol                         ?      |||||||
232900040204     C                   parm                    x2sspo                         ?      |||||||
233000040204     C                   parm      'INT'         @@modo                         ?      |||||||
233100040204     C                   parm      *blanks       endpgm                         ?      |||||||
233200040204     C                   parm                    iispol                         ?      |||||||
233300040204?7x? C                   else                                                   ?X....07||||||
233400040204     C                   call      'PAR310X'                                    ?      |||||||
233500040204     C                   parm                    x2empr                         ?      |||||||
233600040204     C                   parm                    x2sucu                         ?      |||||||
233700040204     C                   parm                    x2arcd                         ?      |||||||
233800040204     C                   parm                    x2spo1                         ?      |||||||
233900040204     C                   parm                    x2spol                         ?      |||||||
234000040204     C                   parm                    x2sspo                         ?      |||||||
234100040204     C                   parm      'INT'         @@modo                         ?      |||||||
234200040204     C                   parm      *blanks       endpgm                         ?      |||||||
234300040204?7e? C                   endif                                                  ?F----07||||||
234400020506     C                   unlock    pawpc001                                     ?       ||||||
234500020506     C     k2@pc0        chain     p1wpc001                           20        ?       ||||||
234600020506     C  n20              delete    p1wpc001                                     ?       ||||||
234700020506     ?* recargar el subarchivo...                                               ?       ||||||
234800020506     C     k3@pc0        setll     p1wpc001                                     ?       ||||||
234900020506     C                   exsr      sf1car                                       ?       ||||||
235000020506     C   30              eval      xxiden = 2                                   ?       ||||||
235100020506     C  n30              eval      xxiden = 1                                   ?       ||||||
235200020506     ?* cuando el w0wp14 tiene un 0, pero están cumplidos                       ?       ||||||
235300020506     ?* todos los pasos de la operación debo mandar a ru-                       ?       ||||||
235400020506     ?* tina de confirmación...                                                 ?       ||||||
235500020506?6x? C                   when      w0wp14 = 0  and                              ?w-----06|||||
235600020506     C                             w0wp01 = 1  and                              ?       ||||||
235700020506     C                             w0wp02 = 1  and                              ?       ||||||
235800020506     C                             w0wp03 = 1  and                              ?       ||||||
235900020506     C                             w0marp = '0'                                 ?       ||||||
236000020506     C                   exsr      sa02ka                                       ?       ||||||
236100020506     ?* otros casos solo recargar...                                            ?       ||||||
236200020506?6x? C                   other                                                  ?w-----06|||||
236300020506     C     k3@pc0        setll     p1wpc001                                     ?       ||||||
236400020506     C                   exsr      sf1car                                       ?       ||||||
236500020506     C   30              eval      xxiden = 2                                   ?       ||||||
236600020506     C  n30              eval      xxiden = 1                                   ?       ||||||
236700020506?6e? C                   endsl                                                  ?F-----06|||||
236800020506?5e? C                   endif                                                  ?F------05||||
236900020506?4e? C                   endif                                                  ?F-------04|||
237000020506     ?* Cambiar cadena Comercial...                                             ?          |||
237100020506?3x? C                   when      x2opci = 'D'                                 ?w--------03||
237200020506     C                   unlock    pawpc001                                     ?          |||
237300020506     C     k2@pc0        chain(n)  p1wpc001                           20        ?          |||
237400020506?4b? C                   if        w0marp = '0'  and                            ?P-------04|||
237500020506     C                             w0wp01 = 1  and                              ?         ||||
237600020506     C                             w0wp02 = 1  and                              ?         ||||
237700020506     C                             w0wp03 = 1  and                              ?         ||||
237800020506     C                             w0tiou <= 2                                  ?         ||||
237900020506     C     k2@pc0        chain     p1wpc001                           20        ?         ||||
238000020506     C  n20              eval      w0marp = '3'                                 ?         ||||
238100020506     C  n20              update    p1wpc001                                     ?         ||||
238200020506     C                   eval      p319 = 'L'                                   ?         ||||
238300020506     C                   call      'PAR319'                                     ?         ||||
238400020506     C                   parm                    x2empr                         ?         ||||
238500020506     C                   parm                    x2sucu                         ?         ||||
238600020506     C                   parm                    x2arcd                         ?         ||||
238700020506     C                   parm                    x2spo1                         ?         ||||
238800020506     C                   parm                    x2spol                         ?         ||||
238900020506     C                   parm                    x2sspo                         ?         ||||
239000020506     C                   parm      *blanks       endpgm                         ?         ||||
239100020506     C     k2@pc0        chain     p1wpc001                           20        ?         ||||
239200020506     C  n20              eval      w0marp = '0'                                 ?         ||||
239300020506     C  n20              update    p1wpc001                                     ?         ||||
239400020506     C                   eval      x2opci = *blanks                             ?         ||||
239500020506     C                   exsr      updsfl                                       ?         ||||
239600020506?4x? C                   else                                                   ?X.......04|||
239700020506     C                   eval      x2opci = *blanks                             ?         ||||
239800020506     C                   exsr      updsfl                                       ?         ||||
239900020506?4e? C                   endif                                                  ?F-------04|||
240000020506?3e? C                   endsl                                                  ?F--------03||
240100020506?2e? C                   endif                                                  ?F---------02|
240200040204?1e? C                   endif                                                  ?F----------01
240300020506     ?*
240400020506     C                   endsr
240500040204     ?******************************************************
240600040204      /SPACE
240700040204     ?******************************************************
240800040204     Csr   valsel02      begsr
240900040204     ?* Valida opciones del SFL de Suspendidas.            *
241000040204     ?*----------------------------------------------------*
241100040204     ?* Las operaciones de Speedway V2 sólo pueden tratarse desde Speedway.
241200040204?1b? C                   if        x2vers = '2'                                 ?P----------01
241300040204     C                   eval      xidmsg = 'PRO9035'                           ?            |
241400040204     C                   eval      *in50 = *on                                  ?            |
241500040204?1e? C                   endif                                                  ?F----------01
241600040204     ?* Actualiza Subfile para refrescar indicadores.
241700040204?1b? C                   if        *in50                                        ?P----------01
241800040204     C                   eval      x2opci = *blank                              ?            |
241900040204     C                   exsr      updsfl                                       ?            |
242000040204?1e? C                   endif                                                  ?F----------01
242100040204     ?*----------------------------------------------------*
242200040204     Csr                 endsr
242300991217     ?******************************************************
242400021205      /SPACE
242500021205     ?******************************************************
242600020506     C     updsfl        begsr
242700020506     ?** ACTAULIZAR EL SUBARCHIVO--------------------------
242800020506     C                   setoff                                         4647
242900020506     C                   setoff                                         4849
243000020506     C     w0user        comp      vsuser                                 49
243100020506     C     w0marp        comp      '3'                                    48
243200020506     C     w0marp        comp      '4'                                    46
243300020506     C     w0marp        comp      '5'                                    47
243400020506     C                   update    par310s1
243500020506     C                   setoff                                         4647
243600020506     C                   setoff                                         4849
243700020506     ?*
243800020506     C                   endsr
243900991217     ?******************************************************
244000021205      /SPACE
244100021205     ?******************************************************
244200020506     C     rollup        begsr
244300020506     ?** AVANCE DE PAGINA----------------------------------
244400020506     C     @@lsf1        chain     par310s1                           50
244500020506     ?*- VER EL PROXIMO REGISTRO...
244600020506     C  n50k2@pc0        setll     p1wpc001
244700020506     C  n50k3@pc0        reade(n)  p1wpc001                               99
244800020506     C  n50
244900020506     Cann99              exsr      sf1car
245000020506     C  n50
245100020506     Can 99              seton                                            50
245200020506     ?*- MENSAJE DE ERROR...
245300020506     C   50              eval      xidmsg = 'PRO0057'
245400020506     ?*
245500020506     C                   endsr
245600991217     ?******************************************************
245700021205      /SPACE
245800021205     ?******************************************************
245900020506     C     roldwn        begsr
246000020506     ?** RETROCESO DE PAGINA-------------------------------
246100020506     C     1             chain     par310s1                           20
246200020506     ?*- VER SI ESTÁ AL COMIENZO DEL GRUPO...
246300020506     C                   setoff                                           99
246400020506     C     k2@pc0        setll     p1wpc001
246500020506     C     k3@pc0        readpe(n) p1wpc001                               99
246600020506     C   99k3@pc0        setll     p1wpc001
246700020506     C   99              seton                                            50
246800020506     C   99              eval      xidmsg = 'PRO0058'
246900020506     ?*- DE LO CONTRARIO RECARGAR...
247000020506?1b? C                   if        not *in50                                    ?P----------01
247100020506     C                   setoff                                           99    ?            |
247200020506     C                   eval      sf1rrn = *zeros                              ?            |
247300020506     C     k2@pc0        setll     p1wpc001                                     ?            |
247400020506?2b? C                   dou       *in99  or                                    ?P---------02|
247500020506     C                             sf1rrn = 11                                  ?           ||
247600020506     C     k3@pc0        readpe(n) p1wpc001                               99    ?           ||
247700020506?3b? C                   if        not *in99                                    ?P--------03||
247800020506     C                   add       1             sf1rrn                         ?          |||
247900020506?3e? C                   endif                                                  ?F--------03||
248000020506?2e? C                   enddo                                                  ?F---------02|
248100020506     ?*- RECARGAR...                                                            ?            |
248200020506     C   99k3@pc0        setll     p1wpc001                                     ?            |
248300020506     C                   exsr      sf1car                                       ?            |
248400020506?1e? C                   endif                                                  ?F----------01
248500020506     ?*
248600020506     C                   endsr
248700991217     ?******************************************************
248800021205      /SPACE
248900021205     ?******************************************************
249000020506     C     pant03        begsr
249100020506     ?** PROCESO PANTALLA 03-------------------------------
249200020506     C                   exfmt     par31003
249300020506     ?*- CORRIGE SITUACIONES DE ERROR ...
249400020506     C                   exsr      apagar
249500020506     ?*- PROCESA TECLAS DE FUNCION...
249600020506?1b? C                   select                                                 ?P----------01
249700020506     ?*- F3=SALIR...                                                            ?            |
249800020506?1x? C                   when      *inkc                                        ?w----------01
249900020506     C                   exsr      libe03                                       ?            |
250000020506     ?*- F4=SOLICITUD...                                                        ?            |
250100020506?1x? C                   when      *inkd                                        ?w----------01
250200020506     C                   exsr      soli03                                       ?            |
250300020506     ?*- PULSA INTRO...                                                         ?            |
250400020506?1x? C                   when      not *in29                                    ?w----------01
250500020506     C                   exsr      vali03                                       ?            |
250600020506?1e? C                   endsl                                                  ?F----------01
250700020506     ?*
250800020506     C                   endsr
250900991217     ?******************************************************
251000021205      /SPACE
251100021205     ?******************************************************
251200020506     C     libe03        begsr
251300020506     ?** LIBERAR OPERACION TOMADA--------------------------
251400020506     C     k1@pc0        chain     p1wpc001                           20
251500020506     C  n20              eval      w0marp = '0'
251600020506     C  n20              update    p1wpc001
251700020506     C  n20              exsr      borr01
251800020506     C  n20              exsr      defe01
251900020506     C  n20              eval      xxiden = 1
252000020506     C  n20              eval      *inkc = '0'
252100020506     ?*
252200020506     C                   endsr
252300991217     ?******************************************************
252400021205      /SPACE
252500021205     ?******************************************************
252600020506     C     carg03        begsr
252700020506     ?** CARGAR PANTALLA 03--------------------------------
252800020506     C                   setoff                                           90
252900020506     ?*
253000020506     C                   endsr
253100991217     ?******************************************************
253200021205      /SPACE
253300021205     ?******************************************************
253400020506     C     soli03        begsr
253500020506     ?** SOLICITUD PANTALLA 03-----------------------------
253600020506     ?*
253700020506     C                   endsr
253800991217     ?******************************************************
253900021205      /SPACE
254000021205     ?******************************************************
254100020506     C     vali03        begsr
254200020506     ?** VALIDACION PANTALLA 03----------------------------
254300020506?1b? C                   if        *in90                                        ?P----------01
254400020506     C                   exsr      grab03                                       ?            |
254500020506     ?* recien aca se boletea el archivo de trabajo de                          ?            |
254600020506     ?* cabecera con lo cual se librera la operaciòn                            ?            |
254700020506     ?* suspendida...                                                           ?            |
254800020506     C     k1@pc0        chain     p1wpc001                           20        ?            |
254900020506     C  n20              delete    p1wpc001                                     ?            |
255000020506     C                   exsr      borr01                                       ?            |
255100020506     C                   exsr      defe01                                       ?            |
255200040204     ?* Por parámetros debe irse al terminar, por lo que fuerza F3.             ?            |
255300040204     C                   eval      *inkc = por_parametros                       ?            |
255400020506     C                   eval      xxiden = 1                                   ?            |
255500020506?1x? C                   else                                                   ?X..........01
255600020506     C                   seton                                        90        ?            |
255700020506?1e? C                   endif                                                  ?F----------01
255800020506     ?*
255900020506     C                   endsr
256000991217     ?******************************************************
256100021205      /SPACE
256200021205     ?******************************************************
256300020506     C     grab03        begsr
256400020506     ?** GRABACION DEL NUMERO DE POLIZA/ENDOSO-------------
256500020506     C                   eval      p310x = 'L'
256600040204     ?* Se llama con la lista que corresponda según la
256700040204     ?* modalidad del llamado.
256800040204?1b? C                   if        por_parametros                               ?P----------01
256900040204     C                   call      'PAR310X'                                    ?            |
257000040204     C                   parm                    usempr                         ?            |
257100040204     C                   parm                    ussucu                         ?            |
257200040204     C                   parm                    w0arcd                         ?            |
257300040204     C                   parm                    w0spo1                         ?            |
257400040204     C                   parm                    w0spol                         ?            |
257500040204     C                   parm                    w0sspo                         ?            |
257600040204     C                   parm      'INT'         @@modo                         ?            |
257700040204     C                   parm      *blanks       endpgm                         ?            |
257800040204     C                   parm                    iispol                         ?            |
257900040204?1x? C                   else                                                   ?X..........01
258000040204     C                   call      'PAR310X'                                    ?            |
258100040204     C                   parm                    usempr                         ?            |
258200040204     C                   parm                    ussucu                         ?            |
258300040204     C                   parm                    w0arcd                         ?            |
258400040204     C                   parm                    w0spo1                         ?            |
258500040204     C                   parm                    w0spol                         ?            |
258600040204     C                   parm                    w0sspo                         ?            |
258700040204     C                   parm      'INT'         @@modo                         ?            |
258800040204     C                   parm      *blanks       endpgm                         ?            |
258900040204?1e? C                   endif                                                  ?F----------01
259000020506     ?*
259100020506     C                   endsr
259200991217     ?******************************************************
259300021205      /SPACE
259400021205     ?******************************************************
259500020506     C     pant04        begsr
259600020506     ?** PROCESO PANTALLA 03-------------------------------
259700020506     C                   exfmt     par31004
259800020506     ?*- CORRIGE SITUACIONES DE ERROR ...
259900020506     C                   exsr      apagar
260000020506     ?*- PROCESA TECLAS DE FUNCION...
260100020506?1b? C                   select                                                 ?P----------01
260200020506     ?*- F3=SALIR...                                                            ?            |
260300020506?1x? C                   when      *inkc                                        ?w----------01
260400020506     C                   exsr      libe04                                       ?            |
260500020506     ?*- F4=SOLICITUD...                                                        ?            |
260600020506?1x? C                   when      *inkd                                        ?w----------01
260700020506     C                   exsr      soli04                                       ?            |
260800020506     ?*- PULSA INTRO...                                                         ?            |
260900020506?1x? C                   when      not *in29                                    ?w----------01
261000020506     C                   exsr      vali04                                       ?            |
261100020506?1e? C                   endsl                                                  ?F----------01
261200020506     ?*
261300020506     C                   endsr
261400991217     ?******************************************************
261500021205      /SPACE
261600021205     ?******************************************************
261700020506     C     libe04        begsr
261800020506     ?** LIBERAR OPERACION TOMADA--------------------------
261900020506     C                   exsr      libe03
262000020506     ?*
262100020506     C                   endsr
262200991217     ?******************************************************
262300021205      /SPACE
262400021205     ?******************************************************
262500020506     C     carg04        begsr
262600020506     ?** CARGAR PANTALLA 04--------------------------------
262700020506     C                   setoff                                           90
262800020506     ?*
262900020506     C                   endsr
263000991217     ?******************************************************
263100021205      /SPACE
263200021205     ?******************************************************
263300020506     C     soli04        begsr
263400020506     ?** SOLICITUD PANTALLA 04-----------------------------
263500020506     ?*
263600020506     C                   endsr
263700991217     ?******************************************************
263800021205      /SPACE
263900021205     ?******************************************************
264000020506     C     vali04        begsr
264100020506     ?** VALIDACION PANTALLA 03----------------------------
264200020506?1b? C                   if        *in90                                        ?P----------01
264300020506     C                   exsr      grab04                                       ?            |
264400020506     C                   exsr      borr01                                       ?            |
264500020506     C                   exsr      defe01                                       ?            |
264600040204     ?* Por parámetros debe irse al terminar, por lo que fuerza F3.             ?            |
264700040204     C                   eval      *inkc = por_parametros                       ?            |
264800020506     C                   eval      xxiden = 1                                   ?            |
264900020506?1x? C                   else                                                   ?X..........01
265000020506     C                   seton                                        90        ?            |
265100020506?1e? C                   endif                                                  ?F----------01
265200020506     ?*
265300020506     C                   endsr
265400991217     ?******************************************************
265500021205      /SPACE
265600021205     ?******************************************************
265700020506     C     grab04        begsr
265800020506     ?** GRABAR MARCA DE SUSPENDIDA ESPECIAL---------------
265900020506     C     k1@pc0        chain     p1wpc001                           20
266000020506?1b? C                   if        not *in20                                    ?P----------01
266100020506     C                   eval      w0marp = '4'                                 ?            |
266200020506     C                   update    p1wpc001                                     ?            |
266300020506?1e? C                   endif                                                  ?F----------01
266400020506     ?** GRABAR COBERTURA PROVISORIA-----------------------
266500020506     C     k1@ec4        chain     p1hec4                             20
266600020506     C   20              exsr      graec4
266700020506     C   20k1@ec4        chain     p1hec4                             20
266800020506?1b? C                   if        not *in20  and                               ?P----------01
266900020506     C                             c4cobn = *zeros                              ?            |
267000020506     C     k2@ec1        chain     p1hec1                             20        ?            |
267100020506?2b? C                   if        not *in20                                    ?P---------02|
267200020506     C     k2@ed0        chain     p1hed0                             20        ?           ||
267300020506?3b? C                   if        not *in20                                    ?P--------03||
267400020506     ?* BUSCAR NUMERO DE COBERTURA...                                           ?          |||
267500020506     C                   eval      t@tnum = 'Z'                                 ?          |||
267600020506     C     t@tnum        chain     s1t902                             20        ?          |||
267700020506     C   20              eval      t@nres = 1                                   ?          |||
267800020506     C   20              write     s1t902                                       ?          |||
267900020506     C  n20              add       1             t@nres                         ?          |||
268000020506     C  n20              update    s1t902                                       ?          |||
268100020506     C                   eval      p0empr = c1empr                              ?          |||
268200020506     C                   eval      p0sucu = c1sucu                              ?          |||
268300020506     C                   eval      p0cobn = t@nres                              ?          |||
268400140927     C     k1hcp0        setll     pahcp0
268500140927     C                   if        not %equal
268600020506     C                   eval      p0arcd = c1arcd                              ?          |||
268700020506     C                   eval      p0spol = c1spol                              ?          |||
268800020506     C                   eval      p0sspo = c1sspo                              ?          |||
268900020506     C                   eval      p0cert = *zeros                              ?          |||
269000020506     C                   eval      p0asen = c1asen                              ?          |||
269100020506     C                   eval      p0fipa = *year                               ?          |||
269200020506     C                   eval      p0fipm = umonth                              ?          |||
269300020506     C                   eval      p0fipd = uday                                ?          |||
269400020506     C                   eval      p0fema = *zeros                              ?          |||
269500020506     C                   eval      p0femm = *zeros                              ?          |||
269600020506     C                   eval      p0femd = *zeros                              ?          |||
269700020506     C                   eval      p0fioa = d0fioa                              ?          |||
269800020506     C                   eval      p0fiom = d0fiom                              ?          |||
269900020506     C                   eval      p0fiod = d0fiod                              ?          |||
270000020506     C                   eval      p0fvoa = d0fvoa                              ?          |||
270100020506     C                   eval      p0fvom = d0fvom                              ?          |||
270200020506     C                   eval      p0fvod = d0fvod                              ?          |||
270300020506     ?* P0MAR1=1 indica generado por Módulo de Emisión                          ?          |||
270400020506     C                   eval      p0mar1 = '1'                                 ?          |||
270500020506     ?* P0MAR2=1 indica Asignado a una SuperPóliza...                           ?          |||
270600020506     C                   eval      p0mar2 = '1'                                 ?          |||
270700020506     ?* P0MAR2=0 Indica que no está listado...                                  ?          |||
270800020506     C                   eval      p0mar3 = '0'                                 ?          |||
270900020506     ?* Restantes marcas por ahora sin unso...                                  ?          |||
271000020506     C                   eval      p0mar4 = '0'                                 ?          |||
271100020506     C                   eval      p0mar5 = '0'                                 ?          |||
271200020506     C                   eval      p0mar6 = '0'                                 ?          |||
271300020506     C                   eval      p0mar7 = '0'                                 ?          |||
271400020506     C                   eval      p0mar8 = '0'                                 ?          |||
271500020506     C                   eval      p0mar9 = '0'                                 ?          |||
271600020506     C                   eval      p0mar0 = '0'                                 ?          |||
271700020506     C                   eval      p0strg = '0'                                 ?          |||
271800020506     C                   eval      p0user = vsuser                              ?          |||
271900020506     C                   time                    p0time                         ?          |||
272000020506     C                   eval      p0date = udate                               ?          |||
272100020506     ?* Los demás campos no se usan cuando es una cobertura                     ?          |||
272200020506     ?* genererada por una suspendida especial por lo tanto                     ?          |||
272300020506     ?* los inicializo en cero o blanco según corresponda                       ?          |||
272400020506     C                   clear                   p0rama                         ?          |||
272500020506     C                   clear                   p0mone                         ?          |||
272600020506     C                   clear                   p0saop                         ?          |||
272700020506     C                   clear                   p0ffva                         ?          |||
272800020506     C                   clear                   p0ffvm                         ?          |||
272900020506     C                   clear                   p0ffvd                         ?          |||
273000020506     C                   clear                   p0vhmc                         ?          |||
273100020506     C                   clear                   p0vhmo                         ?          |||
273200020506     C                   clear                   p0vhcs                         ?          |||
273300020506     C                   clear                   p0vhcr                         ?          |||
273400020506     C                   clear                   p0vhaÑ                         ?          |||
273500020506     C                   clear                   p0vhni                         ?          |||
273600020506     C                   clear                   p0patl                         ?          |||
273700020506     C                   clear                   p0patn                         ?          |||
273800020506     C                   clear                   p0panl                         ?          |||
273900020506     C                   clear                   p0pann                         ?          |||
274000020506     C                   clear                   p0moto                         ?          |||
274100020506     C                   clear                   p0chas                         ?          |||
274200020506     C                   clear                   p0vhct                         ?          |||
274300020506     C                   clear                   p0vhuv                         ?          |||
274400020506     C                   clear                   p0cobl                         ?          |||
274500111125     C                   clear                   p0TMAT                         ?          |||
274600111125     C                   clear                   p0NMAT                         ?          |||
274700020506     C                   write     p1hcp0                                       ?          |||
274800140927?3e? C                   endif                                                  ?F--------03||
274900020506     ?* actualizar pahec4...                                                    ?          |||
275000020506     C                   eval      c4cobn = p0cobn                              ?          |||
275100020506     C                   update    p1hec4                                       ?          |||
275200020506?3e? C                   endif                                                  ?F--------03||
275300020506?2e? C                   endif                                                  ?F---------02|
275400020506?1e? C                   endif                                                  ?F----------01
275500020506     C                   unlock    pahec4
275600020506     ?*
275700020506     C                   endsr
275800991217     ?******************************************************
275900021205      /SPACE
276000021205     ?******************************************************
276100020506     C     graec4        begsr
276200020506     ?** GRABACION PAHEC4----------------------------------
276300020506     ?* Esta grabación está acá para el caso que se renue-
276400020506     ?* ven registros que viene de conversion que quizá no
276500020506     ?* generaron el PAHEC4 porque no estaba en la póliza
276600020506     ?* anterior...
276700020506     C                   eval      c4empr = usempr
276800020506     C                   eval      c4sucu = ussucu
276900020506     C                   eval      c4arcd = w0arcd
277000020506     C                   eval      c4spol = w0spol
277100020506     C                   eval      c4sspo = w0sspo
277200020506     C                   eval      c4cert = *zeros
277300020506     C                   eval      c4cobn = *zeros
277400020506     C                   eval      c4soln = *zeros
277500020506     C                   eval      c4mar1 = '0'
277600020506     C                   eval      c4mar2 = '0'
277700020506     C                   eval      c4mar3 = '0'
277800020506     C                   eval      c4mar4 = '0'
277900020506     C                   eval      c4mar5 = '0'
278000020506     C                   eval      c4user = vsuser
278100020506     C                   time                    c4time
278200020506     C                   eval      c4date = udate
278300020506     C                   eval      c4ref1 = *zeros
278400020506     C                   eval      c4ref2 = *zeros
278500020506     C                   eval      c4ref3 = *blanks
278600020506     C                   eval      c4ref4 = *blanks
278700020506     C                   eval      c4sarc = *zeros
278800020506     C                   write     p1hec4
278900020506     ?*-
279000020506     C                   endsr
279100991217     ?******************************************************
279200021205      /SPACE
279300021205     ?******************************************************
279400020506     C     pant05        begsr
279500020506     ?** PROCESO PANTALLA '5' -----------------------------
279600020506     ?*- ENTRADA/SALIDA PANTALLA '5' ...
279700020506     C                   exfmt     par31005
279800020506     ?*- CORRIGE SITUACIONES DE ERROR ...
279900020506     C                   exsr      apagar
280000020506     ?*- PROCESA TECLAS DE FUNCION...
280100020506?1b? C                   select                                                 ?P----------01
280200020506     ?*- F3=SALIR...                                                            ?            |
280300020506?1x? C                   when      *inkc                                        ?w----------01
280400020506     C                   eval      *inkc = '0'                                  ?            |
280500020506     C                   eval      xxiden = 5                                   ?            |
280600020506     ?*- F4=SOLICITUD...                                                        ?            |
280700020506?1x? C                   when      *inkd                                        ?w----------01
280800020506     C                   exsr      soli05                                       ?            |
280900020506     ?*- F12=RETORNAR...                                                        ?            |
281000020506?1x? C                   when      *inkl                                        ?w----------01
281100020506     C                   clear                   x5rama                         ?            |
281200020506     C                   clear                   x5ramd                         ?            |
281300020506     C                   clear                   x5poli                         ?            |
281400020506     C                   eval      xxiden = 1                                   ?            |
281500020506     ?*- PULSA INTRO...                                                         ?            |
281600020506?1x? C                   when      not *in29                                    ?w----------01
281700020506     C                   exsr      vali05                                       ?            |
281800020506?1e? C                   endsl                                                  ?F----------01
281900020506     ?*
282000020506     C                   endsr
282100991217     ?******************************************************
282200021205      /SPACE
282300021205     ?******************************************************
282400020506     C     soli05        begsr
282500020506     ?** SOLICITUD PANTALLA 05-----------------------------
282600020506     C                   call      'DBA001'
282700020506     C                   parm                    x5rama
282800020506?1b? C                   if        x5rama <> *zeros                             ?P----------01
282900020506     C     x5rama        chain     s1t001                             20        ?            |
283000020506     C  n20              eval      x5ramd = t@ramd                              ?            |
283100020506     C   20              eval      x5ramd = *blanks                             ?            |
283200020506?1e? C                   endif                                                  ?F----------01
283300020506     ?*
283400020506     C                   endsr
283500991217     ?******************************************************
283600021205      /SPACE
283700021205     ?******************************************************
283800020506     C     vali05        begsr
283900020506     ?** VALIDACION PANTALLA 05----------------------------
284000020506     C                   eval      x5ramd = *blanks
284100020506     ?*- VALIDO RAMA...
284200020506     C     x5rama        chain     s1t001                             20
284300020506?1b? C                   if        *in20                                        ?P----------01
284400020506     C                   z-add     51            @e                   50        ?            |
284500020506?1x? C                   else                                                   ?X..........01
284600020506     C                   eval      x5ramd = t@ramd                              ?            |
284700020506?1e? C                   endif                                                  ?F----------01
284800020506     ?*- VALIDO RAMA/POLIZA...
284900020506?1b? C                   if        not *in50                                    ?P----------01
285000020506     C     k1@ed0        chain     p1hed004                           20        ?            |
285100020506?2b? C                   if        *in20  or                                    ?P---------02|
285200020506     C                             not *in20  and                               ?           ||
285300020506     C                             d0poli = *zeros                              ?           ||
285400020506     C                   z-add     51            @e                   50        ?           ||
285500020506?2e? C                   endif                                                  ?F---------02|
285600020506?1e? C                   endif                                                  ?F----------01
285700020506     ?*- SI NO EXISTEN ERRORES...
285800020506?1b? C                   if        not *in50                                    ?P----------01
285900020506?2b? C                   if        x5rama = $$rama  and                         ?P---------02|
286000020506     C                             x5poli = $$poli                              ?           ||
286100020506     C                   exsr      grab05                                       ?           ||
286200020506     C                   eval      xxiden = 1                                   ?           ||
286300020506     C                   setoff                                           90    ?           ||
286400020506?2x? C                   else                                                   ?X.........02|
286500020506     C                   eval      $$rama = x5rama                              ?           ||
286600020506     C                   eval      $$poli = x5poli                              ?           ||
286700020506     C                   seton                                            90    ?           ||
286800020506?2e? C                   endif                                                  ?F---------02|
286900020506?1e? C                   endif                                                  ?F----------01
287000020506     ?*- SI EXISTEN ERRORES...
287100020506?1b? C                   if        *in50  and                                   ?P----------01
287200020506     C                             @e > *zeros                                  ?            |
287300020506     C                   write     par31005                                     ?            |
287400020506     C                   eval      *in(@e) = '1'                                ?            |
287500020506     C                   setoff                                           90    ?            |
287600020506?1e? C                   endif                                                  ?F----------01
287700020506     ?*
287800020506     C                   endsr
287900991217     ?******************************************************
288000021205      /SPACE
288100021205     ?******************************************************
288200020506     C     grab05        begsr
288300020506     ?** GRABACION PANTALLA 05-----------------------------
288400020506     C                   eval      x1arcd = d0arcd
288500020506     C                   eval      x1spo1 = d0spol
288600020506     C     x1arcd        chain     s1t620                             20
288700020506     C  n20              eval      x1arno = t@arno
288800020506     C   20              eval      x1arno = *blanks
288900020506     ?*
289000020506     C                   endsr
289100991217     ?******************************************************
289200021205      /SPACE
289300021205     ?******************************************************
289400020506     C     pant06        begsr
289500020506     ?** PROCESO PANTALLA 03-------------------------------
289600020506     C                   exfmt     par31006
289700020506     ?*- CORRIGE SITUACIONES DE ERROR ...
289800020506     C                   exsr      apagar
289900020506     ?*- PROCESA TECLAS DE FUNCION...
290000020506?1b? C                   select                                                 ?P----------01
290100020506     ?*- F3=SALIR...                                                            ?            |
290200020506?1x? C                   when      *inkc                                        ?w----------01
290300020506     C                   exsr      libe06                                       ?            |
290400020506     ?*- F4=SOLICITUD...                                                        ?            |
290500020506?1x? C                   when      *inkd                                        ?w----------01
290600020506     C                   exsr      soli06                                       ?            |
290700020506     ?*- PULSA INTRO...                                                         ?            |
290800020506?1x? C                   when      not *in29                                    ?w----------01
290900020506     C                   exsr      vali06                                       ?            |
291000020506?1e? C                   endsl                                                  ?F----------01
291100020506     ?*
291200020506     C                   endsr
291300991217     ?******************************************************
291400021205      /SPACE
291500021205     ?******************************************************
291600020506     C     libe06        begsr
291700020506     ?** LIBERAR OPERACION TOMADA--------------------------
291800020506     C                   exsr      libe03
291900020506     ?*
292000020506     C                   endsr
292100991217     ?******************************************************
292200021205      /SPACE
292300021205     ?******************************************************
292400020506     C     carg06        begsr
292500020506     ?** CARGAR PANTALLA 06--------------------------------
292600020506     C                   setoff                                           90
292700020506     ?*
292800020506     C                   endsr
292900991217     ?******************************************************
293000021205      /SPACE
293100021205     ?******************************************************
293200020506     C     soli06        begsr
293300020506     ?** SOLICITUD PANTALLA 06-----------------------------
293400020506     ?*
293500020506     C                   endsr
293600991217     ?******************************************************
293700021205      /SPACE
293800021205     ?******************************************************
293900020506     C     vali06        begsr
294000020506     ?** VALIDACION PANTALLA 06----------------------------
294100020506?1b? C                   if        *in90                                        ?P----------01
294200020506     C                   exsr      grab06                                       ?            |
294300020506     ?* recien aca se boletea el archivo de trabajo de                          ?            |
294400020506     ?* cabecera con lo cual se librera la operaciòn                            ?            |
294500020506     ?* suspendida...                                                           ?            |
294600020506     C     k1@pc0        chain     p1wpc001                           20        ?            |
294700020506     C  n20              delete    p1wpc001                                     ?            |
294800020506     C                   exsr      borr01                                       ?            |
294900020506     C                   exsr      defe01                                       ?            |
295000040204     ?* Por parámetros debe irse al terminar, por lo que fuerza F3.             ?            |
295100040204     C                   eval      *inkc = por_parametros                       ?            |
295200020506     C                   eval      xxiden = 1                                   ?            |
295300020506?1x? C                   else                                                   ?X..........01
295400020506     C                   seton                                        90        ?            |
295500020506?1e? C                   endif                                                  ?F----------01
295600020506     ?*
295700020506     C                   endsr
295800991217     ?******************************************************
295900021205      /SPACE
296000021205     ?******************************************************
296100020506     C     grab06        begsr
296200020506     ?** GRABACION PANTALLA 06-----------------------------
296300020506     C                   exsr      grab03
296400020506     ?*
296500020506     C                   endsr
296600991217     ?******************************************************
296700021205      /SPACE
296800021205     ?******************************************************
296900020506     C     borr07        begsr
297000020506     ?** BORRAR PANTALLA 07--------------------------------
297100020506     C                   clear                   x7arcd
297200020506     C                   clear                   x7spol
297300020506     C                   clear                   x7nomb
297400020506     ?*
297500020506     C                   clear                   $7arcd
297600020506     C                   clear                   $7spol
297700020506     ?*
297800020506     C                   endsr
297900991217     ?******************************************************
298000021205      /SPACE
298100021205     ?******************************************************
298200020506     C     pant07        begsr
298300020506     ?** BUSCAR EN PANTALLA 01-----------------------------
298400020506     C                   exfmt     par31007
298500020506     ?*- ANALIZA TECLAS DE FUNCION...
298600020506     C                   exsr      apagar
298700020506?1b? C                   select                                                 ?P----------01
298800020506     ?*- F3=SALIR...                                                            ?            |
298900020506?1x? C                   when      *inkc                                        ?w----------01
299000020506     ?*- F12=RETORNAR...                                                        ?            |
299100020506?1x? C                   when      *inkl                                        ?w----------01
299200020506     C                   exsr      borr07                                       ?            |
299300020506     C                   eval      xxiden = 2                                   ?            |
299400020506     ?*- INTRO=VALIDAR...                                                       ?            |
299500020506?1x? C                   when      not *in29                                    ?w----------01
299600020506     C                   exsr      vali07                                       ?            |
299700020506?1e? C                   endsl                                                  ?F----------01
299800020506     ?*
299900020506     C                   endsr
300000991217     ?******************************************************
300100021205      /SPACE
300200021205     ?******************************************************
300300020506     C     vali07        begsr
300400020506     ?** VALIDACION PANTALLA 07----------------------------
300500020506     C                   clear                   x7nomb
300600020506     C     k5@pc0        chain     p1wpc002                           20
300700020506?1b? C                   if        *in20                                        ?P----------01
300800020506     C                   seton                                        5051      ?            |
300900020506?1x? C                   else                                                   ?X..........01
301000020506     C     k2@ec1        chain     p1hec1                             20        ?            |
301100020506     C  n20c1asen        chain     g1hdaf                             20        ?            |
301200020506     C  n20              eval      x7nomb = dfnomb                              ?            |
301300020506?1e? C                   endif                                                  ?F----------01
301400020506     ?* no existen errores y *in90 prendido...
301500020506?1b? C                   select                                                 ?P----------01
301600020506?1x? C                   when      not *in50  and                               ?w----------01
301700020506     C                             *in90  and                                   ?            |
301800020506     C                             x7arcd = $7arcd  and                         ?            |
301900020506     C                             x7spol = $7spol                              ?            |
302000020506     C                   eval      xxarcd = w0arcd                              ?            |
302100020506     C                   eval      xxspo1 = w0spo1                              ?            |
302200020506     C                   exsr      posi02                                       ?            |
302300020506     C                   eval      xxiden = 2                                   ?            |
302400020506     C                   setoff                                       90        ?            |
302500020506     ?* no existen errores y *in90 apagado...                                   ?            |
302600020506?1x? C                   when      not *in50                                    ?w----------01
302700020506     C                   eval      $7arcd = x7arcd                              ?            |
302800020506     C                   eval      $7spol = x7spol                              ?            |
302900020506     C                   seton                                        90        ?            |
303000020506     ?* existen errores...                                                      ?            |
303100020506?1x? C                   when      *in50                                        ?w----------01
303200020506     C                   eval      $7arcd = *zeros                              ?            |
303300020506     C                   eval      $7spol = *zeros                              ?            |
303400020506     C                   setoff                                       90        ?            |
303500020506?1e? C                   endsl                                                  ?F----------01
303600020506     ?*
303700020506     C                   endsr
303800991217     ?******************************************************
303900021205      /SPACE
304000021205     ?******************************************************
304100020506     C     apagar        begsr
304200020506     ?** APAGA INDICADORES DE ERROR -----------------------
304300020506     C                   eval      xidmsg = *blanks
304400020506     C                   setoff                                       505152
304500020506     C                   setoff                                       535455
304600020506     C                   setoff                                       565758
304700020506     C                   setoff                                       596061
304800020506     C                   setoff                                       626364
304900020506     C                   setoff                                       656667
305000020506     C                   setoff                                       686970
305100020506     C                   setoff                                       717273
305200020506     C                   setoff                                       747576
305300020506     C                   setoff                                       777879
305400020506     C                   setoff                                       808182
305500020506     C                   setoff                                       838485
305600020506     C                   setoff                                       868788
305700020506     C                   setoff                                           89
305800130607     C                   setoff                                           94
305900020506     C                   eval      @e = *zeros
306000020506     ?*
306100020506     C                   endsr
306200991217     ?******************************************************
306300021205      /SPACE
306400021205     ?******************************************************
306500020506     C     srclos        begsr
306600020506     ?** DESCARGAR PROGRAMAS CERRAR ARCHIVOS---------------
306700020506     ?** GRABACION DE CABECERAS...
306800020506     C                   call      'SP00195'
306900020506     C                   parm                    x1arcd
307000020506     C                   parm                    x1spo1
307100020506     C                   parm                    @@sald
307200020506     C                   parm      'FIN'         @@finp
307300020506?1b? C                   if        p310c = 'L'                                  ?P----------01
307400020506     C                   call      'PAR310C'                                    ?            |
307500020506     C                   parm                    usempr                         ?            |
307600020506     C                   parm                    ussucu                         ?            |
307700020506     C                   parm                    w0arcd                         ?            |
307800020506     C                   parm                    w0spo1                         ?            |
307900020506     C                   parm                    w0spol                         ?            |
308000020506     C                   parm                    w0sspo                         ?            |
308100020506     C                   parm      *blanks       @@mand                         ?            |
308200020506     C                   parm      'FIN'         endpgm                         ?            |
308300020506?1e? C                   endif                                                  ?F----------01
308400020506     ?** GRABACION DE DETALLE...
308500020506?1b? C                   if        p310d = 'L'                                  ?P----------01
308600020506     C                   call      'PAR310D'                                    ?            |
308700020506     C                   parm                    z0empr                         ?            |
308800020506     C                   parm                    z0sucu                         ?            |
308900020506     C                   parm                    z0arcd                         ?            |
309000020506     C                   parm                    z0spo1                         ?            |
309100020506     C                   parm                    z0spol                         ?            |
309200020506     C                   parm                    z0sspo                         ?            |
309300020506     C                   parm                    z0rama                         ?            |
309400020506     C                   parm                    z0arse                         ?            |
309500020506     C                   parm                    z0oper                         ?            |
309600020506     C                   parm                    z0suop                         ?            |
309700020506     C                   parm      *blanks       @@mand                         ?            |
309800020506     C                   parm      'FIN'         endpgm                         ?            |
309900020506?1e? C                   endif                                                  ?F----------01
310000020506     ?** GRABACION DE TEXTOS DE LA OPERACION...
310100020506?1b? C                   if        p310e = 'L'                                  ?P----------01
310200020506     C                   call      'PAR310E'                                    ?            |
310300020506     C                   parm                    z0empr                         ?            |
310400020506     C                   parm                    z0sucu                         ?            |
310500020506     C                   parm                    z0arcd                         ?            |
310600020506     C                   parm                    z0spo1                         ?            |
310700020506     C                   parm                    z0spol                         ?            |
310800020506     C                   parm                    z0sspo                         ?            |
310900020506     C                   parm                    z0rama                         ?            |
311000020506     C                   parm                    z0arse                         ?            |
311100020506     C                   parm                    z0oper                         ?            |
311200020506     C                   parm                    z0suop                         ?            |
311300020506     C                   parm      *blanks       @@mand                         ?            |
311400020506     C                   parm      'FIN'         endpgm                         ?            |
311500020506?1e? C                   endif                                                  ?F----------01
311600020506     ?** ANEXOS Y CLAUSULAS...
311700020506?1b? C                   if        p310f = 'L'                                  ?P----------01
311800020506     C                   call      'PAR310F'                                    ?            |
311900020506     C                   parm                    z0empr                         ?            |
312000020506     C                   parm                    z0sucu                         ?            |
312100020506     C                   parm                    z0arcd                         ?            |
312200020506     C                   parm                    z0spo1                         ?            |
312300020506     C                   parm                    z0spol                         ?            |
312400020506     C                   parm                    z0sspo                         ?            |
312500020506     C                   parm                    z0rama                         ?            |
312600020506     C                   parm                    z0arse                         ?            |
312700020506     C                   parm                    z0oper                         ?            |
312800020506     C                   parm                    z0suop                         ?            |
312900020506     C                   parm      *blanks       @@mand                         ?            |
313000020506     C                   parm      'FIN'         endpgm                         ?            |
313100020506?1e? C                   endif                                                  ?F----------01
313200020506     ?** GRABACION DE NUMEROS DE POLIZAS/ENDOSOS...
313300020506?1b? C                   if        p310x = 'L'                                  ?P----------01
313400020506     C                   call      'PAR310X'                                    ?            |
313500020506     C                   parm                    usempr                         ?            |
313600020506     C                   parm                    ussucu                         ?            |
313700020506     C                   parm                    w0arcd                         ?            |
313800020506     C                   parm                    w0spo1                         ?            |
313900020506     C                   parm                    w0spol                         ?            |
314000020506     C                   parm                    w0sspo                         ?            |
314100020506     C                   parm      'INT'         @@modo                         ?            |
314200020506     C                   parm      'FIN'         endpgm                         ?            |
314300020506?1e? C                   endif                                                  ?F----------01
314400020506     ?** BORRATINA DE ARCHIVOS RELACIONADOS...
314500020506?1b? C                   if        p310y = 'L'                                  ?P----------01
314600020506     C                   call      'PAR310Y'                                    ?            |
314700020506     C                   parm                    x2empr                         ?            |
314800020506     C                   parm                    x2sucu                         ?            |
314900020506     C                   parm                    x2arcd                         ?            |
315000020506     C                   parm                    x2spo1                         ?            |
315100020506     C                   parm                    x2spol                         ?            |
315200020506     C                   parm                    x2sspo                         ?            |
315300020506     C                   parm      'FIN'         endpgm                         ?            |
315400020506?1e? C                   endif                                                  ?F----------01
315500020506     ?** NOMINA DE VIDA...
315600020506?1b? C                   if        p311c = 'L'                                  ?P----------01
315700020506     C                   call      'PAR311C'                                    ?            |
315800020506     C                   parm                    z0empr                         ?            |
315900020506     C                   parm                    z0sucu                         ?            |
316000020506     C                   parm                    z0arcd                         ?            |
316100020506     C                   parm                    z0spo1                         ?            |
316200020506     C                   parm                    z0spol                         ?            |
316300020506     C                   parm                    z0sspo                         ?            |
316400020506     C                   parm                    z0rama                         ?            |
316500020506     C                   parm                    z0arse                         ?            |
316600020506     C                   parm                    z0oper                         ?            |
316700020506     C                   parm                    z0suop                         ?            |
316800020506     C                   parm      *blanks       @@mand                         ?            |
316900020506     C                   parm      'FIN'         endpgm                         ?            |
317000020506?1e? C                   endif                                                  ?F----------01
317100020506     ?** CALCULO DE PREMIO...
317200020506?1b? C                   if        p312c = 'L'                                  ?P----------01
317300020506     C                   call      'PAR312C'                                    ?            |
317400020506     C                   parm                    z0empr                         ?            |
317500020506     C                   parm                    z0sucu                         ?            |
317600020506     C                   parm                    z0arcd                         ?            |
317700020506     C                   parm                    z0spo1                         ?            |
317800020506     C                   parm                    z0spol                         ?            |
317900020506     C                   parm                    z0sspo                         ?            |
318000020506     C                   parm                    z0rama                         ?            |
318100020506     C                   parm                    z0arse                         ?            |
318200020506     C                   parm                    z0oper                         ?            |
318300020506     C                   parm                    z0suop                         ?            |
318400020506     C                   parm      *blanks       @@mand                         ?            |
318500020506     C                   parm      'FIN'         endpgm                         ?            |
318600020506?1e? C                   endif                                                  ?F----------01
318700020506     ?** CALCULO DE COOMISIONES...
318800020506?1b? C                   if        p312f = 'L'                                  ?P----------01
318900020506     C                   call      'PAR312F'                                    ?            |
319000020506     C                   parm                    z0empr                         ?            |
319100020506     C                   parm                    z0sucu                         ?            |
319200020506     C                   parm                    z0arcd                         ?            |
319300020506     C                   parm                    z0spo1                         ?            |
319400020506     C                   parm                    z0spol                         ?            |
319500020506     C                   parm                    z0sspo                         ?            |
319600020506     C                   parm                    z0rama                         ?            |
319700020506     C                   parm                    z0arse                         ?            |
319800020506     C                   parm                    z0oper                         ?            |
319900020506     C                   parm                    z0suop                         ?            |
320000020506     C                   parm      *blanks       @@mand                         ?            |
320100020506     C                   parm      'FIN'         endpgm                         ?            |
320200020506?1e? C                   endif                                                  ?F----------01
320300171002     ?** PLANES MUNDIALES AXA...
320400171002?1b? C                   if        p310p = 'L'                                  ?P----------01
320500171002     C                   call      'PAR310P'                                    ?            |
320600171002     C                   parm                    usempr                         ?            |
320700171002     C                   parm                    ussucu                         ?            |
320800171002     C                   parm                    w0arcd                         ?            |
320900171002     C                   parm                    w0spo1                         ?            |
321000171002     C                   parm                    w0spol                         ?            |
321100171002     C                   parm                    w0sspo                         ?            |
321200171002     C                   parm      *blanks       @@mand                         ?            |
321300171002     C                   parm      'FIN'         endpgm                         ?            |
321400171002?1e? C                   endif                                                  ?F----------01
321500020506     ?** CUOTAS UNIFICADAS...
321600020506?1b? C                   if        p310w = 'L'                                  ?P----------01
321700020506     C                   call      'PAR310W'                                    ?            |
321800020506     C                   parm                    w0empr                         ?            |
321900020506     C                   parm                    w0sucu                         ?            |
322000020506     C                   parm                    w0arcd                         ?            |
322100020506     C                   parm                    w0spo1                         ?            |
322200020506     C                   parm                    w0spol                         ?            |
322300020506     C                   parm                    w0sspo                         ?            |
322400020506     C                   parm      *blanks       @@mand                         ?            |
322500020506     C                   parm      'FIN'         endpgm                         ?            |
322600020506?1e? C                   endif                                                  ?F----------01
322700020506     ?** COBRADORES ADICIONALES...
322800020506?1b? C                   if        p310r = 'L'                                  ?P----------01
322900020506     C                   call      'PAR310R'                                    ?            |
323000020506     C                   parm                    usempr                         ?            |
323100020506     C                   parm                    ussucu                         ?            |
323200020506     C                   parm                    w0arcd                         ?            |
323300020506     C                   parm                    w0spo1                         ?            |
323400020506     C                   parm                    w0spol                         ?            |
323500020506     C                   parm                    w0sspo                         ?            |
323600020506     C                   parm                    @@mone                         ?            |
323700020506     C                   parm                    @@cbrn                         ?            |
323800020506     C                   parm                    @@czco                         ?            |
323900020506     C                   parm      *blanks       @@mand                         ?            |
324000020506     C                   parm      'FIN'         endpgm                         ?            |
324100020506?1e? C                   endif                                                  ?F----------01
324200020506     ?** BUSQUEDA EN NOMINA ORIGINAL...
324300020506     C                   call      'PAR311D'
324400020506     C                   parm                    usempr
324500020506     C                   parm                    ussucu
324600020506     C                   parm                    w0arcd
324700020506     C                   parm                    w0spo1
324800020506     C                   parm                    w0spol
324900020506     C                   parm                    w0sspo
325000020506     C                   parm                    $$nrdf            7 0
325100020506     C                   parm                    $$nomb           40
325200020506     C                   parm                    $$paco            3 0
325300020506     C                   parm                    $$pade           30
325400180911     C                   parm                    $$acti            5 0
325500180911     C                   parm                    $$cate            2 0
325600020506     C                   parm      'FIN'         endpgm
325700020506     ?** PROGRAMA DE AUTOMOVILES...
325800020506?1b? C                   if        p313c = 'L'                                  ?P----------01
325900020506     C                   call      'PAR313C'                            20      ?            |
326000020506     C                   parm                    usempr                         ?            |
326100020506     C                   parm                    ussucu                         ?            |
326200020506     C                   parm                    z0arcd                         ?            |
326300020506     C                   parm                    z0spo1                         ?            |
326400020506     C                   parm                    z0spol                         ?            |
326500020506     C                   parm                    z0sspo                         ?            |
326600020506     C                   parm                    z0rama                         ?            |
326700020506     C                   parm                    z0arse                         ?            |
326800020506     C                   parm                    z0oper                         ?            |
326900020506     C                   parm                    z0suop                         ?            |
327000020506     C                   parm      *blanks       @@mand                         ?            |
327100020506     C                   parm      'FIN'         endpgm                         ?            |
327200020506?1e? C                   endif                                                  ?F----------01
327300020506     ?** PROGRAMA DE RAMAS VARIAS...
327400020506?1b? C                   if        p314c = 'L'                                  ?P----------01
327500020506     C                   call      'PAR314C'                            20      ?            |
327600020506     C                   parm                    z0empr                         ?            |
327700020506     C                   parm                    z0sucu                         ?            |
327800020506     C                   parm                    z0arcd                         ?            |
327900020506     C                   parm                    z0spo1                         ?            |
328000020506     C                   parm                    z0spol                         ?            |
328100020506     C                   parm                    z0sspo                         ?            |
328200020506     C                   parm                    z0rama                         ?            |
328300020506     C                   parm                    z0arse                         ?            |
328400020506     C                   parm                    z0oper                         ?            |
328500020506     C                   parm                    z0suop                         ?            |
328600020506     C                   parm      *blanks       @@mand                         ?            |
328700020506     C                   parm      'FIN'         endpgm                         ?            |
328800020506?1e? C                   endif                                                  ?F----------01
328900020506     ?** CAMBIAR CADENA COMERCIAL...
329000020506?1b? C                   if        p319 = 'L'                                   ?P----------01
329100020506     C                   call      'PAR319'                                     ?            |
329200020506     C                   parm                    x2empr                         ?            |
329300020506     C                   parm                    x2sucu                         ?            |
329400020506     C                   parm                    x2arcd                         ?            |
329500020506     C                   parm                    x2spo1                         ?            |
329600020506     C                   parm                    x2spol                         ?            |
329700020506     C                   parm                    x2sspo                         ?            |
329800020506     C                   parm      'FIN'         endpgm                         ?            |
329900020506?1e? C                   endif                                                  ?F----------01
330000020506     ?** TIPO DE OPERACION...
330100020506?1b? C                   if        c901 = 'L'                                   ?P----------01
330200020506     C                   call      'DBA9011'                                    ?            |
330300020506     C                   parm                    x1tiou                         ?            |
330400020506     C                   parm                    x1stou                         ?            |
330500020506     C                   parm                    p@stos                         ?            |
330600020506     C                   parm                    p@dsop                         ?            |
330700020506     C                   parm      'FIN'         endpgm                         ?            |
330800020506?1e? C                   endif                                                  ?F----------01
330900140908      *
331000140908     c                   eval      P_Error = 'FIN'
331100140908     c                   callp     PAR310N(usempr:
331200140908     c                                     ussucu:
331300140908     c                                     x1arcd:
331400140908     c                                     t$rama:
331500140908     c                                     IIsoln:
331600140908     c                                     iispol:
331700140908     c                                     iitiou:
331800140908     c                                     iistou:
331900140908     c                                     iifunc:
332000140908     c                                     W0SSPO:
332100140908     c                                     P_Error)
332200140213      *
332300140218     c                   callp     SVPVRENO_end
332400020506     ?*
332500020506     C                   endsr
332600040204     ?**************************************************************
332700040204     ?* Desde parámetros nos pueden llegar distintas funciones a   *
332800040204     ?* realizar según desee el usuario. Las opciones son las si-  *
332900040204     ?* guientes:                                                  *
333000040204     ?* iifunc = 1. Operación nueva. Los datos que llegan son incor*
333100040204     ?*             porados como si el usuario los hubiese seleccio*
333200040204     ?*             nado.                                          *
333300040204     ?* iifunc = 2. Operación suspendida. Recupera de los registros*
333400040204     ?*             suspendidos.                                   *
333500040204     ?* iifunc = 3. Borrar operación suspendida. Simula un "4" en  *
333600040204     ?*             el subfile de suspendidas.                     *
333700040204     ?*------------------------------------------------------------*
333800040204     Csr   adonde_voy    begsr
333900070308     ?* Este primer control apenas recibida la propuesta, es para evitar
334000070308     ?* que se produzca el error de generar dos pólizas con igual
334100070308     ?* propuesta Speedway. Por lo tanto si existe en GTI98009 es error,
334200070308     ?* vuelve a llamador.
334300140905     C                   eval      e_code = *blanks
334400070308     C     k1t98009      setll     gti98009
334500070308?1b? C                   if        %equal                                       ?P----------01
334600070308     C                   z-add     61            @e                   50        ?            |
334700140905     C                   eval      e_code = '61'                                ?            |
334800070308     C                   eval      x1tiou = iitiou                              ?            |
334900070308     C                   eval      x1stou = iistou                              ?            |
335000070308     C                   eval      x1arcd = iiarcd                              ?            |
335100070308     C                   eval      x1spo1 = iispol                              ?            |
335200070308     C                   eval      xxiden = 1                                   ?            |
335300070308?1e? C                   endif                                                  ?F----------01
335400130606     ?* Si no llegó número de solicitud es error...
335500130606     C                   if        iisoln <= *zeros
335600130606     C                   z-add     94            @e                   50
335700140905     C                   eval      e_code = '94'                                ?            |
335800130606     C                   eval      x1tiou = iitiou                              ?            |
335900130606     C                   eval      x1stou = iistou                              ?            |
336000130606     C                   eval      x1arcd = iiarcd                              ?            |
336100130606     C                   eval      x1spo1 = iispol                              ?            |
336200130606     C                   eval      xxiden = 1                                   ?            |
336300130606     C                   endif
336400070308
336500140904     ?* En refacturación la fecha desde debe ser igual al hasta facturado
336600140904     ?* de la última facturación...
336700140904     C                   if        iitiou = 3 and
336800140904     C                             iistou = 11
336900140905     ?* Lo valido sólo cuando no está eliminando de suspendida...
337000140905     C                   if        iifunc <> 3
337100140905
337200140905     C                   select
337300140905     ?* Cuando es función 1, la superpóliza llega...
337400140905     C                   when      iifunc = 1
337500140905     C                   eval      ufact_spol = iispol
337600140905     ?* Cuando es función 2, es posible que no llegue superpóliza, por lo
337700140905     ?* que la busco en PAWPC0... Si no la encuentro, entonces no valido y
337800140905     ?* el error será otro.. Ahora, si llega, uso esa...
337900140905     C                   when      iifunc = 2
338000140905     C                   if        iispol <> 0
338100140905     C                   eval      ufact_spol = iispol
338200140905     C                   else
338300140905     C     k1pawpc098    chain     pawpc098
338400140905     C                   if        %found
338500140905     C                   eval      ufact_spol = sp_w0spol
338600140905     C                   else
338700140905     C                   eval      ufact_spol = *zeros
338800140905     C                   endif
338900140905     C                   endif
339000140905     C                   endsl
339100140905
339200140904     C     k3@ed0        setgt     pahed0
339300140904     C     k3@ed0        readpe    pahed0
339400140904     C                   dow       not %eof
339500150410     C                   if        d0tiou = 1 or d0tiou = 2
339600150410     C                   eval      ufact = (d0fhfa * 10000)
339700150410     C                                   + (d0fhfm *   100)
339800150410     C                                   +  d0fhfd
339900150410     C                   leave
340000150410     C                   endif
340100150410     C                   if        (d0tiou = 3 and d0stos = 01)
340200140905     C                   if        d0poli <> 0
340300150313     C     k3@ec1        chain     pahec1
340400150312     C                   if        %found
340500150407     C                   if        c1econ = '0' or ultFac
340600140904     C                   eval      ufact = (d0fhfa * 10000)
340700140904     C                                   + (d0fhfm *   100)
340800150410     C                                   +  d0fhfd
340900140904     C                   leave
341000140905     C                   endif
341100150312     C                   endif
341200150312     C                   endif
341300140905     C                   endif
341400140904     C
341500140904     C     k3@ed0        readpe    pahed0
341600140904     C                   enddo
341700140904     C                   if        ufact <> iifvde
341800140904     C                   z-add     95            @e                   50
341900140905     C                   eval      e_code = '95'                                ?            |
342000140904     C                   eval      x1tiou = iitiou                              ?            |
342100140904     C                   eval      x1stou = iistou                              ?            |
342200140904     C                   eval      x1arcd = iiarcd                              ?            |
342300140904     C                   eval      x1spo1 = iispol                              ?            |
342400140904     C                   eval      xxiden = 1                                   ?            |
342500140904     C                   endif
342600140904     C                   endif
342700140905     C                   endif
342800140904
342900040204?1b? C                   select                                                 ?P----------01
343000040204     ?* Operación nueva.                                                        ?            |
343100040204?1x? C                   when      iifunc =1                                    ?w----------01
343200140904     ?* Si función 1 y la solicitud ya existe en PAWPC0, entonces es error      ?            |
343300140904     ?* debe enviar función 2 para retomar o 3 para eliminar....                ?            |
343400140904     C     k1pawpc098    setll     pawpc098
343500140904     C                   if        %equal
343600140904     C                   z-add     96            @e                   50
343700140905     C                   eval      e_code = '96'                                ?            |
343800140904     C                   endif
343900040204     C                   eval      x1tiou = iitiou                              ?            |
344000040204     C                   eval      x1stou = iistou                              ?            |
344100040204     C                   eval      x1arcd = iiarcd                              ?            |
344200040204     ?* Si se intenta emitir una Superpóliza Nueva Relacionada (IISPOL<>0)      ?            |
344300040204     ?* entonces se mueve *zeros a X1SPO1 para no dañar la lógica pero se       ?            |
344400040204     ?* deja IISPOL como llega para usos posteriores y para que sepa el         ?            |
344500040204     ?* programa que se ha solicitado esta función.                             ?            |
344600040204     ?* Por lo tanto, TODA póliza Nueva deja en *ZEROS a X1SPO1.                ?            |
344700140904?2b? C                   if        not *in50                                    ?P---------02|
344800140904?2b? C                   if        iitiou = 1                                   ?P---------02|
344900040204     C                   eval      x1spo1 = *zeros                              ?           ||
345000040204?2x? C                   else                                                   ?X.........02|
345100040204     C                   eval      x1spo1 = iispol                              ?           ||
345200040204?2e? C                   endif                                                  ?F---------02|
345300140904?2e? C                   endif                                                  ?F---------02|
345400040204     C                   eval      xxiden = 1                                   ?            |
345500040204     ?* Recuperar suspendida.                                                   ?            |
345600040204?1x? C                   when      iifunc =2                                    ?w----------01
345700040204     C                   eval      *in09 = *off                                 ?            |
345800040204     C                   eval      x1arcd = iiarcd                              ?            |
345900040204     C                   eval      x1spo1 = iispol                              ?            |
346000040204     C     k1pawpc098    chain     pawpc098                                     ?            |
346100040204?2b? C                   if        %found                                       ?P---------02|
346200040204?3b? C                   if        sp_w0wp14 = *zeros                           ?P--------03||
346300040204     C                   eval      x1arcd = sp_w0arcd                           ?          |||
346400040204     C                   eval      x1spo1 = sp_w0spo1                           ?          |||
346500040204     C     sp_w0arcd     chain     s1t620                             20        ?          |||
346600040204     C  n20              eval      x1arno = t@arno                              ?          |||
346700040204     C                   eval      xxiden = 1                                   ?          |||
346800040204?3x? C                   else                                                   ?X........03||
346900040204     C                   z-add     67            @e                   50        ?          |||
347000140905     C                   eval      e_code = '67.1'                              ?            |
347100040204     C                   eval      x1tiou = iitiou                              ?          |||
347200040204     C                   eval      x1stou = iistou                              ?          |||
347300040204     C                   eval      x1arcd = iiarcd                              ?          |||
347400040204     C                   eval      x1spo1 = iispol                              ?          |||
347500040204     C                   eval      xxiden = 1                                   ?          |||
347600040204?3e? C                   endif                                                  ?F--------03||
347700040204?2x? C                   else                                                   ?X.........02|
347800040204     C                   z-add     67            @e                   50        ?           ||
347900140905     C                   eval      e_code = '67.2'                              ?            |
348000040204     C                   eval      x1tiou = iitiou                              ?           ||
348100040204     C                   eval      x1stou = iistou                              ?           ||
348200040204     C                   eval      x1arcd = iiarcd                              ?           ||
348300040204     C                   eval      x1spo1 = iispol                              ?           ||
348400040204     C                   eval      xxiden = 1                                   ?           ||
348500040204?2e? C                   endif                                                  ?F---------02|
348600040204     ?* Suprimir suspendida.                                                    ?            |
348700040204?1x? C                   when      iifunc =3                                    ?w----------01
348800040204     C                   eval      x1arcd = iiarcd                              ?            |
348900040204     C                   eval      x1spo1 = iispol                              ?            |
349000040204     C     k1pawpc098    chain     pawpc098                                     ?            |
349100040204?2b? C                   if        %found                                       ?P---------02|
349200040204?3b? C                   if        sp_w0marp = '0'  and                         ?P--------03||
349300040204     C                             sp_w0wp14 = *zeros                           ?          |||
349400040204     C                   eval      p310y = 'L'                                  ?          |||
349500040204     C                   call      'PAR310Y'                                    ?          |||
349600040204     C                   parm                    sp_w0empr                      ?          |||
349700040204     C                   parm                    sp_w0sucu                      ?          |||
349800040204     C                   parm                    sp_w0arcd                      ?          |||
349900040204     C                   parm                    sp_w0spo1                      ?          |||
350000040204     C                   parm                    sp_w0spol                      ?          |||
350100040204     C                   parm                    sp_w0sspo                      ?          |||
350200040204     C                   parm      'BCH'         endpgm                         ?          |||
350300040204     C                   parm      '2'           t@ma44                         ?          |||
350400040204     C                   eval      *inkc = *on                                  ?          |||
350500040204?3e? C                   endif                                                  ?F--------03||
350600040204?2x? C                   else                                                   ?X.........02|
350700040204     C                   z-add     67            @e                   50        ?           ||
350800140905     C                   eval      e_code = '67.3'                              ?            |
350900040204     C                   eval      x1tiou = iitiou                              ?           ||
351000040204     C                   eval      x1stou = iistou                              ?           ||
351100040204     C                   eval      x1arcd = iiarcd                              ?           ||
351200040204     C                   eval      x1spo1 = iispol                              ?           ||
351300040204     C                   eval      xxiden = 1                                   ?           ||
351400040204?2e? C                   endif                                                  ?F---------02|
351500040204?1x? C                   other                                                  ?w----------01
351600040204     C                   z-add     68            @e                   50        ?            |
351700140905     C                   eval      e_code = '68'                                ?            |
351800040204     C                   eval      x1tiou = iitiou                              ?            |
351900040204     C                   eval      x1stou = iistou                              ?            |
352000040204     C                   eval      x1arcd = iiarcd                              ?            |
352100040204     C                   eval      x1spo1 = iispol                              ?            |
352200040204     C                   eval      xxiden = 1                                   ?            |
352300040204?1e? C                   endsl                                                  ?F----------01
352400040204     ?*- SI EXISTEN ERRORES...
352500040204     ?* Bandera de errores en los parámetros y funciones recibidos.
352600040204     C                   eval      hay_error_parm = *in50
352700040204?1b? C                   if        *in50  and                                   ?P----------01
352800040204     C                             @e <> *zeros                                 ?            |
352900040204     C                   setoff                                           90    ?            |
353000040204     C                   write     par31001                                     ?            |
353100040204     C                   eval      *in(@e) = '1'                                ?            |
353200040204?1e? C                   endif                                                  ?F----------01
353300140905
353400140905     C                   if        e_code <> *blanks
353500140905     C                   callp     PAR310_reportErrorSpw( iisoln
353600140905     C                                                  : iispol
353700140905     C                                                  : iiarcd
353800140905     C                                                  : iitiou
353900140905     C                                                  : iistou
354000140905     C                                                  : iiasen
354100140905     C                                                  : iinivc
354200140905     C                                                  : iifvde
354300140905     C                                                  : iifpro
354400140905     C                                                  : iifunc
354500140905     C                                                  : e_code  )
354600140905     C                   endif
354700140905
354800040204     Csr                 endsr
354900040204     ?**************************************************************
355000040419     ?* Procedure name: ira_prc
355100040419     ?* Purpose: Este procedimiento recibe el paso en el que se encuentra
355200040419     ?*          la emisión y devuelve el paso al que desea ir el usuario
355300040419     ?*          (puede ser el mismo en el que se encontraba), los pasos
355400040419     ?*          posteriores se deshabilitan.
355500040420     ?*          El PASO1 (a) siempre está activo al momento de usar
355600040420     ?*          esta función.
355700040419     ?* Returns:        Paso al que debe saltar la lógica
355800040419     ?* Parameters:     prmand => Tecla de función con que se llamó.
355900040419     ?*                 priden => Paso en el que se encuentra la lógica
356000040419     ?*                 priden_kl => Paso al que debería ir por F12.
356100040419     ?*--------------------------------------
356200040419     P ira_prc         b
356300040419     D ira_prc         pi                  like(xxiden)
356400040419     D prmand                              like(@@mand)
356500040419     D priden                              like(xxiden)
356600040419     D priden_kl                           like(xxiden) value
356700040419
356800040419     ?* Local fields
356900040419     D retfield        s                   like(xxiden)
357000040419     D ok_select       s              1n
357100040419     ?* Clave acceso archivo de pasos.
357200040419     C     k1p310        klist
357300040419     C                   kfld                    usempr
357400040419     C                   kfld                    ussucu
357500040419     C                   kfld                    x1arcd
357600040419     C                   kfld                    w0spol
357700040419     C                   kfld                    w0sspo
357800040419     ?* Recupera registro de Pasos cumplidos para configurar pantalla.
357900040419     C     k1p310        chain(n)  pawp31001
358000040419?1b? C                   if        %found                                       ?P----------01
358100040419     ?* Realiza un loop con la intención de habilitar en pantalla los indicadore?            |
358200040419     ?* de 31 a 45 cuyos pasos estén habilitados (= 1). De esta manera se visual?            |
358300040419     ?* en pantalla para que puedan seleccionarse. PASO fue cargado con los paso?            |
358400040419     ?* ejecutados cuando se leyó el registro.                                  ?            |
358500040419     ?* El paso 1 está dividido en dos opciones, Superpóliza y Póliza/Secuencia.?            |
358600040419?2b? C                   for       @in = 31 to 45                               ?P---------02|
358700040419     ?* Setea siempre que esté marcado el paso en archivo y que el mismo no     ?           ||
358800040419     ?* sea superior al que se encuentra actualmente la lógica.                 ?           ||
358900040419?3b? C                   if        paso(@in - 30) = 1 and                       ?P--------03||
359000040419     C                                 (@in - 30) <= priden                     ?          |||
359100040419     C                   eval      *in(@in) = *on                               ?          |||
359200040419?3x? C                   else                                                   ?X........03||
359300040419     C                   eval      *in(@in) = *off                              ?          |||
359400040419?3e? C                   endif                                                  ?F--------03||
359500040419?2e? C                   endfor                                                 ?F---------02|
359600040419     ?* Determina qué hace.                                                     ?            |
359700040419     ?* Por "KL": Vuelve al mismo paso que le llega ya que la lógica resuelve es?            |
359800040419     ?*           caso.                                                         ?            |
359900040419     ?* Por "KR": Procesa la pantalla de salto y obtiene el paso a ir.          ?            |
360000040419?2b? C                   select                                                 ?P---------02|
360100040419?2x? C                   when      prmand = 'KR'                                ?w---------02|
360200040419     ?* Blanquea pantalla de pasos.                                             ?           ||
360300040419     C                   eval      ok_select = *off                             ?           ||
360400040419     C                   eval      @@mand = *blanks                             ?           ||
360500040419     C                   movea     *all' '       paso_p                         ?           ||
360600040419     C                   eval      *inkl = *off                                 ?           ||
360700040419                                                                                ?           ||
360800040419?3b? C                   dow       not *inkl                                    ?P--------03||
360900040419     C                   exfmt     par310lk                                     ?          |||
361000040419?4b? C                   if        *inkl                                        ?P-------04|||
361100040419     C                   eval      @@mand = 'KL'                                ?         ||||
361200040419     C                   eval      retfield = priden_kl                         ?         ||||
361300040419?3v? C                   leave                                                  ?         ||||
361400040419?4e? C                   endif                                                  ?F-------04|||
361500040419     ?* Valida si se seleccionó algún paso.                                     ?          |||
361600040419     ?* Loopea sobre el array de pantalla para ver si se seleccionó el paso.    ?          |||
361700040419     ?* @IN tiene el paso que seleccionó el usuario.                            ?          |||
361800040419?4b? C                   for       @in = 1 to 16                                ?P-------04|||
361900040420?5b? C                   if        paso_p(1) = '1'                              ?P------05||||
362000040420     C                             or                                           ?        |||||
362100040420     C                             paso_p(@in) = '1' and                        ?        |||||
362200040420     C                             @in >= 2 and *in(@in + 29)                   ?        |||||
362300040419     C                   eval      ok_select = *on                              ?        |||||
362400040419     ?* Recupera el paso a saltar del array SALTO.                              ?        |||||
362500040419     C                   eval      dssalto = salto(@in)                         ?        |||||
362600040419     ?* Si el paso correspondiente fuera 99, indica que no se ha definido y     ?        |||||
362700040419     ?* simula un F12.                                                          ?        |||||
362800040419?6b? C                   if        dspaso = 99                                  ?P-----06|||||
362900040419     C                   eval      @@mand = 'KL'                                ?       ||||||
363000040419     C                   eval      retfield = priden_kl                         ?       ||||||
363100040419?4v? C                   leave                                                  ?       ||||||
363200040419?6e? C                   endif                                                  ?F-----06|||||
363300040419     ?* Mueve datos.                                                            ?        |||||
363400040419     C                   eval      retfield = dspaso                            ?        |||||
363500040419     C                   eval      paso(1) = dsmar01                            ?        |||||
363600040419     C                   eval      paso(2) = dsmar02                            ?        |||||
363700040419     C                   eval      paso(3) = dsmar03                            ?        |||||
363800040419     C                   eval      paso(4) = dsmar04                            ?        |||||
363900040419     C                   eval      paso(5) = dsmar05                            ?        |||||
364000040419     C                   eval      paso(6) = dsmar06                            ?        |||||
364100040419     C                   eval      paso(7) = dsmar07                            ?        |||||
364200040419     C                   eval      paso(8) = dsmar08                            ?        |||||
364300040419     C                   eval      paso(9) = dsmar09                            ?        |||||
364400040419     C                   eval      paso(10) = dsmar10                           ?        |||||
364500040419     C                   eval      paso(11) = dsmar11                           ?        |||||
364600040419     C                   eval      paso(12) = dsmar12                           ?        |||||
364700040419     C                   eval      paso(13) = dsmar13                           ?        |||||
364800040419     C                   eval      paso(14) = dsmar14                           ?        |||||
364900040419     C                   eval      paso(15) = dsmar15                           ?        |||||
365000040419     C     k1p310        chain     pawp31001                                    ?        |||||
365100040419?6b? C                   if        %found                                       ?P-----06|||||
365200040419     C                   update    p1wp310                                      ?       ||||||
365300040419?6e? C                   endif                                                  ?F-----06|||||
365400040419?4v? C                   leave                                                  ?        |||||
365500040419?5e? C                   endif                                                  ?F------05||||
365600040419?4e? C                   endfor                                                 ?F-------04|||
365700040419                                                                                ?          |||
365800040419     ?* Hubo selección.                                                         ?          |||
365900040419?4b? C                   if        ok_select                                    ?P-------04|||
366000040419     C                   eval      @@mand = 'KL'                                ?         ||||
366100040419?3v? C                   leave                                                  ?         ||||
366200040419?4e? C                   endif                                                  ?F-------04|||
366300040419                                                                                ?          |||
366400040419?3e? C                   enddo                                                  ?F--------03||
366500040419?2x? C                   other                                                  ?w---------02|
366600040419     C                   eval      retfield = priden_kl                         ?           ||
366700040419?2e? C                   endsl                                                  ?F---------02|
366800040419?1x? C                   else                                                   ?X..........01
366900040419     ?* No encontró registro, asume F12.                                        ?            |
367000040419     C                   eval      @@mand = 'KL'                                ?            |
367100040419     C                   eval      retfield = priden_kl                         ?            |
367200040419?1e? C                   endif                                                  ?F----------01
367300040419
367400040419     C                   return    retfield
367500040419     P ira_prc         e
367600040419     ?**************************************************************
367700040805     ?* Procedimiento que devuelve si un artículo es o no de vida.
367800040805     P es_vida         b
367900040805     D es_vida         pi                  like(*in50)
368000040805     ?* Campos locales
368100040805     D es_vida_ret     s                   like(*in50)
368200040805
368300150810     C     x1arcd        chain     set62104
368400040805     C     t$rama        chain     set001
368500040805     C                   eval      es_vida_ret = (t@rame = 18 or
368600040805     C                                            t@rame = 21)
368700040805     C                   return    es_vida_ret
368800040805     P es_vida         e
368900040805     ?* --------------------------------------------------------------------
369000140905      * ------------------------------------------------------------ *
369100140905      * reportErrorSpw(): Envía un mail ante un error en los paráme- *
369200140905      *                   tros de SpeedWay.                          *
369300140905      *                                                              *
369400140905      *   peSoln  (input)  Número de Solicitud                       *
369500140905      *   peSpol  (input)  SuperPóliza                               *
369600140905      *   peArcd  (input)  Artículo                                  *
369700140905      *   peTiou  (input)  Tipo de Operación                         *
369800140905      *   peStou  (input)  SubTipo de Operación                      *
369900140905      *   peAsen  (input)  Número de Asegurado                       *
370000140905      *   peNivc  (input)  Código de Productor                       *
370100140905      *   peFvde  (input)  Fecha de Inicio de vigencia               *
370200140905      *   peFpro  (input)  Fecha de ingreso de propuesta             *
370300140905      *   peFunc  (input)  Función                                   *
370400140905      *                    1 = Nueva                                 *
370500140905      *                    2 = Retomar Suspendida                    *
370600140905      *                    3 = Eliminar Suspendida                   *
370700140905      *   peEcod  (input)  Código de error                           *
370800140905      *                                                              *
370900140905      * retorna: void                                                *
371000140905      * ------------------------------------------------------------ *
371100140905     P PAR310_reportErrorSpw...
371200140905     P                 B
371300140905     D PAR310_reportErrorSpw...
371400140905     D                 pi
371500140905     D  peSoln                        7  0
371600140905     D  peSpol                        9  0
371700140905     D  peArcd                        6  0
371800140905     D  peTiou                        1  0
371900140905     D  peStou                        2  0
372000140905     D  peAsen                        7  0
372100140905     D  peNivc                        5  0
372200140905     D  peFvde                        8p 0
372300140905     D  peFpro                        8p 0
372400140905     D  peFunc                        1p 0
372500140905     D  peEcod                       10a   const
372600140905
372700140905     D peTo            s             50a   dim(100)
372800140905     D peToad          s            256a   dim(100)
372900140905     D peToty          s             10i 0 dim(100)
373000140905     D peMens          s            512a   varying
373100140905     D peSubj          s             70a   varying
373200140905     D msg             s             70a
373300140905     D rc              s             10i 0
373400140905
373500140905      /free
373600140905
373700140905       peSubj = 'PAR310 - Error Spw (Soln:'
373800140905              + %trim(%char(peSoln))
373900140905              + ')';
374000140905
374100140905       select;
374200140905        when ( peEcod = '61        ' );
374300140905            msg = ' Propuesta ya fue emitida';
374400140905        when ( peEcod = '94        ' );
374500140905            msg = ' Se ha enviado Propuesta en cero';
374600140905        when ( peEcod = '95        ' );
374700140905            msg = ' Fecha Desde Refacturación incoherente';
374800140905        when ( peEcod = '96        ' );
374900140905            msg = ' Función 1 para Propuesta ya suspendida';
375000140905        when ( peEcod = '67.1      ' );
375100140905            msg = ' Paso 14 completado (ya empezó a numerar)';
375200140905        when ( peEcod = '67.2      ' );
375300140905            msg = ' Función 2 y Propuesta no está suspendida';
375400140905        when ( peEcod = '67.3      ' );
375500140905            msg = ' Función 3 y Propuesta no está suspendida';
375600140905        when ( peEcod = '68        ' );
375700140905            msg = ' Función enviada no soportada (debe ser 1, 2 o 3)';
375800140905        other;
375900140905       endsl;
376000140905
376100140905       peMens = '<html>'
376200140905              + 'Solicitud: '    + %editc(peSoln:'X') + '<br>'
376300140905              + 'SuperPóliza: '  + %editc(peSpol:'X') + '<br>'
376400140905              + 'Tipo Oper: '    + %editc(peTiou:'X') + '<br>'
376500140905              + 'SubTipo Oper: ' + %editc(peStou:'X') + '<br>'
376600140905              + 'Asegurado: '    + %editc(peAsen:'X') + '<br>'
376700140905              + 'Productor: '    + %editc(peNivc:'X') + '<br>'
376800140905              + 'Vig. Desde: '   + %editc(peFvde:'X') + '<br>'
376900140905              + 'Fec. Prop: '    + %editc(peFpro:'X') + '<br>'
377000140905              + 'Función: '      + %editc(peFunc:'X') + '<br>'
377100140905              + '<br><br>'
377200140905              + 'Error: <b>' + %trim(peEcod) + msg + '</b>'
377300140905              + '<br><br>'
377400140905              + 'Emisor: ' + %trim(vsuser)
377500140905              + '</html>';
377600140905
377700140905       peTo(1)   = 'Sergio Fernandez';
377800140905       peToad(1) = 'sergio.fernandez@hdi.com.ar';
377900140905       peToty(1) = MAIL_NORMAL;
378000140905
378100140910       peTo(2)   = 'Proc.RobotHDI';
378200140910       peToad(2) = 'Proc.RobotHDI@hdi.com.ar';
378300140910       peToty(2) = MAIL_NORMAL;
378400140910
378500140905       rc = MAIL_sndEmail( '*SYSTEM'
378600140905                         : *blanks
378700140905                         : peSubj
378800140905                         : peMens
378900140905                         : 'H'
379000140905                         : peTo
379100140905                         : peToad
379200140905                         : peToty   );
379300140905
379400140905      /end-free
379500140905
379600140905     P PAR310_reportErrorSpw...
379700140905     P                 E
379800140905
379900150407     P ultFac...
380000150407     P                 B
380100150407     D ultFac...
380200150407     D                 pi              n
380300150407
380400150407     D @@retu          s               n
380500150407
380600150407      /free
380700150407
380800150407        SPAFANU ( d0empr : d0sucu : d0arcd : d0spol : d0sspo : @@retu );
380900150407
381000150407        return @@retu;
381100150407
381200150407      /end-free
381300150407
381400150407     P ultFac...
381500150407     P                 E
381600150407
381700140905     ?* --------------------------------------------------------------------
381800040419**ctdata salto  -> A dónde vamos cuando se selecciona un paso desde IRA_PRC inicializa Pasos
38190004041900000000000000000
38200004041901100000000000000
38210004041902110000000000000
38220004041903111000000000000
38230004041904111100000000000
38240004041905111110000000000
38250004041906111111000000000
38260004041999000000000000000
38270004041999000000000000000
38280004041999000000000000000
38290004041999000000000000000
38300004041999000000000000000
38310004041999000000000000000
38320004041999000000000000000
38330004041999000000000000000
38340004041999000000000000000
