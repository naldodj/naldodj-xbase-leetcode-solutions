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

    local aNumbers as array
    local nOne as numeric

    // Case 1: Numbers appear two times
    aNumbers:={2,3,4,1,4,3,2}
    ? "Input Array (Two Times):",hb_JSONEncode(aNumbers)
    ? "</br>"
    nOne:=singleNumber(aNumbers)
    ? "The Single Number is:",nOne
    ? "</br>"

return nil

// Function to find the single number in the array
static function singleNumber(aNumbers as array)

    local i,nLen as numeric
    local nOne as numeric:=0
    local nNoOne as numeric:=0

    nLen:=Len(aNumbers)

    if (Mod(nLen,2)!=0)
        // Case 1: Numbers appear two times
        aEval(aNumbers,{|n|nOne:=hb_bitXor(nOne,n)})
    else
        // Case 2: Numbers appear three times
        for i:=1 to nLen
            // Check if the number is not already in nNoOne
            if (hb_bitAnd(nNoOne,aNumbers[i])==0)
                nOne:=hb_bitXor(nOne,aNumbers[i])
            endif
            // Check if the number is not already in nOne
            if (hb_bitAnd(nOne,aNumbers[i])==0)
                nNoOne:=hb_bitXor(nNoOne,aNumbers[i])
            endif
        next i
    endif

    return nOne
