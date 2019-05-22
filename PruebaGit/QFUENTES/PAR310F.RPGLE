000100960415     H decedit(',') datedit(*dmy/)
000200960415     ?*****************************************************************
000300961219     ?*  PAR310F : DETALLE DE SUPERPOLIZAS CLAUSULAS Y ANEXOS         *
000400961206     ?*          : MODULO DE PRODUCCION POR ARTICULOS                 *
000500960415     ?*                                                               *
000600961219     ?*  FECHA   : 19/12/96                                           *
000700960415     ?*  AUTOR   : ALEJANDRO RODRIGUEZ                                *
000800001106     ?*                                                               *
000900001106     ?*  Modificaciones:                                              *
001000001106     ?*  ===============                                              *
001100001106     ?*  AHR 06/11/2000 En renovaciones regenero las cláusulas como   *
001200001106     ?*  si fuera póliza nueva, por lo tanto ejecuto la rutina DEFE01 *
001300020424     ?*  SLU 24/04/2002 Se ubicaba mal en el libro, no tenía en cuenta*
001400020424     ?*  la Fecha de Vigencia del mismo y obtenía siempre el más viejo*
001500040419     ?*  SGF 19/04/2004 Agrego Grabación de marca en PAWP310 para el  *
001600040419     ?*                 navegador. F17 = Ir A...                      *
001601110901     ?*  SGF 01/09/2011 F7: Valores por defecto.                      *
001700001106     ?*                                                               *
001800960415     ?*                              (C) COPYRIGHT COLINET-TROTTA SRL *
001900960415     ?*****************************************************************
002000970127     Fpar310fm  cf   e             workstn usropn
002100971105     Fpahec1    if   e           k disk
002200971105     Fpahed0    if   e           k disk
002300970602     Fpawpd0    uf   e           k disk
002400040419     Fpawp310   uf   e           k disk
002500961219     Fpahed4    uf a e           k disk
002600970110     Fpahed401  if   e           k disk
002700961219     Fpahed5    uf a e           k disk
002800970110     Fpahed501  if   e           k disk
002900970227     Fset623    if   e           k disk
003000000918     Fset630    if   e           k disk
003100000918     Fset127    if   e           k disk
003200000919     Fset135    if   e           k disk
003300000918     Fset126    if   e           k disk
003400960415     ?*****************************************************************
003500960415      /SPACE
003600960415     ?*****************************************************************
003700961220     D an              s              1    dim(30)                              ANEXOS
003800961220     D cl              s              3    dim(30)                              CLAUSULAS
003900961220     D @an             s              1    dim(30)                              ANEXOS
004000961220     D @cl             s              3    dim(30)                              CLAUSULAS
004100960415     ?*- AGRUPACION DIA-MES-AÑO EN UN SOLO CAMPO...
004200960415     D                 ds
004300960415     D  p@fdma                01     08  0
004400960415     D  p@fdia                01     02  0
004500960415     D  p@fmes                03     04  0
004600960415     D  p@faÑo                05     08  0
004700960415     ?*- AGRUPACION AÑO-MES-DIA EN UN SOLO CAMPO...
004800960415     D                 ds
004900960415     D  p@famd                01     08  0
005000960415     D  p@1aÑo                01     04  0
005100960415     D  p@1mes                05     06  0
005200960415     D  p@1dia                07     08  0
005300960415     ?*- PARAMETROS PARA 'SPFECH'...
005400960415     D p@fech          ds
005500960415     D  p@flap                01     05  0
005600960415     D  p@ffec                06     13  0
005700960415     ?*- AREA DEL PROGRAMA...
005800960415     D                sds
005900960415     D  vsuser               254    263
006000960415     ?*- AREA LOCAL DE DATOS...
006100960415     D                uds
006200960415     D  usempr               401    401
006300960415     D  ussucu               402    403
006400040419     ?* Campos Independientes...
006500040419     D $$an01          s                   like(d5an01)
006600040419     D $$an02          s                   like(d5an02)
006700040419     D $$an03          s                   like(d5an03)
006800040419     D $$an04          s                   like(d5an04)
006900040419     D $$an05          s                   like(d5an05)
007000040419     D $$an06          s                   like(d5an06)
007100040419     D $$an07          s                   like(d5an07)
007200040419     D $$an08          s                   like(d5an08)
007300040419     D $$an09          s                   like(d5an09)
007400040419     D $$an10          s                   like(d5an10)
007500040419     D $$an11          s                   like(d5an11)
007600040419     D $$an12          s                   like(d5an12)
007700040419     D $$an13          s                   like(d5an13)
007800040419     D $$an14          s                   like(d5an14)
007900040419     D $$an15          s                   like(d5an15)
008000040419     D $$an16          s                   like(d5an16)
008100040419     D $$an17          s                   like(d5an17)
008200040419     D $$an18          s                   like(d5an18)
008300040419     D $$an19          s                   like(d5an19)
008400040419     D $$an20          s                   like(d5an20)
008500040419     D $$an21          s                   like(d5an21)
008600040419     D $$an22          s                   like(d5an22)
008700040419     D $$an23          s                   like(d5an23)
008800040419     D $$an24          s                   like(d5an24)
008900040419     D $$an25          s                   like(d5an25)
009000040419     D $$an26          s                   like(d5an26)
009100040419     D $$an27          s                   like(d5an27)
009200040419     D $$an28          s                   like(d5an28)
009300040419     D $$an29          s                   like(d5an29)
009400040419     D $$an30          s                   like(d5an30)
009500040419     D $$ca01          s                   like(d4ca01)
009600040419     D $$ca02          s                   like(d4ca02)
009700040419     D $$ca03          s                   like(d4ca03)
009800040419     D $$ca04          s                   like(d4ca04)
009900040419     D $$ca05          s                   like(d4ca05)
010000040419     D $$ca06          s                   like(d4ca06)
010100040419     D $$ca07          s                   like(d4ca07)
010200040419     D $$ca08          s                   like(d4ca08)
010300040419     D $$ca09          s                   like(d4ca09)
010400040419     D $$ca10          s                   like(d4ca10)
010500040419     D $$ca11          s                   like(d4ca11)
010600040419     D $$ca12          s                   like(d4ca12)
010700040419     D $$ca13          s                   like(d4ca13)
010800040419     D $$ca14          s                   like(d4ca14)
010900040419     D $$ca15          s                   like(d4ca15)
011000040419     D $$ca16          s                   like(d4ca16)
011100040419     D $$ca17          s                   like(d4ca17)
011200040419     D $$ca18          s                   like(d4ca18)
011300040419     D $$ca19          s                   like(d4ca19)
011400040419     D $$ca20          s                   like(d4ca20)
011500040419     D $$ca21          s                   like(d4ca21)
011600040419     D $$ca22          s                   like(d4ca22)
011700040419     D $$ca23          s                   like(d4ca23)
011800040419     D $$ca24          s                   like(d4ca24)
011900040419     D $$ca25          s                   like(d4ca25)
012000040419     D $$ca26          s                   like(d4ca26)
012100040419     D $$ca27          s                   like(d4ca27)
012200040419     D $$ca28          s                   like(d4ca28)
012300040419     D $$ca29          s                   like(d4ca29)
012400040419     D $$ca30          s                   like(d4ca30)
012500040419     D @@anex          s              1
012600040419     D @@arcd          s                   like(z0arcd)
012700040419     D @@arse          s                   like(z0arse)
012800040419     D @@clau          s              3
012900040419     D @@empr          s                   like(z0empr)
013000040419     D @@femi          s              8  0
013100040419     D @@flib          s              8  0                                      ?            |
013200040419     D @@nlib          s                   like(t@nlib)
013300040419     D @@oper          s                   like(z0oper)
013400040419     D @@rama          s                   like(z0rama)
013500040419     D @@spol          s                   like(z0spol)
013600040419     D @@spo1          s                   like(z0spo1)
013700040419     D @@sspo          s                   like(z0sspo)
013800040419     D @@sucu          s                   like(z0sucu)
013900040419     D @@suop          s                   like(z0suop)
014000040419     D @e              s              2  0
014100040419     D x               s              9  0
014200040419     D xxiden          s              1  0
014300040419     D y               s              9  0
014400040419     D z               s              9  0
014500040419     D @@in23          s              1n
014600960415     ?*****************************************************************
014700960415      /SPACE
014800960415     ?*****************************************************************
014900961220     Ipar31001
015000961220     I              x1ca01                      cl(01)
015100961220     I              x1ca02                      cl(02)
015200961220     I              x1ca03                      cl(03)
015300961220     I              x1ca04                      cl(04)
015400961220     I              x1ca05                      cl(05)
015500961220     I              x1ca06                      cl(06)
015600961220     I              x1ca07                      cl(07)
015700961220     I              x1ca08                      cl(08)
015800961220     I              x1ca09                      cl(09)
015900961220     I              x1ca10                      cl(10)
016000961220     I              x1ca11                      cl(11)
016100961220     I              x1ca12                      cl(12)
016200961220     I              x1ca13                      cl(13)
016300961220     I              x1ca14                      cl(14)
016400961220     I              x1ca15                      cl(15)
016500961220     I              x1ca16                      cl(16)
016600961220     I              x1ca17                      cl(17)
016700961220     I              x1ca18                      cl(18)
016800961220     I              x1ca19                      cl(19)
016900961220     I              x1ca20                      cl(20)
017000961220     I              x1ca21                      cl(21)
017100961220     I              x1ca22                      cl(22)
017200961220     I              x1ca23                      cl(23)
017300961220     I              x1ca24                      cl(24)
017400961220     I              x1ca25                      cl(25)
017500961220     I              x1ca26                      cl(26)
017600961220     I              x1ca27                      cl(27)
017700961220     I              x1ca28                      cl(28)
017800961220     I              x1ca29                      cl(29)
017900961220     I              x1ca30                      cl(30)
018000961220     I              x1an01                      an(01)
018100961220     I              x1an02                      an(02)
018200961220     I              x1an03                      an(03)
018300961220     I              x1an04                      an(04)
018400961220     I              x1an05                      an(05)
018500961220     I              x1an06                      an(06)
018600961220     I              x1an07                      an(07)
018700961220     I              x1an08                      an(08)
018800961220     I              x1an09                      an(09)
018900961220     I              x1an10                      an(10)
019000961220     I              x1an11                      an(11)
019100961220     I              x1an12                      an(12)
019200961220     I              x1an13                      an(13)
019300961220     I              x1an14                      an(14)
019400961220     I              x1an15                      an(15)
019500961220     I              x1an16                      an(16)
019600961220     I              x1an17                      an(17)
019700961220     I              x1an18                      an(18)
019800961220     I              x1an19                      an(19)
019900961220     I              x1an20                      an(20)
020000961220     I              x1an21                      an(21)
020100961220     I              x1an22                      an(22)
020200961220     I              x1an23                      an(23)
020300961220     I              x1an24                      an(24)
020400961220     I              x1an25                      an(25)
020500961220     I              x1an26                      an(26)
020600961220     I              x1an27                      an(27)
020700961220     I              x1an28                      an(28)
020800961220     I              x1an29                      an(29)
020900961220     I              x1an30                      an(30)
021000960415     ?*-
021100960415     ?*****************************************************************
021200960415      /SPACE
021300960415     ?*****************************************************************
021400960415     ?*----------------------------------------------------|
021500961206     C     *entry        plist
021600961206     C                   parm                    @@empr
021700961206     C                   parm                    @@sucu
021800961206     C                   parm                    @@arcd
021900961206     C                   parm                    @@spo1
022000961210     C                   parm                    @@spol
022100961206     C                   parm                    @@sspo
022200961218     C                   parm                    @@rama
022300961218     C                   parm                    @@arse
022400961218     C                   parm                    @@oper
022500961218     C                   parm                    @@suop
022600961206     C                   parm                    @@mand            2
022700961206     C                   parm                    endpgm            3
022800961209     ?*- PROCESO TRONCAL-----------------------------------|
022900961209?1b? C                   select                                                 ?P----------01
023000961209     ?*- SALIDA DEL PROGRAMA RETRN-------------------------|                    ?            |
023100961209?1x? C                   when      endpgm = *blanks                             ?w----------01
023200970127     C                   open      par310fm                                     ?            |
023300961210     C                   exsr      inicio                                       ?            |
023400961206?2b? C                   dou       *inkc                                        ?P---------02|
023500961206?3b? C     xxiden        caseq     1             pant01                         ?P--------03||
023600961206?3e? C                   endcs                                                  ?F--------03||
023700961206?2e? C                   enddo                                                  ?F---------02|
023800970127     C                   close     par310fm                                     ?            |
023900961209     C                   return                                                 ?            |
024000961209     ?*- SALIDA DEL PROGRAMA CON LAST RECORD---------------|                    ?            |
024100961209?1x? C                   when      endpgm = 'FIN'                               ?w----------01
024200961209     C                   exsr      srclos                                       ?            |
024300960415     C                   seton                                            lr    ?            |
024400961209     ?*----------------------------------------------------|                    ?            |
024500961209?1e? C                   endsl                                                  ?F----------01
024600960415     ?*----------------------------------------------------|
024700960415     ?******************************************************
024800960415      /SPACE
024900960415     ?******************************************************
025000961209     C     inicio        begsr
025100960415     ?** INICIO DE PROGRAMA -------------------------------|
025200960415     ?*- DEFINICION DE CAMPOS...                           |
025300961220     C                   eval      x = *zeros
025400961220     C                   eval      y = *zeros
025500961220     C                   eval      z = *zeros
025600960415     ?*- DEFINICIONES GENERALES...                         |
025700960415     ?*- CAMPOS DE PANTALLA 01...                          |
025800961209     ?*- APAGAR TODOS LOS INDICADORES...                   |
025900961209     C                   eval      x = *zeros
026000961209?1b? C                   dou       x = 99                                       ?P----------01
026100961209     C                   add       1             x                              ?            |
026200961209     C                   eval      *in(x) = '0'                                 ?            |
026300961209?1e? C                   enddo                                                  ?F----------01
026400961220     ?*- BORRATINA DE VARIABLES INTERNAS...                |
026500961220     C                   eval      cl = *blanks
026600961220     C                   eval      an = *blanks
026700961220     C                   eval      @cl = *blanks
026800961220     C                   eval      @an = *blanks
026900961220     ?*- LIMPIAR PANTALLA COMPLETA...                      |
027000961210     C                   clear                   par31001
027100000918     ?*- ANALIZAR SI CORRESPONDE VALIDAR...                |
027200000918     C     @@arcd        chain     s1t630                             20
027300000918     ?*- FECHA TENTATIVA DE EMISION...                     |
027400000918     C                   call      'PAR310X3'
027500000918     C                   parm                    @@empr
027600000918     C                   parm      *zeros        @@fema            4 0
027700000918     C                   parm      *zeros        @@femm            2 0
027800000918     C                   parm      *zeros        @@femd            2 0
027900000918     C                   eval      p@1aÑo = @@fema
028000000918     C                   eval      p@1mes = @@femm
028100000918     C                   eval      p@1dia = @@femd
028200000918     C                   eval      @@femi = p@famd
028300000918     ?*- BUSCAR LIBRO DE CLAUSULAS VIGENTE...              |
028400000918     C                   clear                   @@nlib
028500000918     C                   setoff                                           99
028600020424     C     k1t126setl    setgt     s1t126
028700020424     C     k1t126read    readpe    set126
028800020424?1b? C                   if        not %eof(set126)                             ?P----------01
028900000918     C                   eval      p@1aÑo = t@fioa                              ?            |
029000000918     C                   eval      p@1mes = t@fiom                              ?            |
029100000918     C                   eval      p@1dia = t@fiod                              ?            |
029200000918     C                   eval      @@flib = p@famd                              ?            |
029300000918     C                   eval      @@nlib = t@nlib                              ?            |
029400020424?1e? C                   endif                                                  ?F----------01
029500000918     ?*- DEFINICION DE CLAVES P/ACCESO A ARCHIVOS ...      |
029600961218     ?*- PAWPD0...                                         |
029700961218     C     k1@pd0        klist
029800961218     C                   kfld                    @@empr
029900961218     C                   kfld                    @@sucu
030000961218     C                   kfld                    @@arcd
030100961218     C                   kfld                    @@spo1
030200961218     C                   kfld                    @@spol
030300961218     C                   kfld                    @@sspo
030400961218     C                   kfld                    @@rama
030500961218     C                   kfld                    @@arse
030600961218     C                   kfld                    @@oper
030700961218     C                   kfld                    @@suop
030800971104     ?*- PAHEC1...                                         |
030900971104     C     k1@ec1        klist
031000971104     C                   kfld                    @@empr
031100971104     C                   kfld                    @@sucu
031200971104     C                   kfld                    @@arcd
031300971104     C                   kfld                    @@spol
031400971104     C                   kfld                    @@sspo
031500970602     ?*- PAHED0...                                         |
031600970602     C     k1@ed0        klist
031700970602     C                   kfld                    d4empr
031800970602     C                   kfld                    d4sucu
031900970602     C                   kfld                    d4arcd
032000970602     C                   kfld                    d4spol
032100970602     C                   kfld                    d4sspo
032200970602     C                   kfld                    d4rama
032300970602     C                   kfld                    d4arse
032400970602     C                   kfld                    d4oper
032500970602     C                   kfld                    d4suop
032600970602     C     k2@ed0        klist
032700970602     C                   kfld                    d5empr
032800970602     C                   kfld                    d5sucu
032900970602     C                   kfld                    d5arcd
033000970602     C                   kfld                    d5spol
033100970602     C                   kfld                    d5sspo
033200970602     C                   kfld                    d5rama
033300970602     C                   kfld                    d5arse
033400970602     C                   kfld                    d5oper
033500970602     C                   kfld                    d5suop
033600961219     ?*- PAHED4...                                         |
033700961219     C     k1@ed4        klist
033800961218     C                   kfld                    z0empr
033900961218     C                   kfld                    z0sucu
034000961218     C                   kfld                    z0arcd
034100961218     C                   kfld                    z0spol
034200961218     C                   kfld                    z0rama
034300961218     C                   kfld                    z0arse
034400961218     C                   kfld                    z0oper
034500961219     C     k2@ed4        klist
034600961219     C                   kfld                    z0empr
034700961219     C                   kfld                    z0sucu
034800961219     C                   kfld                    z0arcd
034900961219     C                   kfld                    z0spol
035000961219     C                   kfld                    z0sspo
035100961219     C                   kfld                    z0rama
035200961219     C                   kfld                    z0arse
035300961219     C                   kfld                    z0oper
035400961219     C                   kfld                    z0suop
035500961219     C     k3@ed4        klist
035600970110     C                   kfld                    z0empr
035700970110     C                   kfld                    z0sucu
035800970110     C                   kfld                    z0arcd
035900970110     C                   kfld                    z0spo1
036000961219     C                   kfld                    z0rama
036100961219     C                   kfld                    z0arse
036200971104     C     k4@ed4        klist
036300971104     C                   kfld                    z0empr
036400971104     C                   kfld                    z0sucu
036500971104     C                   kfld                    z0arcd
036600971104     C                   kfld                    z0spol
036700971104     C                   kfld                    c1xpro
036800971104     C                   kfld                    z0rama
036900971104     C                   kfld                    z0arse
037000971104     C                   kfld                    z0oper
037100971104     C                   kfld                    c1xpro
037200961219     ?*- PAHED5...                                         |
037300961219     C     k1@ed5        klist
037400961219     C                   kfld                    z0empr
037500961219     C                   kfld                    z0sucu
037600961219     C                   kfld                    z0arcd
037700961219     C                   kfld                    z0spol
037800961219     C                   kfld                    z0rama
037900961219     C                   kfld                    z0arse
038000961219     C                   kfld                    z0oper
038100961219     C     k2@ed5        klist
038200961219     C                   kfld                    z0empr
038300961219     C                   kfld                    z0sucu
038400961219     C                   kfld                    z0arcd
038500961219     C                   kfld                    z0spol
038600961219     C                   kfld                    z0sspo
038700961219     C                   kfld                    z0rama
038800961219     C                   kfld                    z0arse
038900961219     C                   kfld                    z0oper
039000961219     C                   kfld                    z0suop
039100961219     C     k3@ed5        klist
039200970110     C                   kfld                    z0empr
039300970110     C                   kfld                    z0sucu
039400970110     C                   kfld                    z0arcd
039500970110     C                   kfld                    z0spo1
039600970110     C                   kfld                    z0rama
039700961219     C                   kfld                    z0arse
039800971104     C     k4@ed5        klist
039900971104     C                   kfld                    z0empr
040000971104     C                   kfld                    z0sucu
040100971104     C                   kfld                    z0arcd
040200971104     C                   kfld                    z0spol
040300971104     C                   kfld                    c1xpro
040400971104     C                   kfld                    z0rama
040500971104     C                   kfld                    z0arse
040600971104     C                   kfld                    z0oper
040700971104     C                   kfld                    c1xpro
040800970227     ?*- SET623...                                         |
040900970227     C     k1t623        klist
041000970227     C                   kfld                    @@arcd
041100970227     C                   kfld                    @@rama
041200970227     C                   kfld                    @@arse
041300000918     ?*- SET127...                                         |
041400000918     C     k1t127        klist
041500000918     C                   kfld                    @@rama
041600000918     C                   kfld                    @@nlib
041700000918     C                   kfld                    @@clau
041800000919     ?*- SET126...                                         |
041900020424     C     k1t126read    klist
042000000919     C                   kfld                    @@rama
042100020424
042200020424     C     k1t126setl    klist
042300020424     C                   kfld                    @@rama
042400020424     C                   kfld                    @@fema
042500020424     C                   kfld                    @@femm
042600020424     C                   kfld                    @@femd
042700000919     ?*- SET135...                                         |
042800000919     C     k1t135        klist
042900000919     C                   kfld                    @@rama
043000000919     C                   kfld                    @@nlib
043100000919     C                   kfld                    @@anex
043200961206     ?*- BUSCAR REGISTRO DE OPERACION SUSPENDIDA...        |
043300961218     C     k1@pd0        chain(n)  p1wpd0                             20
043400040419     ?* Ver si habilita tecla F17 para navegador...
043500040419     C     k1@pd0        setll     pawp310                            20
043600040419?1b? C                   if        %equal                                       ?P----------01
043700040419     C                   eval      @@in23 = *on                                 ?            |
043800040419?1e? C                   endif                                                  ?F----------01
043900971105     ?*- BUSCAR REGISTRO DEL PAHEC1...                     |
044000971105     C     k1@ec1        chain     p1hec1                             20
044100961206     ?*- PARA EMITIR PANTALLA 0...                         |
044200961206     C                   exsr      borr01
044300961206     C                   exsr      carg01
044400961206     C                   eval      xxiden = 1
044500040419     C                   exsr      reset_pan
044600960415     ?*-                                                   |
044700960415     C                   endsr
044800960415     ?******************************************************
044900960415      /SPACE
045000960415     ?******************************************************
045100961206     C     pant01        begsr
045200960415     ?** PROCESO PANTALLA '1' -----------------------------|
045300960415     ?*- ENTRADA/SALIDA PANTALLA '1' ...                   |
045400961206     C                   exfmt     par31001
045500960415     ?*- CORRIGE SITUACIONES DE ERROR ...                  |
045600960415     C                   exsr      apagar
045700960415     ?*- PROCESA TECLAS DE FUNCION...                      |
045800960415?1b? C                   select                                                 ?P----------01
045900960415     ?*- F3=SALIR...                                       |                    ?            |
046000960415?1x? C                   when      *inkc                                        ?w----------01
046100961206     C                   eval      @@mand = 'KC'                                ?            |
046101110901?1x? C                   when      *inkg                                        ?w----------01
046102110901     C                   exsr      borr01
046104110901     C                   eval      xxarcd = @@arcd
046105110901     C                   eval      xxspol = @@spol
046106110901     C                   eval      xxsspo = @@sspo
046107110901     C                   eval      xxrama = @@rama
046108110901     C                   eval      xxarse = @@arse
046109110901     C                   eval      xxoper = @@oper
046110110901     C                   eval      xxsuop = @@suop
046111110901     C                   eval      xxiden = 1
046112110901     C                   exsr      defe01
046200961218     ?*- F12=RETORNAR...                                   |                    ?            |
046300961218?1x? C                   when      *inkl                                        ?w----------01
046400961218     C                   eval      @@mand = 'KL'                                ?            |
046500961218     C                   eval      *inkc = '1'                                  ?            |
046600040419     ?*- F17=Ir a...                                                            ?            |
046700040419?1x? C                   when      *inkr                                        ?w----------01
046800040419     C                   eval      @@mand = 'KR'                                ?            |
046900040419     C                   eval      *inkc = '1'                                  ?            |
047000960716     ?*- F4=SOLICITUD...                                   ||                   ?            |
047100960716?1x? C                   when      *inkd                                        ?w----------01
047200961206     C                   exsr      soli01                                       ?            |
047300960415     ?*- AYUDA...                                          ||                   ?            |
047400960415?1x? C                   when      *in80                                        ?w----------01
047500960415     ?*- PULSA INTRO...                                    ||                   ?            |
047600960415?1x? C                   when      not *in29                                    ?w----------01
047700961206     C                   exsr      vali01                                       ?            |
047800960415?1e? C                   endsl                                                  ?F----------01
047900960415     ?*                                                    |
048000960415     C                   endsr
048100960415     ?******************************************************
048200960415      /SPACE
048300960415     ?******************************************************
048400961206     C     borr01        begsr
048500961206     ?** BORRADO PANTALLA 01-------------------------------|
048600961218     C                   clear                   par31001
048700960415     ?*-                                                   |
048800961219     C                   clear                   $$ca01
048900961219     C                   clear                   $$ca02
049000961219     C                   clear                   $$ca03
049100961219     C                   clear                   $$ca04
049200961219     C                   clear                   $$ca05
049300961219     C                   clear                   $$ca06
049400961219     C                   clear                   $$ca07
049500961219     C                   clear                   $$ca08
049600961219     C                   clear                   $$ca09
049700961219     C                   clear                   $$ca10
049800961219     C                   clear                   $$ca11
049900961219     C                   clear                   $$ca12
050000961219     C                   clear                   $$ca13
050100961219     C                   clear                   $$ca14
050200961219     C                   clear                   $$ca15
050300961219     C                   clear                   $$ca16
050400961219     C                   clear                   $$ca17
050500961219     C                   clear                   $$ca18
050600961219     C                   clear                   $$ca19
050700961219     C                   clear                   $$ca20
050800961219     C                   clear                   $$ca21
050900961219     C                   clear                   $$ca22
051000961219     C                   clear                   $$ca23
051100961219     C                   clear                   $$ca24
051200961219     C                   clear                   $$ca25
051300961219     C                   clear                   $$ca26
051400961219     C                   clear                   $$ca27
051500961219     C                   clear                   $$ca28
051600961219     C                   clear                   $$ca29
051700961219     C                   clear                   $$ca30
051800961219     C                   clear                   $$an01
051900961219     C                   clear                   $$an02
052000961219     C                   clear                   $$an03
052100961219     C                   clear                   $$an04
052200961219     C                   clear                   $$an05
052300961219     C                   clear                   $$an06
052400961219     C                   clear                   $$an07
052500961219     C                   clear                   $$an08
052600961219     C                   clear                   $$an09
052700961219     C                   clear                   $$an10
052800961219     C                   clear                   $$an11
052900961219     C                   clear                   $$an12
053000961219     C                   clear                   $$an13
053100961219     C                   clear                   $$an14
053200961219     C                   clear                   $$an15
053300961219     C                   clear                   $$an16
053400961219     C                   clear                   $$an17
053500961219     C                   clear                   $$an18
053600961219     C                   clear                   $$an19
053700961219     C                   clear                   $$an20
053800961219     C                   clear                   $$an21
053900961219     C                   clear                   $$an22
054000961219     C                   clear                   $$an23
054100961219     C                   clear                   $$an24
054200961219     C                   clear                   $$an25
054300961219     C                   clear                   $$an26
054400961219     C                   clear                   $$an27
054500961219     C                   clear                   $$an28
054600961219     C                   clear                   $$an29
054700961219     C                   clear                   $$an30
054800961210     ?*-                                                   |
054900960415     C                   endsr
055000961206     ?******************************************************
055100961206      /SPACE
055200961206     ?******************************************************
055300961206     C     carg01        begsr
055400961206     ?** BORRADO PANTALLA 01-------------------------------|
055500970127     ?*- CARGAR CAMPOS DE CABECERA...                      |
055600970127     C                   eval      xxarcd = @@arcd
055700970127     C                   eval      xxspol = @@spol
055800970127     C                   eval      xxsspo = @@sspo
055900970127     C                   eval      xxrama = @@rama
056000970127     C                   eval      xxarse = @@arse
056100970127     C                   eval      xxoper = @@oper
056200970127     C                   eval      xxsuop = @@suop
056300961219     ?* Si el paso03 està en cero es la primera vez que    |
056400961213     ?* entra el programa, entonces ejecuta rutinas de car-|
056500961218     ?* ga por defecto, caso contrario carga desde el      |
056600961219     ?* archivos PAHED4...                                 |
056700961213?1b? C                   select                                                 ?P----------01
056800961219?1x? C                   when      z0wp03 = 1                                   ?w----------01
056900961213     ?*- RECUPERO DE OPERACION SUSPENDIDA O VUELTA A       ||                   ?            |
057000961213     ?*- CABECERA: CARGA DESDE ARCHIVOS YA GRABADOS...     ||                   ?            |
057100961219     ?*- DATOS DEL PAHED4...                               ||                   ?            |
057200961219     C     k2@ed4        chain(n)  p1hed4                             20        ?            |
057300961219?2b? C                   if        not *in20                                    ?P---------02|
057400961219     C                   exsr      mod4pa                                       ?           ||
057500961219?2e? C                   endif                                                  ?F---------02|
057600961219     ?*- DATOS DEL PAHED5...                               ||                   ?            |
057700961219     C     k2@ed5        chain(n)  p1hed5                             20        ?            |
057800961219?2b? C                   if        not *in20                                    ?P---------02|
057900970113     C                   exsr      mod5pa                                       ?           ||
058000961219?2e? C                   endif                                                  ?F---------02|
058100961219?1x? C                   when      z0wp03 = 0                                   ?w----------01
058200961213     ?*- PRIMERA ENTRADA DEL PROGRAMA...                   ||                   ?            |
058300961213     ?*- BUSCA DATOS POR DEFECTO SEGUN EL TIPO DE FUNCION..||                   ?            |
058400971105?2b? C                   select                                                 ?P---------02|
058500971105?2x? C                   when      z0tiou = 1                                   ?w---------02|
058600971105     C                   exsr      defe01                                       ?           ||
058700971105?2x? C                   when      z0tiou = 2                                   ?w---------02|
058800971105     C                   exsr      defe02                                       ?           ||
058900971105?2x? C                   when      z0tiou = 3  and                              ?w---------02|
059000971105     C                             z0stos <> 08                                 ?           ||
059100971105     C                   exsr      defe03                                       ?           ||
059200971105?2x? C                   when      z0tiou = 3  and                              ?w---------02|
059300971105     C                             z0stos = 08                                  ?           ||
059400971105     C                   exsr      defe38                                       ?           ||
059500971105?2x? C                   when      z0tiou = 5                                   ?w---------02|
059600971105     C                   exsr      defe05                                       ?           ||
059700971105?2e? C                   endsl                                                  ?F---------02|
059800961213?1e? C                   endsl                                                  ?F----------01
059900961206     ?*-                                                   |
060000961206     C                   endsr
060100961219     ?******************************************************
060200961219      /SPACE
060300961219     ?******************************************************
060400961219     C     mod5pa        begsr
060500961219     ?*- MOVER CAMPOS DEL PAHED5 A PANTALLA----------------|
060600961220     C                   eval      an(001) = d5an01
060700961220     C                   eval      an(002) = d5an02
060800961220     C                   eval      an(003) = d5an03
060900961220     C                   eval      an(004) = d5an04
061000961220     C                   eval      an(005) = d5an05
061100961220     C                   eval      an(006) = d5an06
061200961220     C                   eval      an(007) = d5an07
061300961220     C                   eval      an(008) = d5an08
061400961220     C                   eval      an(009) = d5an09
061500961220     C                   eval      an(010) = d5an10
061600961220     C                   eval      an(011) = d5an11
061700961220     C                   eval      an(012) = d5an12
061800961220     C                   eval      an(013) = d5an13
061900961220     C                   eval      an(014) = d5an14
062000961220     C                   eval      an(015) = d5an15
062100961220     C                   eval      an(016) = d5an16
062200961220     C                   eval      an(017) = d5an17
062300961220     C                   eval      an(018) = d5an18
062400961220     C                   eval      an(019) = d5an19
062500961220     C                   eval      an(020) = d5an20
062600961220     C                   eval      an(021) = d5an21
062700961220     C                   eval      an(022) = d5an22
062800961220     C                   eval      an(023) = d5an23
062900961220     C                   eval      an(024) = d5an24
063000961220     C                   eval      an(025) = d5an25
063100961220     C                   eval      an(026) = d5an26
063200961220     C                   eval      an(027) = d5an27
063300961220     C                   eval      an(028) = d5an28
063400961220     C                   eval      an(029) = d5an29
063500961220     C                   eval      an(030) = d5an30
063600961219     ?*-                                                   |
063700961219     C                   endsr
063800961219     ?******************************************************
063900961219      /SPACE
064000961219     ?******************************************************
064100961219     C     mod4pa        begsr
064200961219     ?*- MOVER CAMPOS DEL PAHED4 A PANTALLA----------------|
064300961220     C                   eval      cl(001) = d4ca01
064400961220     C                   eval      cl(002) = d4ca02
064500961220     C                   eval      cl(003) = d4ca03
064600961220     C                   eval      cl(004) = d4ca04
064700961220     C                   eval      cl(005) = d4ca05
064800961220     C                   eval      cl(006) = d4ca06
064900961220     C                   eval      cl(007) = d4ca07
065000961220     C                   eval      cl(008) = d4ca08
065100961220     C                   eval      cl(009) = d4ca09
065200961220     C                   eval      cl(010) = d4ca10
065300961220     C                   eval      cl(011) = d4ca11
065400961220     C                   eval      cl(012) = d4ca12
065500961220     C                   eval      cl(013) = d4ca13
065600961220     C                   eval      cl(014) = d4ca14
065700961220     C                   eval      cl(015) = d4ca15
065800961220     C                   eval      cl(016) = d4ca16
065900961220     C                   eval      cl(017) = d4ca17
066000961220     C                   eval      cl(018) = d4ca18
066100961220     C                   eval      cl(019) = d4ca19
066200961220     C                   eval      cl(020) = d4ca20
066300961220     C                   eval      cl(021) = d4ca21
066400961220     C                   eval      cl(022) = d4ca22
066500961220     C                   eval      cl(023) = d4ca23
066600961220     C                   eval      cl(024) = d4ca24
066700961220     C                   eval      cl(025) = d4ca25
066800961220     C                   eval      cl(026) = d4ca26
066900961220     C                   eval      cl(027) = d4ca27
067000961220     C                   eval      cl(028) = d4ca28
067100961220     C                   eval      cl(029) = d4ca29
067200961220     C                   eval      cl(030) = d4ca30
067300961219     ?*-                                                   |
067400961219     C                   endsr
067500961209     ?******************************************************
067600961209      /SPACE
067700961209     ?******************************************************
067800961209     C     defe01        begsr
067900961209     ?** BUSCAR DATOS POR DEFECTO--------------------------|
068000970227     C     k1t623        chain     s1t623                             20
068100970310?1b? C                   if        not *in20                                    ?P----------01
068200970310     C                   eval      cl(001) = t@cl01                             ?            |
068300970310     C                   eval      cl(002) = t@cl02                             ?            |
068400970310     C                   eval      cl(003) = t@cl03                             ?            |
068500970310     C                   eval      cl(004) = t@cl04                             ?            |
068600970310     C                   eval      cl(005) = t@cl05                             ?            |
068700970310     C                   eval      cl(006) = t@cl06                             ?            |
068800970310     C                   eval      cl(007) = t@cl07                             ?            |
068900970310     C                   eval      cl(008) = t@cl08                             ?            |
069000970310     C                   eval      cl(009) = t@cl09                             ?            |
069100970310     C                   eval      cl(010) = t@cl10                             ?            |
069200970310     C                   eval      cl(011) = t@cl11                             ?            |
069300970310     C                   eval      cl(012) = t@cl12                             ?            |
069400970310     C                   eval      cl(013) = t@cl13                             ?            |
069500970310     C                   eval      cl(014) = t@cl14                             ?            |
069600970310     C                   eval      cl(015) = t@cl15                             ?            |
069700970310     C                   eval      cl(016) = t@cl16                             ?            |
069800970310     C                   eval      cl(017) = t@cl17                             ?            |
069900970310     C                   eval      cl(018) = t@cl18                             ?            |
070000970310     C                   eval      cl(019) = t@cl19                             ?            |
070100970310     C                   eval      cl(020) = t@cl20                             ?            |
070200970310     C                   eval      cl(021) = t@cl21                             ?            |
070300970310     C                   eval      cl(022) = t@cl22                             ?            |
070400970310     C                   eval      cl(023) = t@cl23                             ?            |
070500970310     C                   eval      cl(024) = t@cl24                             ?            |
070600970310     C                   eval      cl(025) = t@cl25                             ?            |
070700970310     C                   eval      cl(026) = t@cl26                             ?            |
070800970310     C                   eval      cl(027) = t@cl27                             ?            |
070900970310     C                   eval      cl(028) = t@cl28                             ?            |
071000970310     C                   eval      cl(029) = t@cl29                             ?            |
071100970310     C                   eval      cl(030) = t@cl30                             ?            |
071200970310     C                   eval      an(001) = t@an01                             ?            |
071300970310     C                   eval      an(002) = t@an02                             ?            |
071400970310     C                   eval      an(003) = t@an03                             ?            |
071500970310     C                   eval      an(004) = t@an04                             ?            |
071600970310     C                   eval      an(005) = t@an05                             ?            |
071700970310     C                   eval      an(006) = t@an06                             ?            |
071800970310     C                   eval      an(007) = t@an07                             ?            |
071900970310     C                   eval      an(008) = t@an08                             ?            |
072000970310     C                   eval      an(009) = t@an09                             ?            |
072100970310     C                   eval      an(010) = t@an10                             ?            |
072200970310     C                   eval      an(011) = t@an11                             ?            |
072300970310     C                   eval      an(012) = t@an12                             ?            |
072400970310     C                   eval      an(013) = t@an13                             ?            |
072500970310     C                   eval      an(014) = t@an14                             ?            |
072600970310     C                   eval      an(015) = t@an15                             ?            |
072700970310     C                   eval      an(016) = t@an16                             ?            |
072800970310     C                   eval      an(017) = t@an17                             ?            |
072900970310     C                   eval      an(018) = t@an18                             ?            |
073000970310     C                   eval      an(019) = t@an19                             ?            |
073100970310     C                   eval      an(020) = t@an20                             ?            |
073200970310     C                   eval      an(021) = t@an21                             ?            |
073300970310     C                   eval      an(022) = t@an22                             ?            |
073400970310     C                   eval      an(023) = t@an23                             ?            |
073500970310     C                   eval      an(024) = t@an24                             ?            |
073600970310     C                   eval      an(025) = t@an25                             ?            |
073700970310     C                   eval      an(026) = t@an26                             ?            |
073800970310     C                   eval      an(027) = t@an27                             ?            |
073900970310     C                   eval      an(028) = t@an28                             ?            |
074000970310     C                   eval      an(029) = t@an29                             ?            |
074100970310     C                   eval      an(030) = t@an30                             ?            |
074200970310?1e? C                   endif                                                  ?F----------01
074300961209     ?*-                                                   |
074400961209     C                   endsr
074500961210     ?******************************************************
074600961210      /SPACE
074700961210     ?******************************************************
074800961210     C     defe02        begsr
074900961210     ?** BUSCAR DATOS POR DEFECTO EN RENOVACION------------|
075000961219     ?* buscar ultimo endoso de la misma rama/secuencia    |
075100000524     C                   setoff                                           97
075200970110     C     k3@ed4        setgt     p1hed401
075300970602?1b? C                   dow       1 = 1                                        ?P----------01
075400970602     C     k3@ed4        readpe    p1hed401                               97    ?            |
075500970602?2b? C                   if        not *in97                                    ?P---------02|
075600970602     C     k1@ed0        chain     p1hed0                             20        ?           ||
075700970602?3b? C                   if        not *in20                                    ?P--------03||
075800970602?4b? C                   if        d0tiou = 1  or                               ?P-------04|||
075900970602     C                             d0tiou = 2  or                               ?         ||||
076000970704     C                             d0tiou = 5  or                               ?         ||||
076100970602     C                             d0tiou = 3  and                              ?         ||||
076200970602     C                             d0stos <> 09                                 ?         ||||
076300970602     C                   exsr      mod4pa                                       ?         ||||
076400970602?1v? C                   leave                                                  ?         ||||
076500970602?4e? C                   endif                                                  ?F-------04|||
076600970602?3e? C                   endif                                                  ?F--------03||
076700000524?2x? C                   else                                                   ?X.........02|
076800000524?1v? C                   leave                                                  ?           ||
076900970602?2e? C                   endif                                                  ?F---------02|
077000970602?1e? C                   enddo                                                  ?F----------01
077100970602     ?*                                                    |
077200970602     C                   setoff                                           96
077300970602     C     k3@ed5        setgt     p1hed501
077400970602?1b? C                   dow       1 = 1                                        ?P----------01
077500970602     C     k3@ed5        readpe    p1hed501                               96    ?            |
077600970602?2b? C                   if        not *in96                                    ?P---------02|
077700970602     C     k2@ed0        chain     p1hed0                             20        ?           ||
077800970602?3b? C                   if        not *in20                                    ?P--------03||
077900970602?4b? C                   if        d0tiou = 1  or                               ?P-------04|||
078000970602     C                             d0tiou = 2  or                               ?         ||||
078100970704     C                             d0tiou = 5  or                               ?         ||||
078200970602     C                             d0tiou = 3  and                              ?         ||||
078300970602     C                             d0stos <> 09                                 ?         ||||
078400970602     C                   exsr      mod5pa                                       ?         ||||
078500970602?1v? C                   leave                                                  ?         ||||
078600970602?4e? C                   endif                                                  ?F-------04|||
078700970602?3e? C                   endif                                                  ?F--------03||
078800000524?2x? C                   else                                                   ?X.........02|
078900000524?1v? C                   leave                                                  ?           ||
079000970602?2e? C                   endif                                                  ?F---------02|
079100970602?1e? C                   enddo                                                  ?F----------01
079200001106     ?* sin tener en cuenta lo que hice antes, en AXA      |
079300001106     ?* siempre regenero las cláusulas como si fuera una   |
079400001106     ?* poliza nueva...                                    |
079500001106     C                   exsr      borr01
079600001106     ?* volver a cargar campos de cabecera...              |
079700001106     C                   eval      xxarcd = @@arcd
079800001106     C                   eval      xxspol = @@spol
079900001106     C                   eval      xxsspo = @@sspo
080000001106     C                   eval      xxrama = @@rama
080100001106     C                   eval      xxarse = @@arse
080200001106     C                   eval      xxoper = @@oper
080300001106     C                   eval      xxsuop = @@suop
080400001106     ?* regenerar cláusulas como póliza nueva...           |
080500001106     C                   exsr      defe01
080600961210     ?*-                                                   |
080700961210     C                   endsr
080800961210     ?******************************************************
080900961210      /SPACE
081000961210     ?******************************************************
081100961210     C     defe03        begsr
081200961210     ?** BUSCAR DATOS POR DEFECTO EN ENDOSOS---------------|
081300961218     ?* su buscan los datos en endosos anteriores de la    |
081400961218     ?* misma rama/secuencia...                            |
081500961219     ?* clausulas...                                       |
081600970602     C                   setoff                                           99
081700970110     C     k1@ed4        setgt     p1hed401
081800970602?1b? C                   dow       1 = 1                                        ?P----------01
081900970602     C     k1@ed4        readpe    p1hed401                               99    ?            |
082000970602?2b? C                   if        not *in99                                    ?P---------02|
082100970602     C     k1@ed0        chain     p1hed0                             20        ?           ||
082200970602?3b? C                   if        not *in20                                    ?P--------03||
082300970602?4b? C                   if        d0tiou = 1  or                               ?P-------04|||
082400970602     C                             d0tiou = 2  or                               ?         ||||
082500970704     C                             d0tiou = 5  or                               ?         ||||
082600970602     C                             d0tiou = 3  and                              ?         ||||
082700970602     C                             d0stos <> 09  and                            ?         ||||
082800971104     C                             d0stos <> 08                                 ?         ||||
082900970602     C                   exsr      mod4pa                                       ?         ||||
083000970602?1v? C                   leave                                                  ?         ||||
083100970602?4e? C                   endif                                                  ?F-------04|||
083200970626?3e? C                   endif                                                  ?F--------03||
083300970626?2x? C                   else                                                   ?X.........02|
083400970626?1v? C                   leave                                                  ?           ||
083500970602?2e? C                   endif                                                  ?F---------02|
083600970602?1e? C                   enddo                                                  ?F----------01
083700970602     ?* anexos...                                          |
083800970602     C                   setoff                                           99
083900970602     C     k1@ed5        setgt     p1hed501
084000970602?1b? C                   dow       1 = 1                                        ?P----------01
084100970602     C     k1@ed5        readpe    p1hed501                               99    ?            |
084200970602?2b? C                   if        not *in99                                    ?P---------02|
084300970602     C     k2@ed0        chain     p1hed0                             20        ?           ||
084400970602?3b? C                   if        not *in20                                    ?P--------03||
084500970602?4b? C                   if        d0tiou = 1  or                               ?P-------04|||
084600970602     C                             d0tiou = 2  or                               ?         ||||
084700970704     C                             d0tiou = 5  or                               ?         ||||
084800970602     C                             d0tiou = 3  and                              ?         ||||
084900970602     C                             d0stos <> 09  and                            ?         ||||
085000971104     C                             d0stos <> 08                                 ?         ||||
085100970602     C                   exsr      mod5pa                                       ?         ||||
085200970602?1v? C                   leave                                                  ?         ||||
085300970602?4e? C                   endif                                                  ?F-------04|||
085400970602?3e? C                   endif                                                  ?F--------03||
085500970626?2x? C                   else                                                   ?X.........02|
085600970626?1v? C                   leave                                                  ?           ||
085700970602?2e? C                   endif                                                  ?F---------02|
085800970602?1e? C                   enddo                                                  ?F----------01
085900961210     ?*-                                                   |
086000961210     C                   endsr
086100970704     ?******************************************************
086200970704      /SPACE
086300970704     ?******************************************************
086400970704     C     defe05        begsr
086500970704     ?** BUSCAR DATOS POR DEFECTO EN REHABILITACIONES------|
086600970704     C                   exsr      defe03
086700970704     ?*-                                                   |
086800970704     C                   endsr
086900971104     ?******************************************************
087000971104      /SPACE
087100971104     ?******************************************************
087200971104     C     defe38        begsr
087300971104     ?** BUSCAR DATOS POR DEFECTO ENDOSO AJUSTE PERIODO----|
087400971104     C     k4@ed4        chain(n)  p1hed4                             20
087500971104     C  n20              exsr      mod4pa
087600971104     ?*                                                    |
087700971104     C     k4@ed5        chain(n)  p1hed5                             20
087800971104     C  n20              exsr      mod5pa
087900971104     ?*-                                                   |
088000971104     C                   endsr
088100960716     ?******************************************************
088200960716      /SPACE
088300960716     ?******************************************************
088400961206     C     soli01        begsr
088500960716     ?** SOLICITUD EN PANTALLA 00--------------------------|
088600960716     ?*-                                                   |
088700960716     C                   endsr
088800960415     ?******************************************************
088900960415      /SPACE
089000960415     ?******************************************************
089100961210     C     vali01        begsr
089200960415     ?** GRABACION PANTALLA 00-----------------------------|
089300961220     ?* clasifica matrices...                              |
089400961220     C                   sorta     an
089500961220     C                   sorta     cl
089600961220     ?* eliminar repetidas y blancos intermedios...        |
089700961220     C                   eval      @an = *blanks
089800961220     C                   eval      @cl = *blanks
089900961220     C                   eval      y = 1
090000961220     C                   eval      z = 1
090100961220?1b? C                   do        30            x                              ?P----------01
090200961220     ?* primero los anexos...                              |     :              ?            |
090300961220?2b? C                   if        an(x) <> *blanks                             ?P---------02|
090400961220     C     an(x)         lookup    @an                                    20    ?           ||
090500961220     C  n20              eval      @an(y) = an(x)                               ?           ||
090600961220     C  n20              add       1             y                              ?           ||
090700961220?2e? C                   endif                                                  ?F---------02|
090800961220     ?* y luego las cláusulas...                           |     :              ?            |
090900961220?2b? C                   if        cl(x) <> *blanks                             ?P---------02|
091000961220     C     cl(x)         lookup    @cl                                    20    ?           ||
091100961220     C  n20              eval      @cl(z) = cl(x)                               ?           ||
091200961220     C  n20              add       1             z                              ?           ||
091300961220?2e? C                   endif                                                  ?F---------02|
091400961220?1e? C                   enddo                                                  ?F----------01
091500961220     ?* pasa a series para mostrar en pantalla...          |
091600961220     C                   eval      an = @an
091700961220     C                   eval      cl = @cl
091800000918     ?* ahora que quedó limpilo valido las cláusulas...    |
091900000918?1b? C                   if        t@ma28 = '1'  or                             ?P----------01
092000000918     C                             t@ma28 = '3'                                 ?            |
092100000918?2b? C                   do        30            x                              ?P---------02|
092200000918?3b? C                   if        cl(x) <> *blanks                             ?P--------03||
092300000918     C                   eval      @@clau = cl(x)                               ?          |||
092400000918     C     k1t127        chain     s1t127                             20        ?          |||
092500000918?4b? C                   if        *in20                                        ?P-------04|||
092600000918     C                   z-add     51            @e                   50        ?         ||||
092700000918?2v? C                   leave                                                  ?         ||||
092800000918?4e? C                   endif                                                  ?F-------04|||
092900000918?3e? C                   endif                                                  ?F--------03||
093000000918?2e? C                   enddo                                                  ?F---------02|
093100000918?1e? C                   endif                                                  ?F----------01
093200000918     ?* y si corresponde también los anexos...             |
093300000918?1b? C                   if        not *in50  and                               ?P----------01
093400000918     C                             t@ma28 = '2'  or                             ?            |
093500000918     C                             not *in50  and                               ?            |
093600000918     C                             t@ma28 = '3'                                 ?            |
093700000918?2b? C                   do        30            x                              ?P---------02|
093800000918?3b? C                   if        an(x) <> *blanks                             ?P--------03||
093900000919     C                   eval      @@anex = an(x)                               ?          |||
094000000919     C     k1t135        chain     s1t135                             20        ?          |||
094100000918?4b? C                   if        *in20                                        ?P-------04|||
094200000918     C                   z-add     52            @e                   50        ?         ||||
094300000918?2v? C                   leave                                                  ?         ||||
094400000918?4e? C                   endif                                                  ?F-------04|||
094500000918?3e? C                   endif                                                  ?F--------03||
094600000918?2e? C                   enddo                                                  ?F---------02|
094700000918?1e? C                   endif                                                  ?F----------01
094800961209     ?** SI NO EXISTEN ERRORES AVANZA...                   |
094900960415?1b? C                   if        not *in50                                    ?P----------01
095000960415     ?*- COMPARACION DE CAMPOS...                          ||                   ?            |
095100961220?2b? C                   if        cl(001) = $$ca01  and                        ?P---------02|
095200961220     C                             cl(002) = $$ca02  and                        ?           ||
095300961220     C                             cl(003) = $$ca03  and                        ?           ||
095400961220     C                             cl(004) = $$ca04  and                        ?           ||
095500961220     C                             cl(005) = $$ca05  and                        ?           ||
095600961220     C                             cl(006) = $$ca06  and                        ?           ||
095700961220     C                             cl(007) = $$ca07  and                        ?           ||
095800961220     C                             cl(008) = $$ca08  and                        ?           ||
095900961220     C                             cl(009) = $$ca09  and                        ?           ||
096000961220     C                             cl(010) = $$ca10  and                        ?           ||
096100961220     C                             cl(011) = $$ca11  and                        ?           ||
096200961220     C                             cl(012) = $$ca12  and                        ?           ||
096300961220     C                             cl(013) = $$ca13  and                        ?           ||
096400961220     C                             cl(014) = $$ca14  and                        ?           ||
096500961220     C                             cl(015) = $$ca15  and                        ?           ||
096600961220     C                             cl(016) = $$ca16  and                        ?           ||
096700961220     C                             cl(017) = $$ca17  and                        ?           ||
096800961220     C                             cl(018) = $$ca18  and                        ?           ||
096900961220     C                             cl(019) = $$ca19  and                        ?           ||
097000961220     C                             cl(020) = $$ca20  and                        ?           ||
097100961220     C                             cl(021) = $$ca21  and                        ?           ||
097200961220     C                             cl(022) = $$ca22  and                        ?           ||
097300961220     C                             cl(023) = $$ca23  and                        ?           ||
097400961220     C                             cl(024) = $$ca24  and                        ?           ||
097500961220     C                             cl(025) = $$ca25  and                        ?           ||
097600961220     C                             cl(026) = $$ca26  and                        ?           ||
097700961220     C                             cl(027) = $$ca27  and                        ?           ||
097800961220     C                             cl(028) = $$ca28  and                        ?           ||
097900961220     C                             cl(029) = $$ca29  and                        ?           ||
098000961220     C                             cl(030) = $$ca30  and                        ?           ||
098100961226     C                             an(001) = $$an01  and                        ?           ||
098200961226     C                             an(002) = $$an02  and                        ?           ||
098300961226     C                             an(003) = $$an03  and                        ?           ||
098400961226     C                             an(004) = $$an04  and                        ?           ||
098500961226     C                             an(005) = $$an05  and                        ?           ||
098600961226     C                             an(006) = $$an06  and                        ?           ||
098700961226     C                             an(007) = $$an07  and                        ?           ||
098800961226     C                             an(008) = $$an08  and                        ?           ||
098900961226     C                             an(009) = $$an09  and                        ?           ||
099000961226     C                             an(010) = $$an10  and                        ?           ||
099100961226     C                             an(011) = $$an11  and                        ?           ||
099200961226     C                             an(012) = $$an12  and                        ?           ||
099300961226     C                             an(013) = $$an13  and                        ?           ||
099400961226     C                             an(014) = $$an14  and                        ?           ||
099500961226     C                             an(015) = $$an15  and                        ?           ||
099600961226     C                             an(016) = $$an16  and                        ?           ||
099700961226     C                             an(017) = $$an17  and                        ?           ||
099800961226     C                             an(018) = $$an18  and                        ?           ||
099900961226     C                             an(019) = $$an19  and                        ?           ||
100000961226     C                             an(020) = $$an20  and                        ?           ||
100100961226     C                             an(021) = $$an21  and                        ?           ||
100200961226     C                             an(022) = $$an22  and                        ?           ||
100300961226     C                             an(023) = $$an23  and                        ?           ||
100400961226     C                             an(024) = $$an24  and                        ?           ||
100500961226     C                             an(025) = $$an25  and                        ?           ||
100600961226     C                             an(026) = $$an26  and                        ?           ||
100700961226     C                             an(027) = $$an27  and                        ?           ||
100800961226     C                             an(028) = $$an28  and                        ?           ||
100900961226     C                             an(029) = $$an29  and                        ?           ||
101000961226     C                             an(030) = $$an30  and                        ?           ||
101100961218     C                             *in90                                        ?           ||
101200961206     C                   eval      xxiden = 1                                   ?           ||
101300961206     C                   exsr      grab01                                       ?           ||
101400961218     C                   eval      @@mand = 'KA'                                ?           ||
101500961218     C                   eval      *inkc = '1'                                  ?           ||
101600960415     C                   setoff                                           90    ?           ||
101700960415?2x? C                   else                                                   ?X.........02|
101800961220     C                   eval      $$ca01 = cl(001)                             ?           ||
101900961220     C                   eval      $$ca02 = cl(002)                             ?           ||
102000961220     C                   eval      $$ca03 = cl(003)                             ?           ||
102100961220     C                   eval      $$ca04 = cl(004)                             ?           ||
102200961220     C                   eval      $$ca05 = cl(005)                             ?           ||
102300961220     C                   eval      $$ca06 = cl(006)                             ?           ||
102400961220     C                   eval      $$ca07 = cl(007)                             ?           ||
102500961220     C                   eval      $$ca08 = cl(008)                             ?           ||
102600961220     C                   eval      $$ca09 = cl(009)                             ?           ||
102700961220     C                   eval      $$ca10 = cl(010)                             ?           ||
102800961220     C                   eval      $$ca11 = cl(011)                             ?           ||
102900961220     C                   eval      $$ca12 = cl(012)                             ?           ||
103000961220     C                   eval      $$ca13 = cl(013)                             ?           ||
103100961220     C                   eval      $$ca14 = cl(014)                             ?           ||
103200961220     C                   eval      $$ca15 = cl(015)                             ?           ||
103300961220     C                   eval      $$ca16 = cl(016)                             ?           ||
103400961220     C                   eval      $$ca17 = cl(017)                             ?           ||
103500961220     C                   eval      $$ca18 = cl(018)                             ?           ||
103600961220     C                   eval      $$ca19 = cl(019)                             ?           ||
103700961220     C                   eval      $$ca20 = cl(020)                             ?           ||
103800961220     C                   eval      $$ca21 = cl(021)                             ?           ||
103900961220     C                   eval      $$ca22 = cl(022)                             ?           ||
104000961220     C                   eval      $$ca23 = cl(023)                             ?           ||
104100961220     C                   eval      $$ca24 = cl(024)                             ?           ||
104200961220     C                   eval      $$ca25 = cl(025)                             ?           ||
104300961220     C                   eval      $$ca26 = cl(026)                             ?           ||
104400961220     C                   eval      $$ca27 = cl(027)                             ?           ||
104500961220     C                   eval      $$ca28 = cl(028)                             ?           ||
104600961220     C                   eval      $$ca29 = cl(029)                             ?           ||
104700961220     C                   eval      $$ca30 = cl(030)                             ?           ||
104800961226     C                   eval      $$an01 = an(001)                             ?           ||
104900961226     C                   eval      $$an02 = an(002)                             ?           ||
105000961226     C                   eval      $$an03 = an(003)                             ?           ||
105100961226     C                   eval      $$an04 = an(004)                             ?           ||
105200961226     C                   eval      $$an05 = an(005)                             ?           ||
105300961226     C                   eval      $$an06 = an(006)                             ?           ||
105400961226     C                   eval      $$an07 = an(007)                             ?           ||
105500961226     C                   eval      $$an08 = an(008)                             ?           ||
105600961226     C                   eval      $$an09 = an(009)                             ?           ||
105700961226     C                   eval      $$an10 = an(010)                             ?           ||
105800961226     C                   eval      $$an11 = an(011)                             ?           ||
105900961226     C                   eval      $$an12 = an(012)                             ?           ||
106000961226     C                   eval      $$an13 = an(013)                             ?           ||
106100961226     C                   eval      $$an14 = an(014)                             ?           ||
106200961226     C                   eval      $$an15 = an(015)                             ?           ||
106300961226     C                   eval      $$an16 = an(016)                             ?           ||
106400961226     C                   eval      $$an17 = an(017)                             ?           ||
106500961226     C                   eval      $$an18 = an(018)                             ?           ||
106600961226     C                   eval      $$an19 = an(019)                             ?           ||
106700961226     C                   eval      $$an20 = an(020)                             ?           ||
106800961226     C                   eval      $$an21 = an(021)                             ?           ||
106900961226     C                   eval      $$an22 = an(022)                             ?           ||
107000961226     C                   eval      $$an23 = an(023)                             ?           ||
107100961226     C                   eval      $$an24 = an(024)                             ?           ||
107200961226     C                   eval      $$an25 = an(025)                             ?           ||
107300961226     C                   eval      $$an26 = an(026)                             ?           ||
107400961226     C                   eval      $$an27 = an(027)                             ?           ||
107500961226     C                   eval      $$an28 = an(028)                             ?           ||
107600961226     C                   eval      $$an29 = an(029)                             ?           ||
107700961226     C                   eval      $$an30 = an(030)                             ?           ||
107800960415     C                   seton                                            90    ?           ||
107900960415?2e? C                   endif                                                  ?F---------02|
108000960415?1e? C                   endif                                                  ?F----------01
108100960426     ?*- SI EXISTEN ERRORES...                             |
108200040419     C                   exsr      reset_pan
108300960415     ?*-                                                   |
108400960415     C                   endsr
108500960415     ?******************************************************
108600960415      /SPACE
108700960415     ?******************************************************
108800961206     C     grab01        begsr
108900961206     ?** GRABACION PANTALLA 01-----------------------------|
109000961219     ?* grabacion PAHED4...                                |
109100961219     C     k2@ed4        chain     p1hed4                             20
109200961219     C                   eval      d4empr = z0empr
109300961219     C                   eval      d4sucu = z0sucu
109400961219     C                   eval      d4arcd = z0arcd
109500961219     C                   eval      d4spol = z0spol
109600961219     C                   eval      d4sspo = z0sspo
109700961219     C                   eval      d4rama = z0rama
109800961219     C                   eval      d4arse = z0arse
109900961219     C                   eval      d4oper = z0oper
110000961219     C                   eval      d4suop = z0suop
110100961219     C                   eval      d4cert = *zeros
110200961219     C                   eval      d4poli = *zeros
110300961220     C                   eval      d4ca01 = cl(001)
110400961220     C                   eval      d4ca02 = cl(002)
110500961220     C                   eval      d4ca03 = cl(003)
110600961220     C                   eval      d4ca04 = cl(004)
110700961220     C                   eval      d4ca05 = cl(005)
110800961220     C                   eval      d4ca06 = cl(006)
110900961220     C                   eval      d4ca07 = cl(007)
111000961220     C                   eval      d4ca08 = cl(008)
111100961220     C                   eval      d4ca09 = cl(009)
111200961220     C                   eval      d4ca10 = cl(010)
111300961220     C                   eval      d4ca11 = cl(011)
111400961220     C                   eval      d4ca12 = cl(012)
111500961220     C                   eval      d4ca13 = cl(013)
111600961220     C                   eval      d4ca14 = cl(014)
111700961220     C                   eval      d4ca15 = cl(015)
111800961220     C                   eval      d4ca16 = cl(016)
111900961220     C                   eval      d4ca17 = cl(017)
112000961220     C                   eval      d4ca18 = cl(018)
112100961220     C                   eval      d4ca19 = cl(019)
112200961220     C                   eval      d4ca20 = cl(020)
112300961220     C                   eval      d4ca21 = cl(021)
112400961220     C                   eval      d4ca22 = cl(022)
112500961220     C                   eval      d4ca23 = cl(023)
112600961220     C                   eval      d4ca24 = cl(024)
112700961220     C                   eval      d4ca25 = cl(025)
112800961220     C                   eval      d4ca26 = cl(026)
112900961220     C                   eval      d4ca27 = cl(027)
113000961220     C                   eval      d4ca28 = cl(028)
113100961220     C                   eval      d4ca29 = cl(029)
113200961220     C                   eval      d4ca30 = cl(030)
113300961219     C                   eval      d4marp = '0'
113400961219     C                   eval      d4strg = '0'
113500961219     C                   eval      d4user = vsuser
113600961219     C                   time                    d4time
113700961219     C                   eval      d4date = udate
113800961219     C   20              write     p1hed4
113900961219     C  n20              update    p1hed4
114000961219     ?* grabacion PAHED5...                                |
114100961219     C     k2@ed5        chain     p1hed5                             20
114200961219     C                   eval      d5empr = z0empr
114300961219     C                   eval      d5sucu = z0sucu
114400961219     C                   eval      d5arcd = z0arcd
114500961219     C                   eval      d5spol = z0spol
114600961219     C                   eval      d5sspo = z0sspo
114700961219     C                   eval      d5rama = z0rama
114800961219     C                   eval      d5arse = z0arse
114900961219     C                   eval      d5oper = z0oper
115000961219     C                   eval      d5suop = z0suop
115100961219     C                   eval      d5cert = *zeros
115200961219     C                   eval      d5poli = *zeros
115300961220     C                   eval      d5an01 = an(001)
115400961220     C                   eval      d5an02 = an(002)
115500961220     C                   eval      d5an03 = an(003)
115600961220     C                   eval      d5an04 = an(004)
115700961220     C                   eval      d5an05 = an(005)
115800961220     C                   eval      d5an06 = an(006)
115900961220     C                   eval      d5an07 = an(007)
116000961220     C                   eval      d5an08 = an(008)
116100961220     C                   eval      d5an09 = an(009)
116200961220     C                   eval      d5an10 = an(010)
116300961220     C                   eval      d5an11 = an(011)
116400961220     C                   eval      d5an12 = an(012)
116500961220     C                   eval      d5an13 = an(013)
116600961220     C                   eval      d5an14 = an(014)
116700961220     C                   eval      d5an15 = an(015)
116800961220     C                   eval      d5an16 = an(016)
116900961220     C                   eval      d5an17 = an(017)
117000961220     C                   eval      d5an18 = an(018)
117100961220     C                   eval      d5an19 = an(019)
117200961220     C                   eval      d5an20 = an(020)
117300961220     C                   eval      d5an21 = an(021)
117400961220     C                   eval      d5an22 = an(022)
117500961220     C                   eval      d5an23 = an(023)
117600961220     C                   eval      d5an24 = an(024)
117700961220     C                   eval      d5an25 = an(025)
117800961220     C                   eval      d5an26 = an(026)
117900961220     C                   eval      d5an27 = an(027)
118000961220     C                   eval      d5an28 = an(028)
118100961220     C                   eval      d5an29 = an(029)
118200961220     C                   eval      d5an30 = an(030)
118300961219     C                   eval      d5marp = '0'
118400961219     C                   eval      d5strg = '0'
118500961219     C                   eval      d5user = vsuser
118600961219     C                   time                    d5time
118700961219     C                   eval      d5date = udate
118800961219     C   20              write     p1hed5
118900961219     C  n20              update    p1hed5
119000961218     ?*- ACTUALIZA MARCA EN PAWPD0...                      |
119100961218     C     k1@pd0        chain     p1wpd0                             20
119200961219     C  n20              eval      z0wp03 = 1
119300961218     C  n20              update    p1wpd0
119400040419     ?* Actualiza marca para navegador...
119500040419     C     k1@pd0        chain     pawp310
119600040419?1b? C                   if        %found(pawp310)                              ?P----------01
119700040419     C                   eval      @@in23 = *on                                 ?            |
119800040419     C                   eval      z0wp03lk = 1                                 ?            |
119900040419     C                   update    p1wp310                                      ?            |
120000040419?1e? C                   endif                                                  ?F----------01
120100960415     ?*-                                                   |
120200960415     C                   endsr
120300961206     ?******************************************************
120400961206      /SPACE
120500961206     ?******************************************************
120600961206     C     apagar        begsr
120700961206     ?** APAGAR INDICADORES DE ERROR-----------------------|
120800961206     C                   eval      @e = *zeros
120900961213     C                   setoff                                       404142
121000961213     C                   setoff                                       434445
121100961213     C                   setoff                                       434748
121200961213     C                   setoff                                           49
121300961206     C                   setoff                                       505152
121400961206     C                   setoff                                       535455
121500961206     C                   setoff                                       565758
121600961206     C                   setoff                                       596061
121700961206     C                   setoff                                       626364
121800961206     C                   setoff                                       656667
121900961206     C                   setoff                                       686970
122000961206     C                   setoff                                       717273
122100961206     C                   setoff                                       747576
122200961206     C                   setoff                                       777879
122300961206     C                   setoff                                       808182
122400961206     C                   setoff                                       838485
122500961206     C                   setoff                                       898788
122600961206     C                   setoff                                           89
122700961206     ?*-                                                   |
122800961206     C                   endsr
122900961209     ?******************************************************
123000961209      /SPACE
123100961209     ?******************************************************
123200961209     C     srclos        begsr
123300961209     ?** FINAL DE PROGRAMA---------------------------------|
123400961209     ?*-                                                   |
123500961209     C                   endsr
123600961206     ?******************************************************
123700961206      /SPACE
123800961206     ?******************************************************
123900040419     Csr   reset_pan     begsr
124000040419     ?** RESETEA INDICADORES DE WINDOW
124100040419?1b? C                   if        *in50  and                                   ?P----------01
124200040419     C                             @e <> *zeros                                 ?            |
124300040419     C                             or                                           ?            |
124400040419     C                             not *in50 and @@in23                         ?            |
124500040419     C                   write     par31001                                     ?            |
124600040419     C                   eval      *in23 = @@in23                               ?            |
124700040419?2b? C                   if        *in50                                        ?P---------02|
124800040419     ?* Si hay errores.                                                         ?           ||
124900040419     C                   setoff                                           90    ?           ||
125000040419     C                   eval      *in(@e) = '1'                                ?           ||
125100040419?2e? C                   endif                                                  ?F---------02|
125200040419?1e? C                   endif                                                  ?F----------01
125300040419     ?*
125400040419     Csr                 endsr
125500040419     ?******************************************************
125600040419      /SPACE
125700040419     ?******************************************************
