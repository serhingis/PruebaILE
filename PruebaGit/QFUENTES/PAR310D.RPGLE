000100991217     H decedit(',') datedit(*dmy/)
000200050708     H actgrp(*caller) dftactgrp(*no)
000300991217     ?*****************************************************************
000400991217     ?*  PAR310D : DETALLE DE SUPERPOLIZAS                            *
000500991217     ?*          : MODULO DE PRODUCCION POR ARTICULOS                 *
000600991217     ?*                                                               *
000700991217     ?*  FECHA   : 18/12/96                                           *
000800991217     ?*  AUTOR   : ALEJANDRO RODRIGUEZ                                *
000900991217     ?*                              (C) COPYRIGHT COLINET-TROTTA SRL *
001000991217     ?*****************************************************************
001100991217     ?*                   M O D I F I C A C I O N E S
001200991217     ?* mav mav-14/10/98 -Calcula fecha hasta para tipo de duraciÛn de
001300991217     ?*  perÌodo hasta fecha de nacimiento + cantidad de aÒos
001400991217     ?* ahr ahr-18/05/99 -cambiar tratamiento de las vigencias para
001500991217     ?*  preveer vigencias que van de las 0 a las 24 horas...
001600991217     ?* ahr ahr-06/07/99 -no recalcular vigencia hasta cuando el progra
001700991217     ?*  ma ingresa por segunda vez y no se modificÛ ninguna variable
001800991217     ?*  que afecte la misma...
001900991217     ?* mav mav-11/06/99 -Abre vigencia para endosos varios...
002000991217     ?* mav mav-19/07/99 -Habilita cÛdigo de agenda (in13) con @@MA17..
002100991217     ?* ahr ahr-26/11/99 -Rutina srfech en carg01 condiciono para que
002200991217     ?* se haga solo en polizas nuevas, renovaciones y refacturaciones
002300000414     ?* AC  AC -14.04.00 -Se agrega AYUDA en campo de Plan Comercial.
002400010312     ?* ahr ahr-12.03.01 -Agrego dup9=99 hasta facturado =Vto.Poliza.
002500040415     ?* SLU 15/04/2004 - ConversiÛn a RPG4 FULL.
002600040415     ?*                  Se habilita funciÛn para saltar a pasos ante-
002700040415     ?*                  riores.
002800040526     ?* NWN NWN-26.05.04 -Agregado de Campo D0SIVA en Archivo PAHED0.
002900041122     ?* SLU 22/11/2004 - La PTF31102002 (que no est· detallada en esta sec-
003000041122     ?*                  ciÛn) en el loop de b˙squeda de ˙ltimo endoso
003100041122     ?*                  usaba una combinaciÛn de claves que generaba proble
003200041122     ?*                  mas para elperÌodo de RefacturaciÛn (vida por ejem-
003300041122     ?*                  plo), se accedÌa a las fechas Desde en forma errÛ-
003400041122     ?*                  nea. No se notaba cuando se hacÌa la combinaciÛn
003500041122     ?*                  3/11 -> 3/01 porque ambos tenÌa iguales fechas y si
003600041122     ?*                  bien accedÌa al 3/01 al ser iguales no pasaba nada.
003700041122     ?*                  Cuando Vida hace la combinaciÛn 3/11 -> 3/12, este
003800041122     ?*                  endoso trae las fechas del endoso que se est· ajus-
003900041122     ?*                  tando. Una clave quedaba mal posicionada dando
004000041122     ?*                  errores de validaciÛn al no poder determinar el
004100041122     ?*                  perÌodo correcto.
004200041123     ?* SGF 23/11/2004 - Nueva marca en SET621. Si est· marca = '1' entonces
004300041123     ?*                  se fuerza el DUPE del Hasta Facturado en 99 para
004400041123     ?*                  copiar la vigencia hasta en la fecha hasta factura-
004500041123     ?*                  do.
004600050708     ?* SGF 18/04/2005 - Recompilo por cambio de formato en EC1/ED0.
004700050708     ?* SLU 08/07/2005 - Si corresponde que exista un Contrato de Reaseguro para
004800050708     ?*                  la Fecha de Inicio de Vigencia, debe existir el mismo.
004900050708     ?*                - La diferencia entre la posible Fecha de EmisiÛn y la de
005000050708     ?*                  Vigencia no debe exceder lo indicado en la tabla SET123
005100050708     ?*                  de par·metros de emisiÛn por Rama.
005200061228     ?* NWN 27/12/2006 - Recompilacion por agregado de campo D0CUIC.
005300070105     ?* SLU 05/01/2007 - Por aparente "pÈrdida de fuente" este programa debe
005400070105     ?*                  ser modificado en cuanto a la PTF08072008.
005500070105     ?*                  Estaba dando error al dejar prendida la Bande-
005600070105     ?*                  ra de error en procedimiento OK_CTTOREASE.
005601140603     ?*  SGF 03/06/2014 - Grabo mensaje como "ya listado" por ahorro de        *
005602140603     ?*                   papel.
005700040415     ?*
005800991217     ?*****************************************************************
005900991217     Fpar310dm  cf   e             workstn usropn
006000991217     Fpawpd0    uf   e           k disk
006100040415     Fpawp310   uf   e           k disk
006200991217     Fpahed0    uf a e           k disk
006300991217     Fpahed6    uf a e           k disk
006400991217     Fpahed9    uf a e           k disk
006500991217     Fpahed003  if   e           k disk
006600001128     Fpahed006  if   e           k disk
006700991217     Fpahec0    if   e           k disk
006800000531     Fpahec4    if   e           k disk
006900991217     Fpahec1    if   e           k disk
007000991217     Fset620    if   e           k disk
007100991217     Fset621    if   e           k disk
007200991230     Fset606    if   e           k disk
007300991230     Fset609    if   e           k disk
007400991217     Fset6091   if   e           k disk
007500991217     Fset630    if   e           k disk
007600991217     Fset62202  if   e           k disk
007700050708     Fset80405  if   e           k disk
007800991217     Fgnhdaf    if   e           k disk
007900991217     Fgnhda1    if   e           k disk
008000991217     Fgntloc    if   e           k disk
008100991217     Fgntpro    if   e           k disk
008200991217     Fset12003  if   e           k disk
008300991217     Fset610    if   e           k disk
008400991217     Fset001    if   e           k disk
008500991217     Fset676    if   e           k disk
008600991217     Fset677    if   e           k disk
008700991217     Fset678    if   e           k disk
008800010314     Fset123    if   e           k disk
008900010314     Fpahmsg    uf a e           k disk
009000050708     ?******************************************************************
009100050708     ?* Prototype for procedure: ok_cttorease
009200050708     ?* Purpose:        Controla si existe un ctto. para la fecha y rama par·metros.
009300050708     ?* Returns:        *ON: Hay Contrato Reaseguro. *OFF: No hay.
009400050708     ?* Parameter:      fecha_input => Fecha contra la que debemos ver si hay un contrato.
009500050708     ?* Parameter:      rama_input => Rama para controlar si existe un contrato.
009600050708
009700050708     D ok_cttorease    pr                  like(*in50)
009800050708     D fecha_input                    8  0
009900050708     D rama_input                          like(d0rama)
010000050708     ?******************************************************************
010100010314     ?*- DEFINIR CONSTANTES...
010200010314     D $$c001          c                   const('PAR312X   ')
010300010314     D $$c002          c                   const('DIFERENCIA EN DIAS E-
010400010314     D                                     NTRE FECHA DE EMISIO-
010500010314     D                                     N Y FECHA DE INICIO -
010600010314     D                                     DE VIGENCIA SUPERA L-
010700010314     D                                     APSO PERMITIDO PARA -
010800010314     D                                     LA RAMA*************')
010900010314     ?*- AGRUPACION DIA-MES-A–O EN UN SOLO CAMPO...
011000991217     D                 ds
011100991217     D  p@fdma                01     08  0
011200991217     D  p@fdia                01     02  0
011300991217     D  p@fmes                03     04  0
011400991217     D  p@fa—o                05     08  0
011500991217     D                 ds
011600991217     D  p@2dma                01     08  0
011700991217     D  p@2dia                01     02  0
011800991217     D  p@2mes                03     04  0
011900991217     D  p@2a—o                05     08  0
012000991217     ?*- AGRUPACION A–O-MES-DIA EN UN SOLO CAMPO...
012100991217     D                 ds
012200991217     D  p@famd                01     08  0
012300991217     D  p@1a—o                01     04  0
012400991217     D  p@1mes                05     06  0
012500991217     D  p@1dia                07     08  0
012600991217     ?*- PARAMETROS PARA 'SPFECH'...
012700991217     D p@fech          ds
012800991217     D  p@flap                01     05  0
012900991217     D  p@ffec                06     13  0
013000040415     ?* Campos independientes...
013100040415     D $$agec          s                   like(x1agec)
013200040415     D $$anua          s                   like(x1anua)
013300040415     D $$desd          s                   like(x1desd)
013400040415     D $$dup1          s                   like(x1dup1)
013500040415     D $$dup2          s                   like(x1dup2)
013600040415     D $$hafa          s                   like(x1hafa)
013700040415     D $$hast          s                   like(x1hast)
013800040415     D $$ncoc          s                   like(x1ncoc)
013900040415     D $$plac          s                   like(x1plac)
014000040415     D $$poli          s                   like(x1poli)
014100040415     D $a—o1           s              4  0                                                |
014200040415     D $a—o2           s              4  0                                                |
014300040415     D $dia1           s              2  0                                                |
014400040415     D $dia2           s              2  0                                                |
014500040415     D $mes1           s              2  0                                                |
014600040415     D $mes2           s              2  0                                                |
014700050708     D x@fema          s                   like($a—o1)
014800050708     D x@femm          s                   like($mes1)
014900050708     D x@femd          s                   like($dia1)
015000040415     D @@anua          s                   like(x1anua)
015100040415     D @@arcd          s                   like(z0arcd)
015200040415     D @@arse          s                   like(z0arse)
015300040415     D @@cfpg          s                   like(c1cfpg)
015400040415     D @@desd          s                   like(x1desd)
015500040415     D @@dia           s              2  0                                                |
015600040415     D @@dias          s              5  0                                               ||
015700040415     D @@dia1          s              2  0                                                |
015800040415     D @@dupe          s                   like(x1dup1)
015900040415     D @@empr          s                   like(z0empr)
016000040415     D @@fa—o          s              4  0                                               ||
016100040415     D @@fdia          s              2  0                                               ||
016200040415     D @@fec1          s                   like(x1hast)
016300040415     D @@fec2          s                   like(x1hast)
016400040415     D @@fec3          s                   like(x1hast)
016500040415     D @@fec4          s                   like(x1hast)
016600040415     D @@fec5          s                   like(x1hast)
016700040415     D @@fec6          s                   like(x1hast)
016800040415     D @@fec7          s                   like(x1hast)
016900040415     D @@fec8          s                   like(x1hast)
017000040415     D @@fec9          s                   like(x1hast)
017100040415     D @@fmes          s              2  0                                               ||
017200040415     D @@hafa          s                   like(x1hafa)
017300040415     D @@hast          s                   like(x1hast)
017400040415     D @@in36          s              1  0
017500040415     D @@in74          s              1  0
017600040415     D @@in75          s              1  0
017700040415     D @@in76          s              1  0
017800040415     D @@in78          s              1  0
017900040415     D @@in79          s              1  0
018000040415     D @@in82          s              1  0
018100040415     D @@ma07          s                   like(t@ma07)
018200040415     D @@ma08          s                   like(t@ma08)
018300040415     D @@ma17          s                   like(t@ma17)
018400040415     D @@ma37          s                   like(t@ma37)
018500040415     D @@ma38          s                   like(t@ma38)
018600040415     D @@ma39          s                   like(t@ma39)
018700040415     D @@oper          s                   like(z0oper)
018800040415     D @@pecu          s                   like(d0pecu)
018900040415     D @@plac          s                   like(d0plac)
019000040415     D @@rama          s                   like(z0rama)
019100040415     D @@sarc          s                   like(c4sarc)
019200040415     D @@spol          s                   like(z0spol)
019300040415     D @@spo1          s                   like(z0spo1)
019400040415     D @@sspo          s                   like(z0sspo)
019500040415     D @@sucu          s                   like(z0sucu)
019600040415     D @@suop          s                   like(z0suop)
019700040415     D @e              s              2  0
019800040415     D @1arse          s                   like(z0arse)
019900040415     D @1desd          s                   like(x1desd)
020000040415     D @1dup1          s                   like(x1dup1)
020100040415     D @1dup2          s                   like(x1dup2)
020200040415     D @1hast          s                   like(x1hast)
020300040415     D @1plac          s                   like(d0plac)
020400040415     D @2desd          s                   like(x1desd)
020500040415     D @2hast          s                   like(x1hast)
020600040415     D @2ncoc          s                   like(x1ncoc)
020700040415     D @2plac          s                   like(d0plac)
020800040415     D @3desd          s                   like(x1desd)
020900040415     D wwarcd          s                   like(c1arcd)
021000040415     D wwempr          s                   like(c1empr)
021100040415     D wwpecu          s                   like(d0pecu)
021200040415     D wwspol          s                   like(c1spol)
021300040415     D wwsspo          s                   like(c1sspo)
021400040415     D wwsucu          s                   like(c1sucu)
021500040419     D @@in23          s                   like(*in23)
021600040415     D x               s              9  0
021700040415     D xxiden          s              1  0
021800041123     D t$mar2          s                   like(t@mar2)
021900050708     D x@empr          s                   like(d0empr)
022000050708     D @@fecha         s              8  0
022100991217     ?*- AREA DEL PROGRAMA...
022200991217     D                sds
022300991217     D  vsuser               254    263
022400991217     ?*- AREA LOCAL DE DATOS...
022500991217     D                uds
022600991217     D  usempr               401    401
022700991217     D  ussucu               402    403
022800991217     ?*****************************************************************
022900991217      /SPACE
023000991217     ?*****************************************************************
023100991217     ?*-
023200991217     ?*****************************************************************
023300991217      /SPACE
023400991217     ?*****************************************************************
023500010314     Is1t123
023600010314     I              t@marp                      x@marp
023700010314     I              t@mar1                      x@mar1
023800010314     I              t@mar2                      x@mar2
023900010314     I              t@mar3                      x@mar3
024000991217     ?*-
024100991217     ?*****************************************************************
024200991217      /SPACE
024300991217     ?*****************************************************
024400991217     ?*----------------------------------------------------
024500991217     C     *entry        plist
024600991217     C                   parm                    @@empr
024700991217     C                   parm                    @@sucu
024800991217     C                   parm                    @@arcd
024900991217     C                   parm                    @@spo1
025000991217     C                   parm                    @@spol
025100991217     C                   parm                    @@sspo
025200991217     C                   parm                    @@rama
025300991217     C                   parm                    @@arse
025400991217     C                   parm                    @@oper
025500991217     C                   parm                    @@suop
025600991217     C                   parm                    @@mand            2
025700991217     C                   parm                    endpgm            3
025800991217     ?*- PROCESO TRONCAL-----------------------------------
025900991217?1b? C                   select                                                 ?P----------01
026000991217     ?*- SALIDA DEL PROGRAMA RETRN-------------------------          |          ?            |
026100991217?1x? C                   when      endpgm = *blanks                             ?w----------01
026200991217     C                   open      par310dm                                     ?            |
026300991217     C                   exsr      inicio                                       ?            |
026400991217?2b? C                   dou       *inkc                                        ?P---------02|
026500991217?3b? C     xxiden        caseq     1             pant01                         ?P--------03||
026600991217?3e? C                   endcs                                                  ?F--------03||
026700991217?2e? C                   enddo                                                  ?F---------02|
026800991217     C                   close     par310dm                                     ?            |
026900991217     C                   return                                                 ?            |
027000991217     ?*- SALIDA DEL PROGRAMA CON LAST RECORD---------------          |          ?            |
027100991217?1x? C                   when      endpgm = 'FIN'                               ?w----------01
027200991217     C                   exsr      srclos                                       ?            |
027300991217     C                   seton                                            lr    ?            |
027400991217     ?*----------------------------------------------------          |          ?            |
027500991217?1e? C                   endsl                                                  ?F----------01
027600991217     ?*----------------------------------------------------
027700991217     ?*****************************************************
027800991217      /SPACE
027900991217     ?*****************************************************
028000991217     C     inicio        begsr
028100991217     ?** INICIO DE PROGRAMA -------------------------------
028200991217     ?*- DEFINICION DE CAMPOS...
028300991217     ?*- DEFINICIONES GENERALES...
028400991217     ?*- CAMPOS DE PANTALLA 01...
028500991217     ?*- BORRATINA Y SETEO DE VARIABLES INTERNAS...
028600991217     C                   clear                   @@desd
028700991217     C                   clear                   @1desd
028800991217     C                   clear                   @2desd
028900991217     C                   clear                   @3desd
029000991217     C                   clear                   @@hast
029100991217     C                   clear                   @@fec1
029200991217     C                   clear                   @@fec2
029300991217     C                   clear                   @@fec3
029400991217     C                   clear                   @@fec4
029500991217     C                   clear                   @@fec5
029600991217     C                   clear                   @@dupe
029700991217     C                   clear                   @1dup1
029800991217     C                   clear                   @1dup2
029900991217     C                   clear                   @@hafa
030000991217     C                   clear                   @@anua
030100991217     C                   eval      @1arse = 1
030200991217     ?*- APAGAR TODOS LOS INDICADORES...
030300991217     C                   eval      x = *zeros
030400991217?1b? C                   dou       x = 99                                       ?P----------01
030500991217     C                   add       1             x                              ?            |
030600991217     C                   eval      *in(x) = '0'                                 ?            |
030700991217?1e? C                   enddo                                                  ?F----------01
030800991217     ?*- LIMPIAR PANTALLA COMPLETA...
030900991217     C                   clear                   par31001
031000991217     ?*- DEFINICION DE CLAVES P/ACCESO A ARCHIVOS ...
031100010314     ?*- PAHMSG...
031200010314     C     k1@msg        klist
031300010314     C                   kfld                    msempr
031400010314     C                   kfld                    mssucu
031500010314     C                   kfld                    msarcd
031600010314     C                   kfld                    msspol
031700010314     C                   kfld                    mssspo
031800010314     C                   kfld                    msrama
031900010314     C                   kfld                    msarse
032000010314     C                   kfld                    msoper
032100010314     C                   kfld                    mssuop
032200991217     ?*- PAWPD0...
032300991217     C     k1@pd0        klist
032400991217     C                   kfld                    @@empr
032500991217     C                   kfld                    @@sucu
032600991217     C                   kfld                    @@arcd
032700991217     C                   kfld                    @@spo1
032800991217     C                   kfld                    @@spol
032900991217     C                   kfld                    @@sspo
033000991217     C                   kfld                    @@rama
033100991217     C                   kfld                    @@arse
033200991217     C                   kfld                    @@oper
033300991217     C                   kfld                    @@suop
033400991217     C     k2@pd0        klist
033500991217     C                   kfld                    @@empr
033600991217     C                   kfld                    @@sucu
033700991217     C                   kfld                    @@arcd
033800991217     C                   kfld                    @@spo1
033900991217     C                   kfld                    @@spol
034000991217     C                   kfld                    @@sspo
034100000531     ?*- PAHEC4...
034200000531     C     k1@ec4        klist
034300000531     C                   kfld                    @@empr
034400000531     C                   kfld                    @@sucu
034500000531     C                   kfld                    @@arcd
034600000531     C                   kfld                    @@spol
034700000531     C                   kfld                    @@sspo
034800991217     ?*- PAHED6...
034900991217     C     k1@ed6        klist
035000991217     C                   kfld                    z0empr
035100991217     C                   kfld                    z0sucu
035200991217     C                   kfld                    z0arcd
035300991217     C                   kfld                    z0spol
035400991217     C                   kfld                    z0sspo
035500991217     C                   kfld                    z0rama
035600991217     C                   kfld                    z0arse
035700991217     C                   kfld                    z0oper
035800991217     C                   kfld                    z0suop
035900991217     ?*- PAHED0...
036000991217     C     k1@ed0        klist
036100991217     C                   kfld                    z0empr
036200991217     C                   kfld                    z0sucu
036300991217     C                   kfld                    z0arcd
036400991217     C                   kfld                    z0spol
036500991217     C                   kfld                    z0sspo
036600991217     C                   kfld                    z0rama
036700991217     C                   kfld                    z0arse
036800991217     C                   kfld                    z0oper
036900991217     C                   kfld                    z0suop
037000991217     C     k2@ed0        klist
037100991217     C                   kfld                    z0empr
037200991217     C                   kfld                    z0sucu
037300991217     C                   kfld                    z0arcd
037400991217     C                   kfld                    z0spol
037500991217     C                   kfld                    c1xpro
037600991217     C                   kfld                    z0rama
037700991217     C                   kfld                    z0arse
037800991217     C                   kfld                    z0oper
037900991217     C                   kfld                    c1xpro
038000991217     C     k3@ed0        klist
038100991217     C                   kfld                    z0empr
038200991217     C                   kfld                    z0sucu
038300991217     C                   kfld                    z0arcd
038400991217     C                   kfld                    z0spol
038500991217     C                   kfld                    z0rama
038600991217     C                   kfld                    z0arse
038700991217     C                   kfld                    z0oper
038800001128     C     k4@ed0        klist
038900001128     C                   kfld                    t@empr
039000001128     C                   kfld                    t@sucu
039100001128     C                   kfld                    t@oper
039200991217     ?*- PAHED9...
039300991217     C     k1@ed9        klist
039400991217     C                   kfld                    @@empr
039500991217     C                   kfld                    @@sucu
039600991217     C                   kfld                    @@arcd
039700991217     C                   kfld                    @@spol
039800991217     C                   kfld                    @@sspo
039900991217     C                   kfld                    @@rama
040000991217     C                   kfld                    @@arse
040100991217     C                   kfld                    @@oper
040200991217     C                   kfld                    @@suop
040300991217     C     k2@ed9        klist
040400991217     C                   kfld                    d0empr
040500991217     C                   kfld                    d0sucu
040600991217     C                   kfld                    d0arcd
040700991217     C                   kfld                    d0spol
040800991217     C                   kfld                    d0sspo
040900991217     C                   kfld                    d0rama
041000991217     C                   kfld                    d0arse
041100991217     C                   kfld                    d0oper
041200991217     C                   kfld                    d0suop
041300991217     ?*- PAHEC1...
041400991217     C     k1@ec1        klist
041500991217     C                   kfld                    z0empr
041600991217     C                   kfld                    z0sucu
041700991217     C                   kfld                    z0arcd
041800991217     C                   kfld                    z0spol
041900991217     C                   kfld                    z0sspo
042000021031     C     keyec1        klist
042100021031     C                   kfld                    d0empr
042200021031     C                   kfld                    d0sucu
042300021031     C                   kfld                    d0arcd
042400021031     C                   kfld                    d0spol
042500021031     C                   kfld                    d0sspo
042600021031     C     k1yec1        klist
042700021031     C                   kfld                    wwempr
042800021031     C                   kfld                    wwsucu
042900021031     C                   kfld                    wwarcd
043000021031     C                   kfld                    wwspol
043100021031     C                   kfld                    wwsspo
043200991217     ?*- PAHEC0...
043300991217     C     k1@ec0        klist
043400991217     C                   kfld                    z0empr
043500991217     C                   kfld                    z0sucu
043600991217     C                   kfld                    z0arcd
043700991217     C                   kfld                    z0spol
043800991217     C     k2@ec0        klist
043900991217     C                   kfld                    @@empr
044000991217     C                   kfld                    @@sucu
044100991217     C                   kfld                    @@arcd
044200991217     C                   kfld                    @@spol
044300991217     ?*- SET12003...
044400991217     C     k1t120        klist
044500991217     C                   kfld                    @@empr
044600991217     C                   kfld                    @@sucu
044700991217     C                   kfld                    x1ncoc
044800991217     ?*- SET620...
044900991217     C     k1t620        klist
045000991217     C                   kfld                    z0arcd
045100991217     ?*- SET676...
045200991217     C     k1t676        klist
045300991217     C                   kfld                    x1agec
045400991217     ?*- SET677...
045500991217     C     k1t677        klist
045600991217     C                   kfld                    t@reqc
045700991217     ?*- SET678...
045800991217     C     k1t678        klist
045900991217     C                   kfld                    x1agec
046000991217     ?*- SET621...
046100991217     C     k1t621        klist
046200991217     C                   kfld                    z0arcd
046300991217     C                   kfld                    z0rama
046400991217     C                   kfld                    z0arse
046500991217     C     k2t621        klist
046600991217     C                   kfld                    z0arcd
046700991217     C                   kfld                    z0rama
046800991217     C                   kfld                    @1arse
046900991217     ?*- SET609...
047000991217     C     k1t609        klist
047100991217     C                   kfld                    z0arcd
047200991217     C                   kfld                    z0rama
047300991217     C                   kfld                    z0arse
047400991217     C                   kfld                    c1nivt
047500991217     C                   kfld                    c1nivc
047600991217     C                   kfld                    @@cfpg
047700000531     C                   kfld                    @@sarc
047800991217     C     k2t609        klist
047900991217     C                   kfld                    z0arcd
048000991217     C                   kfld                    z0rama
048100991217     C                   kfld                    z0arse
048200991230     ?*- SET606...
048300991230     C     k1t606        klist
048400991230     C                   kfld                    z0arcd
048500991230     C                   kfld                    z0rama
048600991230     C                   kfld                    z0arse
048700991230     C                   kfld                    z0empr
048800991230     C                   kfld                    z0sucu
048900991230     C                   kfld                    x1ncoc
049000991217     ?*- SET630...
049100991217     C     k1t630        klist
049200991217     C                   kfld                    @@arcd
049300991217     ?*- SET62202...
049400991217     C     k1t622        klist
049500991217     C                   kfld                    @@arcd
049600991217     C                   kfld                    @@rama
049700991217     C                   kfld                    @@arse
049800991217     C                   kfld                    @@empr
049900991217     C                   kfld                    @@sucu
050000991217     C                   kfld                    x1poli
050100991217     ?*- GNHDAF...
050200991217     C     k1tdaf        klist
050300991217     C                   kfld                    t@asen
050400991217     ?*- GNTLOC...
050500991217     C     k1tloc        klist
050600991217     C                   kfld                    dfcopo
050700991217     C                   kfld                    dfcops
050800991217     ?*- GNTPRO...
050900991217     C     k1tpro        klist
051000991217     C                   kfld                    loproc
051100991217     ?*- BUSCAR REGISTRO DE OPERACION SUSPENDIDA...
051200991217     C     k1@pd0        chain(n)  p1wpd0                             20
051300040416     C     k1@pd0        setll     pawp310
051400040416?1b? C                   if        %equal                                       ?P----------01
051500040419     C                   eval      @@in23 = *on                                 ?            |
051600040416?1e? C                   endif                                                  ?F----------01
051700991217     ?*- BUSCAR CABECERA DE SUPERPOLIZA...
051800991217     C     k1@ec1        chain     p1hec1                             20
051900021031     C                   eval      wwempr = c1empr
052000021031     C                   eval      wwsucu = c1sucu
052100021031     C                   eval      wwarcd = c1arcd
052200021031     C                   eval      wwspol = c1spol
052300021031     C                   eval      wwsspo = c1sspo
052400991217     ?*- BUSCAR CABECERA DE SUPERPOLIZA...
052500991217     C     k2@ec0        chain     p1hec0                             20
052600991217     ?*- BUSCAR REGISTRO DEL ARTICULO...
052700991217     C     k1t620        chain     s1t620                             20
052800991217     ?*- BUSCAR CONFIGURACION DEL ARTICULO...
052900991217     C     k1t630        chain     s1t630                             20
053000991217     C  n20              eval      @@ma07 = t@ma07
053100991217     C  n20              eval      @@ma08 = t@ma08
053200991217     C  n20              eval      @@ma17 = t@ma17
053300001128     C  n20              eval      @@ma37 = t@ma37
053400001129     C  n20              eval      @@ma38 = t@ma38
053500001129     C  n20              eval      @@ma39 = t@ma39
053600991217     ?*- PARA EMITIR PANTALLA 0...
053700991217     C                   exsr      borr01
053800991217     C                   exsr      carg01
053900991217     C                   exsr      apag01
054000991217     C                   eval      xxiden = 1
054100040419     C                   exsr      reset_pan
054200991217     ?*-
054300991217     C                   endsr
054400991217     ?*****************************************************
054500991217      /SPACE
054600991217     ?*****************************************************
054700991217     C     pant01        begsr
054800991217     ?** PROCESO PANTALLA '1' -----------------------------
054900991217     ?*- ENTRADA/SALIDA PANTALLA '1' ...
055000991217     C                   exfmt     par31001
055100991217     ?*- CORRIGE SITUACIONES DE ERROR ...
055200991217     C                   exsr      apagar
055300991217     ?*- PROCESA TECLAS DE FUNCION...
055400991217?1b? C                   select                                                 ?P----------01
055500991217     ?*- F3=SALIR...                                                 |          ?            |
055600991217?1x? C                   when      *inkc                                        ?w----------01
055700991217     C                   eval      @@mand = 'KC'                                ?            |
055800991217     ?*- F12=RETORNAR...                                             |          ?            |
055900991217?1x? C                   when      *inkl                                        ?w----------01
056000991217     C                   eval      @@mand = 'KL'                                ?            |
056100991217     C                   eval      *inkc = '1'                                  ?            |
056200040415     ?*- F17=IR A...                                                 |          ?            |
056300040416?1x? C                   when      *inkr                                        ?w----------01
056400040416     C                   eval      @@mand = 'KR'                                ?            |
056500040415     C                   eval      *inkc = '1'                                  ?            |
056600991217     ?*- F4=SOLICITUD...                                             |          ?            |
056700991217?1x? C                   when      *inkd                                        ?w----------01
056800991217     C                   exsr      soli01                                       ?            |
056900991217     ?*- AYUDA...                                                    |          ?            |
057000991217?1x? C                   when      *in80                                        ?w----------01
057100991217     ?*- PULSA INTRO...                                              |          ?            |
057200991217?1x? C                   when      not *in29                                    ?w----------01
057300991217     C                   exsr      vali01                                       ?            |
057400991217?1e? C                   endsl                                                  ?F----------01
057500991217     ?*
057600991217     C                   endsr
057700991217     ?*****************************************************
057800991217      /SPACE
057900991217     ?*****************************************************
058000991217     C     borr01        begsr
058100991217     ?** BORRADO PANTALLA 01-------------------------------
058200991217     C                   clear                   par31001
058300991217     ?*-
058400991217     C                   clear                   $$desd
058500991217     C                   clear                   $$dup1
058600991217     C                   clear                   $$dup2
058700991217     C                   clear                   $$hast
058800991217     C                   clear                   $$plac
058900991217     C                   clear                   $$hafa
059000991217     C                   clear                   $$anua
059100991217     C                   clear                   $$poli
059200991217     C                   clear                   $$agec
059300991217     C                   clear                   $$ncoc
059400991217     ?*-
059500000110     C                   clear                   @2plac
059600000110     ?*-
059700991217     C                   endsr
059800991217     ?*****************************************************
059900991217      /SPACE
060000991217     ?*****************************************************
060100991217     C     carg01        begsr
060200991217     ?** BORRADO PANTALLA 01-------------------------------
060300010312     ?* buscar tabla de ramas...
060400991217     C     @@rama        chain     s1t001                             20
060500010314     ?* buscar tabla de situaciones espciales de la rama
060600010314     C     @@rama        chain     s1t123                             20
060700010314     ?* buscar fecha tentativa de emisiÛn...
060800010314     C                   call      'PAR310X3'
060900050708     C                   parm      @@empr        x@empr
061000050708     C                   parm                    x@fema
061100050708     C                   parm                    x@femm
061200050708     C                   parm                    x@femd
061300010314     C                   eval      p@fa—o = x@fema
061400010314     C                   eval      p@fmes = x@femm
061500010314     C                   eval      p@fdia = x@femd
061600010314     C                   eval      x1femi = p@fdma
061700010312     ?* primero debo analizar si es una poliza global
061800991217     C     k1t621        chain     s1t621                             20
061900991217?1b? C                   if        not *in20  and                               ?P----------01
062000991217     C                             t@mar1 = '1'  and                            ?            |
062100991217     C                             z0ciap = '1'                                 ?            |
062200991217     C                   seton                                        18        ?            |
062300991217?1e? C                   endif                                                  ?F----------01
062400041123     ?* Salvo campo de marca especial en SET621 (t@mar2) dado que luego debo
062500041123     ?* hacer dos cosas dependiendo del valor del mismo:
062600041123     ?* Forzar 99 en DUP2 (Hasta Facturada) y proteger el campo para que no
062700041123     ?* se pueda cambiar...
062800041123     C                   eval      t$mar2 = t@mar2
062900041123?1b? C                   if        t@mar2 = '1'                                 ?P----------01
063000041123     C                   eval      *in91 = *on                                  ?            |
063100041123?1x? C                   else                                                   ?X..........01
063200041123     C                   eval      *in91 = *off                                 ?            |
063300041123?1e? C                   endif                                                  ?F----------01
063400010312     ?* Si el paso01 est” en cero es la primera vez que
063500010312     ?* entra el programa, entonces ejecuta rutinas de car-
063600010312     ?* ga por defecto, caso contrario carga desde el
063700010312     ?* archivos PAHED0...
063800991217?1b? C                   select                                                 ?P----------01
063900991217?1x? C                   when      z0wp01 = 1                                   ?w----------01
064000991217     C     k1@ed0        chain(n)  p1hed0                             20        ?            |
064100991217     ?*- RECUPERO DE OPERACION SUSPENDIDA O VUELTA A                 |          ?            |
064200991217     ?*- CABECERA: CARGA DESDE ARCHIVOS YA GRABADOS...               |          ?            |
064300991217     ?*- DATOS DEL PAHED0...                                         |          ?            |
064400991217     C                   eval      x1arcd = d0arcd                              ?            |
064500991217     C                   eval      x1spol = d0spol                              ?            |
064600991217     C                   eval      x1sspo = d0sspo                              ?            |
064700991217     C                   eval      x1rama = d0rama                              ?            |
064800991217     C                   eval      x1arse = d0arse                              ?            |
064900991217     C                   eval      x1oper = d0oper                              ?            |
065000991217     C                   eval      x1suop = d0suop                              ?            |
065100991217     C                   eval      x1ncoc = d0ncoc                              ?            |
065200991217     C                   eval      x1part = d0part                              ?            |
065300991217     C                   eval      p@fa—o = d0fioa                              ?            |
065400991217     C                   eval      p@fmes = d0fiom                              ?            |
065500991217     C                   eval      p@fdia = d0fiod                              ?            |
065600991217     C                   eval      x1desd = p@fdma                              ?            |
065700991217     C                   eval      @1desd = p@fdma                              ?            |
065800991217     C                   eval      p@fa—o = d0fvoa                              ?            |
065900991217     C                   eval      p@fmes = d0fvom                              ?            |
066000991217     C                   eval      p@fdia = d0fvod                              ?            |
066100991217     C                   eval      x1hast = p@fdma                              ?            |
066200991217     C                   eval      p@fa—o = d0fhfa                              ?            |
066300991217     C                   eval      p@fmes = d0fhfm                              ?            |
066400991217     C                   eval      p@fdia = d0fhfd                              ?            |
066500991217     C                   eval      x1hafa = p@fdma                              ?            |
066600991217     C                   eval      p@fa—o = d0fvaa                              ?            |
066700991217     C                   eval      p@fmes = d0fvam                              ?            |
066800991217     C                   eval      p@fdia = d0fvad                              ?            |
066900991217     C                   eval      x1anua = p@fdma                              ?            |
067000991217     C                   eval      x1dup1 = d0dup1                              ?            |
067100991217     C                   eval      @1dup1 = d0dup1                              ?            |
067200991217     C                   eval      x1mar5 = d0mar5                              ?            |
067300991217     C                   eval      x1dup2 = d0dup2                              ?            |
067400991217     C                   eval      x1pecu = d0pecu                              ?            |
067500991217     C                   eval      x1plac = d0plac                              ?            |
067600991217     C                   eval      @@plac = d0plac                              ?            |
067700000110     C                   eval      @2plac = d0plac                              ?            |
067800000110     C                   eval      @2ncoc = d0ncoc                              ?            |
067900010312     ?* tengo que controlar si hubo cambio de vigencia...            |          ?            |
068000991217?2b? C                   if        d0tiou = 1  or                               ?P---------02|
068100991217     C                             d0tiou = 2  or                               ?           ||
068200991217     C                             d0tiou = 3  and                              ?           ||
068300991217     C                             d0stos = 01                                  ?           ||
068400991217     C                   eval      p@fa—o = c1fioa                              ?           ||
068500991217     C                   eval      p@fmes = c1fiom                              ?           ||
068600991217     C                   eval      p@fdia = c1fiod                              ?           ||
068700991217     C                   eval      @@fec1 = p@fdma                              ?           ||
068800991217     C                   eval      p@fa—o = c1fvoa                              ?           ||
068900991217     C                   eval      p@fmes = c1fvom                              ?           ||
069000991217     C                   eval      p@fdia = c1fvod                              ?           ||
069100991217     C                   eval      @@fec2 = p@fdma                              ?           ||
069200991217?3b? C                   if        x1desd <> @@fec1  or                         ?P--------03||
069300991217     C                             x1hast <> @@fec2                             ?          |||
069400991217     C                   exsr      srfech                                       ?          |||
069500991217?3e? C                   endif                                                  ?F--------03||
069600991217?2e? C                   endif                                                  ?F---------02|
069700991217     ?*- DATOS DEL PAHED6...                                         |          ?            |
069800991217     C     k1@ed6        chain(n)  p1hed6                             20        ?            |
069900991217     C  n20              eval      x1agec = d6agec                              ?            |
070000010312     ?* si es una poliza global debo buscar el pahed9...             |          ?            |
070100991217?2b? C                   if        *in18                                        ?P---------02|
070200991217     C     k1@ed9        chain(n)  p1hed9                             20        ?           ||
070300991217?3b? C                   if        not *in20                                    ?P--------03||
070400991217     C                   eval      x1poli = g9poli                              ?          |||
070500991217?3e? C                   endif                                                  ?F--------03||
070600991217?2e? C                   endif                                                  ?F---------02|
070700991217     C                   exsr      desc01                                       ?            |
070800991217?1x? C                   when      z0wp01 = 0                                   ?w----------01
070900991217     ?*- PRIMERA ENTRADA DEL PROGRAMA...                             |          ?            |
071000991217     ?*- BUSCA DATOS POR DEFECTO SEGUN EL TIPO DE FUNCION..          |          ?            |
071100991217?2b? C                   select                                                 ?P---------02|
071200991217?2x? C                   when      z0tiou = 1                                   ?w---------02|
071300991217     C                   exsr      defe01                                       ?           ||
071400991217?2x? C                   when      z0tiou = 2                                   ?w---------02|
071500991217     C                   exsr      defe02                                       ?           ||
071600991217?2x? C                   when      z0tiou = 3  and                              ?w---------02|
071700991217     C                             z0stos <> 08                                 ?           ||
071800991217     C                   exsr      defe03                                       ?           ||
071900991217?2x? C                   when      z0tiou = 3  and                              ?w---------02|
072000991217     C                             z0stos = 08                                  ?           ||
072100991217     C                   exsr      defe38                                       ?           ||
072200991217?2x? C                   when      z0tiou = 5                                   ?w---------02|
072300991217     C                   exsr      defe05                                       ?           ||
072400991217?2e? C                   endsl                                                  ?F---------02|
072500991217?1e? C                   endsl                                                  ?F----------01
072600010312     ?* protejer campos si corresponde...
072700991217     C                   exsr      prot01
072800991217     ?*-
072900991217     C                   endsr
073000991217     ?*****************************************************
073100991217      /SPACE
073200991217     ?*****************************************************
073300991217     C     srfech        begsr
073400991217     ?*- SUBRUTINA DE GENERACION DE FECHAS-----------------
073500010312     ?* vigencia desde...
073600991217     C                   eval      p@fa—o = c1fioa
073700991217     C                   eval      p@fmes = c1fiom
073800991217     C                   eval      p@fdia = c1fiod
073900991217     C                   eval      x1desd = p@fdma
074000010312     ?* duracion de la pÛliza en meses...
074100991217     C     k1t620        chain     s1t620                             20
074200010312     ?* la duraciÛn de la pÛliza la obtengo siempre desde
074300010312     ?* en el x1dup1 siempre cargo el contenido del pahec1
074400010312     ?* de modo que las vigencias siempre deben coincidir..
074500001129     C                   eval      x1dup1 = c1dupe
074600991217     C                   eval      x1mar5 = t@mar1
074700010312     ?* vigencia hasta...
074800991217?1b? C                   if        x1dup1 <> 99                                 ?P----------01
074900991217?2b? C                   select                                                 ?P---------02|
075000991217?2x? C                   when      x1mar5 = '1'                                 ?w---------02|
075100991217     C                   eval      x1hast = x1desd                              ?           ||
075200991217     C                   call      'SP0001'                                     ?           ||
075300991217     C                   parm                    x1hast                         ?           ||
075400991217     C                   parm                    x1dup1                         ?           ||
075500991217?2x? C                   when      x1mar5 = '2'                                 ?w---------02|
075600991217     C                   eval      p@fdma = x1desd                              ?           ||
075700991217     C                   add       x1dup1        p@fa—o                         ?           ||
075800991217     C                   eval      x1hast = p@fdma                              ?           ||
075900010312     ?*- EXPRESADA EN A—OS HASTA CANTIDAD DE MESES...               ||          ?           ||
076000991217?2x? C                   when      x1mar5 = '3'                                 ?w---------02|
076100991217     C     c1asen        chain     g1hda1                             20        ?           ||
076200991217?3b? C                   if        not *in20                                    ?P--------03||
076300991217     C                   eval      p@fdia = dffnad                              ?          |||
076400991217     C                   eval      p@fmes = dffnam                              ?          |||
076500991217     C     dffnaa        add       x1dup1        p@fa—o                         ?          |||
076600991217     C                   eval      x1hast = p@fdma                              ?          |||
076700991217?3x? C                   else                                                   ?X........03||
076800991217     C                   eval      x1hast = *zeros                              ?          |||
076900991217?3e? C                   endif                                                  ?F--------03||
077000991217?2e? C                   endsl                                                  ?F---------02|
077100991217?1x? C                   else                                                   ?X..........01
077200991217     C                   eval      x1hast = 99999999                            ?            |
077300991217?1e? C                   endif                                                  ?F----------01
077400010312     ?* si la fecha de vencimiento calculada es mayor a la
077500010312     ?* fecha del pahec1 forzar esta ultima...
077600991217     C                   eval      p@fdma = x1hast
077700991217     C                   eval      p@1a—o = p@fa—o
077800991217     C                   eval      p@1mes = p@fmes
077900991217     C                   eval      p@1dia = p@fdia
078000991217     C                   eval      @@fec9 = p@famd
078100991217     C                   eval      p@1a—o = c1fvoa
078200991217     C                   eval      p@1mes = c1fvom
078300991217     C                   eval      p@1dia = c1fvod
078400991217     C                   eval      @@fec8 = p@famd
078500991217?1b? C                   if        @@fec9 > @@fec8                              ?P----------01
078600991217     C                   eval      p@fa—o = c1fvoa                              ?            |
078700991217     C                   eval      p@fmes = c1fvom                              ?            |
078800991217     C                   eval      p@fdia = c1fvod                              ?            |
078900991217     C                   eval      x1hast = p@fdma                              ?            |
079000991217?1e? C                   endif                                                  ?F----------01
079100010312     ?* NUEVA VERSION DE FECHA HASTA...
079200010312     ?* fecha de vencimiento por defecto pongo la
079300010312     ?* del pahec1 (no tengo en cuenta lo que se hizo antes
079400010312     C                   eval      p@fa—o = c1fvoa
079500010312     C                   eval      p@fmes = c1fvom
079600010312     C                   eval      p@fdia = c1fvod
079700010312     C                   eval      x1hast = p@fdma
079800010312     ?* vigencia hasta facturada...
079900991217?1b? C                   select                                                 ?P----------01
080000991217?1x? C                   when      x1ncoc = *zeros                              ?w----------01
080100991217     C     k1t621        chain     s1t621                             20        ?            |
080200991217     C                   eval      @1plac = t@plac                              ?            |
080300991217?1x? C                   when      x1ncoc <> *zeros                             ?w----------01
080400991217     C     k2t621        chain     s1t621                             20        ?            |
080500991217     C                   eval      @1plac = t@plac                              ?            |
080600991217?1e? C                   endsl                                                  ?F----------01
080700041123     ?* Marca especial en SET621: Si es '1' hago dos cosas:
080800041123     ?* Forzar 99 en DUP2 (Hasta Facturado) y protejo el campo para que no
080900041123     ?* lo cambien...
081000041123?1b? C                   if        t@mar2 = '1'                                 ?P----------01
081100041123     C                   eval      x1dup2 = 99                                  ?            |
081200041123     C                   eval      *in91 = *on                                  ?            |
081300041123?1x? C                   else                                                   ?X..........01
081400041123     C                   eval      x1dup2 = t@dupe                              ?            |
081500041123     C                   eval      *in91 = *off                                 ?            |
081600041123?1e? C                   endif                                                  ?F----------01
081700991217     C                   eval      x1hafa = x1desd
081800010312?1b? C                   select                                                 ?P----------01
081900010312?1x? C                   when      x1dup2 <> 99                                 ?w----------01
082000010312     C                   call      'SP0001'                                     ?            |
082100010312     C                   parm                    x1hafa                         ?            |
082200010312     C                   parm                    x1dup2                         ?            |
082300010312?1x? C                   when      x1dup2 = 99                                  ?w----------01
082400010312     C                   eval      x1hafa = x1hast                              ?            |
082500010312?1e? C                   endsl                                                  ?F----------01
082600010312     ?* vencimiento de la anualidad...
082700991217     C                   eval      x1anua = x1desd
082800991217     C                   call      'SP0001'
082900991217     C                   parm                    x1anua
083000991217     C                   parm      12            @@dupe
083100010312     ?* hasta facturado y anualidad en vida obligatorio
083200010312     ?* ajusto las anualidades al 01 de octubre de cada
083300010312     ?* aÒo seg˙n el contenido del @@ma38...
083400001129?1b? C                   if        t@rame = 21  and                             ?P----------01
083500001129     C                             @@ma38 = '1'                                 ?            |
083600001128     C                   exsr      obliga                                       ?            |
083700001128?1x? C                   else                                                   ?X..........01
083800010312     ?* ajustar vigencias si corresponde...                          |          ?            |
083900001128     C                   exsr      ajvige                                       ?            |
084000010312?1e? C                   endif                                                  ?F----------01
084100991217     C                   endsr
084200991217     ?*****************************************************
084300991217      /SPACE
084400991217     ?*****************************************************
084500991217     C     defe01        begsr
084600991217     ?** BUSCAR DATOS POR DEFECTO--------------------------
084700010312     ?* datos constantes de salida...
084800991217     C                   eval      x1arcd = z0arcd
084900991217     C                   eval      x1spol = z0spol
085000991217     C                   eval      x1sspo = z0sspo
085100991217     C                   eval      x1rama = z0rama
085200991217     C                   eval      x1arse = z0arse
085300991217     C                   eval      x1oper = z0oper
085400991217     C                   eval      x1suop = z0suop
085500991217     C                   eval      x1ncoc = z0ncoc
085600991217     C                   eval      x1part = z0part
085700010312     ?* rutina de generacion de fechas...
085800991217     C                   exsr      srfech
085900010312     ?* periodo en curso...
086000991217     C                   eval      x1pecu = 1
086100010312     ?* plan comercial...
086200991217     C                   exsr      srplac
086300010312     ?* descripciones...
086400991217     C                   exsr      desc01
086500991217     ?*-
086600991217     C                   endsr
086700991217     ?*****************************************************
086800991217      /SPACE
086900991217     ?*****************************************************
087000991217     C     srplac        begsr
087100991217     ?** BUSCAR PLAN COMERCIAL ----------------------------
087200010312     ?* buscar plan por compaÒÌa...
087300991230?1b? C                   if        x1ncoc <> *zeros                             ?P----------01
087400991230     C     k1t606        chain     s1t606                             20        ?            |
087500991230     C  n20              eval      x1plac = t@plac                              ?            |
087600991230     C  n20              eval      @@plac = t@plac                              ?            |
087700991230?1x? C                   else                                                   ?X..........01
087800991230     C                   eval      x1plac = *zeros                              ?            |
087900991230     C                   eval      @@plac = *zeros                              ?            |
088000991230?1e? C                   endif                                                  ?F----------01
088100010312     ?* si no encontro por compaÒÌa buscar por
088200010312     ?* intermediario y subaratÌculo...
088300991230?1b? C                   if        x1plac = *zeros                              ?P----------01
088400000531     C     k1@ec4        chain     p1hec4                             20        ?            |
088500991230     C                   eval      @@cfpg = c1cfpg                              ?            |
088600000531     C                   eval      @@sarc = c4sarc                              ?            |
088700991230     C     k1t609        chain     s1t609                             20        ?            |
088800991230     C  n20              eval      x1plac = t@plac                              ?            |
088900991230     C  n20              eval      @@plac = t@plac                              ?            |
089000010312     ?* si no encontrÛ buscar si est‡ dentro de alg˙n                |          ?            |
089100010312     ?* agrupamiento pero siempre con subartÌculo...                 |          ?            |
089200991230?2b? C                   if        x1plac = *zeros                              ?P---------02|
089300991230     C                   setoff                                           99    ?           ||
089400991230     C     k2t609        setll     s1t6091                                      ?           ||
089500991230?3b? C                   dou       *in99                                        ?P--------03||
089600991230     C     k2t609        reade     s1t6091                                99    ?          |||
089700991230?4b? C                   if        not *in99  and                               ?P-------04|||
089800991230     C                             t@cfpg = c1cfpg                              ?         ||||
089900991230     C                   eval      @@cfpg = t@cfpa                              ?         ||||
090000991230?3v? C                   leave                                                  ?         ||||
090100991230?4e? C                   endif                                                  ?F-------04|||
090200991230?3e? C                   enddo                                                  ?F--------03||
090300010312     ?* entonces lo busco...                                        ||          ?           ||
090400991230     C     k1t609        chain     s1t609                             20        ?           ||
090500991230     C  n20              eval      x1plac = t@plac                              ?           ||
090600991230     C  n20              eval      @@plac = t@plac                              ?           ||
090700991230?2e? C                   endif                                                  ?F---------02|
090800991230?1e? C                   endif                                                  ?F----------01
090900010312     ?* si no encontro por antes, ahora lo busco por
091000010312     ?* intermediario y sin subartÌculo...
091100000531?1b? C                   if        x1plac = *zeros                              ?P----------01
091200000531     C                   eval      @@cfpg = c1cfpg                              ?            |
091300000531     C                   eval      @@sarc = *zeros                              ?            |
091400000531     C     k1t609        chain     s1t609                             20        ?            |
091500000531     C  n20              eval      x1plac = t@plac                              ?            |
091600000531     C  n20              eval      @@plac = t@plac                              ?            |
091700010312     ?* si no encontrÛ buscar si est‡ dentro de alg˙n                |          ?            |
091800010312     ?* agrupamiento pero tambiÈn sin subartÌculo...                 |          ?            |
091900000531?2b? C                   if        x1plac = *zeros                              ?P---------02|
092000000531     C                   setoff                                           99    ?           ||
092100000531     C     k2t609        setll     s1t6091                                      ?           ||
092200000531?3b? C                   dou       *in99                                        ?P--------03||
092300000531     C     k2t609        reade     s1t6091                                99    ?          |||
092400000531?4b? C                   if        not *in99  and                               ?P-------04|||
092500000531     C                             t@cfpg = c1cfpg                              ?         ||||
092600000531     C                   eval      @@cfpg = t@cfpa                              ?         ||||
092700000531?3v? C                   leave                                                  ?         ||||
092800000531?4e? C                   endif                                                  ?F-------04|||
092900000531?3e? C                   enddo                                                  ?F--------03||
093000010312     ?* entonces lo busco...                                        ||          ?           ||
093100000531     C     k1t609        chain     s1t609                             20        ?           ||
093200000531     C  n20              eval      x1plac = t@plac                              ?           ||
093300000531     C  n20              eval      @@plac = t@plac                              ?           ||
093400000531?2e? C                   endif                                                  ?F---------02|
093500000531?1e? C                   endif                                                  ?F----------01
093600010312     ?* si no encontro poner el de la set621...
093700991217?1b? C                   if        x1plac = *zeros                              ?P----------01
093800991217     C                   eval      x1plac = @1plac                              ?            |
093900991217     C                   eval      @@plac = @1plac                              ?            |
094000991217?1e? C                   endif                                                  ?F----------01
094100991217     ?*-
094200991217     C                   endsr
094300991217     ?*****************************************************
094400991217      /SPACE
094500991217     ?*****************************************************
094600991217     C     defe02        begsr
094700991217     ?** BUSCAR DATOS POR DEFECTO EN RENOVACION------------
094800010312     ?* en emisiÛn orientado a artÌculos se renueva por
094900010312     ?* el estado actual del artÌculo, luego es lo mismo
095000010312     ?* que pÛliza nueva...
095100991217     C                   exsr      defe01
095200991217     ?*-
095300991217     C                   endsr
095400991217     ?*****************************************************
095500991217      /SPACE
095600991217     ?*****************************************************
095700991217     C     defe03        begsr
095800991217     ?** BUSCAR DATOS POR DEFECTO EN ENDOSOS---------------
095900010312     ?* datos constantes de salida...
096000991217     C                   eval      x1arcd = z0arcd
096100991217     C                   eval      x1spol = z0spol
096200991217     C                   eval      x1sspo = z0sspo
096300991217     C                   eval      x1rama = z0rama
096400991217     C                   eval      x1arse = z0arse
096500991217     C                   eval      x1oper = z0oper
096600991217     C                   eval      x1suop = z0suop
096700991217     C                   eval      x1ncoc = z0ncoc
096800991217     C                   eval      x1part = z0part
096900010312     ?* su buscan los datos en endosos anteriores de la
097000010312     ?* misma rama/secuencia...
097100991217     C                   setoff                                           99
097200991217     C     k3@ed0        setgt     p1hed003
097300991217?1b? C                   dow       1 = 1                                        ?P----------01
097400991217     C     k3@ed0        readpe    p1hed003                               99    ?            |
097500991217?2b? C                   if        not *in99                                    ?P---------02|
097600021031     C     keyec1        chain     pahec1                             27        ?           ||
097700991217?3b? C                   if        d0tiou = 1  or                               ?P--------03||
097800991217     C                             d0tiou = 2  or                               ?          |||
097900991217     C                             d0tiou = 5  or                               ?          |||
098000991217     C                             d0tiou = 3  and                              ?          |||
098100991217     C                             d0stos <> 09  and                            ?          |||
098200991217     C                             d0stos <> 08  and                            ?          |||
098300021031     C                             c1fboa = 0                                   ?          |||
098400991217?1v? C                   leave                                                  ?          |||
098500991217?3e? C                   endif                                                  ?F--------03||
098600991217?2e? C                   endif                                                  ?F---------02|
098700991217?1e? C                   enddo                                                  ?F----------01
098800021031     C     k1yec1        chain     pahec1                             27
098900010312     ?* poliza global buscar en pahed9...
099000991217     C   18k2@ed9        chain(n)  p1hed9                             20
099100991217     C   18
099200991217     Cann20              eval      x1poli = g9poli
099300010312     ?* inicio de vigencia/fecha hasta facturada...
099400991217?1b? C                   select                                                 ?P----------01
099500010312     ?* en refacturacion la vigencia desde la fija el pro-           |          ?            |
099600010312     ?* grama par310c y no se puede cambiar...                       |          ?            |
099700991217?1x? C                   when      z0tiou = 3  and                              ?w----------01
099800991217     C                             z0stos = 01                                  ?            |
099900991217     C                   eval      p@fa—o = c1fioa                              ?            |
100000991217     C                   eval      p@fmes = c1fiom                              ?            |
100100991217     C                   eval      p@fdia = c1fiod                              ?            |
100200991217     C                   eval      x1desd = p@fdma                              ?            |
100300010312     ?* la fecha de vencimiento es siempre la misma...               |          ?            |
100400991217     C                   eval      x1dup1 = d0dup1                              ?            |
100500991217     C                   eval      x1mar5 = d0mar5                              ?            |
100600991217     C                   eval      p@fa—o = d0fvoa                              ?            |
100700991217     C                   eval      p@fmes = d0fvom                              ?            |
100800991217     C                   eval      p@fdia = d0fvod                              ?            |
100900991217     C                   eval      x1hast = p@fdma                              ?            |
101000010312     ?* se calcula la nueva fecha hasta facturada...                 |          ?            |
101100041123     ?* Esto es lo mismo de antes, si la marca de SET621 lo indica entonces     ?            |
101200041123     ?* debor forzar 99 en el DUP2 y protejo el campo...                        ?            |
101300041123?2b? C                   if        t$mar2 = '1'                                 ?P---------02|
101400041123     C                   eval      x1dup2 = 99                                  ?           ||
101500041123     C                   eval      *in91 = *on                                  ?           ||
101600041123?2x? C                   else                                                   ?X.........02|
101700041123     C                   eval      *in91 = *off                                 ?           ||
101800041123     C                   eval      x1dup2 = d0dup2                              ?           ||
101900041123?2e? C                   endif                                                  ?F---------02|
102000991217     C                   eval      x1hafa = x1desd                              ?            |
102100010312?2b? C                   select                                                 ?P---------02|
102200010312?2x? C                   when      x1dup2 <> 99                                 ?w---------02|
102300010312     C                   call      'SP0001'                                     ?           ||
102400010312     C                   parm                    x1hafa                         ?           ||
102500010312     C                   parm                    x1dup2                         ?           ||
102600010312?2x? C                   when      x1dup2 = 99                                  ?w---------02|
102700010312     C                   eval      x1hafa = x1hast                              ?           ||
102800010312?2e? C                   endsl                                                  ?F---------02|
102900991217     C                   exsr      ajhafa                                       ?            |
103000010312     ?* las operaciones en las que la vigencia pasa por              |          ?            |
103100010312     ?* los dÌas 30/31 o 28 de febrero pueden ir perdiendo           |          ?            |
103200010312     ?* dÌas de vigencia...                                          |          ?            |
103300991217     C                   eval      p@2dma = x1hast                              ?            |
103400991217     C                   eval      p@fdma = x1hafa                              ?            |
103500991217?2b? C                   if        p@2a—o = p@fa—o  and                         ?P---------02|
103600991217     C                             p@2mes = p@fmes                              ?           ||
103700991217     C                   eval      @@dias = p@2dia - p@fdia                     ?           ||
103800991217?3b? C                   if        @@dias <= 3                                  ?P--------03||
103900991217     C                   eval      p@fdia = p@2dia                              ?          |||
104000991217     C                   eval      x1hafa = p@fdma                              ?          |||
104100991217?3e? C                   endif                                                  ?F--------03||
104200991217?2e? C                   endif                                                  ?F---------02|
104300010312     ?* la anualidad...                                              |          ?            |
104400991217     C                   eval      p@fa—o = d0fvaa                              ?            |
104500991217     C                   eval      p@fmes = d0fvam                              ?            |
104600991217     C                   eval      p@fdia = d0fvad                              ?            |
104700991217     C                   eval      x1anua = p@fdma                              ?            |
104800010312     ?* si el hasta facturado supera a la anualidad calcu-           |          ?            |
104900010312     ?* las nueva anualidad...                                       |          ?            |
105000991217     C                   eval      p@fdma = x1hafa                              ?            |
105100991217     C                   eval      p@1a—o = p@fa—o                              ?            |
105200991217     C                   eval      p@1mes = p@fmes                              ?            |
105300991217     C                   eval      p@1dia = p@fdia                              ?            |
105400991217     C                   eval      @@fec1 = p@famd                              ?            |
105500991217     C                   eval      p@fdma = x1anua                              ?            |
105600991217     C                   eval      p@1a—o = p@fa—o                              ?            |
105700991217     C                   eval      p@1mes = p@fmes                              ?            |
105800991217     C                   eval      p@1dia = p@fdia                              ?            |
105900991217     C                   eval      @@fec2 = p@famd                              ?            |
106000991217?2b? C                   if        @@fec1 > @@fec2                              ?P---------02|
106100991217     C                   eval      x1anua = x1desd                              ?           ||
106200991217     C                   call      'SP0001'                                     ?           ||
106300991217     C                   parm                    x1anua                         ?           ||
106400991217     C                   parm      12            @@dupe                         ?           ||
106500991217     C                   exsr      ajanua                                       ?           ||
106600991217?2e? C                   endif                                                  ?F---------02|
106700010312     ?* por ultimo se avanza el periodo en curso...                  |          ?            |
106800991217     C     d0pecu        add       1             x1pecu                         ?            |
106900010312     ?* y no est· de m·s poner tambiÈn el plan comercial...          |          ?            |
107000991217     C                   eval      x1plac = d0plac                              ?            |
107100991217     C                   eval      @@plac = d0plac                              ?            |
107200010312     ?* ajustar vigencias si corresponde...                          |          ?            |
107300991217     C                   exsr      ajvige                                       ?            |
107400991217?1x? C                   other                                                  ?w----------01
107500010312     ?* en otros el inicio de vigencia se propone tambiÈn            |          ?            |
107600010312     ?* el que fijÛ el par310c, pero si se puede cambiar...          |          ?            |
107700991217     C                   eval      p@fa—o = c1fioa                              ?            |
107800991217     C                   eval      p@fmes = c1fiom                              ?            |
107900991217     C                   eval      p@fdia = c1fiod                              ?            |
108000991217     C                   eval      x1desd = p@fdma                              ?            |
108100010312     ?* la fecha de vencimiento es siempre la misma...               |          ?            |
108200991217     C                   eval      x1dup1 = d0dup1                              ?            |
108300991217     C                   eval      x1mar5 = d0mar5                              ?            |
108400991217     C                   eval      p@fa—o = d0fvoa                              ?            |
108500991217     C                   eval      p@fmes = d0fvom                              ?            |
108600991217     C                   eval      p@fdia = d0fvod                              ?            |
108700991217     C                   eval      x1hast = p@fdma                              ?            |
108800010312     ?* el hasta facturado no cambia...                              |          ?            |
108900991217     C                   eval      x1dup2 = d0dup2                              ?            |
109000991217     C                   eval      p@fa—o = d0fhfa                              ?            |
109100991217     C                   eval      p@fmes = d0fhfm                              ?            |
109200991217     C                   eval      p@fdia = d0fhfd                              ?            |
109300991217     C                   eval      x1hafa = p@fdma                              ?            |
109400010312     ?* la anualidad no cambia....                                   |          ?            |
109500991217     C                   eval      p@fa—o = d0fvaa                              ?            |
109600991217     C                   eval      p@fmes = d0fvam                              ?            |
109700991217     C                   eval      p@fdia = d0fvad                              ?            |
109800991217     C                   eval      x1anua = p@fdma                              ?            |
109900010312     ?* y el periodo en curso tampoco...                             |          ?            |
110000991217     C                   eval      x1pecu = d0pecu                              ?            |
110100010312     ?* y no est· de m·s poner tambiÈn el plan comercial...          |          ?            |
110200991217     C                   eval      x1plac = d0plac                              ?            |
110300991217     C                   eval      @@plac = d0plac                              ?            |
110400991217?1e? C                   endsl                                                  ?F----------01
110500010312     ?* descripciones...
110600991217     C                   exsr      desc01
110700991217     ?*-
110800991217     C                   endsr
110900991217     ?*****************************************************
111000991217      /SPACE
111100991217     ?*****************************************************
111200991217     C     defe38        begsr
111300991217     ?** BUSCAR DATOS POR DEFECTO EN ENDOSOS---------------
111400010312     ?* datos constantes de salida...
111500991217     C                   eval      x1arcd = z0arcd
111600991217     C                   eval      x1spol = z0spol
111700991217     C                   eval      x1sspo = z0sspo
111800991217     C                   eval      x1rama = z0rama
111900991217     C                   eval      x1arse = z0arse
112000991217     C                   eval      x1oper = z0oper
112100991217     C                   eval      x1suop = z0suop
112200991217     C                   eval      x1ncoc = z0ncoc
112300991217     C                   eval      x1part = z0part
112400010312     ?* se buscan los datos en el suplemento afectado...
112500991217     C     k2@ed0        chain(n)  p1hed0                             20
112600010312     ?* poliza global buscar en pahed9...
112700991217     C   18k2@ed9        chain(n)  p1hed9                             20
112800991217     C   18
112900991217     Cann20              eval      x1poli = g9poli
113000010312     ?* inicio de vigencia/fecha hasta facturada...
113100991217     C                   eval      p@fa—o = d0fioa
113200991217     C                   eval      p@fmes = d0fiom
113300991217     C                   eval      p@fdia = d0fiod
113400991217     C                   eval      x1desd = p@fdma
113500010312     ?* la fecha de vencimiento es siempre la misma...
113600991217     C                   eval      x1dup1 = d0dup1
113700991217     C                   eval      x1mar5 = d0mar5
113800991217     C                   eval      p@fa—o = d0fvoa
113900991217     C                   eval      p@fmes = d0fvom
114000991217     C                   eval      p@fdia = d0fvod
114100991217     C                   eval      x1hast = p@fdma
114200010312     ?* el hasta facturado no cambia...
114300991217     C                   eval      x1dup2 = d0dup2
114400991217     C                   eval      p@fa—o = d0fhfa
114500991217     C                   eval      p@fmes = d0fhfm
114600991217     C                   eval      p@fdia = d0fhfd
114700991217     C                   eval      x1hafa = p@fdma
114800010312     ?* la anualidad no cambia....
114900991217     C                   eval      p@fa—o = d0fvaa
115000991217     C                   eval      p@fmes = d0fvam
115100991217     C                   eval      p@fdia = d0fvad
115200991217     C                   eval      x1anua = p@fdma
115300010312     ?* y el periodo en curso tampoco...
115400991217     C                   eval      x1pecu = d0pecu
115500010312     ?* y no est” de mﬂs poner tambi⁄n el plan comercial...
115600991217     C                   eval      x1plac = d0plac
115700991217     C                   eval      @@plac = d0plac
115800010312     ?* descripciones...
115900991217     C                   exsr      desc01
116000991217     ?*-
116100991217     C                   endsr
116200991217     ?*****************************************************
116300010312     C/SPACE
116400991217     ?*****************************************************
116500991217     C     defe05        begsr
116600991217     ?** CARGAR DATOS POR DEFECTO EN REHABILITACION--------
116700010312     ?* datos constantes de salida...
116800991217     C                   eval      x1arcd = z0arcd
116900991217     C                   eval      x1spol = z0spol
117000991217     C                   eval      x1sspo = z0sspo
117100991217     C                   eval      x1rama = z0rama
117200991217     C                   eval      x1arse = z0arse
117300991217     C                   eval      x1oper = z0oper
117400991217     C                   eval      x1suop = z0suop
117500991217     C                   eval      x1ncoc = z0ncoc
117600991217     C                   eval      x1part = z0part
117700010312     ?* su buscan los datos en endosos anteriores de la
117800010312     ?* misma rama/secuencia...
117900991217     C                   setoff                                           99
118000991217     C     k3@ed0        setgt     p1hed003
118100991217?1b? C                   dow       1 = 1                                        ?P----------01
118200991217     C     k3@ed0        readpe    p1hed003                               99    ?            |
118300991217?2b? C                   if        not *in99                                    ?P---------02|
118400991217?3b? C                   if        d0tiou = 1  or                               ?P--------03||
118500991217     C                             d0tiou = 2  or                               ?          |||
118600991217     C                             d0tiou = 5  or                               ?          |||
118700991217     C                             d0tiou = 3  and                              ?          |||
118800991217     C                             d0stos <> 09  and                            ?          |||
118900991217     C                             d0stos <> 08                                 ?          |||
119000991217?1v? C                   leave                                                  ?          |||
119100991217?3e? C                   endif                                                  ?F--------03||
119200991217?2e? C                   endif                                                  ?F---------02|
119300991217?1e? C                   enddo                                                  ?F----------01
119400010312     ?* poliza global buscar en pahed9...
119500991217     C   18k2@ed9        chain(n)  p1hed9                             20
119600991217     C   18
119700991217     Cann20              eval      x1poli = g9poli
119800010312     ?* el inicio de vigencia es el inicio de vigencia ac-
119900010312     ?* tual del pahec1 que puede haber cambiado porque
120000010312     ?* en rehabilitacion se pueden "saltar" per›odos...
120100991217     C                   eval      p@fa—o = c1fioa
120200991217     C                   eval      p@fmes = c1fiom
120300991217     C                   eval      p@fdia = c1fiod
120400991217     C                   eval      x1desd = p@fdma
120500010312     ?* la fecha de vencimiento es siempre la misma...
120600991217     C                   eval      x1dup1 = d0dup1
120700991217     C                   eval      x1mar5 = d0mar5
120800991217     C                   eval      p@fa—o = d0fvoa
120900991217     C                   eval      p@fmes = d0fvom
121000991217     C                   eval      p@fdia = d0fvod
121100991217     C                   eval      x1hast = p@fdma
121200010312     ?* FECHA HASTA FACTURADA...
121300010312     ?* si inicio de vigencia es mayor a la fecha hasta
121400010312     ?* facturada es que se estﬂn salteando periodos
121500010312     ?* por lo tanto fuerzo inicio de vigencia a la fecha
121600010312     ?* hasta facturada...
121700991217     C                   eval      p@1a—o = c1fioa
121800991217     C                   eval      p@1mes = c1fiom
121900991217     C                   eval      p@1dia = c1fiod
122000991217     C                   eval      @@fec1 = p@famd
122100991217     C                   eval      p@1a—o = d0fhfa
122200991217     C                   eval      p@1mes = d0fhfm
122300991217     C                   eval      p@1dia = d0fhfd
122400991217     C                   eval      @@fec2 = p@famd
122500991217?1b? C                   if        @@fec1 > @@fec2                              ?P----------01
122600991217     C                   eval      p@fa—o = c1fioa                              ?            |
122700991217     C                   eval      p@fmes = c1fiom                              ?            |
122800991217     C                   eval      p@fdia = c1fiod                              ?            |
122900991217     C                   eval      x1hafa = p@fdma                              ?            |
123000991217?1x? C                   else                                                   ?X..........01
123100010312     ?* cuando la fecha hasta facturada es menor o igual             |          ?            |
123200010312     ?* se deja la fecha hasta facturada del ultimo endoso           |          ?            |
123300991217     C                   eval      p@fa—o = d0fhfa                              ?            |
123400991217     C                   eval      p@fmes = d0fhfm                              ?            |
123500991217     C                   eval      p@fdia = d0fhfd                              ?            |
123600991217     C                   eval      x1hafa = p@fdma                              ?            |
123700991217?1e? C                   endif                                                  ?F----------01
123800010312     ?* la anualidad...
123900991217     C                   eval      p@fa—o = d0fvaa
124000991217     C                   eval      p@fmes = d0fvam
124100991217     C                   eval      p@fdia = d0fvad
124200991217     C                   eval      x1anua = p@fdma
124300010312     ?* si el hasta facturado supera a la anualidad calcu-
124400010312     ?* las nueva anualidad...
124500991217     C                   eval      p@fdma = x1hafa
124600991217     C                   eval      p@1a—o = p@fa—o
124700991217     C                   eval      p@1mes = p@fmes
124800991217     C                   eval      p@1dia = p@fdia
124900991217     C                   eval      @@fec1 = p@famd
125000991217     C                   eval      p@fdma = x1anua
125100991217     C                   eval      p@1a—o = p@fa—o
125200991217     C                   eval      p@1mes = p@fmes
125300991217     C                   eval      p@1dia = p@fdia
125400991217     C                   eval      @@fec2 = p@famd
125500991217?1b? C                   if        @@fec1 > @@fec2                              ?P----------01
125600991217     C                   eval      x1anua = x1desd                              ?            |
125700991217     C                   call      'SP0001'                                     ?            |
125800991217     C                   parm                    x1anua                         ?            |
125900991217     C                   parm      12            @@dupe                         ?            |
126000991217     C                   exsr      ajanua                                       ?            |
126100991217?1e? C                   endif                                                  ?F----------01
126200010312     ?* el periodo en curso no cambia...
126300010312     ?* y la duracion del per›odo tampoco...
126400991217     C                   eval      x1pecu = d0pecu
126500991217     C                   eval      x1dup2 = d0dup2
126600010312     ?* hasta facturado en vida obligatorio...
126700010312     ?* ajusto las vigencias al 1 de octubre seg˙n el
126800010312     ?* contenido del @@MA38...
126900001128?1b? C                   if        t@rame = 21  and                             ?P----------01
127000001129     C                             @@ma38 = '1'                                 ?            |
127100001128     C                   exsr      obliga                                       ?            |
127200001128?1e? C                   endif                                                  ?F----------01
127300010312     ?* y no est” de mﬂs poner tambi⁄n el plan comercial..
127400991217     C                   eval      x1plac = d0plac
127500991217     C                   eval      @@plac = d0plac
127600010312     ?* descripciones...
127700991217     C                   exsr      desc01
127800991217     ?*-
127900991217     C                   endsr
128000991217     ?*****************************************************
128100010312     C/SPACE
128200991217     ?*****************************************************
128300991217     C     obliga        begsr
128400991217     ?** HASTA FACTURADO Y ANUALIDAD EN VIDA OBLIGATORIO---
128500010312     ?* se determina el hasta facturado segun la duraci_n
128600010312     ?* del periodo...
128700991217     C                   eval      p@fdma = x1hafa
128800991217     C                   eval      p@fdia = 1
128900991217?1b? C                   select                                                 ?P----------01
129000010312     ?* facturacion mensual...                                       |          ?            |
129100991217?1x? C                   when      x1dup2 = 1                                   ?w----------01
129200010312     ?* facturacion bimestral...                                     |          ?            |
129300991217?1x? C                   when      x1dup2 = 2                                   ?w----------01
129400991217?2b? C                   select                                                 ?P---------02|
129500991217?2x? C                   when      p@fmes = 01                                  ?w---------02|
129600991217     C                   eval      p@fmes = 12                                  ?           ||
129700991217     C                   eval      p@fa—o = p@fa—o - 1                          ?           ||
129800991217?2x? C                   when      p@fmes = 11                                  ?w---------02|
129900991217     C                   eval      p@fmes = 10                                  ?           ||
130000991217?2x? C                   when      p@fmes = 09                                  ?w---------02|
130100991217     C                   eval      p@fmes = 08                                  ?           ||
130200991217?2x? C                   when      p@fmes = 07                                  ?w---------02|
130300991217     C                   eval      p@fmes = 06                                  ?           ||
130400991217?2x? C                   when      p@fmes = 05                                  ?w---------02|
130500991217     C                   eval      p@fmes = 04                                  ?           ||
130600991217?2x? C                   when      p@fmes = 03                                  ?w---------02|
130700991217     C                   eval      p@fmes = 02                                  ?           ||
130800991217?2e? C                   endsl                                                  ?F---------02|
130900010312     ?* facturacion trimestral...                                    |          ?            |
131000991217?1x? C                   when      x1dup2 = 3                                   ?w----------01
131100991217?2b? C                   select                                                 ?P---------02|
131200991217?2x? C                   when      p@fmes = 12  or                              ?w---------02|
131300991217     C                             p@fmes = 11                                  ?           ||
131400991217     C                   eval      p@fmes = 10                                  ?           ||
131500991217?2x? C                   when      p@fmes = 09  or                              ?w---------02|
131600991217     C                             p@fmes = 08                                  ?           ||
131700991217     C                   eval      p@fmes = 07                                  ?           ||
131800991217?2x? C                   when      p@fmes = 06  or                              ?w---------02|
131900991217     C                             p@fmes = 05                                  ?           ||
132000991217     C                   eval      p@fmes = 04                                  ?           ||
132100991217?2x? C                   when      p@fmes = 03  or                              ?w---------02|
132200991217     C                             p@fmes = 02                                  ?           ||
132300991217     C                   eval      p@fmes = 01                                  ?           ||
132400991217?2e? C                   endsl                                                  ?F---------02|
132500010312     ?* facturacion cuatrimestral...                                 |          ?            |
132600991217?1x? C                   when      x1dup2 = 4                                   ?w----------01
132700991217?2b? C                   select                                                 ?P---------02|
132800991217?2x? C                   when      p@fmes = 01                                  ?w---------02|
132900991217     C                   eval      p@fmes = 10                                  ?           ||
133000991217     C                   eval      p@fa—o = p@fa—o - 1                          ?           ||
133100991217?2x? C                   when      p@fmes = 12  or                              ?w---------02|
133200991217     C                             p@fmes = 11                                  ?           ||
133300991217     C                   eval      p@fmes = 10                                  ?           ||
133400991217?2x? C                   when      p@fmes = 09  or                              ?w---------02|
133500991217     C                             p@fmes = 08  or                              ?           ||
133600991217     C                             p@fmes = 07                                  ?           ||
133700991217     C                   eval      p@fmes = 06                                  ?           ||
133800991217?2x? C                   when      p@fmes = 05  or                              ?w---------02|
133900991217     C                             p@fmes = 04  or                              ?           ||
134000991217     C                             p@fmes = 03                                  ?           ||
134100991217     C                   eval      p@fmes = 02                                  ?           ||
134200991217?2e? C                   endsl                                                  ?F---------02|
134300010312     ?* facturacion semestral...                                     |          ?            |
134400991217?1x? C                   when      x1dup2 = 6                                   ?w----------01
134500991217?2b? C                   select                                                 ?P---------02|
134600991217?2x? C                   when      p@fmes = 03  or                              ?w---------02|
134700991217     C                             p@fmes = 02  or                              ?           ||
134800991217     C                             p@fmes = 01                                  ?           ||
134900991217     C                   eval      p@fmes = 10                                  ?           ||
135000991217     C                   eval      p@fa—o = p@fa—o - 1                          ?           ||
135100991217?2x? C                   when      p@fmes = 12  or                              ?w---------02|
135200991217     C                             p@fmes = 11                                  ?           ||
135300991217     C                   eval      p@fmes = 10                                  ?           ||
135400991217?2x? C                   when      p@fmes = 09  or                              ?w---------02|
135500991217     C                             p@fmes = 08  or                              ?           ||
135600991217     C                             p@fmes = 07  or                              ?           ||
135700991217     C                             p@fmes = 06  or                              ?           ||
135800991217     C                             p@fmes = 05                                  ?           ||
135900991217     C                   eval      p@fmes = 04                                  ?           ||
136000991217?2e? C                   endsl                                                  ?F---------02|
136100010312     ?* facturacion anual...                                         |          ?            |
136200991217?1x? C                   when      x1dup2 = 12                                  ?w----------01
136300991217?2b? C                   select                                                 ?P---------02|
136400991217?2x? C                   when      p@fmes = 09  or                              ?w---------02|
136500991217     C                             p@fmes = 08  or                              ?           ||
136600991217     C                             p@fmes = 07  or                              ?           ||
136700991217     C                             p@fmes = 06  or                              ?           ||
136800991217     C                             p@fmes = 05  or                              ?           ||
136900991217     C                             p@fmes = 04  or                              ?           ||
137000991217     C                             p@fmes = 03  or                              ?           ||
137100991217     C                             p@fmes = 02  or                              ?           ||
137200991217     C                             p@fmes = 01                                  ?           ||
137300991217     C                   eval      p@fmes = 10                                  ?           ||
137400991217     C                   eval      p@fa—o = p@fa—o - 1                          ?           ||
137500991217?2x? C                   when      p@fmes = 12  or                              ?w---------02|
137600991217     C                             p@fmes = 11                                  ?           ||
137700991217     C                   eval      p@fmes = 10                                  ?           ||
137800991217?2e? C                   endsl                                                  ?F---------02|
137900991217?1e? C                   endsl                                                  ?F----------01
138000991217     C                   eval      x1hafa = p@fdma
138100010312     ?* si dice que se ajusta vigencia seg∑n d›a 15 en la
138200010312     ?* tabla SET630 hay que reveer la fecha hasta factura-
138300010312     ?* da...
138400991217?1b? C                   if        @@ma07 = '1'                                 ?P----------01
138500991217     C                   eval      p@fdma = x1hafa                              ?            |
138600991217     C                   eval      $dia1 = p@fdia                               ?            |
138700991217     C                   eval      $mes1 = p@fmes                               ?            |
138800991217     C                   eval      $a—o1 = p@fa—o                               ?            |
138900991217     C                   eval      p@fdma = x1desd                              ?            |
139000991217     C                   eval      $dia2 = p@fdia                               ?            |
139100991217     C                   eval      $mes2 = p@fmes                               ?            |
139200991217     C                   eval      $a—o2 = p@fa—o                               ?            |
139300991217     C                   call      'SPDFEC'                                     ?            |
139400991217     C                   parm                    $dia1                          ?            |
139500991217     C                   parm                    $mes1                          ?            |
139600991217     C                   parm                    $a—o1                          ?            |
139700991217     C                   parm                    $dia2                          ?            |
139800991217     C                   parm                    $mes2                          ?            |
139900991217     C                   parm                    $a—o2                          ?            |
140000991217     C                   parm      *zeros        p@dife            5 0          ?            |
140100991217?2b? C                   if        p@dife < 28                                  ?P---------02|
140200991217     C                   eval      p@fdma = x1desd                              ?           ||
140300991217?3b? C                   if        p@fdia > 15                                  ?P--------03||
140400010312     ?* adicionar un per›odo mﬂs a la fecha hasta facturada        |||          ?          |||
140500991217     C                   call      'SP0001'                                     ?          |||
140600991217     C                   parm                    x1hafa                         ?          |||
140700991217     C                   parm                    x1dup2                         ?          |||
140800991217     C                   exsr      ajhafa                                       ?          |||
140900991217?3e? C                   endif                                                  ?F--------03||
141000991217?2e? C                   endif                                                  ?F---------02|
141100991217     C                   eval      p@fdma = x1hafa                              ?            |
141200991217?1e? C                   endif                                                  ?F----------01
141300010312     ?* ahora ver la anualidad...
141400010312     ?* esto es muy obvio, la anualidad debe ser el primer
141500010312     ?* 1 de octubre mayor o igual a la fecha hasta fact.
141600991217     C                   eval      p@fdia = 1
141700991217?1b? C                   select                                                 ?P----------01
141800991217?1x? C                   when      p@fmes = 10                                  ?w----------01
141900991217?1x? C                   when      p@fmes = 11  or                              ?w----------01
142000991217     C                             p@fmes = 12                                  ?            |
142100991217     C                   eval      p@fmes = 10                                  ?            |
142200991217     C                   add       1             p@fa—o                         ?            |
142300991217?1x? C                   other                                                  ?w----------01
142400991217     C                   eval      p@fmes = 10                                  ?            |
142500991217?1e? C                   endsl                                                  ?F----------01
142600991217     C                   eval      x1anua = p@fdma
142700991217     ?*-
142800991217     C                   endsr
142900991217     ?*****************************************************
143000010312     C/SPACE
143100991217     ?*****************************************************
143200991217     C     prot01        begsr
143300991217     ?** PROTEJER CAMPOS EN PANTALLA 01--------------------
143400010312     ?* identificar coaseguro...
143500991217?1b? C                   if        c1wcoa <> *zeros                             ?P----------01
143600991217     C                   seton                                            15    ?            |
143700991217?1e? C                   endif                                                  ?F----------01
143800010312     ?* protejer vigencia desde...
143900991217?1b? C                   if        z0tiou = 1  or                               ?P----------01
144000991217     C                             z0tiou = 2  or                               ?            |
144100991217     C                             z0tiou = 3  and                              ?            |
144200991217     C                             z0stos = 01  or                              ?            |
144300991217     C                             z0tiou = 5                                   ?            |
144400991217     C                   seton                                            10    ?            |
144500991217?1e? C                   endif                                                  ?F----------01
144600010312     ?* fecha de vencimiento...
144700991217?1b? C                   if        z0tiou = 3                                   ?P----------01
144800991217     C                   seton                                            11    ?            |
144900991217?1e? C                   endif                                                  ?F----------01
145000010312     ?* protecciæn general en endosos...
145100991217?1b? C                   if        z0tiou = 3                                   ?P----------01
145200991217     C                   seton                                            03    ?            |
145300991217?1e? C                   endif                                                  ?F----------01
145400010312     ?* protecciæn general en endosos de ajuste de per›odos
145500010312     ?* anteriores (se complementa con el *in03)...
145600991217?1b? C                   if        z0tiou = 3  and                              ?P----------01
145700991217     C                             z0stos = 08                                  ?            |
145800991217     C                   seton                                            12    ?            |
145900991217?1e? C                   endif                                                  ?F----------01
146000010312     ?* protecciæn general art˝culos no "free"...
146100991217?1b? C                   if        t@free = '0'                                 ?P----------01
146200991217     C                   seton                                            19    ?            |
146300991217?1e? C                   endif                                                  ?F----------01
146400010312     ?* protecciæn duraciæn del periodo...
146500010312     ?* se desactiva la protecciæn de la duraciæn del
146600010312     ?* periodo de modo que por mas que sean articulos no
146700010312     ?* free igualmente se puede ingresar la duracion...
146800010312     ?*          T@DUPE    IFNE *ZEROS
146900010312     ?*                    SETON                         16
147000010312     ?*                    END
147100010312     ?* identificar poliza nueva...
147200991217?1b? C                   if        z0tiou = 1  or                               ?P----------01
147300991217     C                             z0tiou = 2                                   ?            |
147400991217     C                   seton                                            17    ?            |
147500991217?1e? C                   endif                                                  ?F----------01
147600010312     ?* identificar refacturacion...
147700991217?1b? C                   if        z0tiou = 3  and                              ?P----------01
147800991217     C                             z0stos = 01                                  ?            |
147900991217     C                   seton                                            22    ?            |
148000991217?1e? C                   endif                                                  ?F----------01
148100010312     ?* habilitar el campo cædigo de agenda...
148200991217?1b? C                   if        @@ma17 = '1'                                 ?P----------01
148300991217     C                   seton                                            13    ?            |
148400991217?1e? C                   endif                                                  ?F----------01
148500010312     ?* Posicionar cursor en compaÒÌa si est· en blanco
148600010312     ?* si no se posiciona en fecha...
148700991217?1b? C                   if        x1ncoc = *zeros                              ?P----------01
148800991217     C                   setoff                                           14    ?            |
148900991217?1x? C                   else                                                   ?X..........01
149000991217     C                   seton                                            14    ?            |
149100991217?1e? C                   endif                                                  ?F----------01
149200991217     ?*-
149300991217     C                   endsr
149400991217     ?*****************************************************
149500010312     C/SPACE
149600991217     ?*****************************************************
149700991217     C     soli01        begsr
149800991217     ?** SOLICITUD EN PANTALLA 00--------------------------
149900991230?1b? C                   if        @@camp = 'X1NCOC'                            ?P----------01
150000991230     C                   call      'DBA1201'                                    ?            |
150100991230     C                   parm                    x1ncoc                         ?            |
150200991230     C                   parm                    x1noco                         ?            |
150300991230     C                   parm      *blanks       finpgm            3            ?            |
150400991230?1e? C                   endif                                                  ?F----------01
150500010312     ?*
150600991217?1b? C                   if        @@camp = 'X1POLI'                            ?P----------01
150700991217     C                   call      'DBA622'                                     ?            |
150800991217     C                   parm                    @@arcd                         ?            |
150900991217     C                   parm                    t@arno                         ?            |
151000991217     C                   parm                    @@rama                         ?            |
151100991217     C                   parm                    @@arse                         ?            |
151200991217     C                   parm                    x1poli                         ?            |
151300991217?1e? C                   endif                                                  ?F----------01
151400010312     ?*
151500991217?1b? C                   if        @@camp = 'X1AGEC'                            ?P----------01
151600991217     C                   call      'DBA676A2'                                   ?            |
151700991217     C                   parm                    x1agec                         ?            |
151800991217     C                   parm                    x1aged                         ?            |
151900991217?1e? C                   endif                                                  ?F----------01
152000000531     ?*
152100000531?1b? C                   if        @@camp = 'X1PLAC'                            ?P----------01
152200000531     C                   call      'DBA6101'                                    ?            |
152300000531     C                   parm                    x1plac                         ?            |
152400000531     C                   parm                    x1plan                         ?            |
152500000531     C                   parm      *blanks       endpgm                         ?            |
152600000531?1e? C                   endif                                                  ?F----------01
152700010312     ?*
152800000531?1b? C                   if        x1poli <> *zeros  or                         ?P----------01
152900000531     C                             x1agec <> *zeros  or                         ?            |
153000000531     C                             x1plac <> *zeros                             ?            |
153100000531     C                   exsr      desc01                                       ?            |
153200000531?1e? C                   endif                                                  ?F----------01
153300000531     ?*
153400991217     C                   endsr
153500991217     ?*****************************************************
153600010312     C/SPACE
153700991217     ?*****************************************************
153800991217     C     desc01        begsr
153900991217     ?** BUSCAR DESCRIPCIONES------------------------------
154000010312     ?* nombre cia.coaseguradora...
154100991217     C     k1t120        chain     s1t12003                           20
154200991217     C   20              eval      x1noco = *blanks
154300991217     C  n20              eval      x1noco = dfnomb
154400010312     ?* plan comercial...
154500991217     C     x1plac        chain     s1t610                             20
154600991217     C   20              eval      x1plan = *blanks
154700991217     C  n20              eval      x1plan = t@plan
154800010312     ?* codigo de agenda...
154900991217?1b? C                   if        x1agec <> *zeros                             ?P----------01
155000991217     C     k1t676        chain     s1t676                             20        ?            |
155100991217     C  n20              eval      x1aged = t@aged                              ?            |
155200991217     C   20              eval      x1aged = *blanks                             ?            |
155300991217?1e? C                   endif                                                  ?F----------01
155400010312     ?* descripciones propias de una poliza global...
155500991217?1b? C                   if        *in18                                        ?P----------01
155600991217     C     k1t622        chain     s1t62202                           20        ?            |
155700991217     C  n20k1tdaf        chain     g1hdaf                             20        ?            |
155800991217     C  n20              eval      x1nomb = dfnomb                              ?            |
155900991217     C  n20k1tloc        chain     g1tloc                             20        ?            |
156000991217     C  n20k1tpro        chain     g1tpro                             20        ?            |
156100991217     C  n20              movel     prrpro        x1rpro                         ?            |
156200991217     C  n20              eval      x1prod = prprod                              ?            |
156300991217     C   20              eval      x1nomb = *blanks                             ?            |
156400991217     C   20              eval      x1rpro = *zeros                              ?            |
156500991217     C   20              eval      x1prod = *blanks                             ?            |
156600991217?1x? C                   else                                                   ?X..........01
156700991217     C                   eval      x1poli = *zeros                              ?            |
156800991217     C                   eval      x1nomb = *blanks                             ?            |
156900991217     C                   eval      x1rpro = *zeros                              ?            |
157000991217     C                   eval      x1prod = *blanks                             ?            |
157100991217?1e? C                   endif                                                  ?F----------01
157200991217     ?*-
157300991217     C                   endsr
157400991217     ?*****************************************************
157500010312     C/SPACE
157600991217     ?*****************************************************
157700991217     C     vali01        begsr
157800991217     ?** GRABACION PANTALLA 00-----------------------------
157900010312     ?* validar compaÒÌa de seguros...
158000991217     C     k1t120        chain     s1t12003                           20
158100991217     C   20              z-add     84            @e                   50
158200991217     C   20              eval      x1noco = *blanks
158300991217     C  n20              eval      x1noco = dfnomb
158400010312     ?* validar fecha de inicio de vigencia...
158500991217?1b? C                   if        not *in50                                    ?P----------01
158600991217     C                   eval      p@flap = *zeros                              ?            |
158700991217     C                   eval      p@ffec = x1desd                              ?            |
158800991217     C                   call      'SPFECH'                                     ?            |
158900991217     C                   parm                    p@fech                         ?            |
159000991217?2b? C                   if        p@flap = *zeros                              ?P---------02|
159100991217     C                   z-add     51            @e                   50        ?           ||
159200991217?2x? C                   else                                                   ?X.........02|
159300991217     C                   eval      x1desd = p@ffec                              ?           ||
159400991217?2e? C                   endif                                                  ?F---------02|
159500991217?1e? C                   endif                                                  ?F----------01
159600010314     ?* fecha de inicio de vigencia contra fecha de emisiÛn
159700010314?1b? C                   if        not *in50  and                               ?P----------01
159800010314     C                             z0tiou <= 2                                  ?            |
159900010314     C                   eval      p@fdma = x1desd                              ?            |
160000010314     C                   eval      $a—o1 = p@fa—o                               ?            |
160100010314     C                   eval      $mes1 = p@fmes                               ?            |
160200010314     C                   eval      $dia1 = p@fdia                               ?            |
160300010314     C                   eval      p@fdma = x1femi                              ?            |
160400010314     C                   eval      $a—o2 = p@fa—o                               ?            |
160500010314     C                   eval      $mes2 = p@fmes                               ?            |
160600010314     C                   eval      $dia2 = p@fdia                               ?            |
160700010314     C                   call      'SPDFEC'                                     ?            |
160800010314     C                   parm                    $dia1                          ?            |
160900010314     C                   parm                    $mes1                          ?            |
161000010314     C                   parm                    $a—o1                          ?            |
161100010314     C                   parm                    $dia2                          ?            |
161200010314     C                   parm                    $mes2                          ?            |
161300010314     C                   parm                    $a—o2                          ?            |
161400010314     C                   parm      *zeros        p@dife                         ?            |
161500010314?2b? C                   if        t@ldee <> *zeros  and                        ?P---------02|
161600010314     C                             p@dife > t@ldee  and                         ?           ||
161700010314     C                             @@in36 <= 1                                  ?           ||
161800010314     C                   z-add     36            @e                   50        ?           ||
161900010314     C                   add       1             @@in36                         ?           ||
162000010314?2e? C                   endif                                                  ?F---------02|
162100010314?1e? C                   endif                                                  ?F----------01
162200050708     ?* Control de existencia de Contrato de Reaseguro.
162300050708     C                   eval      p@fdma = x1desd
162400050708     C                   eval      @@fecha = (p@fa—o * 10000) +
162500050708     C                                       (p@fmes * 100)   + p@fdia
162600050708?1b? C                   if        not *in50 and                                ?P----------01
162700050708     C                             not ok_cttorease(@@fecha : @@rama)           ?            |
162800050708     C                   z-add     56            @e                   50        ?            |
162900050708?1e? C                   endif                                                  ?F----------01
163000010312     ?* fuera de vigencia de superpoliza...
163100991217?1b? C                   if        not *in50                                    ?P----------01
163200991217     C     k1@ec0        chain     p1hec0                             20        ?            |
163300991217?2b? C                   if        not *in20                                    ?P---------02|
163400991217     C                   eval      p@1a—o = c0fioa                              ?           ||
163500991217     C                   eval      p@1mes = c0fiom                              ?           ||
163600991217     C                   eval      p@1dia = c0fiod                              ?           ||
163700991217     C                   eval      @@fec2 = p@famd                              ?           ||
163800991217     C                   eval      p@1a—o = c0fvoa                              ?           ||
163900991217     C                   eval      p@1mes = c0fvom                              ?           ||
164000991217     C                   eval      p@1dia = c0fvod                              ?           ||
164100991217     C                   eval      @@fec3 = p@famd                              ?           ||
164200991217     C                   eval      p@fdma = x1desd                              ?           ||
164300991217     C                   eval      p@1a—o = p@fa—o                              ?           ||
164400991217     C                   eval      p@1mes = p@fmes                              ?           ||
164500991217     C                   eval      p@1dia = p@fdia                              ?           ||
164600991217     C                   eval      @@fec1 = p@famd                              ?           ||
164700991217?3b? C                   if        @@fec1 < @@fec2  or                          ?P--------03||
164800991217     C                             @@fec1 > @@fec3                              ?          |||
164900991217     C                   z-add     52            @e                   50        ?          |||
165000991217?3e? C                   endif                                                  ?F--------03||
165100991217?2e? C                   endif                                                  ?F---------02|
165200991217?1e? C                   endif                                                  ?F----------01
165300010312     ?* fecha de vigencia menor a inicio periodo en curso
165400991217?1b? C                   if        not *in50  and                               ?P----------01
165500991217     C                             z0tiou = 3  and                              ?            |
165600010312     ?* Se agregÛ esta condiciÛn. No se si se va a crear             |          ?            |
165700010312     ?* un nuevo tipo para los cambios de fecha desde...             |          ?            |
165800991217     C                             z0stos <> 05  and                            ?            |
165900991217     C                             z0stos <> 08  or                             ?            |
166000991217     C                             not *in50  and                               ?            |
166100991217     C                             z0tiou = 5                                   ?            |
166200991217     C     k3@ed0        setgt     p1hed003                                     ?            |
166300991217?2b? C                   dou       *in99                                        ?P---------02|
166400991217     C     k3@ed0        readpe    p1hed003                               99    ?           ||
166500991217?3b? C                   if        not *in99                                    ?P--------03||
166600021101     C     keyec1        chain     pahec1                             27        ?          |||
166700991217?4b? C                   if        d0tiou = 1  or                               ?P-------04|||
166800991217     C                             d0tiou = 2  or                               ?         ||||
166900991217     C                             d0tiou = 3  and                              ?         ||||
167000991217     C                             d0stos = 01  and                             ?         ||||
167100021101     C                             c1fboa = 0                                   ?         ||||
167200991217?2v? C                   leave                                                  ?         ||||
167300991217?4e? C                   endif                                                  ?F-------04|||
167400991217?3e? C                   endif                                                  ?F--------03||
167500991217?2e? C                   enddo                                                  ?F---------02|
167600021101     C     k1yec1        chain     pahec1                             27        ?            |
167700991217     C                   eval      p@1a—o = d0fioa                              ?            |
167800991217     C                   eval      p@1mes = d0fiom                              ?            |
167900991217     C                   eval      p@1dia = d0fiod                              ?            |
168000991217     C                   eval      @@fec4 = p@famd                              ?            |
168100991217?2b? C                   if        @@fec1 < @@fec4                              ?P---------02|
168200991217     C                   z-add     53            @e                   50        ?           ||
168300991217?2e? C                   endif                                                  ?F---------02|
168400991217?1e? C                   endif                                                  ?F----------01
168500010312     ?* cuando estoy en artÌculos con m·s de una rama
168600010312     ?* secuencia la vigencia desde y la duraciÛn del
168700010312     ?* periodo de la segunda debe ser igual a la primera
168800991217?1b? C                   if        not *in50                                    ?P----------01
168900010312     ?* buscar pawpd0 registro de la primer rama secuencia           |          ?            |
169000991217     C     k2@pd0        chain(n)  p1wpd0                             20        ?            |
169100991217?2b? C                   if        not *in20                                    ?P---------02|
169200010312     ?* of course debo estar en otra rama secuencia ...             ||          ?           ||
169300991217?3b? C                   if        @@rama = z0rama  and                         ?P--------03||
169400991217     C                             @@arse = z0arse                              ?          |||
169500991217?3x? C                   else                                                   ?X........03||
169600991217     C     k1@ed0        chain(n)  p1hed0                             20        ?          |||
169700991217?4b? C                   if        not *in20                                    ?P-------04|||
169800991217     C                   z-add     d0fioa        p@fdia                         ?         ||||
169900991217     C                   eval      p@fmes = d0fiom                              ?         ||||
170000991217     C                   eval      p@fdia = d0fiod                              ?         ||||
170100991217?5b? C                   if        x1desd <> p@fdma  or                         ?P------05||||
170200991217     C                             x1dup2 <> d0dup2                             ?        |||||
170300991217     C                   z-add     72            @e                   50        ?        |||||
170400991217?5e? C                   endif                                                  ?F------05||||
170500991217?4e? C                   endif                                                  ?F-------04|||
170600991217?3e? C                   endif                                                  ?F--------03||
170700991217?2e? C                   endif                                                  ?F---------02|
170800991217?1e? C                   endif                                                  ?F----------01
170900010312     ?* devolver el registro actual del pawpd0...
171000991217     C     k1@pd0        chain(n)  p1wpd0                             20
171100010312     ?* duraciÛn del periodo de la poliza...
171200991217?1b? C                   if        not *in50  and                               ?P----------01
171300991217     C                             x1dup1 <> c1dupe                             ?            |
171400991217     C                   z-add     65            @e                   50        ?            |
171500991217?1e? C                   endif                                                  ?F----------01
171600010312     ?* vigencia hasta se calcula solo en poliza nueva
171700010312     ?* cuando est· en cero o bien toda vez que cambia la
171800010312     ?* vigencia desde o el dupe...
171900991217?1b? C                   if        not *in50                                    ?P----------01
172000991217?2b? C                   if        z0tiou <= 2  and                             ?P---------02|
172100991217     C                             x1hast = *zeros  or                          ?           ||
172200991217     C                             z0tiou <= 2  and                             ?           ||
172300991217     C                             x1desd <> @1desd  and                        ?           ||
172400991217     C                             x1hast <> 99999999  or                       ?           ||
172500991217     C                             z0tiou <= 2  and                             ?           ||
172600991217     C                             x1dup1 <> @1dup1  and                        ?           ||
172700991217     C                             x1hast <> 99999999  or                       ?           ||
172800991217     C                             x1mar5 = '3'                                 ?           ||
172900991217     C                   eval      @1desd = x1desd                              ?           ||
173000991217     C                   eval      @1dup1 = x1dup1                              ?           ||
173100991217     C                   eval      x1hast = x1desd                              ?           ||
173200991217?3b? C                   select                                                 ?P--------03||
173300991217?3x? C                   when      x1dup1 = 99                                  ?w--------03||
173400991217     C                   eval      x1hast = 99999999                            ?          |||
173500991217?3x? C                   when      x1mar5 = '1'                                 ?w--------03||
173600991217     C                   call      'SP0001'                                     ?          |||
173700991217     C                   parm                    x1hast                         ?          |||
173800991217     C                   parm                    x1dup1                         ?          |||
173900991217?3x? C                   when      x1mar5 = '2'                                 ?w--------03||
174000991217     C                   eval      p@fdma = x1desd                              ?          |||
174100991217     C                   add       x1dup1        p@fa—o                         ?          |||
174200991217     C                   eval      x1hast = p@fdma                              ?          |||
174300010312     ?*- EXPRESADA EN A—OS HASTA CANTIDAD DE MESES...              |||          ?          |||
174400991217?3x? C                   when      x1mar5 = '3'                                 ?w--------03||
174500991217     C     c1asen        chain     g1hda1                             20        ?          |||
174600991217?4b? C                   if        not *in20                                    ?P-------04|||
174700991217     C                   eval      p@fdia = dffnad                              ?         ||||
174800991217     C                   eval      p@fmes = dffnam                              ?         ||||
174900991217     C     dffnaa        add       x1dup1        p@fa—o                         ?         ||||
175000991217     C                   eval      x1hast = p@fdma                              ?         ||||
175100991217?4x? C                   else                                                   ?X.......04|||
175200991217     C                   eval      x1hast = *zeros                              ?         ||||
175300991217?4e? C                   endif                                                  ?F-------04|||
175400991217?3e? C                   endsl                                                  ?F--------03||
175500991217?2e? C                   endif                                                  ?F---------02|
175600010312     ?* NUEVA VERSION DE TRATAMIENTO DE VIGENCIA HASTA...            |          ?            |
175700010312     C                   eval      p@fa—o = c1fvoa                              ?            |
175800010312     C                   eval      p@fmes = c1fvom                              ?            |
175900010312     C                   eval      p@fdia = c1fvod                              ?            |
176000010312     C                   eval      x1hast = p@fdma                              ?            |
176100010312     ?* validar vigencia hasta...                                    |          ?            |
176200991217?2b? C                   if        not *in50  and                               ?P---------02|
176300991217     C                             x1hast <> 99999999                           ?           ||
176400991217     C                   eval      p@flap = *zeros                              ?           ||
176500991217     C                   eval      p@ffec = x1hast                              ?           ||
176600991217     C                   call      'SPFECH'                                     ?           ||
176700991217     C                   parm                    p@fech                         ?           ||
176800991217?3b? C                   if        p@flap = *zeros                              ?P--------03||
176900991217     C                   z-add     60            @e                   50        ?          |||
177000991217?3x? C                   else                                                   ?X........03||
177100991217     C                   eval      x1hast = p@ffec                              ?          |||
177200991217?3e? C                   endif                                                  ?F--------03||
177300991217?2e? C                   endif                                                  ?F---------02|
177400010312     ?* validar fecha de fin de vigencia...                          |          ?            |
177500991217?2b? C                   if        not *in50  and                               ?P---------02|
177600991217     C                             x1hast <> 99999999                           ?           ||
177700991217     C                   eval      p@flap = *zeros                              ?           ||
177800991217     C                   eval      p@ffec = x1hast                              ?           ||
177900991217     C                   call      'SPFECH'                                     ?           ||
178000991217     C                   parm                    p@fech                         ?           ||
178100991217?3b? C                   if        p@flap = *zeros                              ?P--------03||
178200991217     C                   z-add     60            @e                   50        ?          |||
178300991217?3x? C                   else                                                   ?X........03||
178400991217     C                   eval      x1hast = p@ffec                              ?          |||
178500991217?3e? C                   endif                                                  ?F--------03||
178600991217?2e? C                   endif                                                  ?F---------02|
178700010312     ?* comparar las vigencias...                                    |          ?            |
178800991217?2b? C                   if        not *in50                                    ?P---------02|
178900991217     C                   eval      p@fdma = x1hast                              ?           ||
179000991217     C                   eval      p@1a—o = p@fa—o                              ?           ||
179100991217     C                   eval      p@1mes = p@fmes                              ?           ||
179200991217     C                   eval      p@1dia = p@fdia                              ?           ||
179300991217     C                   eval      @@fec5 = p@famd                              ?           ||
179400991217?3b? C                   if        @@fec1 > @@fec5                              ?P--------03||
179500991217     C                   z-add     54            @e                   50        ?          |||
179600991217?3e? C                   endif                                                  ?F--------03||
179700991217?2e? C                   endif                                                  ?F---------02|
179800010312     ?* refacturacion cuando no se puede refacturar...               |          ?            |
179900991217?2b? C                   if        not *in50  and                               ?P---------02|
180000991217     C                             z0tiou = 3  and                              ?           ||
180100991217     C                             z0stos = 01  and                             ?           ||
180200991217     C                             @@fec1 = @@fec5                              ?           ||
180300991217     C                   z-add     55            @e                   50        ?           ||
180400991217?2e? C                   endif                                                  ?F---------02|
180500991217?1e? C                   endif                                                  ?F----------01
180600010312     ?* duracion del periodo de refacturacion...
180700991217?1b? C                   if        not *in50  and                               ?P----------01
180800991217     C                             x1dup2 <> 1  and                             ?            |
180900991217     C                             x1dup2 <> 2  and                             ?            |
181000991217     C                             x1dup2 <> 3  and                             ?            |
181100991217     C                             x1dup2 <> 4  and                             ?            |
181200991217     C                             x1dup2 <> 6  and                             ?            |
181300991217     C                             x1dup2 <> 12  and                            ?            |
181400010315     C                             x1dup2 <> 18  and                            ?            |
181500000928     C                             x1dup2 <> 24  and                            ?            |
181600010315     C                             x1dup2 <> 30  and                            ?            |
181700000928     C                             x1dup2 <> 36  and                            ?            |
181800010315     C                             x1dup2 <> 42  and                            ?            |
181900000928     C                             x1dup2 <> 48  and                            ?            |
182000010315     C                             x1dup2 <> 54  and                            ?            |
182100000928     C                             x1dup2 <> 60  and                            ?            |
182200010315     C                             x1dup2 <> 66  and                            ?            |
182300010315     C                             x1dup2 <> 72  and                            ?            |
182400010312     C                             x1dup2 <> 99                                 ?            |
182500991217     C                   z-add     66            @e                   50        ?            |
182600991217?1e? C                   endif                                                  ?F----------01
182700010312     ?* duracion del periodo de refacturacion...
182800010312?1b? C                   if        not *in50  and                               ?P----------01
182900010312     C                             x1dup2 = 99  and                             ?            |
183000010312     C                             t@rame = 04  or                              ?            |
183100010312     C                             not *in50  and                               ?            |
183200010312     C                             x1dup2 = 99  and                             ?            |
183300010312     C                             t@rame = 18  or                              ?            |
183400010312     C                             not *in50  and                               ?            |
183500010312     C                             x1dup2 = 99  and                             ?            |
183600010312     C                             x1hast = 99999999                            ?            |
183700010312     C                   z-add     37            @e                   50        ?            |
183800010312?1e? C                   endif                                                  ?F----------01
183900010312     ?* duracion de la facturaciÛn debe ser menor a dura-
184000010315     ?* ciÛn de la pÛliza esta situaciÛn la valido solo
184100010315     ?* en pÛlizas nuevas...
184200991217?1b? C                   if        not *in50  and                               ?P----------01
184300010315     C                             z0tiou <= 2  and                             ?            |
184400991217     C                             x1mar5 = '1'  and                            ?            |
184500991217     C                             x1dup2 > x1dup1  and                         ?            |
184600010312     C                             x1dup2 <> 99                                 ?            |
184700991217     C                   z-add     67            @e                   50        ?            |
184800991217?1e? C                   endif                                                  ?F----------01
184900010312     ?* refrescar fecha hasta facturada...
185000991217?1b? C                   if        not *in50                                    ?P----------01
185100991217?2b? C                   if        z0tiou <= 2  and                             ?P---------02|
185200991217     C                             x1hafa = *zeros  or                          ?           ||
185300991217     C                             z0tiou <= 2  and                             ?           ||
185400991217     C                             x1desd <> @2desd  or                         ?           ||
185500991217     C                             z0tiou <= 2  and                             ?           ||
185600991217     C                             x1dup2 <> @1dup2  or                         ?           ||
185700991217     C                             z0tiou = 3  and                              ?           ||
185800991217     C                             z0stos = 01  and                             ?           ||
185900991217     C                             x1hafa = *zeros  or                          ?           ||
186000991217     C                             z0tiou = 3  and                              ?           ||
186100991217     C                             z0stos = 01  and                             ?           ||
186200991217     C                             x1desd <> @2desd  or                         ?           ||
186300991217     C                             z0tiou = 3  and                              ?           ||
186400991217     C                             z0stos = 01  and                             ?           ||
186500991217     C                             x1dup2 <> @1dup2                             ?           ||
186600991217     C                   eval      x1hafa = x1desd                              ?           ||
186700991217     C                   eval      @2desd = x1desd                              ?           ||
186800991217     C                   eval      @1dup2 = x1dup2                              ?           ||
186900010312?3b? C                   select                                                 ?P--------03||
187000010312?3x? C                   when      x1dup2 <> 99                                 ?w--------03||
187100010312     C                   call      'SP0001'                                     ?          |||
187200010312     C                   parm                    x1hafa                         ?          |||
187300010312     C                   parm                    x1dup2                         ?          |||
187400010312?3x? C                   when      x1dup2 = 99                                  ?w--------03||
187500010312     C                   eval      x1hafa = x1hast                              ?          |||
187600010312?3e? C                   endsl                                                  ?F--------03||
187700010312     C                   exsr      ajhafa                                       ?           ||
187800010312     ?* las operaciones en las que la vigencia pasa por             ||          ?           ||
187900010312     ?* los dÌas 30/31 o 28 de febrero pueden ir perdiendo          ||          ?           ||
188000010312     ?* dias de vigencia...                                         ||          ?           ||
188100991217     C                   eval      p@2dma = x1hast                              ?           ||
188200991217     C                   eval      p@fdma = x1hafa                              ?           ||
188300991217?3b? C                   if        p@2a—o = p@fa—o  and                         ?P--------03||
188400991217     C                             p@2mes = p@fmes                              ?          |||
188500991217     C                   eval      @@dias = p@2dia - p@fdia                     ?          |||
188600991217?4b? C                   if        @@dias <= 3                                  ?P-------04|||
188700991217     C                   eval      p@fdia = p@2dia                              ?         ||||
188800991217     C                   eval      x1hafa = p@fdma                              ?         ||||
188900991217?4e? C                   endif                                                  ?F-------04|||
189000991217?3e? C                   endif                                                  ?F--------03||
189100991217?2e? C                   endif                                                  ?F---------02|
189200991217?1e? C                   endif                                                  ?F----------01
189300010312     ?* refrescar anualidad...
189400010312     ?* la anualidad se calcula en poliza nueva/renovacion
189500010312     ?* tambiÈn en refacturaciÛn pero en ese caso no puede
189600010312     ?* modificarse la que se calcula por defecto...
189700991217?1b? C                   if        not *in50  and                               ?P----------01
189800991217     C                             z0tiou <= 2                                  ?            |
189900991217     C                   eval      x1anua = x1desd                              ?            |
190000991217     C                   eval      @3desd = x1desd                              ?            |
190100991217     C                   call      'SP0001'                                     ?            |
190200991217     C                   parm                    x1anua                         ?            |
190300991217     C                   parm      12            @@dupe                         ?            |
190400991217     C                   exsr      ajanua                                       ?            |
190500991217?1e? C                   endif                                                  ?F----------01
190600010312     ?* si no existen errores corregir si es necesario la
190700010312     ?* fecha hasta facturada y el vencimiento de la anua-
190800010312     ?* lidad...
190900991217?1b? C                   if        not *in50                                    ?P----------01
191000991217     C                   eval      p@fdma = x1hafa                              ?            |
191100991217     C                   eval      p@1a—o = p@fa—o                              ?            |
191200991217     C                   eval      p@1mes = p@fmes                              ?            |
191300991217     C                   eval      p@1dia = p@fdia                              ?            |
191400991217     C                   eval      @@fec6 = p@famd                              ?            |
191500991217?2b? C                   if        @@fec6 > @@fec5                              ?P---------02|
191600991217     C                   eval      x1hafa = x1hast                              ?           ||
191700991217?2e? C                   endif                                                  ?F---------02|
191800010312     ?* hacer lo mismo con la anualidad...                           |          ?            |
191900991217     C                   eval      p@fdma = x1anua                              ?            |
192000991217     C                   eval      p@1a—o = p@fa—o                              ?            |
192100991217     C                   eval      p@1mes = p@fmes                              ?            |
192200991217     C                   eval      p@1dia = p@fdia                              ?            |
192300991217     C                   eval      @@fec7 = p@famd                              ?            |
192400991217?2b? C                   if        @@fec7 > @@fec5                              ?P---------02|
192500991217     C                   eval      x1anua = x1hast                              ?           ||
192600991217?2e? C                   endif                                                  ?F---------02|
192700010312     ?* si es vida obligatorio pasar por la rutina famosa..          |          ?            |
192800010312     ?* ajusto las vigencias al 1 de octubre seg˙n el                |          ?            |
192900010312     ?* contenido del @@MA38...                                      |          ?            |
193000001128?2b? C                   if        t@rame = 21  and                             ?P---------02|
193100001129     C                             @@ma38 = '1'                                 ?           ||
193200001128     C                   exsr      obliga                                       ?           ||
193300001128?2x? C                   else                                                   ?X.........02|
193400010312     ?* paso por la rutina de control general de vigencias.         ||          ?           ||
193500001128     C                   exsr      ajvige                                       ?           ||
193600001128?2e? C                   endif                                                  ?F---------02|
193700991217?1e? C                   endif                                                  ?F----------01
193800001106     ?*
193900010312     ?* inicio de vigencia debe ser menor o igual a fecha
194000010312     ?* hasta facturada...
194100991217?1b? C                   if        not *in50  and                               ?P----------01
194200991217     C                             @@fec1 > @@fec6                              ?            |
194300991217     C                   z-add     71            @e                   50        ?            |
194400991217?1e? C                   endif                                                  ?F----------01
194500010312     ?* periodo en curso no puede ser cero...
194600991217?1b? C                   if        not *in50  and                               ?P----------01
194700991217     C                             *in17  and                                   ?            |
194800991217     C                             z0tiou <= 2  and                             ?            |
194900991217     C                             x1pecu = *zeros                              ?            |
195000991217     C                   z-add     77            @e                   50        ?            |
195100991217?1e? C                   endif                                                  ?F----------01
195200010312     ?* se ha cambiado el periodo en curso...
195300991217?1b? C                   if        not *in50  and                               ?P----------01
195400991217     C                             *in17  and                                   ?            |
195500991217     C                             z0tiou <= 2  and                             ?            |
195600991217     C                             x1pecu > 1  and                              ?            |
195700991217     C                             @@in78 <= 1                                  ?            |
195800991217     C                   z-add     78            @e                   50        ?            |
195900991217     C                   add       1             @@in78                         ?            |
196000991217?1e? C                   endif                                                  ?F----------01
196100010312     ?* en polizas nuevas con mas de una rama secuencia
196200010312     ?* si se cambio el periodo en curso de la primera
196300010312     ?* las que siguen deben llevar al mismo periodo en
196400010312     ?* curso...
196500991217?1b? C                   if        not *in50  and                               ?P----------01
196600991217     C                             *in17  and                                   ?            |
196700991217     C                             z0tiou <= 2                                  ?            |
196800010312     ?* buscar pawpd0 registro de la primer rama secuencia           |          ?            |
196900991217     C     k2@pd0        chain(n)  p1wpd0                             20        ?            |
197000991217?2b? C                   if        not *in20                                    ?P---------02|
197100010312     ?* of course debo estar en otra rama secuencia ...             ||          ?           ||
197200991217?3b? C                   if        @@rama = z0rama  and                         ?P--------03||
197300991217     C                             @@arse = z0arse                              ?          |||
197400991217?3x? C                   else                                                   ?X........03||
197500991217     C     k1@ed0        chain(n)  p1hed0                             20        ?          |||
197600991217?4b? C                   if        not *in20  and                               ?P-------04|||
197700991217     C                             x1pecu <> d0pecu                             ?         ||||
197800991217     C                   z-add     81            @e                   50        ?         ||||
197900991217?4e? C                   endif                                                  ?F-------04|||
198000991217?3e? C                   endif                                                  ?F--------03||
198100991217?2e? C                   endif                                                  ?F---------02|
198200991217?1e? C                   endif                                                  ?F----------01
198300010312     ?* devolver el registro actual del pawpd0...
198400991217     C     k1@pd0        chain(n)  p1wpd0                             20
198500010312     ?* plan comercial...
198600010312     ?* antes de validar veo si tengo que refrescar el plan
198700010312     ?* comercial por cambio de la compaÒia de seguros...
198800991230?1b? C                   if        not *in50  and                               ?P----------01
198900991230     C                             x1ncoc <> $$ncoc                             ?            |
199000991230     C     k1t606        chain     s1t606                             20        ?            |
199100991230?2b? C                   if        not *in20                                    ?P---------02|
199200991230     C                   eval      x1plac = t@plac                              ?           ||
199300991230     C                   eval      @@plac = t@plac                              ?           ||
199400991230?2e? C                   endif                                                  ?F---------02|
199500991230?1e? C                   endif                                                  ?F----------01
199600010312     ?* ahora validar el plan comercial...
199700991217?1b? C                   if        not *in50                                    ?P----------01
199800991217     C     x1plac        chain     s1t610                             20        ?            |
199900991217     C   20              z-add     70            @e                   50        ?            |
200000991217?1e? C                   endif                                                  ?F----------01
200100010312     ?* cambio de plan comercial...
200200991217?1b? C                   if        not *in50  and                               ?P----------01
200300991217     C                             x1plac <> @@plac  and                        ?            |
200400991217     C                             @@in79 <= 1                                  ?            |
200500991217     C                   z-add     79            @e                   50        ?            |
200600991217     C                   add       1             @@in79                         ?            |
200700991217?1e? C                   endif                                                  ?F----------01
200800010312     ?* cædigo de agenda...
200900991217?1b? C                   if        not *in50  and                               ?P----------01
201000991217     C                             x1agec <> *zeros                             ?            |
201100991217     C     k1t676        chain     s1t676                             20        ?            |
201200991217     C   20              z-add     83            @e                   50        ?            |
201300991217     C   20              eval      x1aged = *blanks                             ?            |
201400991217     C  n20              eval      x1aged = t@aged                              ?            |
201500991217?1e? C                   endif                                                  ?F----------01
201600010312     ?* cædigo de agenda deber›a existir...
201700991217?1b? C                   if        not *in50  and                               ?P----------01
201800991217     C                             *in13  and                                   ?            |
201900991217     C                             x1agec = *zeros  and                         ?            |
202000991217     C                             @@in82 <= 1                                  ?            |
202100991217     C                   eval      x1aged = *blanks                             ?            |
202200991217     C                   z-add     82            @e                   50        ?            |
202300991217     C                   add       1             @@in82                         ?            |
202400991217?1e? C                   endif                                                  ?F----------01
202500010312     ?* verificar que exista la poliza global...
202600991217?1b? C                   if        not *in50                                    ?P----------01
202700991217?2b? C                   if        *in18  and                                   ?P---------02|
202800991217     C                             x1poli <> *zeros                             ?           ||
202900991217     C     k1t622        chain     s1t62202                           20        ?           ||
203000991217     C   20              z-add     73            @e                   50        ?           ||
203100991217?2e? C                   endif                                                  ?F---------02|
203200991217?1e? C                   endif                                                  ?F----------01
203300010312     ?* fin de vigencia contra fin de vigencia de pÛliza
203400010312     ?* global...
203500001128?1b? C                   if        not *in50                                    ?P----------01
203600001128?2b? C                   if        *in18  and                                   ?P---------02|
203700001128     C                             x1poli <> *zeros                             ?           ||
203800001128     C     k4@ed0        chain     p1hed006                           20        ?           ||
203900001128?3b? C                   if        not *in20  and                               ?P--------03||
204000001128     C                             @@ma37 = '1'  and                            ?          |||
204100001128     C                             d0poli = x1poli                              ?          |||
204200001128     C                   eval      p@fdia = d0fvod                              ?          |||
204300001128     C                   eval      p@fmes = d0fvom                              ?          |||
204400001128     C                   eval      p@fa—o = d0fvoa                              ?          |||
204500001128?4b? C                   if        x1hast <> p@fdma                             ?P-------04|||
204600001128     C                   z-add     39            @e                   50        ?         ||||
204700001128?4e? C                   endif                                                  ?F-------04|||
204800001128?3e? C                   endif                                                  ?F--------03||
204900001128     C     k1@ed0        chain     p1hed0                             20        ?           ||
205000001128?2e? C                   endif                                                  ?F---------02|
205100001128?1e? C                   endif                                                  ?F----------01
205200010312     ?* colectivo abierto no asignado a ninguna poliza
205300991217?1b? C                   if        not *in50  and                               ?P----------01
205400991217     C                             *in18  and                                   ?            |
205500991217     C                             z0tiou <= 2  and                             ?            |
205600991217     C                             x1poli = *zeros  and                         ?            |
205700991217     C                             @@in74 <= 1                                  ?            |
205800991217     C                   z-add     74            @e                   50        ?            |
205900991217     C                   add       1             @@in74                         ?            |
206000991217?1e? C                   endif                                                  ?F----------01
206100010312     ?* colectivo abierto y no coincide el vendedor...
206200991217?1b? C                   if        not *in50  and                               ?P----------01
206300991217     C                             *in18  and                                   ?            |
206400991217     C                             z0tiou <= 2  and                             ?            |
206500991217     C                             x1poli <> *zeros  and                        ?            |
206600991217     C                             @@in75 <= 1                                  ?            |
206700991217?2b? C                   if        c1nivt = t@nivt  and                         ?P---------02|
206800991217     C                             c1nivc = t@nivc                              ?           ||
206900991217?2x? C                   else                                                   ?X.........02|
207000991217     C                   z-add     75            @e                   50        ?           ||
207100991217     C                   add       1             @@in75                         ?           ||
207200991217?2e? C                   endif                                                  ?F---------02|
207300991217?1e? C                   endif                                                  ?F----------01
207400010312     ?* colectivo abierto y no coincide el cobrador...
207500991217?1b? C                   if        not *in50  and                               ?P----------01
207600991217     C                             *in18  and                                   ?            |
207700991217     C                             z0tiou <= 2  and                             ?            |
207800991217     C                             x1poli <> *zeros  and                        ?            |
207900991217     C                             @@in76 <= 1                                  ?            |
208000991217?2b? C                   if        c1cbrn = t@cbrn  and                         ?P---------02|
208100991217     C                             c1czco = t@czco                              ?           ||
208200991217?2x? C                   else                                                   ?X.........02|
208300991217     C                   z-add     76            @e                   50        ?           ||
208400991217     C                   add       1             @@in76                         ?           ||
208500991217?2e? C                   endif                                                  ?F---------02|
208600991217?1e? C                   endif                                                  ?F----------01
208700010312     ?* detectar periodo corto...
208800001129?1b? C                   if        not *in50  and                               ?P----------01
208900001129     C                             @@sspo = *zeros  and                         ?            |
209000001201     C                             x1hast <> 99999999                           ?            |
209100001129     C                   eval      p@fdma = x1desd                              ?            |
209200001129     C                   eval      $dia1 = p@fdia                               ?            |
209300001129     C                   eval      $mes1 = p@fmes                               ?            |
209400001129     C                   eval      $a—o1 = p@fa—o                               ?            |
209500001129     C                   eval      p@fdma = x1hast                              ?            |
209600001129     C                   eval      $dia2 = p@fdia                               ?            |
209700001129     C                   eval      $mes2 = p@fmes                               ?            |
209800001129     C                   eval      $a—o2 = p@fa—o                               ?            |
209900001129     C                   call      'SPDFEC'                                     ?            |
210000001129     C                   parm                    $dia1                          ?            |
210100001129     C                   parm                    $mes1                          ?            |
210200001129     C                   parm                    $a—o1                          ?            |
210300001129     C                   parm                    $dia2                          ?            |
210400001129     C                   parm                    $mes2                          ?            |
210500001129     C                   parm                    $a—o2                          ?            |
210600001129     C                   parm      *zeros        p@dife                         ?            |
210700001129?2b? C                   if        p@dife < 365                                 ?P---------02|
210800001129?3b? C                   if        @@ma39 = '0'  and                            ?P--------03||
210900001129     C                             x1hast <> x1hafa                             ?          |||
211000001129     C                   z-add     38            @e                   50        ?          |||
211100001129?3e? C                   endif                                                  ?F--------03||
211200001129?2e? C                   endif                                                  ?F---------02|
211300001129?1e? C                   endif                                                  ?F----------01
211400010312     ?* descripciones por las dudas...
211500991217     C                   exsr      desc01
211600991217     ?** SI NO EXISTEN ERRORES AVANZA...
211700991217?1b? C                   if        not *in50                                    ?P----------01
211800991217     ?*- COMPARACION DE CAMPOS...                                    |          ?            |
211900991217?2b? C                   if        x1desd = $$desd  and                         ?P---------02|
212000991217     C                             x1hast = $$hast  and                         ?           ||
212100991217     C                             x1dup1 = $$dup1  and                         ?           ||
212200991217     C                             x1dup2 = $$dup2  and                         ?           ||
212300991217     C                             x1plac = $$plac  and                         ?           ||
212400991217     C                             x1hafa = $$hafa  and                         ?           ||
212500991217     C                             x1anua = $$anua  and                         ?           ||
212600991217     C                             x1poli = $$poli  and                         ?           ||
212700991217     C                             x1agec = $$agec  and                         ?           ||
212800991217     C                             x1ncoc = $$ncoc  and                         ?           ||
212900991217     C                             *in90                                        ?           ||
213000991217     C                   eval      xxiden = 1                                   ?           ||
213100991217     C                   exsr      grab01                                       ?           ||
213200991217     C                   eval      @@mand = 'KA'                                ?           ||
213300991217     C                   eval      *inkc = '1'                                  ?           ||
213400991217     C                   setoff                                           90    ?           ||
213500991217?2x? C                   else                                                   ?X.........02|
213600991217     C                   eval      $$desd = x1desd                              ?           ||
213700991217     C                   eval      $$hast = x1hast                              ?           ||
213800991217     C                   eval      $$dup1 = x1dup1                              ?           ||
213900991217     C                   eval      $$dup2 = x1dup2                              ?           ||
214000991217     C                   eval      $$plac = x1plac                              ?           ||
214100991217     C                   eval      $$hafa = x1hafa                              ?           ||
214200991217     C                   eval      $$anua = x1anua                              ?           ||
214300991217     C                   eval      $$poli = x1poli                              ?           ||
214400991217     C                   eval      $$agec = x1agec                              ?           ||
214500991217     C                   eval      $$ncoc = x1ncoc                              ?           ||
214600991217     C                   seton                                            90    ?           ||
214700991217?2e? C                   endif                                                  ?F---------02|
214800991217?1e? C                   endif                                                  ?F----------01
214900991217     ?*- SI EXISTEN ERRORES...
215000991217?1b? C                   if        *in50  and                                   ?P----------01
215100991217     C                             @e <> *zeros                                 ?            |
215200991217     C                   setoff                                           90    ?            |
215300991217     C                   write     par31001                                     ?            |
215400991217     C                   eval      *in(@e) = '1'                                ?            |
215500991217?1e? C                   endif                                                  ?F----------01
215600991217     ?*-
215700991217     C                   endsr
215800991217     ?*****************************************************
215900010312     C/SPACE
216000991217     ?*****************************************************
216100991217     C     grab01        begsr
216200991217     ?** GRABACION PANTALLA 01-----------------------------
216300991217     ?** GRABACION P1HED0...
216400991217     C     k1@ed0        chain     p1hed0                             20
216500010312     ?* campos de clave...
216600991217     C                   eval      d0empr = z0empr
216700991217     C                   eval      d0sucu = z0sucu
216800991217     C                   eval      d0arcd = z0arcd
216900991217     C                   eval      d0spol = z0spol
217000991217     C                   eval      d0sspo = z0sspo
217100991217     C                   eval      d0rama = z0rama
217200991217     C                   eval      d0arse = z0arse
217300991217     C                   eval      d0oper = z0oper
217400991217     C                   eval      d0suop = z0suop
217500010312     ?* campos que se actualizan por confirmacion...
217600991217     C                   eval      d0cert = *zeros
217700991217     C                   eval      d0poli = *zeros
217800991217     C                   eval      d0endo = *zeros
217900010312     ?* campos que vienen del cabecera...
218000991217     C                   eval      d0mone = c1mone
218100991217     C                   eval      d0come = c1come
218200991217     C                   eval      d0conr = *zeros
218300010312     ?* campos que vienen del archivo de trabajo...
218400991217     C                   eval      d0tiou = z0tiou
218500991217     C                   eval      d0stou = z0stou
218600991217     C                   eval      d0stos = z0stos
218700010312     ?* campos que vienen de pantalla...
218800991217     C                   eval      d0plac = x1plac
218900991217     C                   eval      p@fdma = x1desd
219000991217     C                   eval      d0fioa = p@fa—o
219100991217     C                   eval      d0fiom = p@fmes
219200991217     C                   eval      d0fiod = p@fdia
219300991217     C                   eval      p@fdma = x1hast
219400991217     C                   eval      d0fvoa = p@fa—o
219500991217     C                   eval      d0fvom = p@fmes
219600991217     C                   eval      d0fvod = p@fdia
219700991217     C                   eval      p@fdma = x1hafa
219800991217     C                   eval      d0fhfa = p@fa—o
219900991217     C                   eval      d0fhfm = p@fmes
220000991217     C                   eval      d0fhfd = p@fdia
220100991217     C                   eval      p@fdma = x1anua
220200991217     C                   eval      d0fvaa = p@fa—o
220300991217     C                   eval      d0fvam = p@fmes
220400991217     C                   eval      d0fvad = p@fdia
220500010312     ?* campos que vienen del archivo de trabajo...
220600991217     C                   eval      d0ncoc = x1ncoc
220700991217     C     k1t120        chain     s1t12003                           21
220800991217     C  n21              eval      d0ciap = t@ciap
220900991217     C                   eval      d0part = z0part
221000991217     C                   eval      d0cpar = z0cpar
221100991217     C                   eval      d0copc = z0copc
221200991217     C                   eval      d0copg = z0copg
221300991217     C                   eval      d0gpil = z0gpil
221400010312     ?* campos que vienen de pantalla...
221500991217     C                   eval      d0dup1 = x1dup1
221600991217     C                   eval      d0mar5 = x1mar5
221700991217     C                   eval      d0dup2 = x1dup2
221800991217     C                   eval      d0pecu = x1pecu
221900010312     ?* campos que formatean en cero o blanco...
222000010312     ?* solo cuando es primera grabacion...
222100991217     C   20              clear                   d0suas
222200991217     C   20              clear                   d0saca
222300991217     C   20              clear                   d0sacr
222400991217     C   20              clear                   d0sast
222500991217     C   20              clear                   d0prim
222600991217     C   20              clear                   d0bpri
222700991217     C   20              clear                   d0refi
222800991217     C   20              clear                   d0read
222900991217     C   20              clear                   d0dere
223000991217     C   20              clear                   d0seri
223100991217     C   20              clear                   d0seem
223200991217     C   20              clear                   d0impi
223300991217     C   20              clear                   d0sers
223400991217     C   20              clear                   d0tssn
223500991217     C   20              clear                   d0ipr1
223600991217     C   20              clear                   d0ipr2
223700991217     C   20              clear                   d0ipr3
223800991217     C   20              clear                   d0ipr4
223900991217     C   20              clear                   d0ipr5
224000991217     C   20              clear                   d0ipr6
224100991217     C   20              clear                   d0ipr7
224200991217     C   20              clear                   d0ipr8
224300991217     C   20              clear                   d0ipr9
224400991217     C   20              clear                   d0prem
224500991217     C   20              clear                   d0bpre
224600991217     C   20              clear                   d0prco
224700991217     C   20              clear                   d0depp
224800991217     C   20              clear                   d0bpip
224900991217     C   20              clear                   d0xref
225000991217     C   20              clear                   d0xrea
225100991217     C   20              clear                   d0pimi
225200991217     C   20              clear                   d0psso
225300991217     C   20              clear                   d0pssn
225400991217     C   20              clear                   d0pivi
225500991217     C   20              clear                   d0pivn
225600991217     C   20              clear                   d0pivr
225700991217     C   20              clear                   d0bpep
225800040526     C   20              clear                   d0siva
225900060622     C   20              clear                   d0cuic
226000010312     ?* poliza anterior y posterior...
226100991217     C                   clear                   d0poan
226200991217     C                   clear                   d0ponu
226300010312     ?* marcas y todas esas yerbas...
226400991217     C                   eval      d0mar1 = '0'
226500991217     C                   eval      d0mar2 = '0'
226600991217     C                   eval      d0mar3 = '0'
226700110412     C   20              eval      d0mar4 = 'N'
226800991217     C                   eval      d0strg = '0'
226900991217     C                   eval      d0user = vsuser
227000991217     C                   time                    d0time
227100991217     C                   eval      d0date = udate
227200991217     C   20              write     p1hed0
227300991217     C  n20              update    p1hed0
227400991217     ?** GRABACION P1HED9...
227500991217?1b? C                   if        *in18  and                                   ?P----------01
227600991217     C                             x1poli <> *zeros                             ?            |
227700991217     C     k1@ed9        chain     p1hed9                             20        ?            |
227800010312     ?* campos de clave...                                           |          ?            |
227900991217     C                   eval      d9empr = z0empr                              ?            |
228000991217     C                   eval      d9sucu = z0sucu                              ?            |
228100991217     C                   eval      d9arcd = z0arcd                              ?            |
228200991217     C                   eval      d9spol = z0spol                              ?            |
228300991217     C                   eval      d9sspo = z0sspo                              ?            |
228400991217     C                   eval      d9rama = z0rama                              ?            |
228500991217     C                   eval      d9arse = z0arse                              ?            |
228600991217     C                   eval      d9oper = z0oper                              ?            |
228700991217     C                   eval      d9suop = z0suop                              ?            |
228800991217     C                   eval      d9fema = *zeros                              ?            |
228900991217     C                   eval      d9femm = *zeros                              ?            |
229000991217     C                   eval      d9femd = *zeros                              ?            |
229100991217     C                   eval      d9asen = t@asen                              ?            |
229200991217     C                   eval      d9rpro = x1rpro                              ?            |
229300991217     C                   eval      d9niv1 = c1niv1                              ?            |
229400991217     C                   eval      d9niv2 = c1niv2                              ?            |
229500991217     C                   eval      d9niv3 = c1niv3                              ?            |
229600991217     C                   eval      d9niv4 = c1niv4                              ?            |
229700991217     C                   eval      d9niv5 = c1niv5                              ?            |
229800991217     C                   eval      d9niv6 = c1niv6                              ?            |
229900991217     C                   eval      d9niv7 = c1niv7                              ?            |
230000991217     C                   eval      d9niv8 = c1niv8                              ?            |
230100991217     C                   eval      d9niv9 = c1niv9                              ?            |
230200991217     C                   eval      g9empr = @@empr                              ?            |
230300991217     C                   eval      g9sucu = @@sucu                              ?            |
230400991217     C                   eval      g9rama = @@rama                              ?            |
230500991217     C                   eval      g9poli = x1poli                              ?            |
230600991217     C                   eval      g9endo = *zeros                              ?            |
230700991217     C                   eval      g9oper = t@oper                              ?            |
230800991217     C                   eval      g9suop = *zeros                              ?            |
230900991217     C                   eval      g9tiou = *zeros                              ?            |
231000991217     C                   eval      g9stou = *zeros                              ?            |
231100991217     C                   eval      g9stos = *zeros                              ?            |
231200991217     C                   eval      g9fema = *zeros                              ?            |
231300991217     C                   eval      g9femm = *zeros                              ?            |
231400991217     C                   eval      g9femd = *zeros                              ?            |
231500991217     C                   eval      g9mar1 = '0'                                 ?            |
231600991217     C                   eval      g9mar2 = '0'                                 ?            |
231700991217     C                   eval      g9mar3 = '0'                                 ?            |
231800991217     C                   eval      d9user = vsuser                              ?            |
231900991217     C                   time                    d9time                         ?            |
232000991217     C                   eval      d9date = udate                               ?            |
232100991217     C   20              write     p1hed9                                       ?            |
232200991217     C  n20              update    p1hed9                                       ?            |
232300991217?1e? C                   endif                                                  ?F----------01
232400991217     ?*- GRABACION DE AGENDAS...
232500991217     ?*- PRIMERO BORRAR...
232600991217     C                   setoff                                           99
232700991217     C     k1@ed6        setll     p1hed6
232800991217?1b? C                   dou       *in99                                        ?P----------01
232900991217     C     k1@ed6        reade     p1hed6                                 99    ?            |
233000991217?2b? C                   if        not *in99                                    ?P---------02|
233100991217     C                   delete    p1hed6                                       ?           ||
233200991217?2e? C                   endif                                                  ?F---------02|
233300991217?1e? C                   enddo                                                  ?F----------01
233400991217     C                   unlock    pahed6
233500991217     ?*- AHORA GRABAR...
233600991217?1b? C                   if        x1agec <> *zeros                             ?P----------01
233700991217     C                   eval      d6empr = z0empr                              ?            |
233800991217     C                   eval      d6sucu = z0sucu                              ?            |
233900991217     C                   eval      d6arcd = z0arcd                              ?            |
234000991217     C                   eval      d6spol = z0spol                              ?            |
234100991217     C                   eval      d6sspo = z0sspo                              ?            |
234200991217     C                   eval      d6rama = z0rama                              ?            |
234300991217     C                   eval      d6arse = z0arse                              ?            |
234400991217     C                   eval      d6oper = z0oper                              ?            |
234500991217     C                   eval      d6suop = z0suop                              ?            |
234600991217     C                   eval      d6cert = *zeros                              ?            |
234700991217     C                   eval      d6poli = *zeros                              ?            |
234800991217     C                   eval      d6endo = *zeros                              ?            |
234900991217     C                   eval      d6fcra = *zeros                              ?            |
235000991217     C                   eval      d6fcrm = *zeros                              ?            |
235100991217     C                   eval      d6fcrd = *zeros                              ?            |
235200991217     C                   eval      d6mar1 = '0'                                 ?            |
235300991217     C                   eval      d6mar2 = '0'                                 ?            |
235400991217     C                   eval      d6mar3 = '0'                                 ?            |
235500991217     C                   eval      d6mar4 = '0'                                 ?            |
235600991217     C                   eval      d6mar5 = '0'                                 ?            |
235700991217     C                   eval      d6strg = '0'                                 ?            |
235800991217     C                   eval      d6user = vsuser                              ?            |
235900991217     C                   time                    d6time                         ?            |
236000991217     C                   eval      d6date = udate                               ?            |
236100991217     C                   setoff                                           99    ?            |
236200991217     C     k1t678        setll     s1t678                                       ?            |
236300991217?2b? C                   dou       *in99                                        ?P---------02|
236400991217     C     k1t678        reade     s1t678                                 99    ?           ||
236500991217?3b? C                   if        not *in99                                    ?P--------03||
236600991217     C                   eval      d6agec = t@agec                              ?          |||
236700991217     C                   eval      d6reqc = t@reqc                              ?          |||
236800991217     C     k1t677        chain     s1t677                             20        ?          |||
236900991217     C                   eval      d6sevr = t@sevr                              ?          |||
237000991217?4b? C                   select                                                 ?P-------04|||
237100991217?4x? C                   when      t@fbcd = '1'                                 ?w-------04|||
237200991217     C                   eval      p@fa—o = d0fioa                              ?         ||||
237300991217     C                   eval      p@fmes = d0fiom                              ?         ||||
237400991217     C                   eval      p@fdia = d0fiod                              ?         ||||
237500991217?4x? C                   when      t@fbcd = '2'                                 ?w-------04|||
237600991217     C                   eval      p@fdia = uday                                ?         ||||
237700991217     C                   eval      p@fmes = umonth                              ?         ||||
237800991217     C                   eval      p@fa—o = uyear                               ?         ||||
237900991217?5b? C                   if        uyear > 90                                   ?P------05||||
238000991217     C                   add       1900          p@fa—o                         ?        |||||
238100991217?5x? C                   else                                                   ?X......05||||
238200991217     C                   add       2000          p@fa—o                         ?        |||||
238300991217?5e? C                   endif                                                  ?F------05||||
238400991217?4e? C                   endsl                                                  ?F-------04|||
238500991217     C                   eval      p@flap = *zeros                              ?          |||
238600991217     C                   eval      p@ffec = p@fdma                              ?          |||
238700991217     C                   call      'SPFECH'                                     ?          |||
238800991217     C                   parm                    p@fech                         ?          |||
238900991217     C                   add       t@cdia        p@flap                         ?          |||
239000991217     C                   eval      p@ffec = *zeros                              ?          |||
239100991217     C                   call      'SPFECH'                                     ?          |||
239200991217     C                   parm                    p@fech                         ?          |||
239300991217     C                   eval      p@fdma = p@ffec                              ?          |||
239400991217     C                   eval      d6fvra = p@fa—o                              ?          |||
239500991217     C                   eval      d6fvrm = p@fmes                              ?          |||
239600991217     C                   eval      d6fvrd = p@fdia                              ?          |||
239700991217     C                   write     p1hed6                                       ?          |||
239800991217?3e? C                   endif                                                  ?F--------03||
239900991217?2e? C                   enddo                                                  ?F---------02|
240000991217?1e? C                   endif                                                  ?F----------01
240100991217     ?*- ACTUALIZA MARCA EN PAWPD0...
240200000110     C     k1@pd0        chain     p1wpd0                             20
240300000110?1b? C                   if        not *in20                                    ?P----------01
240400000110     C                   eval      z0wp01 = 1                                   ?            |
240500000110     C                   eval      z0ncoc = d0ncoc                              ?            |
240600000110     C                   eval      z0ciap = d0ciap                              ?            |
240700000110?2b? C                   if        not *in20                                    ?P---------02|
240800000110?3b? C                   if        x1plac <> @2plac  or                         ?P--------03||
240900000110     C                             x1ncoc <> @2ncoc                             ?          |||
241000000110     C                   eval      z0wp06 = *zeros                              ?          |||
241100000110?3e? C                   endif                                                  ?F--------03||
241200000110?2e? C                   endif                                                  ?F---------02|
241300000110     C                   update    p1wpd0                                       ?            |
241400000110?1e? C                   endif                                                  ?F----------01
241500040416     ?*- Actualizar marca de paso para OpciÛn Ir A...
241600040416     C     k1@pd0        chain     pawp310
241700040416?1b? C                   if        %found(pawp310)                              ?P----------01
241800040419     C                   eval      @@in23 = *on                                 ?            |
241900040416     C                   eval      z0wp01lk = 1                                 ?            |
242000040416?2b? C                   if        x1plac <> @2plac  or                         ?P---------02|
242100040416     C                             x1ncoc <> @2ncoc                             ?           ||
242200040416     C                   eval      z0wp06lk = *zeros                            ?           ||
242300040416?2e? C                   endif                                                  ?F---------02|
242400040416     C                   update    p1wp310                                      ?            |
242500040416?1e? C                   endif                                                  ?F----------01
242600010314     ?*- GRABAR MENSAJE DE AUDITORIA...
242700010314     C                   exsr      gramsg
242800991217     ?*-
242900991217     C                   endsr
243000991217     ?*****************************************************
243100010312     C/SPACE
243200991217     ?*****************************************************
243300991217     C     apagar        begsr
243400991217     ?** APAGAR INDICADORES DE ERROR-----------------------
243500991217     C                   eval      @e = *zeros
243600010314     C                   setoff                                           36
243700010314     C                   setoff                                       373839
243800001128     C                   setoff                                       404142
243900991217     C                   setoff                                       434445
244000991217     C                   setoff                                       464748
244100991217     C                   setoff                                           49
244200991217     C                   setoff                                       505152
244300991217     C                   setoff                                       535455
244400991217     C                   setoff                                       565758
244500991217     C                   setoff                                       596061
244600991217     C                   setoff                                       626364
244700991217     C                   setoff                                       656667
244800991217     C                   setoff                                       686970
244900991217     C                   setoff                                       717273
245000991217     C                   setoff                                       747576
245100991217     C                   setoff                                       777879
245200991217     C                   setoff                                       808182
245300991217     C                   setoff                                       838485
245400991217     C                   setoff                                       898788
245500991217     C                   setoff                                           89
245600991217     ?*-
245700991217     C                   endsr
245800991217     ?*****************************************************
245900010312     C/SPACE
246000991217     ?*****************************************************
246100991217     C     apag01        begsr
246200991217     ?** APAGAR MENSAJES DE AVISO--------------------------
246300010314     C                   eval      @@in36 = *zeros
246400010314     C                   eval      @@in74 = *zeros
246500991217     C                   eval      @@in75 = *zeros
246600991217     C                   eval      @@in76 = *zeros
246700991217     C                   eval      @@in78 = *zeros
246800991217     C                   eval      @@in79 = *zeros
246900991217     C                   eval      @@in82 = *zeros
247000991217     ?*-
247100991217     C                   endsr
247200991217     ?*****************************************************
247300010312     C/SPACE
247400991217     ?*****************************************************
247500991217     C     ajvige        begsr
247600991217     ?** AJUSTE DE VIGENCIAS-------------------------------
247700010312     ?* vencimiento de la poliza no puede superar vencimien
247800010312     ?* to de la superpoliza..
247900991217     C                   eval      p@1a—o = c1fvoa
248000991217     C                   eval      p@1mes = c1fvom
248100991217     C                   eval      p@1dia = c1fvod
248200991217     C                   eval      @1hast = p@famd
248300991217     C                   eval      p@fdma = x1hast
248400991217     C                   eval      p@1a—o = p@fa—o
248500991217     C                   eval      p@1mes = p@fmes
248600991217     C                   eval      p@1dia = p@fdia
248700991217?1b? C                   if        p@famd > @1hast                              ?P----------01
248800991217     C                   eval      p@fa—o = c1fvoa                              ?            |
248900991217     C                   eval      p@fmes = c1fvom                              ?            |
249000991217     C                   eval      p@fdia = c1fvod                              ?            |
249100991217     C                   eval      x1hast = p@fdma                              ?            |
249200991217?1e? C                   endif                                                  ?F----------01
249300010312     ?* fecha hasta facturada no puede superar vencimiento
249400010312     ?* de la pÛliza...
249500991217     C                   eval      p@fdma = x1hast
249600991217     C                   eval      p@1a—o = p@fa—o
249700991217     C                   eval      p@1mes = p@fmes
249800991217     C                   eval      p@1dia = p@fdia
249900991217     C                   eval      @1hast = p@famd
250000991217     C                   eval      p@fdma = x1hafa
250100991217     C                   eval      p@1a—o = p@fa—o
250200991217     C                   eval      p@1mes = p@fmes
250300991217     C                   eval      p@1dia = p@fdia
250400991217?1b? C                   if        p@famd > @1hast                              ?P----------01
250500991217     C                   eval      x1hafa = x1hast                              ?            |
250600991217?1e? C                   endif                                                  ?F----------01
250700010312     ?* vencimiento de anualidad  no puede superar al
250800010312     ?* vencimiento de la pÛliza...
250900991217     C                   eval      p@fdma = x1hast
251000991217     C                   eval      p@1a—o = p@fa—o
251100991217     C                   eval      p@1mes = p@fmes
251200991217     C                   eval      p@1dia = p@fdia
251300991217     C                   eval      @1hast = p@famd
251400991217     C                   eval      p@fdma = x1anua
251500991217     C                   eval      p@1a—o = p@fa—o
251600991217     C                   eval      p@1mes = p@fmes
251700991217     C                   eval      p@1dia = p@fdia
251800991217?1b? C                   if        p@famd > @1hast                              ?P----------01
251900991217     C                   eval      x1anua = x1hast                              ?            |
252000991217?1e? C                   endif                                                  ?F----------01
252100991217     ?*-
252200991217     C                   endsr
252300991217     ?*****************************************************
252400010312     C/SPACE
252500991217     ?*****************************************************
252600991217     C     ajhafa        begsr
252700991217     ?** AJUSTAR VIGENCIA HASTA FACTURADA------------------
252800010312     ?* corrijo la fecha hasta facturada...
252900991217?1b? C                   if        @@ma07 = '1'  and                            ?P----------01
253000991217     C                             x1hafa <> @@hafa  and                        ?            |
253100991217     C                             x1hast = 99999999                            ?            |
253200991217     C                   eval      p@fdma = x1desd                              ?            |
253300991217     C                   eval      @@dia = p@fdia                               ?            |
253400991217     C                   eval      p@fdma = x1hafa                              ?            |
253500991217     C                   eval      @@dia1 = p@fdia                              ?            |
253600991217?2b? C                   select                                                 ?P---------02|
253700991217?2x? C                   when      @@dia <= 15  and                             ?w---------02|
253800991217     C                             @@dia1 <> 1                                  ?           ||
253900991217     C                   eval      p@fdia = 1                                   ?           ||
254000991217?2x? C                   when      @@dia > 15  and                              ?w---------02|
254100991217     C                             @@dia1 <> 1                                  ?           ||
254200991217     C                   eval      p@fdia = 1                                   ?           ||
254300991217     C                   add       1             p@fmes                         ?           ||
254400991217?3b? C                   if        p@fmes = 13                                  ?P--------03||
254500991217     C                   eval      p@fmes = 1                                   ?          |||
254600991217     C                   add       1             p@fa—o                         ?          |||
254700991217?3e? C                   endif                                                  ?F--------03||
254800991217?2e? C                   endsl                                                  ?F---------02|
254900991217     C                   eval      x1hafa = p@fdma                              ?            |
255000010312     ?* si las vigencias van de las 0 a las 24 horas debo            |          ?            |
255100010312     ?* restar un dÌa a la fecha calculada...                        |          ?            |
255200991217?2b? C                   if        c0mar3 = '1'                                 ?P---------02|
255300991217     C                   eval      p@fdma = x1hafa                              ?           ||
255400991217     C                   eval      @@fdia = p@fdia                              ?           ||
255500991217     C                   eval      @@fmes = p@fmes                              ?           ||
255600991217     C                   eval      @@fa—o = p@fa—o                              ?           ||
255700991217     C                   call      'SPFEDI'                                     ?           ||
255800991217     C                   parm                    @@fdia                         ?           ||
255900991217     C                   parm                    @@fmes                         ?           ||
256000991217     C                   parm                    @@fa—o                         ?           ||
256100991217     C                   parm      -1            @@days            5 0          ?           ||
256200991217     C                   eval      p@fdia = @@fdia                              ?           ||
256300991217     C                   eval      p@fmes = @@fmes                              ?           ||
256400991217     C                   eval      p@fa—o = @@fa—o                              ?           ||
256500991217     C                   eval      x1hafa = p@fdma                              ?           ||
256600991217?2e? C                   endif                                                  ?F---------02|
256700991217     C                   eval      @@hafa = x1hafa                              ?            |
256800991217?1e? C                   endif                                                  ?F----------01
256900991217     ?*-
257000991217     C                   endsr
257100991217     ?*****************************************************
257200010312     C/SPACE
257300991217     ?*****************************************************
257400991217     C     ajanua        begsr
257500991217     ?** AJUSTAR VIGENCIA HASTA ANUALIDAD------------------
257600991217?1b? C                   if        @@ma07 = '1'  and                            ?P----------01
257700991217     C                             x1anua <> @@anua  and                        ?            |
257800991217     C                             x1hast = 99999999                            ?            |
257900991217     C                   eval      p@fdma = x1desd                              ?            |
258000991217     C                   eval      @@dia = p@fdia                               ?            |
258100991217     C                   eval      p@fdma = x1anua                              ?            |
258200991217     C                   eval      @@dia1 = p@fdia                              ?            |
258300991217?2b? C                   select                                                 ?P---------02|
258400991217?2x? C                   when      @@dia <= 15  and                             ?w---------02|
258500991217     C                             @@dia1 <> 1                                  ?           ||
258600991217     C                   eval      p@fdia = 1                                   ?           ||
258700991217?2x? C                   when      @@dia > 15  and                              ?w---------02|
258800991217     C                             @@dia1 <> 1                                  ?           ||
258900991217     C                   eval      p@fdia = 1                                   ?           ||
259000991217     C                   add       1             p@fmes                         ?           ||
259100991217?3b? C                   if        p@fmes = 13                                  ?P--------03||
259200991217     C                   eval      p@fmes = 1                                   ?          |||
259300991217     C                   add       1             p@fa—o                         ?          |||
259400991217?3e? C                   endif                                                  ?F--------03||
259500991217?2e? C                   endsl                                                  ?F---------02|
259600991217     C                   eval      x1anua = p@fdma                              ?            |
259700010312     ?* si las vigencias van de las 0 a las 24 horas debo            |          ?            |
259800010312     ?* restar un dÌa a la fecha calculada...                        |          ?            |
259900991217?2b? C                   if        c0mar3 = '1'                                 ?P---------02|
260000991217     C                   eval      p@fdma = x1anua                              ?           ||
260100991217     C                   eval      @@fdia = p@fdia                              ?           ||
260200991217     C                   eval      @@fmes = p@fmes                              ?           ||
260300991217     C                   eval      @@fa—o = p@fa—o                              ?           ||
260400991217     C                   call      'SPFEDI'                                     ?           ||
260500991217     C                   parm                    @@fdia                         ?           ||
260600991217     C                   parm                    @@fmes                         ?           ||
260700991217     C                   parm                    @@fa—o                         ?           ||
260800991217     C                   parm      -1            @@days                         ?           ||
260900991217     C                   eval      p@fdia = @@fdia                              ?           ||
261000991217     C                   eval      p@fmes = @@fmes                              ?           ||
261100991217     C                   eval      p@fa—o = @@fa—o                              ?           ||
261200991217     C                   eval      x1anua = p@fdma                              ?           ||
261300991217?2e? C                   endif                                                  ?F---------02|
261400991217     C                   eval      @@anua = x1anua                              ?            |
261500991217?1e? C                   endif                                                  ?F----------01
261600991217     ?*-
261700991217     C                   endsr
261800010314     ?*****************************************************
261900010314     C/SPACE
262000010314     ?*****************************************************
262100010314     C     gramsg        begsr
262200010314     ?** GRABAR MENSAJE DE AUDITORIA-----------------------
262300010314     ?* borrar mensajes de este mismo programa...
262400010314     C                   eval      msempr = z0empr
262500010314     C                   eval      mssucu = z0sucu
262600010314     C                   eval      msarcd = z0arcd
262700010314     C                   eval      msspol = z0spol
262800010314     C                   eval      mssspo = z0sspo
262900010314     C                   eval      msrama = z0rama
263000010314     C                   eval      msarse = z0arse
263100010314     C                   eval      msoper = z0oper
263200010314     C                   eval      mssuop = z0suop
263300010314     C                   setoff                                           96
263400010314     C     k1@msg        setll     p1hmsg
263500010314?1b? C                   dou       *in96                                        ?P----------01
263600010314     C     k1@msg        reade     p1hmsg                                 96    ?            |
263700010314?2b? C                   if        not *in96  and                               ?P---------02|
263800010314     C                             mscpgm = $$c001                              ?           ||
263900010314     C                   delete    p1hmsg                                       ?           ||
264000010314?2e? C                   endif                                                  ?F---------02|
264100010314?1e? C                   enddo                                                  ?F----------01
264200010314     C                   unlock    pahmsg
264300010314     ?* revalidar diferencia en dÌas entre emisiÛn y vigenc
264400010314?1b? C                   if        z0tiou <= 2                                  ?P----------01
264500010314     C                   eval      p@fdma = x1desd                              ?            |
264600010314     C                   eval      $a—o1 = p@fa—o                               ?            |
264700010314     C                   eval      $mes1 = p@fmes                               ?            |
264800010314     C                   eval      $dia1 = p@fdia                               ?            |
264900010314     C                   eval      p@fdma = x1femi                              ?            |
265000010314     C                   eval      $a—o2 = p@fa—o                               ?            |
265100010314     C                   eval      $mes2 = p@fmes                               ?            |
265200010314     C                   eval      $dia2 = p@fdia                               ?            |
265300010314     C                   call      'SPDFEC'                                     ?            |
265400010314     C                   parm                    $dia1                          ?            |
265500010314     C                   parm                    $mes1                          ?            |
265600010314     C                   parm                    $a—o1                          ?            |
265700010314     C                   parm                    $dia2                          ?            |
265800010314     C                   parm                    $mes2                          ?            |
265900010314     C                   parm                    $a—o2                          ?            |
266000010314     C                   parm      *zeros        p@dife                         ?            |
266100010314?2b? C                   if        t@ldee <> *zeros  and                        ?P---------02|
266200010314     C                             p@dife > t@ldee                              ?           ||
266300010314     ?* campos de clave...                                          ||          ?           ||
266400010314     C                   eval      msempr = z0empr                              ?           ||
266500010314     C                   eval      mssucu = z0sucu                              ?           ||
266600010314     C                   eval      msarcd = z0arcd                              ?           ||
266700010314     C                   eval      msspol = z0spol                              ?           ||
266800010314     C                   eval      mssspo = z0sspo                              ?           ||
266900010314     C                   eval      msrama = z0rama                              ?           ||
267000010314     C                   eval      msarse = z0arse                              ?           ||
267100010314     C                   eval      msoper = z0oper                              ?           ||
267200010314     C                   eval      mssuop = z0suop                              ?           ||
267300010314     ?* buscar secuencia...                                         ||          ?           ||
267400010314     C     k1@msg        setgt     p1hmsg                                       ?           ||
267500010315     C     k1@msg        readpe(n) p1hmsg                                 96    ?           ||
267600010314     C  n96              add       1             msivse                         ?           ||
267700010314     C   96              eval      msivse = 1                                   ?           ||
267800010314     C                   eval      mssuse = *zeros                              ?           ||
267900010314     ?* restantes campos del archivo...                             ||          ?           ||
268000010314     C                   eval      mscpgm = *blanks                             ?           ||
268100010314     C                   eval      mscpgm = $$c001                              ?           ||
268200010314     ?* armar campo del mensaje...                                  ||          ?           ||
268300010314     C                   eval      mstxmg = *blanks                             ?           ||
268400010314     C                   movel     $$c002        mstxmg                         ?           ||
268500010314     ?* marcas de proceso...                                        ||          ?           ||
268600140603     C                   eval      msmarp = '1'                                 ?           ||
268700010314     ?* marca de si es suspendida o es poliza emitida...            ||          ?           ||
268800010314     C                   eval      msmar1 = '1'                                 ?           ||
268900010314     C                   eval      msmar2 = '0'                                 ?           ||
269000010314     C                   eval      msmar3 = '0'                                 ?           ||
269100010314     C                   eval      msmar4 = '0'                                 ?           ||
269200010314     C                   eval      msmar5 = '0'                                 ?           ||
269300010314     C                   eval      msstrg = '0'                                 ?           ||
269400010314     C                   eval      msuser = vsuser                              ?           ||
269500010314     C                   time                    mstime                         ?           ||
269600010314     C                   eval      msdate = udate                               ?           ||
269700010314     ?* grabar...                                                   ||          ?           ||
269800010314     C                   write     p1hmsg                               96      ?           ||
269900010314?2e? C                   endif                                                  ?F---------02|
270000010314?1e? C                   endif                                                  ?F----------01
270100010315     C                   unlock    pahmsg
270200010314     ?*-
270300010314     C                   endsr
270400991217     ?*****************************************************
270500010312     C/SPACE
270600991217     ?*****************************************************
270700991217     C     srclos        begsr
270800991217     ?** FINAL DE PROGRAMA---------------------------------
270900991230     C                   call      'DBA1201'
271000991230     C                   parm                    x1ncoc
271100991230     C                   parm                    x1noco
271200991230     C                   parm      'FIN'         finpgm
271300991217     ?*-
271400991217     C                   endsr
271500991217     ?*****************************************************
271600010312     C/SPACE
271700991217     ?*****************************************************
271800040419     Csr   reset_pan     begsr
271900040419     ?** RESETEA INDICADORES DE WINDOW
272000040419?1b? C                   if        *in50  and                                   ?P----------01
272100040419     C                             @e <> *zeros                                 ?            |
272200040419     C                             or                                           ?            |
272300040419     C                             not *in50 and @@in23                         ?            |
272400040419     C                   write     par31001                                     ?            |
272500040419     C                   eval      *in23 = @@in23                               ?            |
272600040419?2b? C                   if        *in50                                        ?P---------02|
272700040419     ?* Si hay errores.                                                         ?           ||
272800040419     C                   setoff                                           90    ?           ||
272900040419     C                   eval      *in(@e) = '1'                                ?           ||
273000040419?2e? C                   endif                                                  ?F---------02|
273100040419?1e? C                   endif                                                  ?F----------01
273200040419     ?*
273300040419     Csr                 endsr
273400050708     ?*****************************************************************
273500050708     ?* Procedure name: ok_cttorease                                  *
273600050708     ?* Purpose:        Controla si existe un ctto. para la fecha y   *
273700050708     ?*                 rama par·metros.                              *
273800050708     ?* Returns:        *ON: Hay Contrato Reaseguro. *OFF: No hay.    *
273900050708     ?* Parameter:      fecha_input => Fecha contra la que debemos ver*
274000050708     ?*                 si hay un contrato.                           *
274100050708     ?* Parameter:      rama_input => Rama para controlar si existe un*
274200050708     ?*                 contrato.                                     *
274300050708     ?*****************************************************************
274400050708     P ok_cttorease    b
274500050708     D ok_cttorease    pi                  like(*in50)
274600050708     D fecha_input                    8  0
274700050708     D rama_input                          like(d0rama)
274800050708
274900050708     ?* Local fields
275000050708     Dwk_fecha         ds                  inz
275100050708     D ds_fecha                1      8  0
275200050708     D ds_a—omes               1      6  0
275300050708     D  ds_a—o                 1      4  0
275400050708     D  ds_mes                 5      6  0
275500050708     D ds_dia                  7      8  0
275600050708
275700050708     Dwk_emi           ds                  inz
275800050708     D ds_a—omesemi            1      6  0
275900050708     D  ds_a—oemi              1      4  0
276000050708     D  ds_mesemi              5      6  0
276100050708
276200050708     D retfield        s                   like(*in50)
276300050708     ?*---------------------------------------------------------------*
276400050708     C     kset80405     klist
276500050708     C                   kfld                    usempr
276600050708     C                   kfld                    ussucu
276700050708     C                   kfld                    @@rama
276800050708     ?*---------------------------------------------------------------*
276900050708     ?* Por omisiÛn est· todo OK.
277000050708     C                   eval      retfield = *off
277100050708     C                   eval      ds_fecha = fecha_input
277200050708     ?* Vemos la fecha de emisiÛn para hoy.
277300050708     C                   call      'PAR310X3'
277400050708     C                   parm                    usempr
277500050708     C                   parm                    x@fema
277600050708     C                   parm                    x@femm
277700050708     C                   parm                    x@femd
277800050708
277900050708     C                   eval      ds_a—oemi = x@fema
278000050708     C                   eval      ds_mesemi = x@femm
278100050708     ?* Se valida siempre que el A—O/MES de Vigencia sea > A—O/MES
278200050708     ?* de EmisiÛn.
278300050708?1b? C                   if        ds_a—omes > ds_a—omesemi                     ?P----------01
278400050708     ?* Buscamos par·metros de la Rama.                                         ?            |
278500050708     C     @@rama        chain     set123                                       ?            |
278600050708?2b? C                   if        not %found                                   ?P---------02|
278700050708     C                   eval      t@more = 'NO'                                ?           ||
278800050708?2e? C                   endif                                                  ?F---------02|
278900050708     ?* Si tiene activo el mÛdulo de Reaseguros, vemos si hay un                ?            |
279000050708     ?* contrato.                                                               ?            |
279100050708?2b? C                   if        t@more = 'SI'                                ?P---------02|
279200050708     ?* Busqueda de Contrato...                                                 ?           ||
279300050708     C     kset80405     setll     set80405                                     ?           ||
279400050708     C     kset80405     reade     set80405                                     ?           ||
279500050708?3b? C                   dow       not %eof(set80405)                           ?P--------03||
279600050708     ?*Valido si el contrato est· vigente.                                      ?          |||
279700050708?4b? C                   if        t@ficf<=ds_fecha and t@fvcf>=ds_fecha        ?P-------04|||
279800050708     C                   eval      retfield = *on                               ?         ||||
279900050708?3v? C                   leave                                                  ?         ||||
280000050708?4e? C                   endif                                                  ?F-------04|||
280100050708     C     kset80405     reade     set80405                                     ?          |||
280200050708?3e? C                   enddo                                                  ?F--------03||
280300070105?2x? C                   else                                                   ?X.........02|
280400070105     C                   eval      retfield = *on                               ?           ||
280500050708?2e? C                   endif                                                  ?F---------02|
280600050708?1x? C                   else                                                   ?X..........01
280700050708     C                   eval      retfield = *on                               ?            |
280800050708?1e? C                   endif                                                  ?F----------01
280900050708
281000050708     C                   return    retfield
281100050708     P ok_cttorease    e
281200050708     ?*****************************************************************
