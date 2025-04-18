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

function Main()
return(Integer_to_Roman())

static function Integer_to_Roman()

    local aInputs as array

    local cHTML as character
    local cOutPut as character

    local lMatched as logical

    local nIdx as numeric
    local nInput as numeric
    local nRoman2Dec as numeric

    aInputs:=Array(0)

    aAdd(aInputs,{"III",3})
    aAdd(aInputs,{"LVIII",58})
    aAdd(aInputs,{"MCMXCIV",1994})
    aAdd(aInputs,{"MMMDCCXLIX",3749})
    aAdd(aInputs,{"MCMLXX",1970})
    aAdd(aInputs,{"MMX",2010})

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<caption>"+ProcName()+"</caption>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=            "<th>Roman2Dec</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"
    for nIdx:=1 to Len(aInputs)
        nInput:=aInputs[nIdx][2]
        cOutPut:=intToRoman(nInput)
        nRoman2Dec:=RomanToDec(cOutPut)
        lMatched:=(cOutPut==aInputs[nIdx][1])
        cHTML+=        "<tr>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(nInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cOutPut+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+aInputs[nIdx][1]+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(nRoman2Dec)+"</td>"
        cHTML+=        "</tr>"
    next nIdx
    cHTML+=    "</tbody>"
    cHTML+="</table>"

    ? cHTML

    return(nil)

static function intToRoman( nNumber as numeric )

    local cRoman as character

    nNumber:=Int(nNumber)
    if (nNumber<1).or.(nNumber>3999)
        cRoman:="Out of range 1 <= n <= 3999"
    else
        cRoman:=DecToRoman(nNumber)
    endif

return(cRoman) as character

/*ref.: https://raw.githubusercontent.com/naldodj/naldodj-harbour-core/ce1bc2039902f3a3797de532f2d1c7a7745d44a6/contrib/hbmisc/nconvert.prg*/
static function DecToRoman( nNumber as numeric )

    local cRoman as character:= ""

    local hRoman as hash:={=>}

    if (nNumber>=1000)
        hb_HSet(hRoman,"M",Int(nNumber/1000))
        nNumber-=(hRoman["M"]*1000)
    endif

    if (nNumber>=900)
        hb_HSet(hRoman,"CM",Int(nNumber/900))
        nNumber-=(hRoman["CM"]*900)
    endif

    if (nNumber>=500)
        hb_HSet(hRoman,"D",Int(nNumber/500))
        nNumber-=(hRoman["D"]*500)
    endif

    if (nNumber>=400)
        hb_HSet(hRoman,"CD",Int(nNumber/400))
        nNumber-=(hRoman["CD"]*400)
    endif

    if (nNumber>=100)
        hb_HSet(hRoman,"C",Int(nNumber/100))
        nNumber-=(hRoman["C"]*100)
    endif

    if (nNumber>=90)
        hb_HSet(hRoman,"XC",Int(nNumber/90))
        nNumber-=(hRoman["XC"]*90)
    endif

    if (nNumber>=50)
        hb_HSet(hRoman,"L",Int(nNumber/50))
        nNumber-=(hRoman["L"]*50)
    endif

    if (nNumber>=40)
        hb_HSet(hRoman,"XL",Int(nNumber/40))
        nNumber-=(hRoman["XL"]*40)
    endif

    if (nNumber>=10)
        hb_HSet(hRoman,"X",Int(nNumber/10))
        nNumber-=(hRoman["X"]*10)
    endif

    if (nNumber>=9)
        hb_HSet(hRoman,"IX",Int(nNumber/9))
        nNumber-=(hRoman["IX"]*9)
    endif

    if (nNumber>=5)
        hb_HSet(hRoman,"V",Int(nNumber/5))
        nNumber-=(hRoman["V"]*5)
    endif

    if (nNumber>=4)
        hb_HSet(hRoman,"IV",Int(nNumber/4))
        nNumber-=(hRoman["IV"]*4)
    endif

    if (nNumber>1)
        hb_HSet(hRoman,"I",nNumber)
        nNumber-=nNumber
    endif

    hb_HEval(hRoman,{|cKey as character,nValue as numeric|cRoman+=Replicate(cKey,nValue)})

    return(cRoman) as character

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
