/*
    136. Single Number

    Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

    You must implement a solution with a linear runtime complexity and use only constant extra space.

    Example 1:

    Input: nums = [2,2,1]
    Output: 1

    Example 2:

    Input: nums = [4,1,2,1,2]
    Output: 4

    Example 3:

    Input: nums = [1]
    Output: 1

    Constraints:

    1 <= nums.length <= 3 * 10^4
    -3 * 10^4 <= nums[i] <= 3 * 10^4

    Each element in the array appears twice except for one element which appears only once.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/

function Main()
return(Single_Number())

static function Single_Number()

    local aInput as array
    local aInputs as array

    local cHTML as character

    local nResult as numeric

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{1,{2,2,1}}) // Caso 1
    aAdd(aInputs,{1,{2,1,2}}) // Caso 2
    aAdd(aInputs,{4,{4,1,2,1,2}}) // Caso 3
    aAdd(aInputs,{2,{2}}) // Caso 4
    aAdd(aInputs,{1,{2,3,4,1,4,3,2}}) // Caso 5

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input Array (Two Times)</th><th>The Single Number is</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        nResult:=singleNumber(aInput[2]) // Resultado da função singleNumber
        cHTML+=GenerateHTMLRow(aInput[2],nResult,aInput[1]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return(nil)

// Function to find the single number in the array
static function singleNumber(aNumbers as array)

    local nOne as numeric:=0

    // Numbers appear two times
    aEval(aNumbers,{|n|nOne:=hb_bitXor(nOne,n)})

    return(nOne) as numeric

static function GenerateHTMLRow(aInput as array,nOutput as numeric,nExpected as numeric)

    local cRow as character
    local cBgColor as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(nOutput)==hb_JSONEncode(nExpected))
    cBgColor:=if(lMatched,"#22560D","#E4080A")

    cRow:="<tr>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(aInput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(nOutput)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(nExpected)+"</td>"
    cRow+="<td style='background-color:"+cBgColor+";'>"+hb_JSONEncode(lMatched)+"</td>"
    cRow+="</tr>"

    return(cRow) as character
