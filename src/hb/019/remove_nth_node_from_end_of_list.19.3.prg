/*
    19. Remove Nth Node From End of List

    Given the head of a linked list, remove the nth node from the end of the list and return its head.

    Example 1:
    Input: head = [1,2,3,4,5], n = 2
    Output: [1,2,3,5]

    Example 2:
    Input: head = [1], n = 1
    Output: []

    Example 3:
    Input: head = [1,2], n = 1
    Output: [1]

    Constraints:

    The number of nodes in the list is sz.
    1 <= sz <= 30
    0 <= Node.val <= 100
    1 <= n <= sz

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local aInput as array
    local aInputs as array
    local aOutPut as array

    local cHTML as character

    local lMatched as logical

    local nIdx as numeric
    local nTarget as numeric

    aInputs:=Array(0)

    // Casos de teste definidos
    aAdd(aInputs,{{1,2,3,5},{1,2,3,4,5},2})// Caso 1
    aAdd(aInputs,{{},{1},1})// Caso 2
    aAdd(aInputs,{{1},{1,2},1})// Caso 3
    aAdd(aInputs,{{2},{1,2},2}) // Caso 4
    aAdd(aInputs,{{},{},1})// Caso 5 (edge case)
    aAdd(aInputs,{{1,2,3,4,5},{1,2,3,4,5},0})// Caso 6 (edge case)

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<caption>"+ProcName()+"</caption>"
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
        nTarget:=aInputs[nIdx][3] // Valor de n
        aOutPut:=removeNthFromEnd(aInput,nTarget) // Resultado da função removeNthFromEnd
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

static function removeNthFromEnd(aNums as array, nTarget as numeric)

    local aResult as array
    local nSize as numeric
    local nNthNode as numeric
    local i as numeric
    local nNewIdx as numeric

    nSize:=Len(aNums)
    aResult:=Array(Max(nSize-1,0)) // Cria um array com tamanho reduzido

    if ((nTarget>0).and.(nSize>0))

        nNthNode:=((nSize - nTarget) + 1)
        nNthNode:=Max(Min(nNthNode, nSize), 1)

        nNewIdx:=1
        for i:=1 to nSize
            if (i!=nNthNode) // Copia apenas os elementos que não devem ser removidos
                aResult[nNewIdx]:=aNums[i]
                nNewIdx++
            endif
        next i

    else

        aResult:=aClone(aNums) // Retorna o array original se nTarget for inválido

    endif

    return(aResult) as array
