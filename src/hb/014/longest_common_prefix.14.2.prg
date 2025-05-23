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
function Main()
    return(Longest_Common_Prefix())

static function Longest_Common_Prefix()

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

    return(nil)

static function LongestCommonPrefix(aStrings as array)

    local cPrefix as character

    local lContinue as logical

    local i,nCount,nPrefix,nCurrent as numeric

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
        aEval(aStrings,{;
                            |cCurrent as character,nIndex as numeric,nLength as numeric|;
                                 nCurrent:=Len(cCurrent);
                                ,nLength:=Min(nPrefix,nCurrent);
                                ,i:=0;
                                ,lContinue:=.T.;
                                ,aEval(__String2Array(cCurrent,nCurrent),{|c as character, n as numeric|if(((lContinue).and.(SubStr(cPrefix,n,1)==c)),i:=n,lContinue:=.F.)},1,nLength);// Compara os caracteres um por um
                                ,cPrefix:=SubStr(cPrefix,1,i);// Ajusta o prefixo até o ponto em que os caracteres coincidam
                        };
                        ,2;
                        ,nCount;
        )

    end sequence

    return(cPrefix) as character

/*
xHarbour supports using [] operator to access single characters in
string items. Harbour doesn't by default but it has strong enough
OOP API to allow adding such extension without touching core code
even by user at .prg level. It was implemented in Harbour in XHB.LIB.
ref.: https://raw.githubusercontent.com/naldodj/naldodj-harbour-core/21ea321f0ae910520df99bd5fd2b7ccf414d90bc/doc/xhb-diff.txt
*/
static function __String2Array(cString as character,nStringSize as numeric)

    local aString as array

    aString:=array(nStringSize)

    while (nStringSize>0)
        aString[nStringSize--]:=SubStr(cString,nStringSize,1)
    end while

return(aString) as array
