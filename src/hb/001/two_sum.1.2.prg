/*
    Given an array of integers nums and an integer target,return Indexes of the two numbers such that they add up to target.

    You may assume that each input would have exactly one solution,and you may not use the same element twice.

    You can return the answer in any order.

    Example 1:
    Input: nums = [2,7,11,15],target = 9
    Output: [0,1]
    Explanation: Because nums[0] + nums[1] == 9,we return [0,1] or [1,0].

    Example 2:
    Input: nums = [3,2,4],target = 6
    Output: [1,2] or [2,3]

    Example 3:
    Input: nums = [3,3],target = 6
    Output: [0,1] or [1,2]

    Example 4:
    Input: nums = [2,7,11,15],target = 17
    Output: [0,3] or [1,4]

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local aNums as array  // Input array of integers
    local aResult as array // Array to hold the result Indexes
    local nTarget as numeric  // Target sum
    local lZeroBasedIndex as logical:=.T. // Whether to return zero-based indexes

    ********************************************************************
    aNums:={2,7,11,15}
    nTarget:=9
    aResult:=TwoSum(aNums,nTarget,lZeroBasedIndex)
    ? "Indexes: " ,hb_JSONEncode(aResult),if(lZeroBasedIndex,"Store the zero-based index","Store the one-based index") // Output the Indexes as JSON: if(lZeroBasedIndex,[0,1],[1,2])
    ? "</br>"

    ********************************************************************
    aNums:={ 3,2,4 }
    nTarget:=6 // Target sum
    aResult:=TwoSum(aNums,nTarget,lZeroBasedIndex)
    ? "Indexes: " ,hb_JSONEncode(aResult),if(lZeroBasedIndex,"Store the zero-based index","Store the one-based index") // Output the Indexes as JSON: if(lZeroBasedIndex,[1,2],[2,3])
    ? "</br>"

    ********************************************************************
    aNums:={3,3}
    nTarget:=6
    aResult:=TwoSum(aNums,nTarget,lZeroBasedIndex)
    ? "Indexes: " ,hb_JSONEncode(aResult),if(lZeroBasedIndex,"Store the zero-based index","Store the one-based index") // Output the Indexes as JSON: if(lZeroBasedIndex,[0,1],[1,2])
    ? "</br>"

    ********************************************************************
    aNums:={2,7,11,15}
    nTarget:=17
    aResult:=TwoSum(aNums,nTarget,lZeroBasedIndex)
    ? "Indexes: " ,hb_JSONEncode(aResult),if(lZeroBasedIndex,"Store the zero-based index","Store the one-based index") // Output the Indexes as JSON: if(lZeroBasedIndex,[0,1],[1,2])
    ? "</br>"

    return

static function TwoSum(aNums as array,nTarget as numeric,lZeroBasedIndex as logical)

    local hSeen as hash:=hb_hASH() // Dictionary to store {value => index}
    local i,nAT,nNum,nComplement as numeric // Loop variables and temporary values

    hb_default(@lZeroBasedIndex,.F.) // Default value for lZeroBasedIndex is False

    for i:=1 to Len(aNums)

        nNum:=aNums[i] // Current number in the array
        nComplement:=nTarget-nNum // Calculate the complement for the target sum

        // Check if the complement has already been seen
        if (nAT:=hb_hPos(hSeen,nComplement)) > 0
            return { hb_hValueAt(hSeen,nAT),i-(if(lZeroBasedIndex,1,0)) } // return zero-based or the one-based Indexes
        endif

        // Add the current number and its index to the dictionary
        hb_hSet(hSeen,nNum,i-(if(lZeroBasedIndex,1,0)) ) // Store the zero-based index or Store the one-based index

    next i

    return {} // return an empty array if no solution is found
