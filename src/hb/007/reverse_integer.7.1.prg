/*
    7. Reverse Integer

    Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-2^31, 2^31 - 1], then return 0.

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

static function ReverseNumber(nNumber as numeric)

    local cReversed as character:=hb_NToC(Abs(nNumber))

    local nSign as numeric:=if(nNumber<0,-1,1)
    local nResult as numeric

    // Invertendo os dígitos
    cReversed:=reverseString(cReversed,Len(cReversed))

    // Convertendo de volta para número
    nResult:=(Val(cReversed)*nSign)

    // Validando intervalo de 32 bits
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
