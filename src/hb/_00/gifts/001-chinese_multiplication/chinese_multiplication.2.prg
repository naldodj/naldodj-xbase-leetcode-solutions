/*
    Chinese Multiplication

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
    aAdd(aInputs,{"39483","123","321"})// Caso 1
    aAdd(aInputs,{"5332114","1234","4321"})// Caso 2
    aAdd(aInputs,{"670592745","12345","54321"})// Caso 3
    aAdd(aInputs,{"80779853376","123456","654321"})// Caso 4
    aAdd(aInputs,{"9449772114007","1234567","7654321"})// Caso 5
    aAdd(aInputs,{"1082152022374638","12345678","87654321"})// Caso 6
    aAdd(aInputs,{"121932631112635269","123456789","987654321"})// Caso 7
    aAdd(aInputs,{"10989704241","87589","125469"})// Caso 8
    aAdd(aInputs,{"317894204559700","15121970","21022010"})// Caso 9
    aAdd(aInputs,{"3493563288039056627687700","317894204559700","10989704241"})// Caso 10
    aAdd(aInputs,{"12204984447534264545287191518481535614248731290000","3493563288039056627687700","3493563288039056627687700"})// Caso 11

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
        cOutPut:=ChineseMultiplication(aInputs[nIdx][2],aInputs[nIdx][3]) // cResultado da função ChineseMultiplication
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
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

static function ChineseMultiplication(cN1 as string,cN2 as string)

    local aDiagonalnSums as array

    local nN1Len as numeric
    local nN2Len as numeric
    local nMaxLen as numeric

    local cResult as string

    local i,j as numeric
    local nSum as numeric
    local nCarry as numeric

    nSum:=0
    nCarry:=0
    cResult:=""

    nN1Len:=Len(cN1)
    nN2Len:=Len(cN2)
    nMaxLen:=((nN1Len+nN2Len)-1)

    aDiagonalnSums:=Array(nMaxLen)

    // Inicializa array de somas das diagonais
    aFill(aDiagonalnSums,0)

    // Calcula produtos e soma diretamente nas diagonais
    for i:=1 to nN1Len
        for j:=1 to nN2Len
            aDiagonalnSums[i+j-1]+=Val(SubStr(cN1,i,1))*Val(SubStr(cN2,j,1))
        next j
    next i

    // Processa diagonais e constrói cResultado como string
    for i:=nMaxLen to 1 step -1
        nSum:=(aDiagonalnSums[i]+nCarry)
        nCarry:=Int(nSum/10)
        cResult:=Str(nSum%10,1)+cResult
    next i

    // Adiciona nCarry restante, se houver
    if (nCarry>0)
        cResult:=hb_NToC(nCarry)+cResult
    endif

    return(cResult)
