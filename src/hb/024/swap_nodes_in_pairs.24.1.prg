/*

    24. Swap Nodes in Pairs

    Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

    Example 1:
    Input: head =[1,2,3,4]
    Output: [2,1,4,3]

    Example 2:
    Input: head =[]
    Output: []

    Example 3:
    Input: head =[1]
    Output: [1]

    Example 4:
    Input: head =[1,2,3]
    Output: [2,1,3]

    Constraints:

    The number of nodes in the list is in the range [0, 100].
    0<=Node.val<=100

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
function Main()
    return(Swap_Nodes_In_Pairs())

static function Swap_Nodes_In_Pairs()

    local aInput as array
    local aInputs as array
    local aResult as array

    local cHTML as character

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{2,1,4,3},{1,2,3,4}}) // Caso 1
    aAdd(aInputs,{{},{}}) // Caso 2
    aAdd(aInputs,{{1},{1}}) // Caso 3
    aAdd(aInputs,{{2,1,3},{1,2,3}}) // Caso 4
    aAdd(aInputs,{{1,0,3,2,5,4,7,6,9,8},{0,1,2,3,4,5,6,7,8,9}}) // Caso 5

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input</th><th>Swaped Nodes</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        // Cria a lista encadeada a partir do array de entrada, efetua a troca de pares e converte o resultado de volta para array
        aResult:=ListToArray(SwapPairs(CreateLinkedList(aInput[2]))) // Resultado da função SwapPairs
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

static function SwapPairs(oHead as object)

    local oDummy as object
    local oFirst as object
    local oSecond as object
    local oCurrent as object

    // Cria um nó fictício que aponta para a cabeça da lista
    oDummy:=TListNode():New(0, NIL)
    oDummy:next:=oHead
    oCurrent:=oDummy

    // Enquanto existirem pelo menos dois nós à frente
    while ((oCurrent:next!=NIL).and.(oCurrent:next:next!=NIL) )
        // Define os dois nós a serem trocados
        oFirst:=oCurrent:next
        oSecond:=oCurrent:next:next
        // Realiza a troca dos nós
        oFirst:next:=oSecond:next
        oSecond:next:=oFirst
        oCurrent:next:=oSecond
        // Avança o ponteiro para o próximo par
        oCurrent:=oFirst
    end while

    // Retorna a nova cabeça da lista (ignora o nó fictício)
    return(oDummy:next) as object

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
