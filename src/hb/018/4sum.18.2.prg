/*
    18. 4Sum

    Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:

    0 <= a, b, c, d < n
    a, b, c, and d are distinct.
    nums[a] + nums[b] + nums[c] + nums[d] == target

    You may return the answer in any order.

    Example 1:
    Input: nums = [1,0,-1,0,-2,2], target = 0
    Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]

    Example 2:
    Input: nums = [2,2,2,2,2], target = 8
    Output: [[2,2,2,2]]

    Constraints:

        1 <= nums.length <= 200
    -10^9 <= nums[i] <= 10^9
    -10^9 <= target <= 10^9

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
    aAdd(aInputs,{{{-2,-1,1,2},{-2,0,0,2},{-1,0,0,1}},{1,0,-1,0,-2,2},0})
    aAdd(aInputs,{{{2,2,2,2}},{2,2,2,2,2},8})

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
        nTarget:=aInputs[nIdx][3]
        aOutPut:=FourSum(aInput,nTarget) // Resultado da função FourSum
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

static function FourSum(aNums as array,nTarget as numeric)

    local aResult as array
    local i, j, k, l,nLen,nSum as numeric

    aResult:=Array(0)
    nLen:=Len(aNums)

    // Ordena o array para facilitar a busca
    aSort( aNums )

    for i:=1 to nLen-3
        // Evita duplicatas para o primeiro número
        if (i>1).and.(aNums[i]==aNums[i-1])
            loop
        endif
        for j:=i+1 to nLen-2
            // Evita duplicatas para o segundo número
            if (j>i+1).and.(aNums[j]==aNums[j-1])
                loop
            endif
            k:=j+1
            l:=nLen
            while (k<l)
                nSum:=aNums[i]+aNums[j]+aNums[k]+aNums[l]
                if (nSum==nTarget)
                    aAdd(aResult,{aNums[i],aNums[j],aNums[k],aNums[l]})
                    // Evita duplicatas para o terceiro número
                    while (k<l).and.(aNums[k]==aNums[k+1])
                        k++
                    end while
                    // Evita duplicatas para o quarto número
                    while ((k<l).and.(aNums[l]==aNums[l-1]))
                        l--
                    end while
                    k++
                    l--
                elseif (nSum<nTarget)
                    k++
                else
                    l--
                endif
            end while
        next j
    next i

    return(aResult) as array
