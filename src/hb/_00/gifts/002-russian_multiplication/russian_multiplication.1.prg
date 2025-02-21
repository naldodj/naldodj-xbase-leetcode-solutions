/*
    Russian Multiplication

    Exemplo em PowerShell:
    //-----------------------------------------------------------------------------------
    function ps_rMult([int]$a,[int]$b){
         $r=0;
         do {
             "$a x $b";
             if (($a%2)-and($a -gt 0)){
                 $r+=$b;
                 "`t+$b";
                 $a--;
             }
             $a=$a/2;
             $b=$b*2;
         } until ($a -eq 0);
         "result:$r";
    }
    ps_rMult 340 125

    340 x 125
    170 x 250
     85 x 500
                +500
     42 x 1000
     21 x 2000
                +2000
     10 x 4000
      5 x 8000
                +8000
      2 x 16000
      1 x 32000
                +32000
     result:   42500

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
procedure Main()

    local aInputs as array

    local cHTML as character

    local cOutPut as logical

    local lMatched as logical

    local nIdx as numeric

   // Casos de teste definidos
    aInputs:=Array(0)

    // Exemplo: 340 x 125 (como no PowerShell)
    aAdd(aInputs,{"42500","340","125",.F.,.T.})// Caso 1

    aAdd(aInputs,{"39483","123","321",.F.,.F.})// Caso 2
    aAdd(aInputs,{"5332114","1234","4321",.F.,.F.})// Caso 3
    aAdd(aInputs,{"670592745","12345","54321",.F.,.F.})// Caso 4
    aAdd(aInputs,{"80779853376","123456","654321",.F.,.F.})// Caso 5
    aAdd(aInputs,{"9449772114007","1234567","7654321",.F.,.F.})// Caso 6
    aAdd(aInputs,{"1082152022374638","12345678","87654321",.F.,.F.})// Caso 7
    aAdd(aInputs,{"121932631112635269","123456789","987654321",.F.,.F.})// Caso 8
    aAdd(aInputs,{"10989704241","87589","125469",.F.,.F.})// Caso 9
    aAdd(aInputs,{"317894204559700","15121970","21022010",.F.,.F.})// Caso 10
    aAdd(aInputs,{"3493563288039056627687700","317894204559700","10989704241",.F.,.F.})// Caso 11
    aAdd(aInputs,{"14867566530049990397812181822702361","121932631112635269","121932631112635269",.F.,.F.})// Caso 12
    aAdd(aInputs,{"22104453452546271203067005842684145330432044859158276335785679497432100","148675665300499903978121818227023610","148675665300499903978121818227023610",.F.,.F.})// Caso 13

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<caption>"+ProcName()+"</caption>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input(1)</th>"
    cHTML+=            "<th>*</th>"
    cHTML+=            "<th>Input(2)</th>"
    cHTML+=            "<th>=</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"

    // Itera sobre os casos de teste
    for nIdx:=1 to Len(aInputs)
        if ((nIdx>1).and.aInputs[1][4])
            aInputs[nIdx][5]:=.F.
        else
            aInputs[nIdx][5]:=.T.
        endif
        if (aInputs[nIdx][5])
            cOutPut:=RussianMultiplication(aInputs[nIdx][2],aInputs[nIdx][3],aInputs[nIdx][4]) // Resultado da função ChineseMultiplication
            lMatched:=(hb_JSONEncode(cOutPut)==hb_JSONEncode(aInputs[nIdx][1])) // Verifica correspondência com o esperado
            // Gera uma linha na tabela HTML
            cHTML+=        "<tr>"
            cHTML+=            "<td align='right' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][2])+"</td>"
            cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>*</td>"
            cHTML+=            "<td align='right' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][3])+"</td>"
            cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>=</td>"
            cHTML+=            "<td align='right' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(cOutPut)+"</td>"
            cHTML+=            "<td align='right' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
            cHTML+=            "<td align='right' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
            cHTML+=        "</tr>"
        endif
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

/* -------------------------------------------------------------
   RussianMultiplication(cN1,cN2,lTrace)
   Recebe dois números em formato string (cN1,cN2,lTrace)
   e exibe o processo passo a passo,retornando o resultado
   também como string.
   ------------------------------------------------------------- */
static function RussianMultiplication(cN1,cN2,lTrace)

    local cTab as character
    local cTmpN1 as character
    local cTmpN2 as character
    local cResultado as character

    cTab:=Replicate("&nbsp;",8)
    cTmpN1:=cN1
    cTmpN2:=cN2
    cResultado:="0"

    hb_default(@lTrace,.F.)

    while (!BigIsZero(cTmpN1))
        // Exibe passo a passo
        if (lTrace)
            ? cTmpN1+" x "+cTmpN2,"<br/>"
        endif
        // Se cTmpN1 for ímpar,soma cTmpN2 ao resultado e decrementa cTmpN1
        if (BigIsOdd(cTmpN1))
            cResultado:=BigAdd(cResultado,cTmpN2)
            // Exibe passo a passo
            if (lTrace)
                ? cTab,"+" +cTmpN2,"<br/>"
            endif
            cTmpN1:=BigSubOne(cTmpN1) // Subtrai 1
        endif
        // Divide cTmpN1 por 2
        cTmpN1:=BigHalve(cTmpN1)
        // Dobra cTmpN2
        cTmpN2:=BigDouble(cTmpN2)
    end while

    // Exibe passo a passo
    if (lTrace)
      ? "result: "+cResultado,"<br/>"
    endif

    return(cResultado)

/* -------------------------------------------------------------
   BigIsZero(cNum)
   Verifica se a string numérica é zero.
   ------------------------------------------------------------- */
static function BigIsZero(cNum as character)
   // Remove zeros à esquerda para evitar "000..."
   cNum:=BigTrimLeftZeros(cNum)
   return((cNum=="").or.(cNum=="0"))

/* -------------------------------------------------------------
   BigIsOdd(cNum)
   Verifica se o número (string) é ímpar,
   checando apenas o último dígito.
   ------------------------------------------------------------- */
static function BigIsOdd(cNum as character)
   local cLast as character
   local nLast as numeric
   cLast:=Right(cNum,1)
   nLast:=Val(cLast)
   return(nLast%2==1)

/* -------------------------------------------------------------
   BigAdd(cNum1,cNum2)
   Soma de duas strings numéricas,retorna string.
   ------------------------------------------------------------- */
static function BigAdd(cNum1,cNum2)

    local cRes as character

    local nCarry as numeric
    local nMaxLen,i as numeric
    local n1,n2,nSum as numeric

    cRes:=""
    nCarry:=0

    // Remove zeros à esquerda para cada número
    cNum1:=BigTrimLeftZeros(cNum1)
    cNum2:=BigTrimLeftZeros(cNum2)

    // Se um deles for vazio,significa que era zero
    if (Empty(cNum1))
        return(iif(Empty(cNum2),"0",cNum2))
    elseif Empty(cNum2)
        return(cNum1)
    endif

    // Ajusta comprimento
    if (Len(cNum1)>Len(cNum2))
        cNum2:=(Replicate("0",Len(cNum1)-Len(cNum2))+cNum2)
    elseif (Len(cNum2)>Len(cNum1))
        cNum1:=(Replicate("0",Len(cNum2)-Len(cNum1))+cNum1)
    endif

    nMaxLen:=Len(cNum1)

    // Soma de trás pra frente
    for i:=nMaxLen to 1 step -1
        n1:=Val(SubStr(cNum1,i,1))
        n2:=Val(SubStr(cNum2,i,1))
        nSum:=((n1+n2)+nCarry)
        nCarry:=Int(nSum/10)
        cRes:=(LTrim(Str(Mod(nSum,10),1))+cRes)
    next i

    // Se sobrou carry
    if (nCarry>0)
        cRes:=LTrim(Str(nCarry,1))+cRes
    endif

    cRes:=BigTrimLeftZeros(cRes)

    return(cRes)

/* -------------------------------------------------------------
   BigDouble(cNum)
   Dobra o valor numérico passado em string (cNum*2).
   ------------------------------------------------------------- */
static function BigDouble(cNum as character)
   local cRes as character
   cRes:=BigAdd(cNum,cNum)
   return(cRes)

/* -------------------------------------------------------------
   BigSubOne(cNum)
   Subtrai 1 de uma string numérica (assume cNum > 0).
   ------------------------------------------------------------- */
static function BigSubOne(cNum as character)

    local cRes as character

    local i,nVal as numeric
    local nCarry as numeric

    cRes:=""
    nCarry:=1

    // Remove zeros à esquerda
    cNum:=BigTrimLeftZeros(cNum)
    if (Empty(cNum))
        return("0")
    endif

    // Subtração de 1,da direita pra esquerda
    for i:=Len(cNum) to 1 step -1
        nVal:=Val(SubStr(cNum,i,1))
        if (nVal>=nCarry)
            nVal-=nCarry
            nCarry:=0
        else
            nVal:=10+nVal-nCarry
            nCarry:=1
      endif
        cRes:=(LTrim(Str(nVal,1))+cRes)
    next i

    cRes:=BigTrimLeftZeros(cRes)

    return(cRes)

/* -------------------------------------------------------------
   BigHalve(cNum)
   Divide o número (string) por 2 (divisão inteira).
   ------------------------------------------------------------- */
static function BigHalve(cNum as character)

    local cRes as character

    local i,nVal,nDiv as numeric
    local nCarry as numeric

    cRes:=""
    nCarry:=0

    // Remove zeros à esquerda
    cNum:=BigTrimLeftZeros(cNum)
    if (Empty(cNum))
        return("0")
    endif

    // Percorre da esquerda pra direita
    for i:=1 to Len(cNum)
        nVal:=((nCarry*10)+Val(SubStr(cNum,i,1)))
        nDiv:=Int(nVal/2)
        nCarry:=Mod(nVal,2)
        cRes+=LTrim(Str(nDiv,1))
    next i

    cRes:=iif(Empty(BigTrimLeftZeros(cRes)),"0",BigTrimLeftZeros(cRes))

    return(cRes)

/* -------------------------------------------------------------
   BigTrimLeftZeros(cNum)
   Remove zeros à esquerda de uma string numérica.
   ------------------------------------------------------------- */
static function BigTrimLeftZeros(cNum as character)

    local nPos as numeric

    nPos:=1

    // Encontra a primeira posição != '0'
    while (nPos<=Len(cNum).and.(SubStr(cNum,nPos,1)=="0"))
        nPos++
    end while

    if (nPos>Len(cNum))
        return("")
    else
        return(SubStr(cNum,nPos))
    endif
