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

    local aNumbers as array
    local nOne as numeric

    // Case 2: Numbers appear three times
    aNumbers:={6,5,9,6,4,1,7,7,3,6,10,3,9,8,5,7,10,10,3,1,4,4,5,8,2,1,8,9}
    ? "Input Array (Three Times):",hb_JSONEncode(aNumbers)
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
