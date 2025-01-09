/*
    15. 3Sum

    Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

    Notice that the solution set must not contain duplicate triplets.

    Example 1:

    Input: nums = [-1,0,1,2,-1,-4]
    Output: [[-1,-1,2],[-1,0,1]]
    Explanation:
    nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
    nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
    nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
    The distinct triplets are [-1,0,1] and [-1,-1,2].
    Notice that the order of the output and the order of the triplets does not matter.

    Example 2:

    Input: nums = [0,1,1]
    Output: []
    Explanation: The only possible triplet does not sum up to 0.
    Example 3:

    Input: nums = [0,0,0]
    Output: [[0,0,0]]
    Explanation: The only possible triplet sums up to 0.

    Constraints:

    3 <= nums.length <= 3000
    -10^5 <= nums[i] <= 10^5

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
    local aOutPut as array

    /*
        cHTML armazena a saída em formato HTML. Isso facilita a visualização dos resultados
        em uma tabela formatada, destacando correspondências entre a saída e o valor esperado.
    */
    local cHTML as character

    local lMatched as logical

    local nIdx as numeric

    aInputs:=Array(0)

    // Casos de teste definidos
    aAdd(aInputs,{{{-1,-1,2},{-1,0,1}},{-1,0,1,2,-1,-4}})
    aAdd(aInputs,{{},{0,1,1}})
    aAdd(aInputs,{{{0,0,0}},{0,0,0}})

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
        aOutPut:=ThreeSum(aInput) // Resultado da função ThreeSum
        lMatched:=(hb_JSONEncode(aOutPut)==hb_JSONEncode(aInputs[nIdx][1])) // Verifica correspondência com o esperado
        // Gera uma linha na tabela HTML
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

/*
    Função ThreeSum:
    Identifica todos os triplets em um array que somam exatamente 0. Evita duplicatas.
*/
static function ThreeSum(aNums as array)

    /*
        Variáveis principais:
        - aResult: Armazena os triplets encontrados.
        - aSortedNums: Array ordenado da entrada.
        - Ponteiros nLeft e nRight para busca eficiente de pares complementares.
    */
    local aResult as array
    local aSortedNums as array

    local i,nLen,nLeft,nRight,nCurrentSum as numeric

    // Copia e Ordena a entrada para facilitar o processamento
    aSortedNums:=aSort(aClone(aNums))
    nLen:=Len(aSortedNums)
    aResult:=Array(0)

    // Iteração sobre o array, fixando um elemento em cada ciclo
    for i:=1 to nLen-2

        // Ignora elementos duplicados para evitar resultados repetidos
        if ((i>1).and.aSortedNums[i]==aSortedNums[i-1])
            loop
        endif

        // Define ponteiros para os elementos subsequentes
        nLeft:=i+1
        nRight:=nLen

        // Busca por pares cuja soma, junto com o elemento fixado, seja 0
        while (nLeft<nRight)

            nCurrentSum:=aSortedNums[i]
            nCurrentSum+=aSortedNums[nLeft]
            nCurrentSum+=aSortedNums[nRight]

            if (nCurrentSum==0)

                // Adiciona o triplet ao resultado
                aAdd(aResult,{aSortedNums[i],aSortedNums[nLeft],aSortedNums[nRight]})

                // Move os ponteiros para evitar duplicatas
                while ((nLeft<nRight).and.(aSortedNums[nLeft]==aSortedNums[nLeft+1]))
                    nLeft++
                end while

                while ((nLeft<nRight).and.(aSortedNums[nRight]==aSortedNums[nRight-1]))
                    nRight--
                end while

                nLeft++
                nRight--

            elseif (nCurrentSum<0)

                // Incrementa ponteiro esquerdo se a soma for menor que 0
                nLeft++

            else

                // Decrementa ponteiro direito se a soma for maior que 0
                nRight--

            endif

        end while

    next i

    // Retorna o array de triplets encontrados
    return(aResult) as array
