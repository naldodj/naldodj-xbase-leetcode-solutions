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

    lIsPalindrome:=((nReverseNumber>0).and.(nReverseNumber==nNumber))

return(lIsPalindrome)

static function reverseNumber(nNumber as numeric,nMin as numeric,nMax as numeric)

    local nAbs as numeric:=Abs(nNumber) // Trabalha com o valor absoluto
    local nMult:=10
    local nSign as numeric:=if(nNumber<0,-1,1) // Armazena o sinal
    local nDigit as numeric// Armazena o dígito extraído
    local nReversed as numeric:= 0 // Armazena o número revertido
    local nReversedSign as numeric

    hb_default(@nMin,-2147483648)
    hb_default(@nMax,2147483647)

    while (nAbs>0)

        nDigit:=(nAbs%nMult) // Extrai o último dígito
        nAbs:=Int(nAbs/nMult) // Remove o último dígito

        // Verifica possível estouro de 32 bits
        nReversedSign:=nReversed*nSign
        if (((nReversedSign<nMin).or.(nReversedSign>nMax)))
            exit
        endif

        nReversed*=nMult
        nReversed+=nDigit // Adiciona o dígito extraído

    end while

    // Aplica o sinal e valida intervalo
    nReversed*=nSign
    if ((nReversed<nMin).or.(nReversed>nMax))
        nReversed:=0
    endif

    return(nReversed)
