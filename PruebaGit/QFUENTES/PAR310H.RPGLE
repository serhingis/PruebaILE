000200130717     ?* ************************************************************ *
000300130717     ?*  PAR310H : Producción por artículos.                         *
000400130717     ?*            Textos a nivel de componente.                     *
000500130717     ?* ------------------------------------------------------------ *
000501130717     ?* Este programa es el viejo PAR314H. Le cambié el nombre para  *
000502130717     ?* que pueda ser invocado independientemente de la rama.        *
000503130717     ?* ------------------------------------------------------------ *
000600130717     ?*  Sergio Fernandez                 *17-Jul-2013               *
000601140520     ?* ------------------------------------------------------------ *
000602140520     ?*                    MODIFICACIONES                            *
000603140520     ?* SFA 20/05/14 - Determino si es rama autos                    *
000604140601     ?* SGF 02/06/14 - FPGM = 'DLT', borrar PAHEG2.                  *
000605140601     ?*                                                              *
000606130717     ?* ************************************************************ *
001000130716     Fpar310hm  cf   e             workstn usropn
001100130716     F                                     sfile(par310s1:sf1rrn)
001200000919     Fpaheg2    uf a e           k disk
001300000919     Fpawpd0    if   e           k disk
001400000919     Fpahed0    if   e           k disk
001500000919     Fpaheg202  if   e           k disk
001600960715     Fset124    if   e           k disk
001601140520     Fset001    if   e           k disk
001700890823     ?********************************************************************CSV100
001800931119      /SPACE
001900931119     ?********************************************************************CSV100
002000960723     D ast             s             75    dim(1) ctdata perrcd(1)              ASTERISCOS
002100980326     D wrk             s             75    dim(200)                             TRABAJO
002200980326     D txt             s             75    dim(200)                             PARAMETROS
002300980326     D $$1             s             75    dim(200)                             TRABAJO
002400980326     D $$2             s             75    dim(200)                             TRABAJO
002401130716     D @@arcd          s                   like(g2arcd)                         |
002402130716     D @@arse          s                   like(g2arse)                         |
002403130716     D @@empr          s                   like(g2empr)                         |
002404130716     D @@lsf1          s              9  0                                      |
002405130716     D @@oper          s                   like(g2oper)                         |
002406130716     D @@poco          s                   like(g2poco)                         |
002407130716     D @@rama          s                   like(g2rama)                         |
002408130716     D @@spol          s                   like(g2spol)                         |
002409130716     D @@spo1          s                   like(z0spo1)                         |
002410130716     D @@ssan          s                   like(g2sspo)                         |
002411130716     D @@sspo          s                   like(g2sspo)                         |
002412130716     D @@suan          s                   like(g2suop)                         |
002413130716     D @@sucu          s                   like(g2sucu)                         |
002414130716     D @@suop          s                   like(g2suop)                         |
002415130716     D q               s              9  0                                      |
002416130716     D sf1rrn          s              9  0                                      |
002417130716     D x               s              9  0                                      |::::::::::
002418130716     D y               s              9  0                                      |
002419140520     D es_autos        s               n                                        |
002500931119     ?********************************************************************CSV100
002600910313      /SPACE
002700910313     ?********************************************************************CSV100
002800910313     ?*- AREA DE DATOS DEL PROGRAMA...
002900900118     D                sds
003000900528     D  vsuser               254    263
003100910313     ?*- AREA LOCAL DE DATOS...
003200900321     D                uds
003300900528     D  usempr               401    401
003400900528     D  ussucu               402    403
003500900529     D  usbibl               404    413
003600960703     ?******************************************************           *********
003700910313      /SPACE
003800910313     ?******************************************************           *********
003900960703     ?*- AREA DE COMUNICACION...                           |
004000960703     C     *entry        plist                                                  |
004100000919     C                   parm                    @@empr                         ||
004200000919     C                   parm                    @@sucu                         ||
004300000919     C                   parm                    @@arcd                         ||
004400000919     C                   parm                    @@spo1                         ||
004500000919     C                   parm                    @@spol                         ||
004600000919     C                   parm                    @@sspo                         ||
004700000919     C                   parm                    @@rama                         ||
004800000919     C                   parm                    @@arse                         ||
004900000919     C                   parm                    @@oper                         ||
005000000919     C                   parm                    @@poco                         ||
005100000919     C                   parm                    @@suop                         ||
005200961218     C                   parm                    @@mand            2            ||
005300961218     C                   parm                    endpgm            3            ||
005400960703     ?*----------------------------------------------------|           *********
005500960715?1b? C                   select                                                 |           ********
005600961218?1x? C                   when      endpgm = *blanks                             ||
005700130716     C                   open      par310hm                                     ||
005800961218     C                   exsr      inicio                                       ||
005900961218?2b? C                   dou       *inkc                                        ||:::::::::
006000961218     C                   exsr      pant01                                       ||        :
006100961218?2e? C                   enddo                                                  ||:::::::::
006200130716     C                   close     par310hm                                     ||
006300961218     C                   return                                                 ||
006301140601?1x? C                   when      endpgm = 'DLT'                               ||
006302140601     C     k1heg2        setll     paheg2
006303140601     C     k1heg2        reade     paheg2
006304140601     C                   dow       not %eof
006305140601     C                   delete    p1heg2
006306140601     C     k1heg2        reade     paheg2
006307140601     C                   enddo
006308140601     C                   return
006400961218?1x? C                   when      endpgm = 'FIN'                               ||
006500960715     C                   seton                                        lr        ||
006600960715?1e? C                   endsl                                                  ||
006700910313     ?******************************************************           *********
006800910313      /SPACE
006900910313     ?******************************************************           *********
007000900528     C     pant01        begsr                                                  |
007100910611     ?*- ENTRADA/SALIDA PANTALLA 01...                     |
007200130716     C                   exfmt     par310c1                                     |
007300910611     ?*- PROCESO DE TECLAS DE FUNCION...                   |
007400950301?1b? C                   select                                                 |
007500950301     ?*- F3=SALIR DEL PROGRAMA...                          |
007600950301?1x? C                   when      *inkc                                        |
007700961218     C                   eval      @@mand = 'KC'                                |
007800950301     ?*- F6=INSERTAR...                                    |
007900950301?1x? C                   when      *inkf                                        |
008000950301     C                   exsr      inse01                                       |
008100950301     ?*- F7=SEPARAR PARRAFO...                             |
008200950301?1x? C                   when      *inkg                                        |
008300950301     C                   exsr      sepa01                                       |
008400950301     ?*- F8=ELIMINAR BLANCOS...                            |
008500950301?1x? C                   when      *inkh                                        |
008600950301     C                   exsr      elim01                                       |
008700950301     ?*- F9=ELIMINAR REGISTRO                              |
008800950301?1x? C                   when      *inki                                        |
008900950301     C                   exsr      dele01                                       |
009000950301     ?*- F10=TRAER REGISTROS DE TEXTOS PRESETEADOS...      |
009100950301?1x? C                   when      *inkj                                        |
009200950301     C                   exsr      sele01                                       |
009300961218     ?*- F12=RETORNAR...                                   |
009400961218?1x? C                   when      *inkl                                        |
009500961218     C                   eval      *inkc = '1'                                  |
009600961218     C                   eval      @@mand = 'KL'                                |
009700950301     ?*- F23=BORRAR SUBARCHIVO...                          |
009800950301?1x? C                   when      *inkx                                        |
009900950301     C                   exsr      sf1car                                       |
010000950301     ?*- F24=AYUDA...                                      |
010100950301?1x? C                   when      *inky                                        |
010200950301     ?*- PULSO INTRO...                                    |
010300961218?1x? C                   when      not *in29                                    |
010400961218     C                   exsr      vali01                                       |
010500950301?1e? C                   endsl                                                  |
010600950301     ?*-                                                   |
010700890822     C                   endsr                                                  |
010800961218     ?******************************************************
010900961218      /SPACE
011000961218     ?******************************************************
011100961218     C     vali01        begsr                                                  |
011200961218     ?*- GRABACION SI NO HAY MODIFICACIONES----------------|
011300961218?1b? C                   do        @@lsf1        q                              |
011400130716     C     q             chain     par310s1                           20        |
011500961218?2b? C                   if        not *in20                                    |
011600961218     C                   movel     x1retx        $$1(q)                         |
011700961218?2e? C                   endif                                                  |
011800961218?1e? C                   enddo                                                  |
011900961218     ?*- GRABACION...                                      |
012000961218?1b? C                   do        @@lsf1        q                              |:::::
012100961218?2b? C                   if        $$1(q) <> $$2(q)                             ||   :
012200961218?1v? C                   leave                                                  ||   :
012300961218?2e? C                   endif                                                  ||   :
012400961218?1e? C                   enddo                                                  |:::::
012500961218     ?*-                                                   |
012600961218     C     @@lsf1        add       1             x                              |
012700961218?1b? C                   if        q = x  and                                   ||
012800961218     C                             *in90                                        ||
012900961218     C                   exsr      grab01                                       ||
013000961218     C                   eval      @@mand = 'KA'                                ||
013100961218     C                   eval      *inkc = '1'                                  ||
013200961218     C                   setoff                                       90        ||
013300961218?1x? C                   else                                                   |/
013400961218     C                   eval      $$2 = $$1                                    ||
013500961218     C                   seton                                        90        ||
013600961218?1e? C                   endif                                                  ||
013700961218     ?*-                                                   |
013800961218     C                   endsr                                                  |
013900931119     ?******************************************************
014000931119      /SPACE
014100931119     ?******************************************************
014200960703     C     grab01        begsr                                                  |
014300961218     ?*- GRABACION-----------------------------------------|
014400000919     ?*- BORRAR TODO EL ARCHIVO PAHEG2...                  |
014500960715     C                   exsr      del001                                       |
014600960715     ?*- AHORA GRABAR DE ATRAS HACIA ADELANTE...           |
014700960715     ?*- BUSCAR EL ULTIMO OCUPADO...                       |
014800960715     C                   eval      sf1rrn = @@lsf1                              |
014900960715     C                   add       1             sf1rrn                         |
015000960715?1b? C                   dou       x1retx <> *blanks  or                        |::::::
015100960715     C                             sf1rrn = 0                                   |:    :
015200960715     C                   eval      sf1rrn = sf1rrn - 1                          |     :
015300130716     C     sf1rrn        chain     par310s1                           20        |     :
015400960715?1e? C                   enddo                                                  |::::::
015500960715     ?*- AHORA GRABAR...                                   |
015600960715     ?*- CAMPOS GENERALES...                               |
015700000919     C                   eval      g2empr = @@empr                              |
015800000919     C                   eval      g2sucu = @@sucu                              |
015900000919     C                   eval      g2arcd = @@arcd                              |
016000000919     C                   eval      g2spol = @@spol                              |
016100000919     C                   eval      g2sspo = @@sspo                              |
016200000919     C                   eval      g2rama = @@rama                              |
016300000919     C                   eval      g2arse = @@arse                              |
016400000919     C                   eval      g2oper = @@oper                              |
016500000919     C                   eval      g2suop = @@suop                              |
016600000919     C                   eval      g2poco = @@poco                              |
016700960715     ?*- CAMPOS VARIABLES...                               |
016800960715     C                   eval      x = sf1rrn                                   |
016900960715?1b? C                   do        x             sf1rrn                         |::::::
017000130716     C     sf1rrn        chain     par310s1                           20        |     :
017100960715?2b? C                   if        not *in20                                    ||    :
017200000919     C                   z-add     sf1rrn        g2nrre                         ||    :
017300000919     C                   movel     x1retx        g2retx                         ||    :
017400000919     C                   eval      g2cert = *zeros                              ||    :
017500000919     C                   eval      g2poli = *zeros                              ||    :
017600000919     C                   eval      g2marp = '0'                                 ||    :
017700000919     C                   eval      g2strg = '0'                                 ||    :
017800000919     C                   eval      g2user = vsuser                              ||    :
017900000919     C                   time                    g2time                         ||    :
018000000919     C                   eval      g2date = udate                               ||    :
018100000919     C                   write     p1heg2                                       ||    :
018200960715?2e? C                   endif                                                  ||    :
018300960715?1e? C                   enddo                                                  |::::::
018400931119     ?*-                                                   |
018500931119     C                   endsr                                                  |
018600950301     ?******************************************************
018700950301      /SPACE
018800950301     ?******************************************************
018900950301     C     dele01        begsr                                                  |
019000950301     ?*- DELETEAR UN SOLO REGISTRO-------------------------|
019100950301     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...      |
019200950301     C                   eval      x = *zeros                                   |
019300950301     C                   eval      y = *zeros                                   |
019400950301     C                   eval      wrk = *blanks                                |
019500950301     ?*- PASAR A SERIE DE TRABAJO...                       |
019600950301?1b? C                   do        @@lsf1        x                              |::::::::::
019700130716     C     x             chain     par310s1                           20        |         :
019800950301?2b? C                   if        not *in20  and                               ||        :
019900950301     C                             x <> cursor                                  ||        :
020000950301     C                   add       1             y                              ||        :
020100950301     C                   movel     x1retx        wrk(y)                         ||        :
020200950301?2e? C                   endif                                                  ||        :
020300950301?1e? C                   enddo                                                  |::::::::::
020400950301     ?*- LUEGO RECARGA EL SUBARCHIVO...                    |
020500950301     C                   exsr      sf1bor                                       |
020600950301?1b? C                   do        @@lsf1        x                              |::::::::::
020700950301     C                   eval      sf1rrn = x                                   |         :
020800950301     C                   movel     wrk(x)        x1retx                         |         :
020900130716     C                   write     par310s1                                     |         :
021000950301?1e? C                   enddo                                                  |::::::::::
021100950301     ?*- INDICADORES DE SUBARCHIVO...                      |
021200950301?1b? C                   if        sf1rrn <> *zeros                             ||
021300950301     C                   seton                                          3031    ||
021400950301?1x? C                   else                                                   |/
021500950301     C                   seton                                            31    ||
021600950301?1e? C                   endif                                                  ||
021700950301     ?*-                                                   |
021800950301     C                   endsr                                                  |
021900950301     ?******************************************************
022000950301      /SPACE
022100950301     ?******************************************************
022200950301     C     sele01        begsr                                                  |
022300950301     ?*- SELECCIONAR TEXTOS PRESETEADOS--------------------|
022400950301     C                   clear                   x1tpcd                         |
022500130716     C                   exfmt     par31001                                     |
022600950301     ?*- SI EL CÓDIGO ES VALIDO TRATAR DE CARGAR....       |
022700950301     C                   exsr      sf1ca1                                       |
022800950301     ?*-                                                   |
022900950301     C                   endsr                                                  |
023000950301     ?******************************************************
023100950301      /SPACE
023200950301     ?******************************************************
023300950301     C     sf1ca1        begsr                                                  |
023400950301     ?*- CARGAR SUBARCHIVO DESDE TEXTOS PRESETEADOS--------|
023500950301     ?*- VER ULTIMO RENGLON OCUPADO...                     |
023600950301     C     @@lsf1        add       1             y                              |
023700950301?1b? C                   do        y             x                              |::::::::::
023800950301     C                   eval      sf1rrn = y - x                               |         :
023900130716     C     sf1rrn        chain     par310s1                           20        |         :
024000950301?2b? C                   if        not *in20                                    ||        :
024100950301?3b? C                   if        x1retx <> *blanks                            |||       :
024200950301?1v? C                   leave                                                  |||       :
024300950301?3e? C                   endif                                                  |||       :
024400950301?2e? C                   endif                                                  ||        :
024500950301?1e? C                   enddo                                                  |::::::::::
024600950301     ?*- CARGAR DESDE TEXTOS PRESETEADOS...                |
024700950301     C                   setoff                                           99    |
024800000919     C     k1t124        setll     s1t124                                       |
024900950301?1b? C                   dou       *in99  or                                    |::::::::::
025000950301     C                             sf1rrn = @@lsf1                              |         :
025100000919     C     k1t124        reade     s1t124                                 99    |         :
025200950301?2b? C                   if        not *in99                                    ||        :
025300950301     ?*- CARGAR SUBARCHIVO...                              ||        :
025400950301     C                   add       1             sf1rrn                         ||        :
025500130716     C     sf1rrn        chain     par310s1                           20        ||        :
025600950301?3b? C                   if        not *in20                                    |||       :
025700950301     C                   movel     t@tpds        x1retx                         |||       :
025800130716     C                   update    par310s1                                     |||       :
025900950301?3e? C                   endif                                                  |||       :
026000950301?2e? C                   endif                                                  ||        :
026100950301?1e? C                   enddo                                                  |::::::::::
026200950301     ?*-                                                   |
026300950301     C                   endsr                                                  |
026400931119     ?******************************************************
026500931119      /SPACE
026600931119     ?******************************************************
026700931119     C     sepa01        begsr                                                  |
026800931119     ?*- COLOCA SEPARADOR DE PARRAFOS----------------------|
026900931119     ?*- DETERMINAR PRIMER REGISTRO OCUPADO...             |
027000931119     C     @@lsf1        add       1             y                              |
027100950301?1b? C                   do        y             x                              |::::::::::
027200931119     C                   eval      sf1rrn = y - x                               |         :
027300130716     C     sf1rrn        chain     par310s1                           20        |         :
027400931119?2b? C                   if        not *in20                                    ||        :
027500931119?3b? C                   if        x1retx <> *blanks                            |||       :
027600931119?1v? C                   leave                                                  |||       :
027700931119?3e? C                   endif                                                  |||       :
027800931119?2e? C                   endif                                                  ||        :
027900931119?1e? C                   enddo                                                  |::::::::::
028000931119     ?*- COLOCA EL SEPARADOR...                            |
028100950301?1b? C                   if        sf1rrn < @@lsf1                              ||
028200931119     C                   add       1             sf1rrn                         ||
028300130716     C     sf1rrn        chain     par310s1                           20        ||
028400931119     C  n20              movel     ast(1)        x1retx                         ||
028500130716     C  n20              update    par310s1                                     ||
028600931119?1e? C                   endif                                                  ||
028700931119     ?*-                                                   |
028800931119     C                   endsr                                                  |
028900931119     ?******************************************************
029000931119      /SPACE
029100931119     ?******************************************************
029200931119     C     elim01        begsr                                                  |
029300931119     ?*- ELIMINA REGISTROS EN BLANCO-----------------------|
029400931119     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...      |
029500931119     C                   eval      x = *zeros                                   |
029600931119     C                   eval      y = *zeros                                   |
029700931119     C                   eval      wrk = *blanks                                |
029800931119?1b? C                   do        @@lsf1        x                              |::::::::::
029900130716     C     x             chain     par310s1                           20        |         :
030000931119?2b? C                   if        not *in20  and                               ||        :
030100931119     C                             x1retx <> *blanks                            ||        :
030200931119     C                   add       1             y                              ||        :
030300931119     C                   movel     x1retx        wrk(y)                         ||        :
030400931119?2e? C                   endif                                                  ||        :
030500931119?1e? C                   enddo                                                  |::::::::::
030600931119     ?*- LUEGO RECARGA EL SUBARCHIVO...                    |
030700950301     C                   exsr      sf1bor                                       |
030800931119?1b? C                   do        @@lsf1        x                              |::::::::::
030900931119     C                   eval      sf1rrn = x                                   |         :
031000931119     C                   movel     wrk(x)        x1retx                         |         :
031100130716     C                   write     par310s1                                     |         :
031200931119?1e? C                   enddo                                                  |::::::::::
031300931119     ?*- INDICADORES DE SUBARCHIVO...                      |
031400931119?1b? C                   if        sf1rrn <> *zeros                             ||
031500931119     C                   seton                                          3031    ||
031600931119?1x? C                   else                                                   |/
031700931119     C                   seton                                            31    ||
031800931119?1e? C                   endif                                                  ||
031900931119     ?*-                                                   |
032000931119     C                   endsr                                                  |
032100931119     ?******************************************************
032200931119      /SPACE
032300931119     ?******************************************************
032400931119     C     inse01        begsr                                                  |
032500931119     ?*- INSERTAR REGISTROS EN BLANCO----------------------|
032600931119     ?*- PASAR LOS REGISTROS A LA SERIE DE TRABAJO...      |
032700931119     C                   eval      x = *zeros                                   |
032800931119     C                   eval      y = *zeros                                   |
032900931119     C                   eval      wrk = *blanks                                |
033000931119?1b? C                   do        @@lsf1        x                              |::::::::::
033100130716     C     x             chain     par310s1                           20        |         :
033200931119?2b? C                   if        not *in20                                    ||        :
033300931119     C                   add       1             y                              ||        :
033400931119     C                   movel     x1retx        wrk(y)                         ||        :
033500931119?2e? C                   endif                                                  ||        :
033600931119?1e? C                   enddo                                                  |::::::::::
033700931119     ?*- DETERMINAR PRIMER REGISTRO OCUPADO...             |
033800931119     C     @@lsf1        add       1             y                              |
033900931119?1b? C                   do        y             x                              |::::::::::
034000931119     C                   eval      sf1rrn = y - x                               |         :
034100130716     C     sf1rrn        chain     par310s1                           20        |         :
034200931119?2b? C                   if        not *in20                                    ||        :
034300931119?3b? C                   if        x1retx <> *blanks                            |||       :
034400931119?1v? C                   leave                                                  |||       :
034500931119?3e? C                   endif                                                  |||       :
034600931119?2e? C                   endif                                                  ||        :
034700931119?1e? C                   enddo                                                  |::::::::::
034800931119     ?*- VER SI HAY ESPACIO PARA INSERTAR...               |
034900950301?1b? C                   if        sf1rrn < @@lsf1                              ||
035000931119     ?*- LUEGO RECARGA EL SUBARCHIVO...                    ||
035100931119     C                   eval      x = *zeros                                   ||
035200931119     C                   eval      y = *zeros                                   ||
035300950301     C                   exsr      sf1bor                                       ||
035400931119?2b? C                   do        @@lsf1        sf1rrn                         ||:::::::::
035500931119?3b? C                   if        sf1rrn = cursor                              |||       :
035600931119     C                   eval      x1retx = *blanks                             |||       :
035700931119?3x? C                   else                                                   ||/       :
035800931119     C                   add       1             x                              |||       :
035900931119     C                   movel     wrk(x)        x1retx                         |||       :
036000931119?3e? C                   endif                                                  |||       :
036100130716     C                   write     par310s1                                     ||        :
036200931119?2e? C                   enddo                                                  ||:::::::::
036300931119     ?*- INDICADORES DE SUBARCHIVO...                      ||
036400931119?2b? C                   if        sf1rrn <> *zeros                             |||
036500931119     C                   seton                                          3031    |||
036600931119?2x? C                   else                                                   ||/
036700931119     C                   seton                                            31    |||
036800931119?2e? C                   endif                                                  |||
036900931119?1e? C                   endif                                                  ||
037000931119     ?*-                                                   |
037100931119     C                   endsr                                                  |
037200960703     ?******************************************************
037300960703      /SPACE
037400960703     ?******************************************************
037500960715     C     sf1bor        begsr                                                  |
037600960703     ?*- BORRA EL CONTENIDO DEL SUBFILE...                 |
037700960703     C                   seton                                        32        |
037800130716     C                   write     par310c1                                     |
037900960703     C                   setoff                                       32        |
038000960703     ?*-                                                   |
038100960703     C                   endsr                                                  |
038200960703     ?******************************************************
038300960703      /SPACE
038400960703     ?******************************************************
038500960715     C     sf1car        begsr                                                  |
038600960703     ?*- CARGAR DEL SUBARCHIVO-----------------------------|
038700960703     ?*- PRIMERO BORRAR...                                 |
038800960715     C                   exsr      sf1bor                                       |
038900960703     ?*- AHORA CARGAR...                                   |
039000960703     ?*- INDICADORES DE SUBARCHIVO...                      |
039100960703     C                   setoff                                         3031    |
039200961220     C                   setoff                                           99    |
039300960703     C                   eval      sf1rrn = *zeros                              |
039400000919     C     k1heg2        setll     p1heg2                                       |
039500960715?1b? C                   dou       *in99                                        |::::::::::
039600000919     C     k1heg2        reade(n)  p1heg2                                 99    |         :
039700960715?2b? C                   if        not *in99                                    ||        :
039800960715     C                   add       1             sf1rrn                         ||        :
039900000919     C                   movel     g2retx        x1retx                         ||        :
040000130716     C                   write     par310s1                                     ||        :
040100960715?2e? C                   endif                                                  ||        :
040200960715?1e? C                   enddo                                                  |::::::::::
040300000919     C                   unlock    paheg2                                       |
040400960715     ?*- CARGAR EL RESTO HASTA ULTIMO REGISTRO...          |
040500960715     C                   eval      x = @@lsf1 - sf1rrn                          |
040600960715?1b? C                   do        x                                            |::::::::::
040700960715     C                   add       1             sf1rrn                         |         :
040800960715     C                   eval      x1retx = *blanks                             |         :
040900130716     C                   write     par310s1                                     |         :
041000960715?1e? C                   enddo                                                  |::::::::::
041100960703     ?*- CARGA DEL SUBARCHIVO...                           |
041200960703     ?*- INDICADORES DE SUBARCHIVO...                      |
041300960703?1b? C                   if        sf1rrn <> *zeros                             ||
041400960703     C                   seton                                          3031    ||
041500960703?1x? C                   else                                                   |/
041600960703     C                   seton                                            31    ||
041700960703?1e? C                   endif                                                  ||
041800960703     ?*-                                                   |
041900960703     C                   endsr                                                  |
042000960715     ?******************************************************
042100960715      /SPACE
042200960715     ?******************************************************
042300960715     C     sf2car        begsr                                                  |
042400960715     ?*- CARGAR DEL SUBARCHIVO-----------------------------|
042500960715     ?*- PRIMERO BORRAR...                                 |
042600960715     C                   exsr      sf1bor                                       |
042700960715     ?*- AHORA CARGAR...                                   |
042800960715     ?*- INDICADORES DE SUBARCHIVO...                      |
042900960715     C                   setoff                                         3031    |
043000961220     C                   setoff                                           99    |
043100960715     C                   eval      sf1rrn = *zeros                              |
043200000919     C     k2heg2        setll     p1heg2                                       |
043300960715?1b? C                   dou       *in99                                        |::::::::::
043400000919     C     k2heg2        reade(n)  p1heg2                                 99    |         :
043500960715?2b? C                   if        not *in99                                    ||        :
043600960715     C                   add       1             sf1rrn                         ||        :
043700000919     C                   movel     g2retx        x1retx                         ||        :
043800130716     C                   write     par310s1                                     ||        :
043900960715?2e? C                   endif                                                  ||        :
044000960715?1e? C                   enddo                                                  |::::::::::
044100000919     C                   unlock    paheg2                                       |
044200960715     ?*- CARGAR EL RESTO HASTA ULTIMO REGISTRO...          |
044300960715     C                   eval      x = @@lsf1 - sf1rrn                          |
044400960715?1b? C                   do        x                                            |::::::::::
044500960715     C                   add       1             sf1rrn                         |         :
044600960715     C                   eval      x1retx = *blanks                             |         :
044700130716     C                   write     par310s1                                     |         :
044800960715?1e? C                   enddo                                                  |::::::::::
044900960715     ?*- CARGA DEL SUBARCHIVO...                           |
045000960715     ?*- INDICADORES DE SUBARCHIVO...                      |
045100960715?1b? C                   if        sf1rrn <> *zeros                             ||
045200960715     C                   seton                                          3031    ||
045300960715?1x? C                   else                                                   |/
045400960715     C                   seton                                            31    ||
045500960715?1e? C                   endif                                                  ||
045600960715     ?*-                                                   |
045700960715     C                   endsr                                                  |
045800960715     ?******************************************************           *********
045900960715      /SPACE
046000960715     ?******************************************************
046100961218     C     carg01        begsr                                                  |
046200960715     ?*- CARGAR SUBARCHIVO PRIMERA ENTRADA-----------------|
046300000919     ?*- VERIFICA SI TIENE DATOS PREVIOS...                |
046400000919     C     k1heg2        chain(n)  p1heg2                             20        |
046500000919?1b? C                   if        not *in20                                    ||
046600000919     C                   exsr      sf1car                                       ||
046700000919     ?*- ANALIZA FORMAS DE CARGAR SUBARCHIVO...            ||
046800000919?1x? C                   else                                                   |/
046900000919     C     k1wpd0        chain     p1wpd0                             20        ||
047000000919?2b? C                   select                                                 |||
047100000919?2x? C                   when      z0tiou = 1                                   |||
047200000919     C                   exsr      defe01                                       |||
047300000919?2x? C                   when      z0tiou = 2                                   ||+
047400000919     C                   exsr      defe02                                       |||
047500000919?2x? C                   when      z0tiou = 3  and                              ||+
047600000919     C                             z0stos <> 08                                 |||
047700000919     C                   exsr      defe03                                       |||
047800000919?2x? C                   when      z0tiou = 3  and                              ||+
047900000919     C                             z0stos = 08                                  |||
048000000919     C                   exsr      defe38                                       |||
048100000919?2x? C                   when      z0tiou = 5                                   ||+
048200000919     C                   exsr      defe05                                       |||
048300000919?2e? C                   endsl                                                  |||
048400000919?1e? C                   endif                                                  ||
048500960715     ?*-                                                   |
048600960715     C                   endsr                                                  |
048700961218     ?******************************************************           *********
048800961218      /SPACE
048900961218     ?******************************************************
049000961218     C     defe01        begsr                                                  |
049100961218     ?*- CARGA POR DEFECTO EN OPERACIONES NUEVAS-----------|
049200961218     ?* se inicializa el subarchivo sin registros...       |
049300961218     C                   exsr      sf1car                                       |
049400961218     ?*-                                                   |
049500961218     C                   endsr                                                  |
049600961218     ?******************************************************           *********
049700961218      /SPACE
049800961218     ?******************************************************
049900961218     C     defe02        begsr                                                  |
050000961218     ?*- CARGA POR DEFECTO EN RENOVACIONES-----------------|
050100000919     ?* se inicializa el subarchivo sin registros...       |
050200000919     C                   exsr      sf1car                                       |
050300970110     ?*-                                                   |
050400961218     C                   endsr                                                  |
050500961218     ?******************************************************           *********
050600961218      /SPACE
050700961218     ?******************************************************
050800961218     C     defe03        begsr                                                  |
050900961218     ?*- CARGA POR DEFECTO EN ENDOSOS----------------------|
051000970602     ?* cargar del ultimo endoso que no sea una anulacion  |
051100970602     ?* o un endoso de anulacion de endoso...              |
051200000919     C                   clear                   *in99                          |
051300000919     C     k3heg2        setgt     p1heg202                                     |
051400000919?1b? C                   dow       not *in99                                    |::::::
051500000919     C     k3heg2        readpe    p1heg202                               99    |     :
051600000919?2b? C                   if        not *in99  and                               ||    :
051700000919     C                             g2sspo <> @@sspo                             ||    :
051800000919     C     k1hed0        chain     p1hed0                             99        ||    :
051900000919?3b? C                   if        not *in99                                    |||   :
052000000919?4b? C                   if        d0tiou = 1  or                               ||||  :
052100000919     C                             d0tiou = 2  or                               ||||  :
052200000919     C                             d0tiou = 5  or                               ||||  :
052300000919     C                             d0tiou = 3  and                              ||||  :
052400000919     C                             d0stos <> 09  and                            ||||  :
052500000919     C                             d0stos <> 08                                 ||||  :
052600000919?1v? C                   leave                                                  ||||  :
052700000919?4e? C                   endif                                                  ||||  :
052800970602?3e? C                   endif                                                  |||   :
052900970602?2e? C                   endif                                                  ||    :
053000970602?1e? C                   enddo                                                  |::::::
053100000919     C                   eval      @@ssan = g2sspo                              |
053200000919     C                   eval      @@suan = g2suop                              |
053201140520     C                   if        es_autos
053202140520     C                   exsr      sf1car                                       |
053203140520     C                   else
053300961218     C                   exsr      sf2car                                       |
053301140520     C                   endif
053400961218     ?*-                                                   |
053500961218     C                   endsr                                                  |
053600970703     ?******************************************************           *********
053700970703      /SPACE
053800970703     ?******************************************************
053900970703     C     defe05        begsr                                                  |
054000970703     ?*- CARGA POR DEFECTO EN REHABILITACION---------------|
054100970703     C                   exsr      defe03                                       |
054200970703     ?*-                                                   |
054300970703     C                   endsr                                                  |
054400971104     ?******************************************************           *********
054500971104      /SPACE
054600971104     ?******************************************************
054700971104     C     defe38        begsr                                                  |
054800971104     ?*- CARGA POR DEFECTO ENDOSO AJUSTE PERIODO-----------|
054900971104     ?* se inicializa el subarchivo sin registros...       |
055000971104     C                   exsr      sf1car                                       |
055100971104     ?*-                                                   |
055200971104     C                   endsr                                                  |
055300960715     ?******************************************************           *********
055400960715      /SPACE
055500960715     ?******************************************************
055600960715     C     del001        begsr                                                  |
055700960715     ?*- BORRAR TEXTOS ANTERIORES--------------------------|
055800960715     C                   setoff                                           98    |
055900000919     C     k1heg2        setll     p1heg2                                       |
056000960715?1b? C                   dou       *in98                                        |:::::::
056100000919     C     k1heg2        reade     p1heg2                                 98    |      :
056200960715?2b? C                   if        not *in98                                    ||     :
056300000919     C                   delete    p1heg2                                       ||     :
056400960715?2e? C                   endif                                                  ||     :
056500960715?1e? C                   enddo                                                  |:::::::
056600000919     C                   unlock    paheg2                                       |
056700960715     ?*-                                                   |
056800960715     C                   endsr                                                  |
056900910315     ?******************************************************           *********
057000910313      /SPACE
057100890822     ?******************************************************
057200961218     C     inicio        begsr                                                  |
057300950301     ?*- INICIO DE PROGRAMA Y DEFINICIONES-----------------|
057400920430     C                   eval      sf1rrn = *zeros                              |
057500000919     C                   eval      @@lsf1 = 200                                 |
057600950301     C                   eval      x = *zeros                                   |
057700950301     C                   eval      y = *zeros                                   |
057800961218     C                   eval      q = *zeros                                   |
059200961218     ?*- APAGAR TODOS LOS INDICADORES...                   |
059300961218     C                   eval      x = *zeros                                   |
059400961218?1b? C                   dou       x = 99                                       |:::
059500961218     C                   add       1             x                              |  :
059600961218     C                   eval      *in(x) = '0'                                 |  :
059700961218?1e? C                   enddo                                                  |:::
059800961218     ?*- DEFINICIONES DE CLAVES...                         |
059900000919     C     k1t124        klist                                                  |
060000950301     C                   kfld                    @@rama                         |
060100950301     C                   kfld                    x1tpcd                         |
060200961218     ?*- PAWPD0...                                         |
060300000919     C     k1wpd0        klist                                                  |
060400961218     C                   kfld                    @@empr                         |
060500961218     C                   kfld                    @@sucu                         |
060600961218     C                   kfld                    @@arcd                         |
060700961218     C                   kfld                    @@spo1                         |
060800961218     C                   kfld                    @@spol                         |
060900961218     C                   kfld                    @@sspo                         |
061000961218     C                   kfld                    @@rama                         |
061100961218     C                   kfld                    @@arse                         |
061200961218     C                   kfld                    @@oper                         |
061300961218     C                   kfld                    @@suop                         |
061400000919     ?*- PAHEG2...                                         |
061500000919     C     k1heg2        klist                                                  |
061600000919     C                   kfld                    @@empr                         |
061700000919     C                   kfld                    @@sucu                         |
061800000919     C                   kfld                    @@arcd                         |
061900000919     C                   kfld                    @@spol                         |
062000000919     C                   kfld                    @@sspo                         |
062100000919     C                   kfld                    @@rama                         |
062200000919     C                   kfld                    @@arse                         |
062300000919     C                   kfld                    @@oper                         |
062400000919     C                   kfld                    @@poco                         |
062500000919     C                   kfld                    @@suop                         |
062600000919     C     k2heg2        klist                                                  |
062700000919     C                   kfld                    @@empr                         |
062800000919     C                   kfld                    @@sucu                         |
062900000919     C                   kfld                    @@arcd                         |
063000000919     C                   kfld                    @@spol                         |
063100000919     C                   kfld                    @@ssan                         |
063200000919     C                   kfld                    @@rama                         |
063300000919     C                   kfld                    @@arse                         |
063400000919     C                   kfld                    @@oper                         |
063500000919     C                   kfld                    @@poco                         |
063600000919     C                   kfld                    @@suan                         |
063700000919     C     k3heg2        klist                                                  |
063800000919     C                   kfld                    @@empr                         |
063900000919     C                   kfld                    @@sucu                         |
064000000919     C                   kfld                    @@arcd                         |
064100000919     C                   kfld                    @@spol                         |
064200000919     C                   kfld                    @@rama                         |
064300000919     C                   kfld                    @@arse                         |
064400000919     C                   kfld                    @@oper                         |
064500000919     C                   kfld                    @@poco                         |
064600961218     ?*- PAHED0...                                         |
064700000919     C     k1hed0        klist                                                  |
064800000919     C                   kfld                    g2empr                         |
064900000919     C                   kfld                    g2sucu                         |
065000000919     C                   kfld                    g2arcd                         |
065100000919     C                   kfld                    g2spol                         |
065200000919     C                   kfld                    g2sspo                         |
065300000919     C                   kfld                    g2rama                         |
065400000919     C                   kfld                    g2arse                         |
065500000919     C                   kfld                    g2oper                         |
065600000919     C                   kfld                    g2suop                         |
065601140520     ?*- determino si es de rama autos...                  |
065602140520     C     @@rama        chain     set001
065603140520     C                   if        %found and t@rame = 4
065604140520     C                   eval      es_autos = *On
065605140520     C                   else
065606140520     C                   eval      es_autos = *Off
065607140520     C                   endif
065700970127     ?* cargar campos de cabecera...                       |
065800970127     C                   eval      xxarcd = @@arcd                              |
065900970127     C                   eval      xxspol = @@spol                              |
066000970127     C                   eval      xxsspo = @@sspo                              |
066100970127     C                   eval      xxrama = @@rama                              |
066200970127     C                   eval      xxarse = @@arse                              |
066300970127     C                   eval      xxoper = @@oper                              |
066400000919     C                   eval      xxpoco = @@poco                              |
066500970127     C                   eval      xxsuop = @@suop                              |
066600970127     ?* cargar subarchivo primera entrada...               |
066700961218     C                   exsr      carg01                                       |
066800910611     ?*-                                                   |
066900890822     C                   endsr                                                  |
067000910314     ?******************************************************
067100960723**
067200960723***************************************************************************
