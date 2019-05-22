000100021025     H decedit(',') datedit(*dmy/)
000200021025     H copyright('© AXA Todos los derechos reservados.')
000300060613     H actgrp(*caller) dftactgrp(*no)
000400160607     H bnddir('HDIILE/HDIBDIR')
000500001030     ?*****************************************************************
000600001030     ?*  PAR310E : TEXTOS A NIVEL DE DETALLE DE ARTICULO              *
000700001030     ?*          : MODULO DE PRODUCCION POR ARTICULOS                 *
000800001030     ?*                                                               *
000900001030     ?*  FECHA   : 18/12/96                                           *
001000001030     ?*  AUTOR   : ALEJANDRO RODRIGUEZ                                *
001100001030     ?*****************************************************************
001200001030     ?* Personalizado para AXA toma la línea de texto de 79 caracteres
001300001030     ?* para no perder los textos ya cargados en la SET124...
001400001107     ?* Recupera textos en renovación de póliza original y no de
001500001107     ?* último endoso...
001600021025     ?* NWN - 25/10/2002 : Convertido a FULL RPG
001700021205     ?* NWN - 25/10/2002 : Agregado de Sentencias de SPEEDWAY
001800031203     ?* SLU - 03/12/2003 : Se chequea Speedway Versión 1 desde el Artículo
001900031203     ?*                    para condicionar las tareas de este producto.
002000040416     ?* SGF - 16/04/2004 : Agrego grabación de marca de paso en el PAWP310
002100040416     ?*                    para navegador. Función F17 = Ir a...
002200040419     ?*                    ATENCION!!!!! Despues de cada CLEAR de un reg.
002300040419     ?*                    de pantalla se RESTAURA el *IN23 porque se hace
002400040419     ?*                    goma y no habilita la tecla del navegador.
002500040618     ?* NWN - 15/06/2004 : Agrego Función F11. Busca y graba textos de
002600040618     ?*                    pólizas emitidas. Se pueden grabar todo el texto
002700040618     ?*                    de la póliza con sus suplementos o solamente un
002800040618     ?*                    suplemento pedido.
002900040622     ?* NWN - 22/06/2004 : Agrego Validaciones a la función F11.
003000060613     ?* SGF - 13/06/2006 : Cuando es una póliza de AON ASSIST (determina
003100060613     ?*                    vía SPDETAON) y tiene un texto preseteado asocia-
003200060613     ?*                    do, lo carga automáticamente para operaciones nue
003300060613     ?*                    vas y por primera entrada de programa.
003400060613     ?*                    En renovaciones no se toca porque se buscan los
003500060613     ?*                    textos de la póliza original.
003600100831     ?* SGF - 31/08/2010 : En Renovaciones, Cascos recupera los textos de
003700100831     ?*                    toda la póliza anterior.
003800150312     ?* SFA - 12/03/2015 : En Renovaciones, si tiene configuracion de textos
003900150312     ?*                    automaticos no cargo textos de PAHED2
004000160606     ?* LRG - 06/06/2016 : Copiar Ubicaciones - Para riesgos Varios
004100190405     ?* GIO - 05/04/2019 : RM#02815 Se elimina la lógica en la rutina sf1car de
004200190405     ?*                    PAR310E "if txtAutom" ==> carga siempre subarchivo vacío.
004300190411     ?* GIO - 11/04/2019 : RM#04647 Corrige Boton [F23 Inicializar] en Emision
004400150312     ?*
004500001030     ?*****************************************************************
004600001030     Fpar310em  cf   e             workstn usropn
004700001030     F                                     sfile(par310s1:sf1rrn)
004800001030     Fpahed2    uf a e           k disk
004900001030     Fpahed21   uf a e           k disk
005000001030     Fpawpd0    uf   e           k disk
005100040416     Fpawp310   uf   e           k disk
005200001030     Fpahed003  if   e           k disk
005300001030     Fset124    if   e           k disk
005400001030     Fset630    if   e           k disk
005500021205nwn02Fgti98001  if   e           k disk
005600040618     Fpahed201  if   e           k disk    prefix(rr:2)
005700160607     Fpahed004  if   e           k disk    prefix(t1:2)
005800021025     ?********************************************************************
005900160608      /copy HDIILE/QCPYBOOKS,SVPWS_H
006000160607     ?********************************************************************
006100060613     ?* Determina Servicio de Asistencia AON.                         *
006200060613     ?*---------------------------------------------------------------*
006300060613     D spdetaon        pr                  extpgm('SPDETAON')
006400060613     D a                                   like(d2empr)
006500060613     D b                                   like(d2sucu)
006600060613     D c                                   like(d2arcd)
006700060613     D d                                   like(d2spol)
006800060613     D e                                   like(*inlr)
006900060613     D f                                   like(endpgm)
007000060613     D g                                   like(x1tpcd)
007100160607
007200150312     ?********************************************************************
007300150312     D txtAutom        pr              n
007400150312
007500150313     D SPTXTAUTE       pr                  ExtPgm('SPTXTAUTE')
007600150312     D    empr                        1    const
007700150312     D    sucu                        2    const
007800150312     D    arcd                        6  0 const
007900150312     D    spol                        9  0 const
008000150312     D    sspo                        3  0 const
008100150312     D    txta                         n
008200150312     D    fech                        8  0 options(*omit:*nopass)
008300160607     ?********************************************************************
008400160607     D spseter         pr                  extpgm('SPSETER')
008500160607     D peEmpr                         1    const
008600160607     D peSucu                         2    const
008700160607     D peArcd                         6  0 const
008800160607     D peSpol                         9  0 const
008900160607     D peRama                         2  0 const
009000160607     D peArse                         2  0 const
009100160607     D peSpon                         9  0 const
009200160607     D peOpen                         7  0 const
009300160607     D peSspo                         3  0 options(*nopass:*omit)
009400160607     D pePoli                         7  0 options(*nopass:*omit)
009500160607     D peCert                         9  0 options(*nopass:*omit)
009600060613     ?********************************************************************
009700001030     D ast             s             79    dim(1) ctdata perrcd(1)              ASTERISCOS
009800001122     D wrk             s             79    dim(600)                             TRABAJO
009900001122     D txt             s             79    dim(600)                             PARAMETROS
010000001122     D $$1             s             79    dim(600)                             TRABAJO
010100001122     D $$2             s             79    dim(600)                             TRABAJO
010200021025     ?********************************************************************
010300021025     D $2tpc0          s                   like(x2tpc0)
010400021025     D $2tpc1          s                   like(x2tpc1)
010500021025     D $2tpc2          s                   like(x2tpc2)
010600021025     D $2tpc3          s                   like(x2tpc3)
010700021025     D $2tpc4          s                   like(x2tpc4)
010800021025     D $2tpc5          s                   like(x2tpc5)
010900021025     D $2tpc6          s                   like(x2tpc6)
011000021025     D $2tpc7          s                   like(x2tpc7)
011100021025     D $2tpc8          s                   like(x2tpc8)
011200021025     D $2tpc9          s                   like(x2tpc9)
011300021025     D @@arcd          s                   like(d2arcd)
011400021025     D @@arse          s                   like(d2arse)
011500021025     D @@empr          s                   like(d2empr)
011600021025     D @@lsf1          s              9  0
011700021025     D @@oper          s                   like(d2oper)
011800021025     D @@rama          s                   like(d2rama)
011900021025     D @@spol          s                   like(d2spol)
012000021025     D @@spo1          s                   like(z0spo1)
012100021025     D @@sspo          s                   like(d2sspo)
012200021025     D @@sucu          s                   like(d2sucu)
012300021025     D @@suop          s                   like(d2suop)
012400021025     D q               s              9  0
012500021025     D sf1rrn          s              9  0
012600021025     D x               s              9  0
012700021025     D x@rama          s                   like(d2rama)
012800021025     D x@tpcd          s                   like(x2tpc0)
012900021025     D xxiden          s              2  0
013000021025     D y               s              9  0
013100040419     D @@in23          s                   like(*in23)
013200040618     D @@@@suop        s                   like(d2suop)
013300040622     D @@@@retx        s             21                                         ?          |||
013400040622     D @@@@retx1       s             79                                         ?          |||
013500040622     D @@@1suop        s              3
013600060613     D es_aon          s               n
013700060613     D @@fpgm          s              3a
013800060614     D zztpcd          s                   like(x1tpcd)
013900100830     D @@ma43          s                   like(t@ma43)
014000040618     D@@linea1         c                   const('Suplemento Nro.:')
014100040618     D@@linea2         c                   const('*****************************-
014200040618     D                                     **************************')
014300060614     Dc$001            c                   const('PÓLIZA CON AON ASSIST')
014400021025     ?********************************************************************
014500001030     ?*- AREA DE DATOS DEL PROGRAMA...
014600001030     D                sds
014700001030     D  vsuser               254    263
014800001030     ?*- AREA LOCAL DE DATOS...
014900001030     D                uds
015000001030     D  usempr               401    401
015100001030     D  ussucu               402    403
015200001030     D  usbibl               404    413
015300021025     ?******************************************************
015400021025     ?*- AREA DE COMUNICACION...
015500021025     C     *entry        plist
015600021025     C                   parm                    @@empr
015700021025     C                   parm                    @@sucu
015800021025     C                   parm                    @@arcd
015900021025     C                   parm                    @@spo1
016000021025     C                   parm                    @@spol
016100021025     C                   parm                    @@sspo
016200021025     C                   parm                    @@rama
016300021025     C                   parm                    @@arse
016400021025     C                   parm                    @@oper
016500021025     C                   parm                    @@suop
016600021025     C                   parm                    @@mand            2
016700021025     C                   parm                    endpgm            3
016800021025     ?*----------------------------------------------------
016900021025?1b? C                   select                                                 ?P----------01
017000021025?1x? C                   when      endpgm = *blanks                             ?w----------01
017100021025     C                   open      par310em                                     ?            |
017200021025     C                   exsr      inicio                                       ?            |
017300021025?2b? C                   dou       *inkc                                        ?P---------02|
017400021025?3b? C     xxiden        caseq     1             pant01                         ?P--------03||
017500021025     C     xxiden        caseq     2             pant02                         ?          |||
017600021025?3e? C                   endcs                                                  ?F--------03||
017700021025?2e? C                   enddo                                                  ?F---------02|
017800021025     C                   close     par310em                                     ?            |
017900021025     C                   return                                                 ?            |
018000021025?1x? C                   when      endpgm = 'FIN'                               ?w----------01
018100060614     C                   callp     spdetaon(@@empr:
018200060614     C                                      @@sucu:
018300060614     C                                      @@arcd:
018400060614     C                                      @@spol:
018500060613     C                                      es_aon:
018600060613     C                                      endpgm:
018700060614     C                                      zztpcd)
018800021025     C                   seton                                        lr        ?            |
018900021025?1e? C                   endsl                                                  ?F----------01
019000021025     ?******************************************************
019100021025     C     pant01        begsr
019200021025     ?*- ENTRADA/SALIDA PANTALLA 01...
019300040419     C  n50              write     par31000
019400021025     C                   exfmt     par310c1
019500021025     ?*- PROCESO DE TECLAS DE FUNCION...
019600021025?1b? C                   select                                                 ?P----------01
019700021025     ?*- F3=SALIR DEL PROGRAMA...                                               ?            |
019800021025?1x? C                   when      *inkc                                        ?w----------01
019900021025     C                   eval      @@mand = 'KC'                                ?            |
020000021025     ?*- F6=INSERTAR...                                                         ?            |
020100021025?1x? C                   when      *inkf                                        ?w----------01
020200021025     C                   exsr      inse01                                       ?            |
020300021025     ?*- F7=SEPARAR PARRAFO...                                                  ?            |
020400021025?1x? C                   when      *inkg                                        ?w----------01
020500021025     C                   exsr      sepa01                                       ?            |
020600021025     ?*- F8=ELIMINAR BLANCOS...                                                 ?            |
020700021025?1x? C                   when      *inkh                                        ?w----------01
020800021025     C                   exsr      elim01                                       ?            |
020900021025     ?*- F9=ELIMINAR REGISTRO                                                   ?            |
021000021025?1x? C                   when      *inki                                        ?w----------01
021100021025     C                   exsr      dele01                                       ?            |
021200021025     ?*- F10=TRAER REGISTROS DE TEXTOS PRESETEADOS...                           ?            |
021300021025?1x? C                   when      *inkj                                        ?w----------01
021400021025     C                   exsr      sele01                                       ?            |
021500040618     ?*- F11=TRAER REGISTROS DE POLIZAS REFERENCIADAS...                        ?            |
021600040618?1x? C                   when      *inkk                                        ?w----------01
021700040618     C                   exsr      selepol                                      ?            |
021800021025     ?*- F12=RETORNAR...                                                        ?            |
021900021025?1x? C                   when      *inkl                                        ?w----------01
022000021025     C                   eval      *inkc = '1'                                  ?            |
022100021025     C                   eval      @@mand = 'KL'                                ?            |
022200040416     ?*- F17=Ir a...                                                            ?            |
022300040416?1x? C                   when      *inkr                                        ?w----------01
022400040416     C                   eval      *inkc = '1'                                  ?            |
022500040416     C                   eval      @@mand = 'KR'                                ?            |
022600021025     ?*- F23=BORRAR SUBARCHIVO...                                               ?            |
022700021025?1x? C                   when      *inkx                                        ?w----------01
022800190411     C                   clear                   sf1rrn                         ?            |
022900021025     C                   exsr      sf1car                                       ?            |
023000021025     ?*- F24=AYUDA...                                                           ?            |
023100021025?1x? C                   when      *inky                                        ?w----------01
023200021025     ?*- PULSO INTRO...                                                         ?            |
023300021025?1x? C                   when      not *in29                                    ?w----------01
023400021025     C                   exsr      vali01                                       ?            |
023500021025?1e? C                   endsl                                                  ?F----------01
023600021025     ?*-
023700021025     C                   endsr
023800001030     ?******************************************************
023900021025     C     vali01        begsr
024000021025     ?*- GRABACION SI NO HAY MODIFICACIONES----------------
024100021025?1b? C                   do        @@lsf1        q                              ?P----------01
024200021025     C     q             chain     par310s1                           20        ?            |
024300021025?2b? C                   if        not *in20                                    ?P---------02|
024400021025     C                   eval      $$1(q) = x1retx                              ?           ||
024500021025?2e? C                   endif                                                  ?F---------02|
024600021025?1e? C                   enddo                                                  ?F----------01
024700021025     ?*- GRABACION...
024800021025?1b? C                   do        @@lsf1        q                              ?P----------01
024900021025?2b? C                   if        $$1(q) <> $$2(q)                             ?P---------02|
025000021025?1v? C                   leave                                                  ?           ||
025100021025?2e? C                   endif                                                  ?F---------02|
025200021025?1e? C                   enddo                                                  ?F----------01
025300021025     ?*-
025400021025     C                   eval      x = @@lsf1 + 1
025500021025?1b? C                   if        q = x  and                                   ?P----------01
025600021025     C                             *in90                                        ?            |
025700021025     C                   exsr      grab01                                       ?            |
025800021025     C                   eval      @@mand = 'KA'                                ?            |
025900021025     C                   eval      *inkc = '1'                                  ?            |
026000021025     C                   setoff                                       90        ?            |
026100021025?1x? C                   else                                                   ?X..........01
026200021025     C                   eval      $$2 = $$1                                    ?            |
026300021025     C                   seton                                        90        ?            |
026400021025?1e? C                   endif                                                  ?F----------01
026500021025     ?*-
026600021025     C                   endsr
026700001030     ?******************************************************
026800021025     C     grab01        begsr
026900021025     ?*- GRABACION-----------------------------------------
027000021025     ?*- BORRAR TODO EL ARCHIVO PAHED2...
027100021025     C                   exsr      del001
027200021025     ?*- AHORA GRABAR DE ATRAS HACIA ADELANTE...
027300021025     ?*- BUSCAR EL ULTIMO OCUPADO...
027400021025     C                   eval      sf1rrn = @@lsf1
027500021025     C                   add       1             sf1rrn
027600021025?1b? C                   dou       x1retx <> *blanks  or                        ?P----------01
027700021025     C                             sf1rrn = 0                                   ?            |
027800021025     C                   eval      sf1rrn = sf1rrn - 1                          ?            |
027900021025     C     sf1rrn        chain     par310s1                           20        ?            |
028000021025?1e? C                   enddo                                                  ?F----------01
028100021025     ?*- AHORA GRABAR...
028200021025     ?*- CAMPOS GENERALES...
028300021025     C                   eval      d2empr = @@empr
028400021025     C                   eval      d2sucu = @@sucu
028500021025     C                   eval      d2arcd = @@arcd
028600021025     C                   eval      d2spol = @@spol
028700021025     C                   eval      d2sspo = @@sspo
028800021025     C                   eval      d2rama = @@rama
028900021025     C                   eval      d2arse = @@arse
029000021025     C                   eval      d2oper = @@oper
029100021025     C                   eval      d2suop = @@suop
029200021025     ?*- CAMPOS VARIABLES...
029300021025     C                   eval      x = sf1rrn
029400021025?1b? C                   do        x             sf1rrn                         ?P----------01
029500021025     C     sf1rrn        chain     par310s1                           20        ?            |
029600021025?2b? C                   if        not *in20                                    ?P---------02|
029700021025     C                   eval      d2nrre = sf1rrn                              ?           ||
029800021025     C                   eval      d2retx = x1retx                              ?           ||
029900021025     C                   eval      d2cert = *zeros                              ?           ||
030000021025     C                   eval      d2poli = *zeros                              ?           ||
030100021025     C                   eval      d2marp = '0'                                 ?           ||
030200021025     C                   eval      d2strg = '0'                                 ?           ||
030300021025     C                   eval      d2user = vsuser                              ?           ||
030400021025     C                   time                    d2time                         ?           ||
030500021025     C                   eval      d2date = udate                               ?           ||
030600021025     C                   write     p1hed2                                       ?           ||
030700021025?2e? C                   endif                                                  ?F---------02|
030800021025?1e? C                   enddo                                                  ?F----------01
030900021025     ?* colocar marca de paso "ya realizado"...
031000021025     C     k1@pd0        chain     p1wpd0                             20
031100021025     C  n20              eval      z0wp02 = 1
031200021025     C  n20              update    p1wpd0
031300040416     ?* Actualiza marca de paso para navegador...
031400040416     C     k1@pd0        chain     pawp310
031500040416?1b? C                   if        %found(pawp310)                              ?P----------01
031600040416     C                   eval      z0wp02lk = 1                                 ?            |
031700040416     C                   update    p1wp310                                      ?            |
031800040416?1e? C                   endif                                                  ?F----------01
031900021025     ?*-
032000021025     C                   endsr
032100001030     ?******************************************************
032200021025     C     dele01        begsr
032300021025     ?*- DELETEAR UN SOLO REGISTRO-------------------------
032400021025     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...
032500021025     C                   eval      x = *zeros
032600021025     C                   eval      y = *zeros
032700021025     C                   eval      wrk = *blanks
032800021025     ?*- PASAR A SERIE DE TRABAJO...
032900021025?1b? C                   do        @@lsf1        x                              ?P----------01
033000021025     C     x             chain     par310s1                           20        ?            |
033100021025?2b? C                   if        not *in20  and                               ?P---------02|
033200021025     C                             x <> cursor                                  ?           ||
033300021025     C                   add       1             y                              ?           ||
033400021025     C                   eval      wrk(y) = x1retx                              ?           ||
033500021025?2e? C                   endif                                                  ?F---------02|
033600021025?1e? C                   enddo                                                  ?F----------01
033700021025     ?*- LUEGO RECARGA EL SUBARCHIVO...
033800021025     C                   exsr      sf1bor
033900021025?1b? C                   do        @@lsf1        x                              ?P----------01
034000021025     C                   eval      sf1rrn = x                                   ?            |
034100021025     C                   eval      x1retx = wrk(x)                              ?            |
034200021025     C                   write     par310s1                                     ?            |
034300021025?1e? C                   enddo                                                  ?F----------01
034400021025     ?*- INDICADORES DE SUBARCHIVO...
034500021025?1b? C                   if        sf1rrn <> *zeros                             ?P----------01
034600021025     C                   seton                                          3031    ?            |
034700021025?1x? C                   else                                                   ?X..........01
034800021025     C                   seton                                            31    ?            |
034900021025?1e? C                   endif                                                  ?F----------01
035000021025     ?*-
035100021025     C                   endsr
035200001030     ?******************************************************
035300021025     C     sele01        begsr
035400021025     ?*- SELECCIONAR TEXTOS PRESETEADOS--------------------
035500021025     C                   clear                   x1tpcd
035600021025     C                   exfmt     par31001
035700021025     ?*- SI EL CÓDIGO ES VALIDO TRATAR DE CARGAR....
035800021025     C                   exsr      sf1ca1
035900021025     ?*-
036000021025     C                   endsr
036100001030     ?******************************************************
036200021025     C     sf1ca1        begsr
036300021025     ?*- CARGAR SUBARCHIVO DESDE TEXTOS PRESETEADOS--------
036400021025     ?*- VER ULTIMO RENGLON OCUPADO...
036500021025     C                   eval      y = @@lsf1 + 1
036600021025?1b? C                   do        y             x                              ?P----------01
036700021025     C                   eval      sf1rrn = y - x                               ?            |
036800021025     C     sf1rrn        chain     par310s1                           20        ?            |
036900021025?2b? C                   if        not *in20                                    ?P---------02|
037000021025?3b? C                   if        x1retx <> *blanks                            ?P--------03||
037100021025?1v? C                   leave                                                  ?          |||
037200021025?3e? C                   endif                                                  ?F--------03||
037300021025?2e? C                   endif                                                  ?F---------02|
037400021025?1e? C                   enddo                                                  ?F----------01
037500021025     ?*- CARGAR DESDE TEXTOS PRESETEADOS...
037600021025     C                   setoff                                           99
037700021025     C     k@01          setll     s1t124
037800021025?1b? C                   dou       *in99  or                                    ?P----------01
037900021025     C                             sf1rrn = @@lsf1                              ?            |
038000021025     C     k@01          reade     s1t124                                 99    ?            |
038100021025?2b? C                   if        not *in99                                    ?P---------02|
038200021025     ?*- CARGAR SUBARCHIVO...                                                   ?           ||
038300021025     C                   add       1             sf1rrn                         ?           ||
038400021025     C     sf1rrn        chain     par310s1                           20        ?           ||
038500021025?3b? C                   if        not *in20                                    ?P--------03||
038600021025     C                   eval      x1retx = t@tpds                              ?          |||
038700021025     C                   update    par310s1                                     ?          |||
038800021025?3e? C                   endif                                                  ?F--------03||
038900021025?2e? C                   endif                                                  ?F---------02|
039000021025?1e? C                   enddo                                                  ?F----------01
039100021025     ?*-
039200021025     C                   endsr
039300010921     ?******************************************************
039400021025     C     sf1ca2        begsr
039500021025     ?*- CARGAR SUBARCHIVO DESDE TEXTOS PRESETEADOS--------
039600021025     ?*- VER ULTIMO RENGLON OCUPADO...
039700021025     C                   eval      y = @@lsf1 + 1
039800021025?1b? C                   do        y             x                              ?P----------01
039900021025     C                   eval      sf1rrn = y - x                               ?            |
040000021025     C     sf1rrn        chain     par310s1                           20        ?            |
040100021025?2b? C                   if        not *in20                                    ?P---------02|
040200021025?3b? C                   if        x1retx <> *blanks                            ?P--------03||
040300021025?1v? C                   leave                                                  ?          |||
040400021025?3e? C                   endif                                                  ?F--------03||
040500021025?2e? C                   endif                                                  ?F---------02|
040600021025?1e? C                   enddo                                                  ?F----------01
040700021025     ?*- CARGAR DESDE TEXTOS PRESETEADOS...
040800021025     C                   setoff                                           99
040900021025     C     k@01a         setll     s1t124
041000021025?1b? C                   dou       *in99  or                                    ?P----------01
041100021025     C                             sf1rrn = @@lsf1                              ?            |
041200021025     C     k@01a         reade     s1t124                                 99    ?            |
041300021025?2b? C                   if        not *in99                                    ?P---------02|
041400021025     ?*- CARGAR SUBARCHIVO...                                                   ?           ||
041500021025     C                   add       1             sf1rrn                         ?           ||
041600021025     C     sf1rrn        chain     par310s1                           20        ?           ||
041700021025?3b? C                   if        not *in20                                    ?P--------03||
041800021025     C                   eval      x1retx = t@tpds                              ?          |||
041900021025     C                   update    par310s1                                     ?          |||
042000021025?3e? C                   endif                                                  ?F--------03||
042100021025?2e? C                   endif                                                  ?F---------02|
042200021025?1e? C                   enddo                                                  ?F----------01
042300021025     ?*-
042400021025     C                   endsr
042500001030     ?******************************************************
042600021025     C     sepa01        begsr
042700021025     ?*- COLOCA SEPARADOR DE PARRAFOS----------------------
042800021025     ?*- DETERMINAR PRIMER REGISTRO OCUPADO...
042900021025     C                   eval      y = @@lsf1 + 1
043000021025?1b? C                   do        y             x                              ?P----------01
043100021025     C                   eval      sf1rrn = y - x                               ?            |
043200021025     C     sf1rrn        chain     par310s1                           20        ?            |
043300021025?2b? C                   if        not *in20                                    ?P---------02|
043400021025?3b? C                   if        x1retx <> *blanks                            ?P--------03||
043500021025?1v? C                   leave                                                  ?          |||
043600021025?3e? C                   endif                                                  ?F--------03||
043700021025?2e? C                   endif                                                  ?F---------02|
043800021025?1e? C                   enddo                                                  ?F----------01
043900021025     ?*- COLOCA EL SEPARADOR...
044000021025?1b? C                   if        sf1rrn < @@lsf1                              ?P----------01
044100021025     C                   add       1             sf1rrn                         ?            |
044200021025     C     sf1rrn        chain     par310s1                           20        ?            |
044300021025     C  n20              eval      x1retx = ast(1)                              ?            |
044400021025     C  n20              update    par310s1                                     ?            |
044500021025?1e? C                   endif                                                  ?F----------01
044600021025     ?*-
044700021025     C                   endsr
044800001030     ?******************************************************
044900021025     C     elim01        begsr
045000021025     ?*- ELIMINA REGISTROS EN BLANCO-----------------------
045100021025     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...
045200021025     C                   eval      x = *zeros
045300021025     C                   eval      y = *zeros
045400021025     C                   eval      wrk = *blanks
045500021025?1b? C                   do        @@lsf1        x                              ?P----------01
045600021025     C     x             chain     par310s1                           20        ?            |
045700021025?2b? C                   if        not *in20  and                               ?P---------02|
045800021025     C                             x1retx <> *blanks                            ?           ||
045900021025     C                   add       1             y                              ?           ||
046000021025     C                   eval      wrk(y) = x1retx                              ?           ||
046100021025?2e? C                   endif                                                  ?F---------02|
046200021025?1e? C                   enddo                                                  ?F----------01
046300021025     ?*- LUEGO RECARGA EL SUBARCHIVO...
046400021025     C                   exsr      sf1bor
046500021025?1b? C                   do        @@lsf1        x                              ?P----------01
046600021025     C                   eval      sf1rrn = x                                   ?            |
046700021025     C                   eval      x1retx = wrk(x)                              ?            |
046800021025     C                   write     par310s1                                     ?            |
046900021025?1e? C                   enddo                                                  ?F----------01
047000021025     ?*- INDICADORES DE SUBARCHIVO...
047100021025?1b? C                   if        sf1rrn <> *zeros                             ?P----------01
047200021025     C                   seton                                          3031    ?            |
047300021025?1x? C                   else                                                   ?X..........01
047400021025     C                   seton                                            31    ?            |
047500021025?1e? C                   endif                                                  ?F----------01
047600021025     ?*-
047700021025     C                   endsr
047800001030     ?******************************************************
047900021025     C     inse01        begsr
048000021025     ?*- INSERTAR REGISTROS EN BLANCO----------------------
048100021025     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...
048200021025     C                   eval      x = *zeros
048300021025     C                   eval      y = *zeros
048400021025     C                   eval      wrk = *blanks
048500021025?1b? C                   do        @@lsf1        x                              ?P----------01
048600021025     C     x             chain     par310s1                           20        ?            |
048700021025?2b? C                   if        not *in20                                    ?P---------02|
048800021025     C                   add       1             y                              ?           ||
048900021025     C                   eval      wrk(y) = x1retx                              ?           ||
049000021025?2e? C                   endif                                                  ?F---------02|
049100021025?1e? C                   enddo                                                  ?F----------01
049200021025     ?*- DETERMINAR PRIMER REGISTRO OCUPADO...
049300021025     C                   eval      y = @@lsf1 + 1
049400021025?1b? C                   do        y             x                              ?P----------01
049500021025     C                   eval      sf1rrn = y - x                               ?            |
049600021025     C     sf1rrn        chain     par310s1                           20        ?            |
049700021025?2b? C                   if        not *in20                                    ?P---------02|
049800021025?3b? C                   if        x1retx <> *blanks                            ?P--------03||
049900021025?1v? C                   leave                                                  ?          |||
050000021025?3e? C                   endif                                                  ?F--------03||
050100021025?2e? C                   endif                                                  ?F---------02|
050200021025?1e? C                   enddo                                                  ?F----------01
050300021025     ?*- VER SI HAY ESPACIO PARA INSERTAR...
050400021025?1b? C                   if        sf1rrn < @@lsf1                              ?P----------01
050500021025     ?*- LUEGO RECARGA EL SUBARCHIVO...                                         ?            |
050600021025     C                   eval      x = *zeros                                   ?            |
050700021025     C                   eval      y = *zeros                                   ?            |
050800021025     C                   exsr      sf1bor                                       ?            |
050900021025?2b? C                   do        @@lsf1        sf1rrn                         ?P---------02|
051000021025?3b? C                   if        sf1rrn = cursor                              ?P--------03||
051100021025     C                   eval      x1retx = *blanks                             ?          |||
051200021025?3x? C                   else                                                   ?X........03||
051300021025     C                   add       1             x                              ?          |||
051400021025     C                   eval      x1retx = wrk(x)                              ?          |||
051500021025?3e? C                   endif                                                  ?F--------03||
051600021025     C                   write     par310s1                                     ?           ||
051700021025?2e? C                   enddo                                                  ?F---------02|
051800021025     ?*- INDICADORES DE SUBARCHIVO...                                           ?            |
051900021025?2b? C                   if        sf1rrn <> *zeros                             ?P---------02|
052000021025     C                   seton                                          3031    ?           ||
052100021025?2x? C                   else                                                   ?X.........02|
052200021025     C                   seton                                            31    ?           ||
052300021025?2e? C                   endif                                                  ?F---------02|
052400021025?1e? C                   endif                                                  ?F----------01
052500021025     ?*-
052600021025     C                   endsr
052700001030     ?******************************************************
052800021025     C     sf1bor        begsr
052900021025     ?*- BORRA EL CONTENIDO DEL SUBFILE...
053000021025     C                   seton                                        32
053100021025     C                   write     par310c1
053200021025     C                   setoff                                       32
053300021025     ?*-
053400021025     C                   endsr
053500001030     ?******************************************************
053600021025     C     sf1car        begsr
053700021025     ?*- CARGAR DEL SUBARCHIVO-----------------------------
053800021025     ?*- PRIMERO BORRAR...
053900021025     C                   exsr      sf1bor
054000190405     C*-
054100190411     C                   setoff                                           99
054200190411     C                   seton                                          3031    ?            |
054300190411     C*-
054400190411     C                   if        not *inkx
054500190411     C*-
054600021025     C     k1@ed2        setll     p1hed2
054700021025?1b? C                   dou       *in99                                        ?P----------01
054800021025     C     k1@ed2        reade(n)  p1hed2                                 99    ?            |
054900021025?2b? C                   if        not *in99                                    ?P---------02|
055000021025     C                   add       1             sf1rrn                         ?           ||
055100021025     C                   eval      x1retx = d2retx                              ?           ||
055200021025     C                   write     par310s1                                     ?           ||
055300021025?2e? C                   endif                                                  ?F---------02|
055400021025?1e? C                   enddo                                                  ?F----------01
055500190411     C*-
055600190411     C                   endif
055700190411     C*-
055800021025     C                   unlock    pahed2
055900021025     ?*- CARGAR EL RESTO HASTA ULTIMO REGISTRO...
056000021025     C                   eval      x = @@lsf1 - sf1rrn
056100021025?1b? C                   do        x                                            ?P----------01
056200021025     C                   add       1             sf1rrn                         ?            |
056300021025     C                   eval      x1retx = *blanks                             ?            |
056400021025     C                   write     par310s1                                     ?            |
056500021025?1e? C                   enddo                                                  ?F----------01
056600021025     ?*- CARGA DEL SUBARCHIVO...
056700021025     ?*- INDICADORES DE SUBARCHIVO...
056800021025?1b? C                   if        sf1rrn <> *zeros                             ?P----------01
056900021025     C                   seton                                          3031    ?            |
057000021025?1x? C                   else                                                   ?X..........01
057100021025     C                   seton                                            31    ?            |
057200021025?1e? C                   endif                                                  ?F----------01
057300021025     ?*-
057400021025     C                   endsr
057500001030     ?******************************************************
057600021025     C     sf2car        begsr
057700021025     ?*- CARGAR DEL SUBARCHIVO-----------------------------
057800021025     ?*- PRIMERO BORRAR...
057900021025     C                   exsr      sf1bor
058000021025     ?*- AHORA CARGAR...
058100100830     ?* Para Cascos (ma43 = '3'), en Renovaciones, cargar los textos de
058200100830     ?* todos los Endosos...
058300100830     C                   eval      *in43 = (@@ma43 = '3') and
058400100830     C                                     z0tiou = 2
058500021025     ?*- INDICADORES DE SUBARCHIVO...
058600021025     C                   setoff                                         3031
058700021025     C                   setoff                                           99
058800021025     C                   eval      sf1rrn = *zeros
058900150313     C                   if        txtAutom
059000150313     C                   eval      x = @@lsf1 - sf1rrn
059100150313?1b? C                   do        x                                            ?P----------01
059200150313     C                   add       1             sf1rrn                         ?            |
059300150313     C                   eval      x1retx = *blanks                             ?            |
059400150313     C                   write     par310s1                                     ?            |
059500150313?1e? C                   enddo                                                  ?F----------01
059600150316     C                   seton                                          3031    ?            |
059700150313     C                   leavesr
059800150313     C                   endif
059900100830     C  n43k2@ed2        setll     p1hed2
060000100830     C   43k3@ed2        setll     p1hed2
060100021025?1b? C                   dou       *in99                                        ?P----------01
060200100830     C  n43k2@ed2        reade(n)  p1hed2                                 99    ?            |
060300100830     C   43k3@ed2        reade(n)  p1hed2                                 99    ?            |
060400021025?2b? C                   if        not *in99                                    ?P---------02|
060500021025     C                   add       1             sf1rrn                         ?           ||
060600021025     C                   eval      x1retx = d2retx                              ?           ||
060700021025     C                   write     par310s1                                     ?           ||
060800021025?2e? C                   endif                                                  ?F---------02|
060900021025?1e? C                   enddo                                                  ?F----------01
061000021025     C                   unlock    pahed2
061100021025     ?*- CARGAR EL RESTO HASTA ULTIMO REGISTRO...
061200021025     C                   eval      x = @@lsf1 - sf1rrn
061300021025?1b? C                   do        x                                            ?P----------01
061400021025     C                   add       1             sf1rrn                         ?            |
061500021025     C                   eval      x1retx = *blanks                             ?            |
061600021025     C                   write     par310s1                                     ?            |
061700021025?1e? C                   enddo                                                  ?F----------01
061800021025     ?*- CARGA DEL SUBARCHIVO...
061900021025     ?*- INDICADORES DE SUBARCHIVO...
062000021025?1b? C                   if        sf1rrn <> *zeros                             ?P----------01
062100021025     C                   seton                                          3031    ?            |
062200021025?1x? C                   else                                                   ?X..........01
062300021025     C                   seton                                            31    ?            |
062400021025?1e? C                   endif                                                  ?F----------01
062500021025     ?*-
062600021025     C                   endsr
062700021025     ?******************************************************
062800021025     C     carg01        begsr
062900021025     ?*- CARGAR SUBARCHIVO PRIMERA ENTRADA-----------------
063000021025     C     k1@pd0        chain(n)  p1wpd0                             20
063100021025?1b? C                   select                                                 ?P----------01
063200021025     ?*- ANALIZA FORMAS DE CARGAR SUBARCHIVO...                                 ?            |
063300021025?1x? C                   when      z0wp02 = 1                                   ?w----------01
063400021025     C                   exsr      sf1car                                       ?            |
063500021025?1x? C                   when      z0wp02 = *zeros                              ?w----------01
063600021025?2b? C                   select                                                 ?P---------02|
063700021025?2x? C                   when      z0tiou = 1                                   ?w---------02|
063800021025     C                   exsr      defe01                                       ?           ||
063900021025?2x? C                   when      z0tiou = 2                                   ?w---------02|
064000021025     C                   exsr      defe02                                       ?           ||
064100021025?2x? C                   when      z0tiou = 3  and                              ?w---------02|
064200021025     C                             z0stos <> 08 and *in48                       ?           ||
064300021025     C                   exsr      defe03i                                      ?           ||
064400021025?2x? C                   when      z0tiou = 3  and                              ?w---------02|
064500021025     C                             z0stos <> 08 and not *in48                   ?           ||
064600021025     C                   exsr      defe03                                       ?           ||
064700021025?2x? C                   when      z0tiou = 3  and                              ?w---------02|
064800021025     C                             z0stos = 08                                  ?           ||
064900021025     C                   exsr      defe38                                       ?           ||
065000021025?2x? C                   when      z0tiou = 5                                   ?w---------02|
065100021025     C                   exsr      defe05                                       ?           ||
065200021025?2e? C                   endsl                                                  ?F---------02|
065300021025?1e? C                   endsl                                                  ?F----------01
065400021025     ?*-
065500021025     C                   endsr
065600001030     ?******************************************************
065700021025     C     defe01        begsr
065800021025     ?*- CARGA POR DEFECTO EN OPERACIONES NUEVAS-----------
065900021025     ?* se inicializa el subarchivo sin registros...
066000021025     C                   exsr      sf1car
066100021025     ?* veo si tengo que cargar algun texto por defecto
066200031203?1b? C                   if        %found(set630)                               ?P----------01
066300021025     C                   eval      x1tpcd = t@tpcd                              ?            |
066400021025     C     k@01          chain     s1t124                             20        ?            |
066500021025?2b? C                   if        not *in20                                    ?P---------02|
066600021025     C                   exsr      sf1ca1                                       ?           ||
066700021025?2x? C                   else                                                   ?X.........02|
066800021025     C     k@01a         chain     s1t124                             20        ?           ||
066900021025?3b? C                   if        not *in20                                    ?P--------03||
067000021025     C                   exsr      sf1ca2                                       ?          |||
067100021025?3x? C                   else                                                   ?X........03||
067200021025     C                   exsr      sf1ca1                                       ?          |||
067300021025?3e? C                   endif                                                  ?F--------03||
067400021025?2e? C                   endif                                                  ?F---------02|
067500021025?1e? C                   endif                                                  ?F----------01
067600060613     ?* Si es una póliza de AON y tiene algún texto preseteado asociado
067700060613     ?* debe sacarlo automáticamente...
067800060613     C                   if        es_aon and
067900060614     C                             zztpcd <> *blanks
068000060614     C                   eval      x1tpcd = zztpcd
068100060613     C                   exsr      sf1ca1                                       ?          |||
068200060613     C                   endif
068300060613     ?*-
068400021025     C                   endsr
068500001030     ?******************************************************
068600021025     C     defe02        begsr
068700021025     ?*- CARGA POR DEFECTO EN RENOVACIONES-----------------
068800021025     ?* buscar ultima rama/secuencia de la poliza anterior
068900021025     C     k1@ed0        setgt     p1hed003
069000021025?1b? C                   dow       1 = 1                                        ?P----------01
069100021025     C     k1@ed0        readpe    p1hed003                               99    ?            |
069200021025?2b? C                   if        not *in99                                    ?P---------02|
069300021025?3b? C                   if        d0tiou = 1  or                               ?P--------03||
069400021025     C                             d0tiou = 2  or                               ?          |||
069500021025     C                             d0tiou = 5  or                               ?          |||
069600021025     C                             d0tiou = 3  and                              ?          |||
069700021025     C                             d0stos <> 09                                 ?          |||
069800021025?1v? C                   leave                                                  ?          |||
069900021025?3e? C                   endif                                                  ?F--------03||
070000021025?2e? C                   endif                                                  ?F---------02|
070100021025?1e? C                   enddo                                                  ?F----------01
070200021025     ?* en axa se recuperan los textos desde la póliza
070300021025     ?* original y no desde el último endoso, por lo tanto
070400021025     ?* mando cero al suplemento...
070500021025     C                   eval      d0sspo = *zeros
070600021025     C                   eval      d0suop = *zeros
070700021025     C                   exsr      sf2car
070800021025     ?*-
070900021025     C                   endsr
071000001030     ?******************************************************
071100021025     C     defe03        begsr
071200021025     ?*- CARGA POR DEFECTO EN ENDOSOS----------------------
071300021025     ?* cargar del ultimo endoso que no sea una anulacion
071400021025     ?* o un endoso de anulacion de endoso...
071500021025     C     k2@ed0        setgt     p1hed003
071600021025?1b? C                   dow       1 = 1                                        ?P----------01
071700021025     C     k2@ed0        readpe    p1hed003                               98    ?            |
071800021025?2b? C                   if        not *in98  and                               ?P---------02|
071900021025     C                             d0sspo <> @@sspo                             ?           ||
072000021025?3b? C                   if        d0tiou = 1  or                               ?P--------03||
072100021025     C                             d0tiou = 2  or                               ?          |||
072200021025     C                             d0tiou = 5  or                               ?          |||
072300021025     C                             d0tiou = 3  and                              ?          |||
072400021025     C                             d0stos <> 09  and                            ?          |||
072500021025     C                             d0stos <> 08                                 ?          |||
072600021025?1v? C                   leave                                                  ?          |||
072700021025?3e? C                   endif                                                  ?F--------03||
072800021025?2e? C                   endif                                                  ?F---------02|
072900021025?1e? C                   enddo                                                  ?F----------01
073000021025     C                   exsr      sf2car
073100021025     ?*-
073200021025     C                   endsr
073300021025     ?******************************************************
073400021025     C     defe03i       begsr
073500021205     ?*- CARGA POR DEFECTO EN ENDOSOS DE SPEEDWAY.----------
073600021025     C     k3@ed0        setll     p1hed003                           98
073700021025?1b? C                   dow       not *in98                                    ?P----------01
073800021025     C     k3@ed0        reade     p1hed003                               98    ?            |
073900021025?2b? C                   if        not *in98  and                               ?P---------02|
074000021025     C                             d0sspo <> @@sspo                             ?           ||
074100021025?3b? C                   if        d0tiou = 1  or                               ?P--------03||
074200021025     C                             d0tiou = 2  or                               ?          |||
074300021025     C                             d0tiou = 5  or                               ?          |||
074400021025     C                             d0tiou = 3  and                              ?          |||
074500021025     C                             d0stos <> 09  and                            ?          |||
074600021025     C                             d0stos <> 08                                 ?          |||
074700021025?1v? C                   leave                                                  ?          |||
074800021025?3e? C                   endif                                                  ?F--------03||
074900021025?2e? C                   endif                                                  ?F---------02|
075000021025?1e? C                   enddo                                                  ?F----------01
075100021025     C                   exsr      sf2car
075200021025     ?*-
075300021025     C                   endsr
075400001030     ?******************************************************
075500021025     C     defe05        begsr
075600021025     ?*- CARGA POR DEFECTO EN REHABILITACION---------------
075700021025     C                   exsr      defe03
075800021025     ?*-
075900021025     C                   endsr
076000001030     ?******************************************************
076100021025     C     defe38        begsr
076200021025     ?*- CARGA POR DEFECTO ENDOSO AJUSTE PERIODO-----------
076300021025     ?* se inicializa el subarchivo sin registros...
076400021025     C                   exsr      sf1car
076500021025     ?*-
076600021025     C                   endsr
076700001030     ?******************************************************
076800021025     C     del001        begsr
076900021025     ?*- BORRAR TEXTOS ANTERIORES--------------------------
077000021025     C                   setoff                                           98
077100021025     C     k1@ed2        setll     p1hed2
077200021025?1b? C                   dou       *in98                                        ?P----------01
077300021025     C     k1@ed2        reade     p1hed2                                 98    ?            |
077400021025?2b? C                   if        not *in98                                    ?P---------02|
077500021025     C                   delete    p1hed2                                       ?           ||
077600021025?2e? C                   endif                                                  ?F---------02|
077700021025?1e? C                   enddo                                                  ?F----------01
077800021025     C                   unlock    pahed2
077900021025     ?*-
078000021025     C                   endsr
078100021025     ?******************************************************
078200021025     C     pant02        begsr
078300021025     ?*- ENTRADA/SALIDA PANTALLA 02...
078400040419     C  n50              write     par31000
078500021025     C  n50              write     par310c1
078600021025     C                   exfmt     par31002
078700021025     ?*- APAGAR INDICADOR DE ERROR...
078800021025     C                   setoff                                       505152
078900021025     C                   setoff                                       535455
079000021025     C                   setoff                                       565758
079100021025     C                   setoff                                       5960
079200021025     ?*- PROCESO DE TECLAS DE FUNCION...
079300021025?1b? C                   select                                                 ?P----------01
079400021025     ?*- F3=SALIR DEL PROGRAMA...                                               ?            |
079500021025?1x? C                   when      *inkc                                        ?w----------01
079600021025     C                   eval      @@mand = 'KC'                                ?            |
079700021025     ?*- F12=RETORNAR...                                                        ?            |
079800021025?1x? C                   when      *inkl                                        ?w----------01
079900021025     C                   eval      *inkc = '1'                                  ?            |
080000021025     C                   eval      @@mand = 'KL'                                ?            |
080100021025     ?*- PULSO INTRO...                                                         ?            |
080200021025?1x? C                   when      not *in29                                    ?w----------01
080300021025     C                   exsr      vali02                                       ?            |
080400021025?1e? C                   endsl                                                  ?F----------01
080500021025     ?*-
080600021025     C                   endsr
080700021025     ?******************************************************
080800021025     C     carg02        begsr
080900021025     ?*- CARGAR PANTALLA 02--------------------------------
081000021025     C                   clear                   par31002
081100040419     ?* Restaurar *in23 para tecla del navegador porque el CLEAR anterior
081200040419     ?* lo boleteo!!!
081300040419     C                   eval      *in23 = @@in23
081400021025     C                   setoff                                           99
081500021025     C     k1@ed2        setll     p1hed21
081600021025?1b? C                   dou       *in99                                        ?P----------01
081700021025     C     k1@ed2        reade     p1hed21                                99    ?            |
081800021025?2b? C                   if        not *in99                                    ?P---------02|
081900021025?3b? C                   select                                                 ?P--------03||
082000021025?3x? C                   when      d2seco = 1                                   ?w--------03||
082100021025     C                   eval      x2tpc1 = d2cotx                              ?          |||
082200021025?3x? C                   when      d2seco = 2                                   ?w--------03||
082300021025     C                   eval      x2tpc2 = d2cotx                              ?          |||
082400021025?3x? C                   when      d2seco = 3                                   ?w--------03||
082500021025     C                   eval      x2tpc3 = d2cotx                              ?          |||
082600021025?3x? C                   when      d2seco = 4                                   ?w--------03||
082700021025     C                   eval      x2tpc4 = d2cotx                              ?          |||
082800021025?3x? C                   when      d2seco = 5                                   ?w--------03||
082900021025     C                   eval      x2tpc5 = d2cotx                              ?          |||
083000021025?3x? C                   when      d2seco = 6                                   ?w--------03||
083100021025     C                   eval      x2tpc6 = d2cotx                              ?          |||
083200021025?3x? C                   when      d2seco = 7                                   ?w--------03||
083300021025     C                   eval      x2tpc7 = d2cotx                              ?          |||
083400021025?3x? C                   when      d2seco = 8                                   ?w--------03||
083500021025     C                   eval      x2tpc8 = d2cotx                              ?          |||
083600021025?3x? C                   when      d2seco = 9                                   ?w--------03||
083700021025     C                   eval      x2tpc9 = d2cotx                              ?          |||
083800021025?3x? C                   when      d2seco = 10                                  ?w--------03||
083900021025     C                   eval      x2tpc0 = d2cotx                              ?          |||
084000021025?3e? C                   endsl                                                  ?F--------03||
084100021025?2e? C                   endif                                                  ?F---------02|
084200021025?1e? C                   enddo                                                  ?F----------01
084300021025     ?*-
084400021025     C                   endsr
084500001030     ?******************************************************
084600021025     C     vali02        begsr
084700021025     ?*- VALIDACION PANTALLA 02----------------------------
084800021025     ?* CODIGO 1...
084900021025?1b? C                   if        x2tpc1 <> *blanks                            ?P----------01
085000021025     C                   eval      x@tpcd = x2tpc1                              ?            |
085100021025     C     k@02          chain     s1t124                             20        ?            |
085200021025     C   20              seton                                        5051      ?            |
085300021025?1e? C                   endif                                                  ?F----------01
085400021025     ?* CODIGO 2...
085500021025?1b? C                   if        not *in50  and                               ?P----------01
085600021025     C                             x2tpc2 <> *blanks                            ?            |
085700021025     C                   eval      x@tpcd = x2tpc2                              ?            |
085800021025     C     k@02          chain     s1t124                             20        ?            |
085900021025     C   20              seton                                        5052      ?            |
086000021025?1e? C                   endif                                                  ?F----------01
086100021025     ?* CODIGO 3...
086200021025?1b? C                   if        not *in50  and                               ?P----------01
086300021025     C                             x2tpc3 <> *blanks                            ?            |
086400021025     C                   eval      x@tpcd = x2tpc3                              ?            |
086500021025     C     k@02          chain     s1t124                             20        ?            |
086600021025     C   20              seton                                        5053      ?            |
086700021025?1e? C                   endif                                                  ?F----------01
086800021025     ?* CODIGO 4...
086900021025?1b? C                   if        not *in50  and                               ?P----------01
087000021025     C                             x2tpc4 <> *blanks                            ?            |
087100021025     C                   eval      x@tpcd = x2tpc4                              ?            |
087200021025     C     k@02          chain     s1t124                             20        ?            |
087300021025     C   20              seton                                        5054      ?            |
087400021025?1e? C                   endif                                                  ?F----------01
087500021025     ?* CODIGO 5...
087600021025?1b? C                   if        not *in50  and                               ?P----------01
087700021025     C                             x2tpc5 <> *blanks                            ?            |
087800021025     C                   eval      x@tpcd = x2tpc5                              ?            |
087900021025     C     k@02          chain     s1t124                             20        ?            |
088000021025     C   20              seton                                        5055      ?            |
088100021025?1e? C                   endif                                                  ?F----------01
088200021025     ?* CODIGO 6...
088300021025?1b? C                   if        not *in50  and                               ?P----------01
088400021025     C                             x2tpc6 <> *blanks                            ?            |
088500021025     C                   eval      x@tpcd = x2tpc6                              ?            |
088600021025     C     k@02          chain     s1t124                             20        ?            |
088700021025     C   20              seton                                        5056      ?            |
088800021025?1e? C                   endif                                                  ?F----------01
088900021025     ?* CODIGO 7...
089000021025?1b? C                   if        not *in50  and                               ?P----------01
089100021025     C                             x2tpc7 <> *blanks                            ?            |
089200021025     C                   eval      x@tpcd = x2tpc7                              ?            |
089300021025     C     k@02          chain     s1t124                             20        ?            |
089400021025     C   20              seton                                        5057      ?            |
089500021025?1e? C                   endif                                                  ?F----------01
089600021025     ?* CODIGO 8...
089700021025?1b? C                   if        not *in50  and                               ?P----------01
089800021025     C                             x2tpc8 <> *blanks                            ?            |
089900021025     C                   eval      x@tpcd = x2tpc8                              ?            |
090000021025     C     k@02          chain     s1t124                             20        ?            |
090100021025     C   20              seton                                        5058      ?            |
090200021025?1e? C                   endif                                                  ?F----------01
090300021025     ?* CODIGO 9...
090400021025?1b? C                   if        not *in50  and                               ?P----------01
090500021025     C                             x2tpc9 <> *blanks                            ?            |
090600021025     C                   eval      x@tpcd = x2tpc9                              ?            |
090700021025     C     k@02          chain     s1t124                             20        ?            |
090800021025     C   20              seton                                        5059      ?            |
090900021025?1e? C                   endif                                                  ?F----------01
091000021025     ?* CODIGO 10...
091100021025?1b? C                   if        not *in50  and                               ?P----------01
091200021025     C                             x2tpc0 <> *blanks                            ?            |
091300021025     C                   eval      x@tpcd = x2tpc0                              ?            |
091400021025     C     k@02          chain     s1t124                             20        ?            |
091500021025     C   20              seton                                        5060      ?            |
091600021025?1e? C                   endif                                                  ?F----------01
091700021025     ?* Ahora grabar...
091800021025?1b? C                   if        not *in50                                    ?P----------01
091900021025?2b? C                   if        x2tpc1 = $2tpc1  and                         ?P---------02|
092000021025     C                             x2tpc2 = $2tpc2  and                         ?           ||
092100021025     C                             x2tpc3 = $2tpc3  and                         ?           ||
092200021025     C                             x2tpc4 = $2tpc4  and                         ?           ||
092300021025     C                             x2tpc5 = $2tpc5  and                         ?           ||
092400021025     C                             x2tpc6 = $2tpc6  and                         ?           ||
092500021025     C                             x2tpc7 = $2tpc7  and                         ?           ||
092600021025     C                             x2tpc8 = $2tpc8  and                         ?           ||
092700021025     C                             x2tpc9 = $2tpc9  and                         ?           ||
092800021025     C                             x2tpc0 = $2tpc0                              ?           ||
092900021025     C                   exsr      grab02                                       ?           ||
093000021025     C                   eval      xxiden = 1                                   ?           ||
093100021025     C                   setoff                                           91    ?           ||
093200021025?2x? C                   else                                                   ?X.........02|
093300021025     C                   eval      $2tpc1 = x2tpc1                              ?           ||
093400021025     C                   eval      $2tpc2 = x2tpc2                              ?           ||
093500021025     C                   eval      $2tpc3 = x2tpc3                              ?           ||
093600021025     C                   eval      $2tpc4 = x2tpc4                              ?           ||
093700021025     C                   eval      $2tpc5 = x2tpc5                              ?           ||
093800021025     C                   eval      $2tpc6 = x2tpc6                              ?           ||
093900021025     C                   eval      $2tpc7 = x2tpc7                              ?           ||
094000021025     C                   eval      $2tpc8 = x2tpc8                              ?           ||
094100021025     C                   eval      $2tpc9 = x2tpc9                              ?           ||
094200021025     C                   eval      $2tpc0 = x2tpc0                              ?           ||
094300021025     C                   seton                                            91    ?           ||
094400021025?2e? C                   endif                                                  ?F---------02|
094500021025?1e? C                   endif                                                  ?F----------01
094600021025     ?*-
094700021025     C                   endsr
094800001030     ?******************************************************
094900021025     C     grab02        begsr
095000021025     ?*- GRABAR PANTALLA 02--------------------------------
095100021025     ?* primero borrar...
095200021025     C                   setoff                                           99
095300021025     C     k1@ed2        setll     p1hed21
095400021025?1b? C                   dou       *in99                                        ?P----------01
095500021025     C     k1@ed2        reade     p1hed21                                99    ?            |
095600021025?2b? C                   if        not *in99                                    ?P---------02|
095700021025     C                   delete    p1hed21                                      ?           ||
095800021025?2e? C                   endif                                                  ?F---------02|
095900021025?1e? C                   enddo                                                  ?F----------01
096000021025     ?* ahora grabar....
096100021025     C                   eval      d2empr = @@empr
096200021025     C                   eval      d2sucu = @@sucu
096300021025     C                   eval      d2arcd = @@arcd
096400021025     C                   eval      d2spol = @@spol
096500021025     C                   eval      d2sspo = @@sspo
096600021025     C                   eval      d2rama = @@rama
096700021025     C                   eval      d2arse = @@arse
096800021025     C                   eval      d2oper = @@oper
096900021025     C                   eval      d2suop = @@suop
097000021025     C                   eval      d2cert = *zeros
097100021025     C                   eval      d2poli = *zeros
097200021025     C                   eval      d2marp = '0'
097300021025     C                   eval      d2strg = '0'
097400021025     C                   eval      d2user = vsuser
097500021025     C                   time                    d2time
097600021025     C                   eval      d2date = udate
097700021025     ?*- CAMPOS VARIABLES...
097800021025     C                   clear                   d2seco
097900021025?1b? C                   if        x2tpc1 <> *blanks                            ?P----------01
098000021025     C                   add       1             d2seco                         ?            |
098100021025     C                   eval      d2cotx = x2tpc1                              ?            |
098200021025     C                   write     p1hed21                                      ?            |
098300021025?1e? C                   endif                                                  ?F----------01
098400021025     ?*
098500021025?1b? C                   if        x2tpc2 <> *blanks                            ?P----------01
098600021025     C                   add       1             d2seco                         ?            |
098700021025     C                   eval      d2cotx = x2tpc2                              ?            |
098800021025     C                   write     p1hed21                                      ?            |
098900021025?1e? C                   endif                                                  ?F----------01
099000021025     ?*
099100021025?1b? C                   if        x2tpc3 <> *blanks                            ?P----------01
099200021025     C                   add       1             d2seco                         ?            |
099300021025     C                   eval      d2cotx = x2tpc3                              ?            |
099400021025     C                   write     p1hed21                                      ?            |
099500021025?1e? C                   endif                                                  ?F----------01
099600021025     ?*
099700021025?1b? C                   if        x2tpc4 <> *blanks                            ?P----------01
099800021025     C                   add       1             d2seco                         ?            |
099900021025     C                   eval      d2cotx = x2tpc4                              ?            |
100000021025     C                   write     p1hed21                                      ?            |
100100021025?1e? C                   endif                                                  ?F----------01
100200021025     ?*
100300021025?1b? C                   if        x2tpc5 <> *blanks                            ?P----------01
100400021025     C                   add       1             d2seco                         ?            |
100500021025     C                   eval      d2cotx = x2tpc5                              ?            |
100600021025     C                   write     p1hed21                                      ?            |
100700021025?1e? C                   endif                                                  ?F----------01
100800021025     ?*
100900021025?1b? C                   if        x2tpc6 <> *blanks                            ?P----------01
101000021025     C                   add       1             d2seco                         ?            |
101100021025     C                   eval      d2cotx = x2tpc6                              ?            |
101200021025     C                   write     p1hed21                                      ?            |
101300021025?1e? C                   endif                                                  ?F----------01
101400021025     ?*
101500021025?1b? C                   if        x2tpc7 <> *blanks                            ?P----------01
101600021025     C                   add       1             d2seco                         ?            |
101700021025     C                   eval      d2cotx = x2tpc7                              ?            |
101800021025     C                   write     p1hed21                                      ?            |
101900021025?1e? C                   endif                                                  ?F----------01
102000021025     ?*
102100021025?1b? C                   if        x2tpc8 <> *blanks                            ?P----------01
102200021025     C                   add       1             d2seco                         ?            |
102300021025     C                   eval      d2cotx = x2tpc8                              ?            |
102400021025     C                   write     p1hed21                                      ?            |
102500021025?1e? C                   endif                                                  ?F----------01
102600021025     ?*
102700021025?1b? C                   if        x2tpc9 <> *blanks                            ?P----------01
102800021025     C                   add       1             d2seco                         ?            |
102900021025     C                   eval      d2cotx = x2tpc9                              ?            |
103000021025     C                   write     p1hed21                                      ?            |
103100021025?1e? C                   endif                                                  ?F----------01
103200021025     ?*
103300021025?1b? C                   if        x2tpc0 <> *blanks                            ?P----------01
103400021025     C                   add       1             d2seco                         ?            |
103500021025     C                   eval      d2cotx = x2tpc0                              ?            |
103600021025     C                   write     p1hed21                                      ?            |
103700021025?1e? C                   endif                                                  ?F----------01
103800021025     ?*-
103900021025     C                   endsr
104000040618     ?******************************************************
104100040618     C     selepol       begsr
104200040618     ?*- SELECCIONAR TEXTOS DE POLIZAS---------------------
104300040618     C                   clear                   x1poli
104400040618     C                   clear                   x1suop
104500040618     C                   eval      x1marc = 'N'
104600160606     C                   eval      x1cpub = 'N'
104700040618     C     volver        tag
104800040618     C                   exfmt     par31003
104900040618     C                   setoff                                       636450
105000040618     ?*- SI LA PÓLIZA ES VALIDA TRATAR DE CARGAR....
105100040618?1b? C                   if        x1marc = 'N'
105200040618?2b? C                   if        x1poli <> *zeros
105300040618     C     k1@ed2pol     chain     pahed201
105400040618?3b? C                   if        %found(pahed201)
105500040618     C                   exsr      cargapol
105600040618?3x? C                   else
105700040618     C                   seton                                        5063
105800040618?3e? C                   endif
105900040618?2x? C                   else
106000040618     C                   seton                                        5064
106100040618?2e? C                   endif
106200040618?1x? C                   else
106300040618     C     k2@ed2pol     chain     pahed201
106400040618?2b? C                   if        %found(pahed201)
106500040618     C                   exsr      cargapol
106600040618?2x? C                   else
106700040618     C                   seton                                        5063
106800040618?2e? C                   endif
106900040618?1e? C                   endif
107000040622     ?*- SI ES F12 SALE DE LA PANTALLA...
107100040618?1b? C                   if        *inkl
107200040618     C                   setoff                                       636450
107300160607     C                   leaveSr
107400040618?1e? C                   endif
107500040622     ?*- SI ES ERROR VUELVE A VALIDAR...
107600040618?1b? C                   if        *in63 or
107700040618     C                             *in64
107800040618?GO? C                   goto      volver
107900040618?1e? C                   endif
108000160607      *
108100160607     ?* Copia Archivos ER*
108200160608     C                   if        x1cpub = 'S' and
108300160608     C                             SVPWS_getGrupoRamaArch( @@rama ) = 'R'
108400160608     C
108500160607     C     k4@ed0        chain     pahed004
108600160607     C                   if        %found( pahed004 )
108700160607     C
108800160607     C                   callp     spseter ( @@empr
108900160607     C                                     : @@sucu
109000160607     C                                     : t1arcd
109100160607     C                                     : t1spol
109200160607     C                                     : @@rama
109300160607     C                                     : @@arse
109400160607     C                                     : @@spol
109500160607     C                                     : @@oper
109600160607     C                                     : @@sspo
109700160607     C                                     : *omit
109800160607     C                                     : *omit  )
109900160607     C                   leaveSr
110000160607     C                   endif
110100160607     C                   endif
110200040618     C                   endsr
110300040618     ?******************************************************
110400040618     C     cargapol      begsr
110500040618     ?*-
110600040618     C                   eval      y = @@lsf1 + 1
110700040618?1b? C                   do        y             x                              ?P----------01
110800040618     C                   eval      sf1rrn = y - x                               ?            |
110900040618     C     sf1rrn        chain     par310s1                           20        ?            |
111000040618?2b? C                   if        not *in20                                    ?P---------02|
111100040618?3b? C                   if        x1retx <> *blanks                            ?P--------03||
111200040618?1v? C                   leave                                                  ?          |||
111300040618?3e? C                   endif                                                  ?F--------03||
111400040618?2e? C                   endif                                                  ?F---------02|
111500040618?1e? C                   enddo                                                  ?F----------01
111600040618     ?*- Si la marca viene con 'N' toma todos los endosos de la póliza...
111700040618?1b? C                   if        x1marc = 'N'
111800040618     C                   seton                                        41
111900040618?1x? C                   else
112000040618     ?*- Sino toma solo el suplemento que se informa por pantalla...
112100040618     C                   seton                                        42
112200040618?1e? C                   endif
112300040618     C                   setoff                                         99      ?            |
112400040618     C                   eval      @@@@suop = *zeros
112500040618     ?*- INDICADORES DE SUBARCHIVO...
112600040618     C   41k1@ed2pol     setll     p1hed201
112700040618     C   42k2@ed2pol     setll     p1hed201
112800040618?1b? C                   dou       *in99  or                                    ?P----------01
112900040618     C                             sf1rrn = @@lsf1                              ?            |
113000040618     C   41k1@ed2pol     reade     p1hed201                               99    ?            |
113100040618     C   42k2@ed2pol     reade     p1hed201                               99    ?            |
113200040618?2b? C                   if        not *in99                                    ?P---------02|
113300040622?4b? C                   if        @@@@suop <> rrsuop
113400040622     C                   eval      @@@@suop = rrsuop
113500040622     C                   exsr      grabolinea
113600040622?4e? C                   endif                                                  ?F--------03||
113700040618     ?*- CARGAR SUBARCHIVO...                                                   ?           ||
113800040618     C                   add       1             sf1rrn                         ?           ||
113900040618     C     sf1rrn        chain     par310s1                           20        ?           ||
114000040618?3b? C                   if        not *in20                                    ?P--------03||
114100040622     C                   eval      x1retx = rrretx                              ?          |||
114200040618     C                   update    par310s1                                     ?          |||
114300040618?3e? C                   endif                                                  ?F--------03||
114400040618?2e? C                   endif                                                  ?F---------02|
114500040618?1e? C                   enddo                                                  ?F----------01
114600040618     ?*-
114700040618     ?*-
114800040618     C                   endsr
114900040618     ?******************************************************
115000040618     C     grabolinea    begsr
115100040618     ?*-
115200040622     C                   add       1             sf1rrn                         ?           ||
115300040622     C     sf1rrn        chain     par310s1                           20        ?           ||
115400040618     C                   move      rrsuop        @@@1suop
115500040618     C     @@linea1      cat       @@@1suop:1    @@@@retx                       ?          |||
115600040618     C     @@@@retx      cat       @@linea2:1    @@@@retx1                      ?          |||
115700040618     C                   eval      x1retx = @@@@retx1                           ?          |||
115800040622     C                   update    par310s1                                     ?          |||
115900040618     ?*-
116000040618     C                   endsr
116100001030     ?******************************************************
116200021025     C     inicio        begsr
116300021025     ?*- INICIO DE PROGRAMA Y DEFINICIONES-----------------
116400021025     C                   eval      sf1rrn = *zeros
116500021025     C                   eval      @@lsf1 = 600
116600021025     C                   eval      x = *zeros
116700021025     C                   eval      y = *zeros
116800021025     C                   eval      q = *zeros
116900021025     C                   eval      xxiden = 2
117000021025     ?*- APAGAR TODOS LOS INDICADORES...
117100021025     C                   eval      x = *zeros
117200021025?1b? C                   dou       x = 99                                       ?P----------01
117300021025     C                   add       1             x                              ?            |
117400021025     C                   eval      *in(x) = '0'                                 ?            |
117500021025?1e? C                   enddo                                                  ?F----------01
117600021025     C                   clear                   par31002
117700021025     C                   clear                   par31001
117800040419     ?* Y seguimosss... despues del clear, restaurar para navegador...
117900040419     C                   eval      *in23 = @@in23
118000021025     C                   clear                   $2tpc1
118100021025     C                   clear                   $2tpc2
118200021025     C                   clear                   $2tpc3
118300021025     C                   clear                   $2tpc4
118400021025     C                   clear                   $2tpc5
118500021025     C                   clear                   $2tpc6
118600021025     C                   clear                   $2tpc7
118700021025     C                   clear                   $2tpc8
118800021025     C                   clear                   $2tpc9
118900021025     C                   clear                   $2tpc0
119000021025     ?*- DEFINICIONES DE CLAVES...
119100021025     C     k@01          klist
119200021025     C                   kfld                    @@rama
119300021025     C                   kfld                    x1tpcd
119400021025     C     k@01a         klist
119500021025     C                   kfld                    x@rama
119600021025     C                   kfld                    x1tpcd
119700021025     C     k@02          klist
119800021025     C                   kfld                    @@rama
119900021025     C                   kfld                    x@tpcd
120000021025     ?*- PAWPD0...
120100021025     C     k1@pd0        klist
120200021025     C                   kfld                    @@empr
120300021025     C                   kfld                    @@sucu
120400021025     C                   kfld                    @@arcd
120500021025     C                   kfld                    @@spo1
120600021025     C                   kfld                    @@spol
120700021025     C                   kfld                    @@sspo
120800021025     C                   kfld                    @@rama
120900021025     C                   kfld                    @@arse
121000021025     C                   kfld                    @@oper
121100021025     C                   kfld                    @@suop
121200021025     ?*- PAHED2...
121300021025     C     k1@ed2        klist
121400021025     C                   kfld                    z0empr
121500021025     C                   kfld                    z0sucu
121600021025     C                   kfld                    z0arcd
121700021025     C                   kfld                    z0spol
121800021025     C                   kfld                    z0sspo
121900021025     C                   kfld                    z0rama
122000021025     C                   kfld                    z0arse
122100021025     C                   kfld                    z0oper
122200021025     C                   kfld                    z0suop
122300021025     C     k2@ed2        klist
122400021025     C                   kfld                    d0empr
122500021025     C                   kfld                    d0sucu
122600021025     C                   kfld                    d0arcd
122700021025     C                   kfld                    d0spol
122800021025     C                   kfld                    d0sspo
122900021025     C                   kfld                    d0rama
123000021025     C                   kfld                    d0arse
123100021025     C                   kfld                    d0oper
123200021025     C                   kfld                    d0suop
123300100830     C     k3@ed2        klist
123400100830     C                   kfld                    d0empr
123500100830     C                   kfld                    d0sucu
123600100830     C                   kfld                    d0arcd
123700100830     C                   kfld                    d0spol
123800021025     ?*- PAHED0...
123900021025     C     k1@ed0        klist
124000021025     C                   kfld                    z0empr
124100021025     C                   kfld                    z0sucu
124200021025     C                   kfld                    z0arcd
124300021025     C                   kfld                    z0spo1
124400021025     C                   kfld                    z0rama
124500021025     C                   kfld                    z0arse
124600021025     C     k2@ed0        klist
124700021025     C                   kfld                    z0empr
124800021025     C                   kfld                    z0sucu
124900021025     C                   kfld                    z0arcd
125000021025     C                   kfld                    z0spol
125100021025     C                   kfld                    z0rama
125200021025     C                   kfld                    z0arse
125300021025     C                   kfld                    z0oper
125400160607     C     k4@ed0        klist
125500160607     C                   kfld                    @@empr
125600160607     C                   kfld                    @@sucu
125700160607     C                   kfld                    @@rama
125800160607     C                   kfld                    x1poli
125900021205     ?* KLIST DE SPEEDWAY...
126000021025     C     k1@980        klist
126100021025     C                   kfld                    @@empr
126200021025     C                   kfld                    @@sucu
126300021025     C                   kfld                    @@arcd
126400021025     C                   kfld                    @@spol
126500021025     C                   kfld                    @@sspo
126600021025     C     k3@ed0        klist
126700021025     C                   kfld                    z0empr
126800021025     C                   kfld                    z0sucu
126900021025     C                   kfld                    z0arcd
127000021025     C                   kfld                    z0spol
127100021025     C                   kfld                    z0rama
127200021025     C                   kfld                    z0arse
127300021025     C                   kfld                    z0oper
127400021025     C                   kfld                    z0suop
127500040618     C     k1@ed2pol     klist
127600040618     C                   kfld                    @@empr
127700040618     C                   kfld                    @@sucu
127800040618     C                   kfld                    @@rama
127900040618     C                   kfld                    x1poli
128000040618     C     k2@ed2pol     klist
128100040618     C                   kfld                    @@empr
128200040618     C                   kfld                    @@sucu
128300040618     C                   kfld                    @@rama
128400040618     C                   kfld                    x1poli
128500040618     C                   kfld                    x1suop
128600021025     ?* cargar campos de cabecera...
128700021025     C                   eval      xxarcd = @@arcd
128800021025     C                   eval      xxspol = @@spol
128900021025     C                   eval      xxsspo = @@sspo
129000021025     C                   eval      xxrama = @@rama
129100021025     C                   eval      xxarse = @@arse
129200021025     C                   eval      xxoper = @@oper
129300021025     C                   eval      xxsuop = @@suop
129400040416     ?* Ver si habilita tecla F17 para navegador...
129500040416     C     k1@pd0        setll     pawp310
129600040416?1b? C                   if        %equal                                       ?P----------01
129700040419     C                   eval      @@in23 = *on                                 ?            |
129800040416?1e? C                   endif                                                  ?F----------01
129900031203     ?* Accede al Artículo para ciertos parámetros.
130000031203     C     @@arcd        chain     set630
130100100830     C                   if        %found(set630)
130200100830     C                   eval      @@ma43 = t@ma43
130300100830     C                   else
130400100830     C                   eval      @@ma43 = '0'
130500100830     C                   endif
130600021205     ?*  ES POLIZA DE SPEEDWAY...
130700031203     C                   eval      *in48 = *off
130800031203?1b? C                   if        %found(set630) and t@ma44 = '1'              ?P----------01
130900031203     C     k1@980        chain     gti98001                           20        ?            |
131000021025?2b? C                   if        not *in20                                    ?P---------02|
131100021025     C                   seton                                        48        ?           ||
131200021025?2e? C                   endif                                                  ?F---------02|
131300031203?1e? C                   endif                                                  ?F----------01
131400060614     ?* Veo si es una póliza de AON ASSIST...
131500060614     C                   eval      @@fpgm = 'INT'
131600060614     C                   callp     spdetaon(@@empr:
131700060614     C                                      @@sucu:
131800060614     C                                      @@arcd:
131900060614     C                                      @@spol:
132000060614     C                                      es_aon:
132100060614     C                                      @@fpgm:
132200060614     C                                      zztpcd)
132300060614     ?* Si es de AON ASSIST muestro un mensaje...
132400060614     C                   if        es_aon
132500060614     C                   eval      xxmsg = c$001
132600060614     C                   else
132700060614     C                   eval      xxmsg = *blanks
132800060614     C                   endif
132900060614     ?* cargar subarchivo primera entrada...
133000021025     C                   exsr      carg01
133100021025     ?* cargar pantalla 02...
133200021025     C                   exsr      carg02
133300021025     ?* Mostrar pantalla 02...
133400021025     C                   eval      xxiden = 2
133500021025     ?*-
133600021025     C                   endsr
133700150312     ?******************************************************
133800150312
133900150312     P txtAutom        b
134000150312     D txtAutom        pi              n
134100150312
134200150312     D txtAut          s               n
134300150312
134400150313        SPTXTAUTE ( @@empr : @@sucu : @@arcd : @@spol : @@sspo : txtAut );
134500150312
134600150312        if txtAut;
134700150626          if ( z0tiou = 2 and z0stou = 0 );
134800150626            return *On;
134900150626          endif;
135000150626          return *Off;
135100150312        else;
135200150312          return *Off;
135300150312        endif;
135400150312
135500150312     P txtAutom        e
135600001030     ?******************************************************
135700031203**
135800031203***************************************************************************
