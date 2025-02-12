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
    local aResult as array

    local cHTML as character

    local nTarget as numeric

    local oHead as object

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{1,2,3,5},{1,2,3,4,5},2}) // Caso 1
    aAdd(aInputs,{{},{1},1}) // Caso 2
    aAdd(aInputs,{{1},{1,2},1}) // Caso 3
    aAdd(aInputs,{{2},{1,2},2}) // Caso 4
    aAdd(aInputs,{{},{},1}) // Caso 5
    aAdd(aInputs,{{1,2,3,4,5},{1,2,3,4,5},0}) // Caso 6

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><toHead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input</th><th>Nth Node</th><th>Output</th><th>Expected</th><th>Matched</th></tr></toHead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        oHead:=arrayToList(aInput[2])// Entrada atual
        nTarget:=aInput[3] // Valor de n
        aResult:=listToArray(removeNthFromEnd(oHead,nTarget)) // Resultado da função removeNthFromEnd
        cHTML+=generateHTMLRow(aInput[2],nTarget,aResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return

function TListNode()

   static s_oTListNodeClass

   if (s_oTListNodeClass==NIL)

      s_oTListNodeClass:=HBClass():New("TLISTNODE")

      s_oTListNodeClass:AddData("Val")
      s_oTListNodeClass:AddData("Next",10)

      s_oTListNodeClass:AddMethod("New",@TListNodeNew())

      s_oTListNodeClass:Create()

   endif

   return(s_oTListNodeClass:Instance())

static function TListNodeNew(Val,Next)
    self:=QSelf()
    self:Val:=Val
    self:Next:=Next
return(self)

static function removeNthFromEnd(oHead,nTarget)

    local i as numeric

    local oDummy as object
    local oFirst as object
    local oSecond as object

    oDummy:=TListNode():New(0,oHead)
    oFirst:=oDummy
    oSecond:=oDummy

    // Avança oFirst n+1 posições à frente
    for i:=1 to nTarget+1
        if (oFirst!=NIL)
            oFirst:=oFirst:Next
        endif
    next i

    // Move oFirst até o final,mantendo oSecond n posições atrás
    while (oFirst!=NIL)
        oFirst:=oFirst:Next
        oSecond:=oSecond:Next
    end while

    // Remove o nth nó
    if (oSecond:Next!=NIL)
        oSecond:Next:=oSecond:Next:Next
    endif

    return(oDummy:Next) as object

static function arrayToList(aNums as array)

    local i as numeric

    local oDummy as object
    local oCurrent as object

    oDummy:=TListNode():New(0,NIL)
    oCurrent:=oDummy

    for i:=1 to Len(aNums)
        oCurrent:Next:=TListNode():New(aNums[i],NIL)
        oCurrent:=oCurrent:Next
    next i

    return(oDummy:Next) as object

static function listToArray(oHead as object)

    local aResult as array

    aResult:=Array(0)

    while (oHead!=NIL)
        aAdd(aResult,oHead:Val)
        oHead:=oHead:Next
    end while

    return(aResult) as array

static function generateHTMLRow(aInput as array,nNthNode as numeric,aOutput as array,aExpected as array)

    local cRow as character
    local cBgColor as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(aOutput)==hb_JSONEncode(aExpected))
    cBgColor:=if(lMatched,"#22560D","#E4080A")

    cRow:="<tr>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aInput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(nNthNode)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aOutput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aExpected)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(lMatched)+"</td>"
    cRow+="</tr>"

    return(cRow) as character
