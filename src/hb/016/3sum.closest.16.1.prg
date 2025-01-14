/*
    16. 3Sum Closest

    Given an integer array nums of length n and an integer target, find three integers in nums such that the sum is closest to target.

    Return the sum of the three integers.

    You may assume that each input would have exactly one solution.

    Example 1:

    Input: nums = [-1,2,1,-4], target = 1
    Output: 2
    Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).

    Example 2:

    Input: nums = [0,0,0], target = 1
    Output: 0
    Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).

    Constraints:

    3 <= nums.length <= 500
    -1000 <= nums[i] <= 1000
    -10^4 <= target <= 10^4

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    /*
        aInputs contém conjuntos de casos de teste. Cada entrada é uma matriz de dois elementos:
        - O primeiro elemento é o valor esperado (triplets que somam 0).
        - O segundo elemento é o array de entrada para testar a função ThreeSum.
    */
    local aInput as array
    local aInputs as array

    /*
        cHTML armazena a saída em formato HTML. Isso facilita a visualização dos resultados
        em uma tabela formatada, destacando correspondências entre a saída e o valor esperado.
    */
    local cHTML as character

    local lMatched as logical

    local nIdx as numeric
    local nOutPut as numeric

    aInputs:=Array(0)

    // Casos de teste definidos
    aAdd(aInputs,{2,{{-1,2,1,-4},1}})
    aAdd(aInputs,{0,{{0,0,0},1}})

    /*
        Construção da tabela HTML que será gerada como saída.
        Inclui cabeçalhos e estilos para facilitar a leitura.
    */
    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"

    // Itera sobre os casos de teste
    for nIdx:=1 to Len(aInputs)
        aInput:=aInputs[nIdx][2] // Entrada atual
        nOutPut:=ThreeSumClosest(aClone(aInput[1]),aInput[2]) // Resultado da função ThreeSumClosest
        lMatched:=(nOutPut==aInputs[nIdx][1]) // Verifica correspondência com o esperado
        // Gera uma linha na tabela HTML
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(nOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

static function ThreeSumClosest(aNums as array,nTarget as numeric)

    local lClosestSum as logical

    local n as numeric
    local nClosestSum as numeric
    local i, nLeft, nRight, nCurrentSum as numeric

    n:=Len(aNums)

    // Ordenar o array
    aSort(aNums)

    lClosestSum:=.F.

    begin sequence

        // Iterar por cada elemento, fixando-o
        for i:=1 to n-2

            nLeft:=i+1
            nRight:=n

            // Usar dois ponteiros para buscar a soma mais próxima
            while (nLeft<nRight)

                nCurrentSum:=(aNums[i]+aNums[nLeft]+aNums[nRight])

                // Atualizar a soma mais próxima
                if ((!lClosestSum).or.(ABS(nCurrentSum-nTarget)<ABS(nClosestSum-nTarget)))
                    lClosestSum:=.T.
                    nClosestSum:=nCurrentSum
                endif

                // Ajustar ponteiros
                if (nCurrentSum<nTarget)
                    nLeft++
                elseif (nCurrentSum>nTarget)
                    nRight--
                else
                    nClosestSum:=nCurrentSum // Encontro exato
                    break
                endif

            end while

        next

    end sequence

   return(nClosestSum) as numeric
