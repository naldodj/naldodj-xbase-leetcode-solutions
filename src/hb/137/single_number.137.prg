/*
    137. Single Number II

    Given an integer array nums where every element appears three times except for one, which appears exactly once. Find the single element and return it.

    You must implement a solution with a linear runtime complexity and use only constant extra space.

    Example 1:

    Input: nums = [2,2,3,2]
    Output: 3

    Example 2:

    Input: nums = [0,1,0,1,0,1,99]
    Output: 99

    Constraints:

    1 <= nums.length <= 3 * 104
    -2^31 <= nums[i] <= 2^31 - 1

    Each element in nums appears exactly three times except for one element which appears once.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/

function Main()
    return(Single_Number_II())

static function Single_Number_II()

    local aInput as array
    local aInputs as array

    local cHTML as character

    local nResult as numeric

    // Casos de teste definidos
    aInputs:=Array(0)
    aAdd(aInputs,{3,{2,2,3,2}}) // Caso 1
    aAdd(aInputs,{3,{3,2,2,2}}) // Caso 2
    aAdd(aInputs,{99,{0,1,0,1,0,1,99}}) // Caso 3
    aAdd(aInputs,{2,{6,5,9,6,4,1,7,7,3,6,10,3,9,8,5,7,10,10,3,1,4,4,5,8,2,1,8,9}}) // Caso 4

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input Array (Three Times)</th><th>The Single Number is</th><th>Expected</th><th>Matched</th></tr></thead><tbody>"

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

    local i as numeric
    local nNum as numeric
    local nOne as numeric:=0
    local nNoOne as numeric:=0

    // Case 2: Numbers appear three times
    for each nNum in aNumbers
        nOne:=hb_bitAnd(hb_bitXor(nOne,nNum),hb_bitNot(nNoOne))
        nNoOne:=hb_bitAnd(hb_bitXor(nNoOne,nNum),hb_bitNot(nOne))
    next each

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
