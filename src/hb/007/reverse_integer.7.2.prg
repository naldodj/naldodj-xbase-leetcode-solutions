/*
    7. Reverse Integer

    Given a signed 32-bit integer x, return x with its digits reversed. if reversing x causes the value to go outside the signed 32-bit integer range [-2^31, 2^31 - 1], then return(0).

    Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

    Example 1:

    Input: x = 123
    Output: 321

    Example 2:

    Input: x = -123
    Output: -321

    Example 3:

    Input: x = 120
    Output: 21

    Constraints:

    -2^31 <= x <= 2^31 - 1

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local nInput as numeric
    local nOutPut as numeric

    nInput:=123
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    nInput*=-1
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    nInput:=7463847412
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    nInput:=-8463847412
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    nInput:=2147483647
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    nInput:=-2147483648
    ? "Input: ",nInput,"<br/>"
    nOutPut:=ReverseNumber(nInput)
    ? "Output: ",hb_NToC(nOutPut),"<br/>","<br/>"

    return

static function ReverseNumber( nNumber as numeric,nMin as numeric,nMax as numeric)

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
