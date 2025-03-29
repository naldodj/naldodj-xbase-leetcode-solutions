/*
    Chinese Multiplication

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
function Main()
    return(Chinese_Multiplication())

static function Chinese_Multiplication()

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
        cOutPut:=ChineseMultiplication(aInputs[nIdx][2],aInputs[nIdx][3]) // Resultado da função ChineseMultiplication
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

    return(nil)

static function ChineseMultiplication(cN1 as character,cN2 as character)

   local aGrid as array
   local aDiagonalSums as array

   local cResult as character

   local i as numeric
   local j as numeric

   local nSum as numeric
   local nCarry as numeric
   local nDigit as numeric
   local nMaxLen as numeric
   local nN1Digits as numeric
   local nN2Digits as numeric

   nN1Digits:=Len(cN1)
   nN2Digits:=Len(cN2)
   nMaxLen:=((nN1Digits+nN2Digits)-1)

   // Inicializa o array que armazenará a soma dos produtos de cada diagonal
   aDiagonalSums:=Array(nMaxLen)
   for i:=1 to nMaxLen
      aDiagonalSums[i]:=0
   next i

   // Cria a matriz para armazenar os produtos individuais dos dígitos
   aGrid:=Array(nN1Digits,nN2Digits)
   for i:=1 to nN1Digits
      for j:=1 to nN2Digits
         aGrid[i][j]:=Val(SubStr(cN1,i,1))*Val(SubStr(cN2,j,1))
      next j
   next i

   // Soma os produtos nas diagonais correspondentes
   for i:=1 to nN1Digits
      for j:=1 to nN2Digits
         aDiagonalSums[i+j-1]+=aGrid[i,j]
      next j
   next i

   cResult:=""
   nCarry:=0

   // Processa as diagonais para compor o resultado final (em formato string), tratando os "vai um"
   // Processa da última diagonal (menos significativa) até a primeira
   for i:=nMaxLen to 1 step -1
      nSum:=(aDiagonalSums[i]+nCarry)
      nCarry:=Int(nSum/10) // Parte inteira da divisão por 10
      nDigit:=(nSum-(nCarry*10)) // Resto da divisão por 10
      cResult:=Chr(48+nDigit)+cResult
   next i

   // Enquanto houver nCarry, extrai seus dígitos e os adiciona à esquerda
   while (nCarry>0)
      nDigit:=(nCarry-(Int(nCarry/10)*10))
      nCarry:=Int(nCarry/10)
      cResult:=(Chr(48+nDigit)+cResult)
   end while

   return(cResult)
