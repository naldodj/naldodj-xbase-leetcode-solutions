/*
    14. Longest Common Prefix

    Write a function to find the longest common prefix string amongst an array of strings.

    If there is no common prefix, return an empty string "".

    Example 1:

    Input: strs = ["flower","flow","flight"]
    Output: "fl"
    Example 2:

    Input: strs = ["dog","racecar","car"]
    Output: ""
    Explanation: There is no common prefix among the input strings.

    Constraints:

    1 <= strs.length <= 200
    0 <= strs[i].length <= 200

    strs[i] consists of only lowercase English letters.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local aInput as array
    local aInputs as array

    local cHTML as character
    local cOutPut as character

    local lMatched as logical

    local nIdx as numeric

    aInputs:=Array(0)

    aAdd(aInputs,{"fl",{"flower","flow","flight"}})
    aAdd(aInputs,{"",{"dog","racecar","car"}})
    aAdd(aInputs,{"mar",{"marinaldo","maria","mar","marcela","margarida"}})
    aAdd(aInputs,{"davi",{"davi","david"}})
    aAdd(aInputs,{"ti",{"tio","tia","tido","time","tipo"}})

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
    for nIdx:=1 to Len(aInputs)
        aInput:=aInputs[nIdx][2]
        cOutPut:=LongestCommonPrefix(aInput)
        lMatched:=(cOutPut==aInputs[nIdx][1])
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cOutPut+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+aInputs[nIdx][1]+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx
    cHTML+=    "</tbody>"
    cHTML+="</table>"

    ? cHTML

    return

static function LongestCommonPrefix(aStrings as array)

    local cPrefix,cCurrent as character

    local i,nCount,nIndex,nLength,nPrefix as numeric

    begin sequence

        // Se o array estiver vazio, retorna uma string vazia
        nCount:=Len(aStrings)
        if (nCount==0)
            cPrefix:=""
            break
        endif

        // Inicializa o prefixo com a primeira string
        cPrefix:=aStrings[1]
        nPrefix:=Len(cPrefix)

        // Itera sobre as outras strings do array
        for nIndex:=2 to nCount

            cCurrent:=aStrings[nIndex]
            nLength:=Min(nPrefix,Len(cCurrent))

            // Compara os caracteres um por um
            for i:=1 to nLength
                if (SubStr(cPrefix,i,1)!=SubStr(cCurrent,i,1))
                    exit
                endif
            next i

            // Ajusta o prefixo até o ponto em que os caracteres coincidam
            cPrefix:=SubStr(cPrefix,1,i-1)

            // Se o prefixo for vazio, não há necessidade de continuar
            if (Empty(cPrefix))
                break
            endif

        next nIndex

    end sequence

    return(cPrefix) as character
