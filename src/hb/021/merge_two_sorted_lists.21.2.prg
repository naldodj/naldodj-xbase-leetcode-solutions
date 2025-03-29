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

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{{1,1,2,3,4,4},{1,2,4},{1,3,4}}) // Caso 1
    aAdd(aInputs,{{},{},{}}) // Caso 2
    aAdd(aInputs,{{0},{},{0}}) // Caso 3
    aAdd(aInputs,{{1,1,2,2,3,3,4,4},{1,2,3,4},{1,2,3,4}}) // Caso 4

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input1</th><th>Input2</th><th>Merged List</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        aResult:=aClone(aInput[2])
        aEval(aInput[3],{|e|aAdd(aResult,e)})
        aResult:=aSort(aResult,nil,nil,{|x,y|x<y}) // Resultado da função aSort
        cHTML+=GenerateHTMLRow(aInput[2],aInput[3],aResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return

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
