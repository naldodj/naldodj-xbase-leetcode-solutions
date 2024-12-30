/*
    9. Palindrome Number

    Given an integer x, return true if x is a palindrome, and false otherwise.

    Example 1:

    Input: x = 121
    Output: true
    Explanation: 121 reads as 121 from left to right and from right to left.

    Example 2:

    Input: x = -121
    Output: false
    Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.

    Example 3:

    Input: x = 10
    Output: false
    Explanation: Reads 01 from right to left. Therefore it is not a palindrome.

    Constraints:

    -2^31 <= x <= 2^31 - 1

    Follow up: Could you solve it without converting the integer to a string?

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local lOutPut as logical

    local nInput as numeric

    nInput:=121
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

    nInput*=-1
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

    nInput:=10
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

    nInput:=444
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

    nInput:=454
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

    nInput:=321
    ? "Input: ",nInput,"</br>"
    lOutPut:=isPalindrome(nInput)
    ? "Output: ",hb_JSONEncode(lOutPut),"</br>","</br>"

return

static function isPalindrome(nNumber as numeric)

    local nReverseNumber as numeric

    local lIsPalindrome as logical

    nReverseNumber:=reverseNumber(nNumber)

    lIsPalindrome:=if(nReverseNumber<0,.F.,(nReverseNumber==nNumber))

return(lIsPalindrome)

static function reverseNumber(nNumber as numeric,nMin as numeric,nMax as numeric)

    local cReversed as character:=hb_NToC(Abs(nNumber))

    local nSign as numeric:=if(nNumber<0,-1,1)
    local nResult as numeric

    // Invertendo os dígitos
    cReversed:=reverseString(cReversed,Len(cReversed))

    // Convertendo de volta para número
    nResult:=(Val(cReversed)*nSign)

    // Validando intervalo de 32 bits
    hb_default(@nMin,-2147483648)
    hb_default(@nMax,2147483647)
    if ((nResult<-2147483648).or.(nResult>2147483647))
        nResult:=0
    endif

    return(nResult)

static function reverseString(cInput as character,nSizeInput as numeric)

    local cOutPut as character

    local y as numeric, i as numeric:=0

    cOutPut:=Space(nSizeInput)
    y:=nSizeInput
    while (y>0)
        cOutPut:=Stuff(cOutPut,++i,1,SubStr(cInput,y--,1))
    end while

    return(cOutPut) as character
