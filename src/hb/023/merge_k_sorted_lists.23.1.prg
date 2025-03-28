/*
    21. Merge Two Sorted Lists

    You are given the heads of two sorted linked lists list1 and list2.

    Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

    Return the head of the merged linked list.

    Example 1:
    Input: list1 = [1,2,4], list2 = [1,3,4]
    Output: [1,1,2,3,4,4]

    Example 2:
    Input: list1 = [], list2 = []
    Output: []

    Example 3:
    Input: list1 = [], list2 = [0]
    Output: [0]

    Constraints:

    The number of nodes in both lists is in the range [0, 50].
    -100 <= Node.val <= 100
    Both list1 and list2 are sorted in non-decreasing order.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
procedure Main()

    local aInput as array
    local aInputs as array
    local aResult as array

    local cHTML as character

    local oList1 as object
    local oList2 as object

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{1,1,2,3,4,4},{1,2,4},{1,3,4}}) // Caso 1
    aAdd(aInputs,{{},{},{}}) // Caso 2
    aAdd(aInputs,{{0},{},{0}}) // Caso 3
    aAdd(aInputs,{{1,1,2,2,3,3,4,4},{1,2,3,4},{1,2,3,4}}) // Caso 4

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><toHead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input1</th><th>Input2</th><th>Merged List</th><th>Expected</th><th>Matched</th></tr></toHead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        oList1:=CreateLinkedList(aInput[2])// Entrada atual Lista 1
        oList2:=CreateLinkedList(aInput[3])// Entrada atual Lista 2
        aResult:=ListToArray(MergeSortedLists(oList1,oList2)) // Resultado da função MergeSortedLists
        cHTML+=GenerateHTMLRow(aInput[2],aInput[3],aResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return

function TListNode()

   static s_oTListNodeClass

   if (s_oTListNodeClass==NIL)

      s_oTListNodeClass:=HBClass():New("TLISTNODE")

      s_oTListNodeClass:AddData("value")
      s_oTListNodeClass:AddData("next",10)

      s_oTListNodeClass:AddMethod("New",@TListNodeNew())

      s_oTListNodeClass:Create()

   endif

   return(s_oTListNodeClass:Instance()) as object

static function TListNodeNew(value,next)
    self:=QSelf()
    self:value:=value
    self:next:=next
return(self) as object

static function MergeSortedLists(oList1 as object,oList2 as object)

    local oTail as object
    local oDummy as object

    oDummy:=TListNode():New(0,NIL) // Nó fictício para facilitar a junção
    oTail:=oDummy

    while ((oList1!=NIL).and.(oList2!=NIL))
        if ((oList1:value)<=(oList2:value))
            oTail:next:=oList1
            oList1:=oList1:next
        else
            oTail:next:=oList2
            oList2:=oList2:next
        endif
        oTail:=oTail:next
    end while

    // Se ainda houver elementos em uma das listas
    if (oList1!=NIL)
        oTail:next:=oList1
    else
        oTail:next:=oList2
    endif

    return(oDummy:next) as object // Retorna a lista mesclada, ignorando o nó fictício

static function CreateLinkedList(aList as array)
    return(ArrayToList(aList)) as object

static function ArrayToList(aList as array)

    local i as numeric

    local oDummy as object
    local oCurrent as object

    oDummy:=TListNode():New(0,NIL)
    oCurrent:=oDummy

    for i:=1 to Len(aList)
        oCurrent:next:=TListNode():New(aList[i],NIL)
        oCurrent:=oCurrent:next
    next i

    return(oDummy:next) as object

static function ListToArray(oHead as object)

    local aResult as array

    aResult:=Array(0)

    while (oHead!=NIL)
        aAdd(aResult,oHead:value)
        oHead:=oHead:next
    end while

    return(aResult) as array

static function GenerateHTMLRow(aInput1 as array,aInput2 as array,aOutput as array,aExpected as array)

    local cRow as character
    local cBgColor as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(aOutput)==hb_JSONEncode(aExpected))
    cBgColor:=if(lMatched,"#22560D","#E4080A")

    cRow:="<tr>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aInput1)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aInput2)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aOutput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aExpected)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(lMatched)+"</td>"
    cRow+="</tr>"

    return(cRow) as character
