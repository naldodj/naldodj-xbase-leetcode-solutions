/*
    23. Merge k Sorted Lists

    You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

    Merge all the linked-lists into one sorted linked-list and return it.

    Example 1:
    Input: lists = [[1,4,5],[1,3,4],[2,6]]
    Output: [1,1,2,3,4,4,5,6]
    Explanation: The linked-lists are:
    [
      1->4->5,
      1->3->4,
      2->6
    ]
    merging them into one sorted list:
    1->1->2->3->4->4->5->6

    Example 2:
    Input: lists = []
    Output: []

    Example 3:
    Input: lists = [[]]
    Output: []

    Constraints:
    k == lists.length
    0 <= k <= 10^4
    0 <= lists[i].length <= 500
    -10^4 <= lists[i][j] <= 10^4
    lists[i] is sorted in ascending order.
    The sum of lists[i].length will not exceed 104.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
function Main()
    return(Merge_K_Sorted_Lists())

static function Merge_K_Sorted_Lists()

    local aInput as array
    local aInputs as array
    local aResult as array

    local cHTML as character

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{1,1,2,3,4,4,5,6},{{1,4,5},{1,3,4},{2,6}}}) // Caso 1
    aAdd(aInputs,{{},{}}) // Caso 2
    aAdd(aInputs,{{},{{}}}) // Caso 3
    aAdd(aInputs,{{0,1,2,3,4,5,6,7,8,9},{{2,4,6,8},{0},{1,3,5,7,9}}}) // Caso 4

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input</th><th>Merged List</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        aResult:=MergeKLists(aInput[2]) // Resultado da função MergeKLists
        cHTML+=GenerateHTMLRow(aInput[2],aResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return(nil)

function TListNode()

   static s_oTListNodeClass as object

   if (s_oTListNodeClass==NIL)
      s_oTListNodeClass:=HBClass():New("TLISTNODE")
      s_oTListNodeClass:AddData("value")
      s_oTListNodeClass:AddData("next",10)
      s_oTListNodeClass:AddMethod("New",@TListNodeNew())
      s_oTListNodeClass:Create()
   endif

   return(s_oTListNodeClass:Instance()) as object

static function TListNodeNew(value,next)
    local self as object:=QSelf()
    self:value:=value
    self:next:=next
return(self) as object

static function MergeKLists(aLists as array)

    local aList as array
    local aResult as array

    begin sequence

        if (empty(aLists))
            aResult:=Array(0)
            break
        endif

        for each aList in aLists
            if (aList:__enumIndex()==1)
                // Inicializa a lista mesclada com a primeira lista
                aResult:=aLists[1]
            else
                aResult:=ListToArray(MergeSortedLists(CreateLinkedList(aResult),CreateLinkedList(aList)))
            endif
        next each //aList

    end sequence

    return(aResult) as array

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

static function GenerateHTMLRow(aInput as array,aOutput as array,aExpected as array)

    local cRow as character
    local cBgColor as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(aOutput)==hb_JSONEncode(aExpected))
    cBgColor:=if(lMatched,"#22560D","#E4080A")

    cRow:="<tr>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aInput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aOutput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aExpected)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(lMatched)+"</td>"
    cRow+="</tr>"

    return(cRow) as character
