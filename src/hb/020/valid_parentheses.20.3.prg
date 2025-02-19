/*
    20. Valid Parentheses

    Given a string s containing just the characters '(',')','{','}','[' and ']',determine if the input string is valid.

    An input string is valid if:

    Open brackets must be closed by the same type of brackets.
    Open brackets must be closed in the correct order.
    Every close bracket has a corresponding open bracket of the same type.

    Example 1:
    Input: s = "()"
    Output: true

    Example 2:
    Input: s = "()[]{}"
    Output: true

    Example 3:
    Input: s = "(]"
    Output: false

    Example 4:
    Input: s = "([])"
    Output: true

    Constraints:

    1 <= s.length <= 104
    s consists of parentheses only '()[]{}'.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
procedure Main()

    local aInputs as array

    local cHTML as character
    local cInput as character

    local lOutPut as logical
    local lMatched as logical

    local nIdx as numeric

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{.T.,"()"})// Caso 1
    aAdd(aInputs,{.T.,"()[]{}"})// Caso 2
    aAdd(aInputs,{.F.,"(]"})// Caso 3
    aAdd(aInputs,{.T.,"([])"})// Caso 4
    aAdd(aInputs,{.T.,"{[()]}"})// Caso 5
    aAdd(aInputs,{.F.,"{[()}]"})// Caso 6

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
        cInput:=aInputs[nIdx][2] // Entrada atual
        lOutPut:=IsValid(cInput) // Resultado da função IsValid
        lMatched:=(hb_JSONEncode(lOutPut)==hb_JSONEncode(aInputs[nIdx][1])) // Verifica correspondência com o esperado
        // Gera uma linha na tabela HTML
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(cInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

static function IsValid(cInput as character)

    local cPrev as character
    local cPattern as character

    local lIsValid as logical

    cPrev:=cInput
    cPattern:="\(\)|\[\]|\{\}"  // Expressão regular que casa os pares válidos

    while (.T.)
        cInput:=hb_regexReplace(cPattern,cInput,"",.F.,.F.,1)
        if (cInput==cPrev)
            exit // Não houve mudança: não existem mais pares válidos para remover
        endif
        cPrev:=cInput
    end while

    lIsValid:=Empty(cInput)

    return(lIsValid)

/*ref.: hb_regexReplace => https://github.com/harbour/core/blob/72a672a452fc156458e31418494bd22a352144c6/contrib/xhb/regexrpl.prg*/

#define MATCH_STRING  1
#define MATCH_START   2
#define MATCH_END     3

static function hb_regexReplace(cRegex as character,cString as character,cReplace as character,lCaseSensitive as logical,lNewLine as logical,nMaxMatches as numeric,nGetMatch as numeric)

    local aMatch as array
    local aMatches as array

    local cReturn as character
    local cSearch as character

    local nStart as numeric
    local nOffSet as numeric
    local nLenSearch as numeric
    local nLenReplace as numeric

    nOffSet:=0

    aMatches:=hb_regexAll(cRegEx,cString,lCaseSensitive,lNewLine,nMaxMatches,nGetMatch,.F.)
    cReturn:=cString

    if (!Empty(aMatches))
        for each aMatch IN aMatches
            if ((HB_ISARRAY(aMatch)).and.(Len(aMatch)>=1).and.(HB_ISARRAY(aMatch[1])))
                aMatch:=aMatch[1]
                if (Len(aMatch)==3) // if regex matches I must have an array of 3 elements
                   cSearch:=aMatch[MATCH_STRING]
                   nStart:=aMatch[MATCH_START]
                   nLenSearch:=Len(cSearch)
                   nLenReplace:=Len(cReplace)
                   cReturn:=Stuff(cReturn,nStart-nOffSet,nLenSearch,cReplace)
                   nOffSet+=nLenSearch-nLenReplace
                endif
            endif
        next aMatch

    endif

    return(cReturn)
