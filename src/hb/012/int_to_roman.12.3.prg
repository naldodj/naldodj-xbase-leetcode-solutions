/*
    12. Integer to Roman

    Seven different symbols represent Roman numerals with the following values:

    Symbol  Value
    I       1
    V       5
    X       10
    L       50
    C       100
    D       500
    M       1000
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
    ? "Output: ",cOutPut,"</br>"
    nInput:=RomanToDec( cOutPut )
    ? "Rom2Dec: ",nInput,"</br>","</br>"

    nInput:=58
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>"
    nInput:=RomanToDec( cOutPut )
    ? "Rom2Dec: ",nInput,"</br>","</br>"

    nInput:=1994
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>"
    nInput:=RomanToDec( cOutPut )
    ? "Rom2Dec: ",nInput,"</br>","</br>"

    nInput:=1970
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>"
    nInput:=RomanToDec( cOutPut )
    ? "Rom2Dec: ",nInput,"</br>","</br>"

    nInput:=2010
    ? "Input: ",nInput,"</br>"
    cOutPut:=intToRoman(nInput)
    ? "Output: ",cOutPut,"</br>"
    nInput:=RomanToDec( cOutPut )
    ? "Rom2Dec: ",nInput,"</br>","</br>"

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

static function RomanMapping()
    return(;
                {;
                   {1000,"M"};
                  ,{900,"CM"};
                  ,{500,"D"};
                  ,{400,"CD"};
                  ,{100,"C"};
                  ,{90,"XC"};
                  ,{50,"L"};
                  ,{40,"XL"};
                  ,{10,"X"};
                  ,{9,"IX"};
                  ,{5,"V"};
                  ,{4,"IV"};
                  ,{1,"I"};
                };
    ) as array

static function DecToRoman( nNumber as numeric )

    local aMapping as array:=RomanMapping()

    local cRoman as character:=""

    local i as numeric

    for i:=1 to Len(aMapping)
        while (nNumber>=aMapping[i][1])
            cRoman+=aMapping[i][2]
            nNumber-=aMapping[i][1]
        end while
    next i

    return(cRoman)

static function RomanToDec( cRoman as character )

   local nTotal as numeric:=0
   local nPrevValue as numeric:=0
   local nCurrentValue as numeric:=0
   local i as numeric

   // Mapeamento de valores dos números romanos
   local hRomanValues as hash := {;
        "I" => 1;
       ,"V" => 5;
       ,"X" => 10;
       ,"L" => 50;
       ,"C" => 100;
       ,"D" => 500;
       ,"M" => 1000;
   }

   // Percorrer o número romano do final ao início
   for i:=Len(cRoman) to 1 step -1
      // Obter o valor do caractere atual
      nCurrentValue:=hRomanValues[subStr(cRoman,i,1)]
      if (nCurrentValue<nPrevValue)
         // Regra de subtração
         nTotal-=nCurrentValue
      else
         // Adicionar valor ao total
         nTotal+=nCurrentValue
      endif
      // Atualizar o valor anterior
      nPrevValue:=nCurrentValue
   next i

   return(nTotal) as numeric