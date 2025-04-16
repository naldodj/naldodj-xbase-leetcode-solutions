/*

    25. Reverse Nodes in k-Group

    Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

    k is a positive integer and is less than or equal to the length of the linked list.
    If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

    You may not alter the values in the list's nodes, only nodes themselves may be changed.

    Example 1:
    Input: head = [1,2,3,4,5], k = 2
    Output: [2,1,4,3,5]

    Example 2:
    Input: head = [1,2,3,4,5], k = 3
    Output: [3,2,1,4,5]

    Constraints:
    The number of nodes in the list is n.
    1 <= k <= n <= 5000
    0 <= Node.val <= 1000

    Follow-up: Can you solve the problem in O(1) extra memory space?

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
function Main()
    return(Reverse_Nodes_In_K_Group())

static function Reverse_Nodes_In_K_Group()

    local aInput as array
    local aInputs as array
    local aResult as array

    local nK as numeric

    local cHTML as character

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{},{},1})
    aAdd(aInputs,{{1},{1},1}) // Caso 3
    aAdd(aInputs,{{1,2,3,4},{1,2,3,4},0})
    aAdd(aInputs,{{1,2,3,4},{1,2,3,4},1})
    aAdd(aInputs,{{2,1,4,3},{1,2,3,4},2})
    aAdd(aInputs,{{3,2,1,4},{1,2,3,4},3})
    aAdd(aInputs,{{4,3,2,1},{1,2,3,4},4})
    aAdd(aInputs,{{1,2,3,4},{1,2,3,4},5})
    aAdd(aInputs,{{1,2,3,4,5},{1,2,3,4,5},0})
    aAdd(aInputs,{{1,2,3,4,5},{1,2,3,4,5},1})
    aAdd(aInputs,{{2,1,4,3,5},{1,2,3,4,5},2})
    aAdd(aInputs,{{3,2,1,4,5},{1,2,3,4,5},3})
    aAdd(aInputs,{{4,3,2,1,5},{1,2,3,4,5},4})
    aAdd(aInputs,{{5,4,3,2,1},{1,2,3,4,5},5})
    aAdd(aInputs,{{1,2,3,4,5},{1,2,3,4,5},6})
    aAdd(aInputs,{{1,2,3,4,5,6,7},{1,2,3,4,5,6,7},0})
    aAdd(aInputs,{{1,2,3,4,5,6,7},{1,2,3,4,5,6,7},1})
    aAdd(aInputs,{{2,1,4,3,6,5,7},{1,2,3,4,5,6,7},2})
    aAdd(aInputs,{{3,2,1,6,5,4,7},{1,2,3,4,5,6,7},3})
    aAdd(aInputs,{{4,3,2,1,5,6,7},{1,2,3,4,5,6,7},4})
    aAdd(aInputs,{{5,4,3,2,1,6,7},{1,2,3,4,5,6,7},5})
    aAdd(aInputs,{{6,5,4,3,2,1,7},{1,2,3,4,5,6,7},6})
    aAdd(aInputs,{{7,6,5,4,3,2,1},{1,2,3,4,5,6,7},7})
    aAdd(aInputs,{{1,2,3,4,5,6,7},{1,2,3,4,5,6,7},8})

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input</th><th>k</th><th>Reversed k-Group</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        nK:=aInput[3]
        // Cria a lista encadeada a partir do array de entrada, efetua a reversão e converte o resultado de volta para array
        aResult:=ListToArray(ReverseKGroup(CreateLinkedList(aInput[2]),nK)) // Resultado da função ReverseKGroup
        cHTML+=GenerateHTMLRow(aInput[2],nK,aResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return(nil)

static function ReverseKGroup(oHead as object,nK as numeric)

    local oPrev as object
    local oNext as object
    local oDummy as object
    local oCurrent as object
    local oGroupStart as object
    local oGroupPrevEnd as object

    local i as numeric
    local nCount as numeric

    // Cria um nó fictício que aponta para a cabeça da lista
    oDummy:=TListNode():New(0, NIL)
    oDummy:next:=oHead

    begin sequence

        if (nK<=1)
            break
        endif

        oGroupPrevEnd:=oDummy

        while (.T.)

            // Verifica se há nós suficientes para formar um grupo de tamanho k
            oGroupStart:=oGroupPrevEnd:next
            oCurrent:=oGroupStart
            nCount:=0

            while ((oCurrent!=NIL).and.(nCount<nK))
                oCurrent:=oCurrent:next
                nCount++
            end while

            // Se não houver nós suficientes, terminamos
            if (nCount<nK)
                exit
            endif

            // Reverte o grupo de k nós
            oPrev:=oGroupPrevEnd
            oCurrent:=oGroupStart
            for i:=1 to nK
                oNext:=oCurrent:next
                oCurrent:next:=oPrev
                oPrev:=oCurrent
                oCurrent:=oNext
            next i

            // Reconecta os ponteiros do grupo revertido
            oGroupStart:next:=oCurrent
            oGroupPrevEnd:next:=oPrev
            oGroupPrevEnd:=oGroupStart

        end while

    end sequence

    // Retorna a nova cabeça da lista (ignora o nó fictício)
    return(oDummy:next) as object

static function GenerateHTMLRow(aInput as array, nK as numeric, aOutput as array, aExpected as array)

    local cRow as character
    local cIMG as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(aOutput)==hb_JSONEncode(aExpected))
    cIMG:=if(lMatched,"✔", "❌")

    cRow:="<tr>"
    cRow+="<td>"+hb_JSONEncode(aInput)+"</td>"
    cRow+="<td>"+hb_ValToExp(nK)+"</td>"
    cRow+="<td>"+hb_JSONEncode(aOutput)+"</td>"
    cRow+="<td>"+hb_JSONEncode(aExpected)+"</td>"
    cRow+="<td>"+cIMG+"</td>"
    cRow+="</tr>"

    return(cRow) as character

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
