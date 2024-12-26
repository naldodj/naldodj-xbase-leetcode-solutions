/*
    6. Zigzag Conversion

    The string "PAYPALISHIRING" is written in a zigzag Pattern on a given number of rows like this: (you may want to display this Pattern in a fixed font for better legibility)

    P   A   H   N
    A P L S I I G
    Y   I   R
    And then read line by line: "PAHNAPLSIIGYIR"

    Write the code that will take a string and make this conversion given a number of rows:

    string convert(string s, int NumRows);

    Example 1:
    Input: s = "PAYPALISHIRING", NumRows = 3
    Output: "PAHNAPLSIIGYIR"

    Example 2:
    Input: s = "PAYPALISHIRING", NumRows = 4
    Output: "PINALSIGYAHRPI"
    Explanation:
    P     I    N
    A   L S  I G
    Y A   H R
    P     I

    Example 3:
    Input: s = "A", NumRows=1
    Output: "A"

    Constraints:

    1 <= s.length <= 1000
    s consists of English letters (lower-case and upper-case), ',' and '.'.
    1 <= NumRows <= 1000

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/

procedure Main()

    local cInput as character
    local cOutput as character
    local cReverse as character

    local nNumRows as numeric

    cInput:="PAYPALISHIRING"
    nNumRows:=3
    cOutput:=ZigZagConvert(cInput,nNumRows)
    cReverse:=ReverseZigZag(cOutput,nNumRows)
    ? "Input: "+cInput,"</br>"
    ? "Output: "+cOutput,"</br>"
    ? "Reverse: "+cReverse,"</br>","</br>"

    cInput:="PAYPALISHIRING"
    nNumRows:=4
    cOutput:=ZigZagConvert(cInput,nNumRows)
    cReverse:=ReverseZigZag(cOutput,nNumRows)
    ? "Input: "+cInput,"</br>"
    ? "Output: "+cOutput,"</br>"
    ? "Reverse: "+cReverse,"</br>","</br>"

    cInput:="The quick, brown fox jumps over the lazy dog."
    nNumRows:=10
    cOutput:=ZigZagConvert(cInput,nNumRows)
    cReverse:=ReverseZigZag(cOutput,nNumRows)
    ? "Input: "+cInput,"</br>"
    ? "Output: "+cOutput,"</br>"
    ? "Reverse: "+cReverse,"</br>","</br>"

    cInput:="DAC NTHE"
    nNumRows:=3
    cOutput:=ZigZagConvert(cInput,nNumRows)
    cReverse:=ReverseZigZag(cOutput,nNumRows)
    ? "Input: "+cInput,"</br>"
    ? "Output: "+cOutput,"</br>"
    ? "Reverse: "+cReverse,"</br>","</br>"

    return

static function ZigZagConvert(cInput as character,nNumRows as numeric)

    local cOutPut as character

    local nInputLen as numeric:=Len(cInput)
    local i as numeric,nIdx as numeric,nDirection as numeric

    local hRows as hash

    if ((nNumRows<=1).or.(nInputLen<=nNumRows))
        return(cInput)
    endif

    hRows:={=>}

    nIdx:=1

    // 1 para descer, -1 para subir
    nDirection:=1

    // Percorre a string em formato zigzag
    for i:=1 to nInputLen

        if (hb_HHasKey(hRows,nIdx))
            hRows[nIdx]+=subStr(cInput,i,1)
        else
            hb_HSet(hRows,nIdx,subStr(cInput,i,1))
        endif

        if (i<nInputLen)
            if (nIdx==nNumRows)
                nDirection:=-1
            elseif (nIdx==1)
                nDirection:=1
            endif
            nIdx+=nDirection
        endif

    next i

    cOutPut:=""
    hb_HEval(hRows,{|nKey as numeric,cValue as character|cOutPut+=cValue})

    return(cOutPut)

static function ReverseZigZag(cZigZagStr, nNumRows as numeric)

    local aPositions as array
    local aRowLengths as array

    local cOutPut as character

    local i,nRow,nStart,nDirection as numeric
    local nStrLen:=Len(cZigZagStr)

    if ((nNumRows<=1).or.(nStrLen<=nNumRows))
        return(cZigZagStr)
    endif

    // Etapa 1: Calcular o número de caracteres em cada linha
    nRow:=1
    nDirection:=1
    aRowLengths:=aFill(Array(nNumRows),0)
    for i:=1 to nStrLen
        aRowLengths[nRow]++
        if (nRow==nNumRows)
            nDirection:=-1
        elseif (nRow==1)
            nDirection:=1
        endif
        nRow+=nDirection
    next i

    // Etapa 2: Dividir a string codificada em blocos para cada linha
    nStart:=1
    aPositions:={}
    for nRow := 1 to nNumRows
        aAdd(aPositions,subStr(cZigZagStr,nStart,aRowLengths[nRow]))
        nStart+=aRowLengths[nRow]
    next nRow

    // Etapa 3: Reconstituir a string original usando o padrão zigzag
    nRow:=1
    cOutPut:=Space(nStrLen)
    nDirection := 1
    for i:=1 to nStrLen
        cOutPut:=Stuff(cOutPut,i,1,Left(aPositions[nRow],1))
        //Remove o primeiro caractere usado
        aPositions[nRow]:=subStr(aPositions[nRow],2)
        if (nRow==nNumRows)
            nDirection:=-1
        elseif (nRow==1)
            nDirection:=1
        endif
        nRow+=nDirection
    next i

    return(cOutPut) as character
