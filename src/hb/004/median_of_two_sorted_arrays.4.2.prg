/*
    4. Median of Two Sorted Arrays

    Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

    The overall run time complexity should be O(log (m+n)).

    Example 1:

    Input: nums1 = [1,3], nums2 = [2]
    Output: 2.00000
    Explanation: merged array = [1,2,3] and median is 2.

    Example 2:

    Input: nums1 = [1,2], nums2 = [3,4]
    Output: 2.50000
    Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

    Constraints:

    nums1.length == m
    nums2.length == n
    0 <= m <= 1000
    0 <= n <= 1000
    1 <= m + n <= 2000
    -106 <= nums1[i], nums2[i] <= 106

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
procedure Main()

    local aNums1 as array
    local aNums2 as array
    local nMedian as numeric

    aNums1 := {1, 3}
    aNums2 := {2}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1, 2}
    aNums2 := {3, 4}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {0}
    aNums2 := {3, 4}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,5}
    aNums2 := {2,3,4,6}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {2,7}
    aNums2 := {1,3,4,5,6}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {2,7}
    aNums2 := {1,3,4,5,6,8}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,3}
    aNums2 := {2}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,2}
    aNums2 := {3,4}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,4}
    aNums2 := {2,3}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {0}
    aNums2 := {3,4}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {2,5,7}
    aNums2 := {1,3}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,2,3}
    aNums2 := {4,5,6}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {1,3,8}
    aNums2 := {2,4,5}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {0,0}
    aNums2 := {0,0}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {}
    aNums2 := {1}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {2}
    aNums2 := {}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {21,33,41}
    aNums2 := {14,15,16}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    aNums1 := {3,121,133,141}
    aNums2 := {5,114,115,116}
    nMedian := FindMedianSortedArrays(aNums1, aNums2)
    ? "FindMedianSortedArrays("+hb_JSONEncode(aNums1)+","+hb_JSONEncode(aNums2)+")", "Median: ", nMedian,"</br>"

    return

static function FindMedianSortedArrays(aNums1, aNums2)

    local aResult as array := {}

    local i as numeric := 1
    local j as numeric := 1
    local k as numeric := 1
    local m as numeric := Len(aNums1)
    local n as numeric := Len(aNums2)
    local nMid1, nMid2  as numeric
    local nTotal as numeric
    local nCurrent as numeric

    if (m==0)
        aNums1:=aFill(aSize(aNums1,1),0)
        m:=1
    endif

    if (n==0)
        aNums2:=aFill(aSize(aNums2,1),0)
        n:=1
    endif

    nTotal := ( m + n )

    if (nTotal==2)
        AAdd(aResult, aNums1[1] )
        AAdd(aResult, aNums2[1] )
    else
        if ( Mod(nTotal, 2) == 1 )
            nMid1 := Int((nTotal + 1) / 2)
        else
            nMid1 := nTotal / 2
            nMid2 := nMid1 + 1
        endif

        while ( k <= nTotal )
            if ( i > m )
                // Apenas elementos de aNums2 restantes
                nCurrent := aNums2[j]
                j++
            elseif ( j > n )
                // Apenas elementos de aNums1 restantes
                nCurrent := aNums1[i]
                i++
            elseif ( aNums1[i] < aNums2[j] )
                nCurrent := aNums1[i]
                i++
            else
                nCurrent := aNums2[j]
                j++
            endif

            // Capture os valores do meio
            if ( k == nMid1 )
                AAdd(aResult, nCurrent)
            endif
            if (!Empty(nMid2)) .and. (k == nMid2)
                AAdd(aResult, nCurrent)
            endif

            k++
        end while
    endif

    // Retorna a mediana
    if (Len(aResult) == 1)
        return aResult[1]
    else
        return ( (aResult[1] + aResult[2]) / 2 )
    endif

return(0)

static function VirtualMerge(aNums1, aNums2)

    local i as numeric := 1
    local j as numeric := 1
    local m as numeric := Len(aNums1)
    local n as numeric := Len(aNums2)

    if (m==0)
        aNums1:=aFill(aSize(aNums1,1),0)
        m:=1
    endif

    if (n==0)
        aNums2:=aFill(aSize(aNums2,1),0)
        n:=1
    endif

    while ( ( i <= m ) .or. ( j <= n ) )
        if (i > m)
            // Apenas elementos restantes de aNums2
            ? aNums2[j]
            j++
        elseif ( j > n )
            // Apenas elementos restantes de aNums1
            ? aNums1[i]
            i++
        elseif ( aNums1[i] < aNums2[j] )
            ? aNums1[i]
            i++
        else
            ? aNums2[j]
            j++
        endif
    end while

    return(nil)
