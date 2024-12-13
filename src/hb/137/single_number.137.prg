/*
    Problem:
    1. Given an array of integers where every element appears three times except for one,
       find the unique element that appears once.

    2. Given an array of integers where every element appears two times except for one,
       find the unique element that appears once.

    Constraints:
    - Linear runtime complexity (O(n)).
    - No additional memory usage (constant space).

    Notes:
    - The solution differs for the two cases and is determined by the length of the array.
      If the array length is odd, it assumes case 1 (numbers appear twice).
      If the array length is even, it assumes case 2 (numbers appear three times).

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/

function Main()

    local aNumbers as array
    local nOne as numeric

    // Case 1: Numbers appear two times
    if (.F.)
        aNumbers := {2, 3, 4, 1, 4, 3, 2}
        ? "Input Array (Two Times):", hb_JSONEncode(aNumbers)
        ? "</br>"
        nOne := singleNumber(aNumbers)
        ? "The Single Number is:", nOne
        ? "</br>"
    endif

    // Case 2: Numbers appear three times
    aNumbers := {6, 5, 9, 6, 4, 1, 7, 7, 3, 6, 10, 3, 9, 8, 5, 7, 10, 10, 3, 1, 4, 4, 5, 8, 2, 1, 8, 9}
    ? "Input Array (Three Times):", hb_JSONEncode(aNumbers)
    ? "</br>"
    nOne := singleNumber(aNumbers)
    ? "The Single Number is:", nOne
    ? "</br>"

return nil

// Function to find the single number in the array
static function singleNumber(aNumbers as array)

    local i, nLen as numeric
    local nOne as numeric := 0
    local nNoOne as numeric := 0

    nLen := Len(aNumbers)

    if (Mod(nLen, 2) != 0)
        // Case 1: Numbers appear two times
        aEval(aNumbers,{|n|nOne:=hb_bitXor(nOne,n)})
    else
        // Case 2: Numbers appear three times
        for i := 1 to nLen
            // Check if the number is not already in nNoOne
            if (hb_bitAnd(nNoOne, aNumbers[i]) == 0)
                nOne := hb_bitXor(nOne, aNumbers[i])
            endif
            // Check if the number is not already in nOne
            if (hb_bitAnd(nOne, aNumbers[i]) == 0)
                nNoOne := hb_bitXor(nNoOne, aNumbers[i])
            endif
        next i
    endif

    return nOne
