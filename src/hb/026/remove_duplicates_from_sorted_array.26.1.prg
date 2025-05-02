/*

    26. Remove Duplicates from Sorted Array

    Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same. Then return the number of unique elements in nums.

    Consider the number of unique elements of nums to be k, to get accepted, you need to do the following things:

    Change the array nums such that the first k elements of nums contain the unique elements in the order they were present in nums initially. The remaining elements of nums are not important as well as the size of nums.
    Return k.
    Custom Judge:

    The judge will test your solution with the following code:

    int[] nums = [...]; // Input array
    int[] expectedNums = [...]; // The expected answer with correct length

    int k = removeDuplicates(nums); // Calls your implementation

    assert k == expectedNums.length;
    for (int i = 0; i < k; i++) {
        assert nums[i] == expectedNums[i];
    }
    If all assertions pass, then your solution will be accepted.

    Example 1:
    Input: nums = [1,1,2]
    Output: 2, nums = [1,2,_]
    Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
    It does not matter what you leave beyond the returned k (hence they are underscores).

    Example 2:
    Input: nums = [0,0,1,1,1,2,2,3,3,4]
    Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
    Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
    It does not matter what you leave beyond the returned k (hence they are underscores).

    Constraints:
    1 <= nums.length <= 3 * 10^4
    -100 <= nums[i] <= 100
    nums is sorted in non-decreasing order.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
function Main()
    return(Remove_Duplicates_from_Sorted_Array())

static function Remove_Duplicates_from_Sorted_Array()

    local aInput as array
    local aInputs as array
    local aResult as array

    local cHTML as character

    // Casos de teste definidos
    aInputs:=Array(0)

    aAdd(aInputs,{{1,2,"_"},{1,1,2},.T.,.F.,.F.})
    aAdd(aInputs,{{0,1,2,3,4,"_","_","_","_","_"},{0,0,1,1,1,2,2,3,3,4},.T.,.F.,.T.})
    aAdd(aInputs,{{3,1,4,2,0,"_","_","_","_","_"},{3,1,4,2,1,3,0,4,0,2},.F.,.F.,.F.})
    aAdd(aInputs,{{0,1,2,3,4,"_","_","_","_","_"},{3,1,4,2,1,3,0,4,0,2},.F.,.T.,.T.})

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+="<caption>"+ProcName()+"</caption><thead><tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+="<th>Input</th><th>OutPut</th><th>Expected</th><th>IsOrdered</th><th>Reorder</th><th>Matched</th></tr></thead><tbody>"

    // Itera sobre os casos de teste
    for each aInput in aInputs
        // Cria a lista encadeada a partir do array de entrada, efetua a reversão e converte o resultado de volta para array
        aResult:=RemoveDuplicates(aClone(aInput[2]),aInput[3],aInput[4],aInput[5]) // Resultado da função RemoveDuplicates
        cHTML+=GenerateHTMLRow(aInput[2],aResult,aInput[1],aInput[3],aInput[4]) // Gera uma linha na tabela HTML
    next each

    cHTML+="</tbody></table>"

    ? cHTML

    return(nil)

static function GenerateHTMLRow(aInput as array,aOutput as array,aExpected as array,lIsOrdered as logical,lForceTheIncreasingOrder as logical)

    local cRow as character
    local cIMGMatch as character
    local cIMGOrdered as character
    local cIMGForceNonDecreasingOrder as character

    local lMatched as logical

    lMatched:=(hb_JSONEncode(aOutput)==hb_JSONEncode(aExpected))
    cIMGMatch:=if(lMatched,"✔", "❌")

    cIMGOrdered:=if(lIsOrdered,"✔", "❌")
    cIMGForceNonDecreasingOrder:=if(lForceTheIncreasingOrder,"✔", "❌")

    cRow:="<tr>"
    cRow+="<td>"+hb_JSONEncode(aInput)+"</td>"
    cRow+="<td>"+hb_JSONEncode(aOutput)+"</td>"
    cRow+="<td>"+hb_JSONEncode(aExpected)+"</td>"
    cRow+="<td>"+cIMGOrdered+"</td>"
    cRow+="<td>"+cIMGForceNonDecreasingOrder+"</td>"
    cRow+="<td>"+cIMGMatch+"</td>"
    cRow+="</tr>"

    return(cRow) as character

static function RemoveDuplicates(aArray as array,lIsOrdered as logical,lForceTheIncreasingOrder as logical,lUseXor as logical)

    local lMatch as logical

    local i as numeric
    local j as numeric
    local nValue as numeric
    local nALen as array

    nALen:=Len(aArray)

    if (nALen>0)

        i:=1

        hb_default(@lIsOrdered,.T.)
        hb_default(@lUseXor,.F.)

        while (i<=nALen)
            nValue:=aArray[i]
            j:=i+1
            while ((j<=nALen).and.(valtype(aArray[j])=="N"))
                lMatch:=if(lUseXor,hb_bitXor(nValue,aArray[j])==0,nValue==aArray[j])
                if (lMatch)
                    aDel(aArray,j--)
                    aArray[nALen]:="_"
                elseif (lIsOrdered)
                    exit
                endif
                j++
            end while
            i++
            if (valtype(aArray[i])!="N")
                exit
            endif
        end while

        if (!lIsOrdered)
            hb_default(@lForceTheIncreasingOrder,.T.)
            if (lForceTheIncreasingOrder)
                aSort(aArray,1,j-1)
            endif
        endif

    endif

    return(aArray) as array
