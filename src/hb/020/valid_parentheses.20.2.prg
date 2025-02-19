/*
    20. Valid Parentheses

    Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

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

    local aStack as array // Pilha para armazenar os parênteses abertos

    local c as character
    local cTop as character

    local lIsValid as logical

    local i as numeric
    local nStacks as numeric

    aStack:={}
    nStacks:=0
    lIsValid:=.F.

    begin sequence

        for i:=1 to Len(cInput)
            c:=SubStr(cInput,i,1)
            if (c=="(").or.(c=="[").or.(c=="{")
                aAdd(aStack,c)
                nStacks++
            elseif (c==")").or.(c=="]").or.(c=="}")
                if (nStacks==0)
                    break // Não há par de abertura para o fechamento
                endif
                cTop:=aStack[nStacks] // Último elemento da pilha
                aDel(aStack,nStacks)  // Remove o topo da pilha
                aSize(aStack,--nStacks)
                do case
                    case ((c==")").and.(cTop!="("))
                        break
                    case ((c=="]").and.(cTop!="["))
                        break
                    case (c=="}").and.(cTop!="{")
                        break
                end case
            endif
        next i

        lIsValid:=(nStacks==0)  // Se a pilha estiver vazia, a string é válida

    end sequence

    return(lIsValid)
