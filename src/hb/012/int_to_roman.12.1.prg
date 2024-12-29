/*
    12. Integer to Roman

    Seven different symbols represent Roman numerals with the following values:

    Symbol    Value
    I    1
    V    5
    X    10
    L    50
    C    100
    D    500
    M    1000
    Roman numerals are formed by appending the conversions of decimal place values from highest to lowest. Converting a decimal place value into a Roman numeral has the following rules:

    If the value does not start with 4 or 9, select the symbol of the maximal value that can be subtracted from the input, append that symbol to the result, subtract its value, and convert the remainder to a Roman numeral.
    If the value starts with 4 or 9 use the subtractive form representing one symbol subtracted from the following symbol, for example, 4 is 1 (I) less than 5 (V): IV and 9 is 1 (I) less than 10 (X): IX. Only the following subtractive forms are used: 4 (IV), 9 (IX), 40 (XL), 90 (XC), 400 (CD) and 900 (CM).
    Only powers of 10 (I, X, C, M) can be appended consecutively at most 3 times to represent multiples of 10. You cannot append 5 (V), 50 (L), or 500 (D) multiple times. If you need to append a symbol 4 times use the subtractive form.
    Given an integer, convert it to a Roman numeral.

    Example 1:

    Input: num = 3749

    Output: "MMMDCCXLIX"

    Explanation:

    3000 = MMM as 1000 (M) + 1000 (M) + 1000 (M)
     700 = DCC as 500 (D) + 100 (C) + 100 (C)
      40 = XL as 10 (X) less of 50 (L)
       9 = IX as 1 (I) less of 10 (X)
    Note: 49 is not 1 (I) less of 50 (L) because the conversion is based on decimal places

    Example 2:

    Input: num = 58

    Output: "LVIII"

    Explanation:

    50 = L
     8 = VIII
    Example 3:

    Input: num = 1994

    Output: "MCMXCIV"

    Explanation:

    1000 = M
     900 = CM
      90 = XC
       4 = IV

    Constraints:

    1 <= num <= 3999

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local nInput as numeric
    local cOutPut as character

    nInput:=3749
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>","</br>"

    nInput:=58
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>","</br>"

    nInput:=1994
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>","</br>"

    nInput:=1970
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>","</br>"

    nInput:=2010
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>","</br>"

return

static function intToRoman( nNumber as numeric )

    local cRoman as character

    nNumber:=Int(nNumber)
    if (nNumber<1).or.(nNumber>3999)
        cRoman:="Out of range 1 <= n <= 3999"
    else
        cRoman:=DecToRoman(nNumber)
    endif

return(cRoman)

/*ref.: https://raw.githubusercontent.com/naldodj/naldodj-harbour-core/ce1bc2039902f3a3797de532f2d1c7a7745d44a6/contrib/hbmisc/nconvert.prg*/
static function DecToRoman( nNumber as numeric )

   LOCAL cRoman as character := ""

   DO WHILE nNumber >= 1000
      cRoman += "M"
      nNumber -= 1000
   ENDDO
   DO WHILE nNumber >= 900
      cRoman += "CM"
      nNumber -= 900
   ENDDO
   DO WHILE nNumber >= 500
      cRoman += "D"
      nNumber -= 500
   ENDDO
   DO WHILE nNumber >= 400
      cRoman += "CD"
      nNumber -= 400
   ENDDO
   DO WHILE nNumber >= 100
      cRoman += "C"
      nNumber -= 100
   ENDDO
   DO WHILE nNumber >= 90
      cRoman += "XC"
      nNumber -= 90
   ENDDO
   DO WHILE nNumber >= 50
      cRoman += "L"
      nNumber -= 50
   ENDDO
   DO WHILE nNumber >= 40
      cRoman += "XL"
      nNumber -= 40
   ENDDO
   DO WHILE nNumber >= 10
      cRoman += "X"
      nNumber -= 10
   ENDDO
   DO WHILE nNumber >= 9
      cRoman += "IX"
      nNumber -= 9
   ENDDO
   DO WHILE nNumber >= 5
      cRoman += "V"
      nNumber -= 5
   ENDDO
   DO WHILE nNumber >= 4
      cRoman += "IV"
      nNumber -= 4
   ENDDO
   DO WHILE nNumber >= 1
      cRoman += "I"
      --nNumber
   ENDDO

   RETURN(cRoman) as character
