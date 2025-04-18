/*

    3. Longest Substring Without Repeating Characters

    Given a string s,find the length of the longest substring without repeating characters.

    Example 1:

    Input: s = "abcabcbb"
    Output: 3
    Explanation: The answer is "abc",with the length of 3.

    Example 2:

    Input: s = "bbbbb"
    Output: 1
    Explanation: The answer is "b",with the length of 1.

    Example 3:

    Input: s = "pwwkew"
    Output: 3
    Explanation: The answer is "wke",with the length of 3.
    Notice that the answer must be a substring,"pwke" is a subsequence and not a substring.

    Constraints:

    0 <= s.length <= 5 * 104
    s consists of English letters,digits,symbols and spaces.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local cSubString as character

    ? "abcabcbb =>",lengthOfLongestsubString("abcabcbb",@cSubString)," => ",hb_JSONEncode(cSubString)  // Resultado: 3
    ? "<br/>"

    ? "bbbbb =>" ,lengthOfLongestsubString("bbbbb",@cSubString)," => ",hb_JSONEncode(cSubString)     // Resultado: 1
    ? "<br/>"

    ? "pwwkew => ",lengthOfLongestsubString("pwwkew",@cSubString)," => ",hb_JSONEncode(cSubString)    // Resultado: 3
    ? "<br/>"

    ? "blacktdn =>",lengthOfLongestsubString("blacktdn",@cSubString)," => ",hb_JSONEncode(cSubString)  // Resultado: 8
    ? "<br/>"

    ? "susej ed odlaniram => ",lengthOfLongestsubString("susej ed odlaniram",@cSubString)," => ",hb_JSONEncode(cSubString) // Resultado: 8
    ? "<br/>"

    ? "xBase => ",lengthOfLongestsubString("xBase",@cSubString)," => ",hb_JSONEncode(cSubString) // Resultado: 5
    ? "<br/>"

    ? "harbour => ",lengthOfLongestsubString("harbour",@cSubString)," => ",hb_JSONEncode(cSubString) // Resultado: 6
    ? "<br/>"

    ? "tlpp => ",lengthOfLongestsubString("tlpp",@cSubString)," => ",hb_JSONEncode(cSubString) // Resultado: 3
    ? "<br/>"

    ? "advpl => ",lengthOfLongestsubString("advpl",@cSubString)," => ",hb_JSONEncode(cSubString) // Resultado: 5
    ? "<br/>"

return

static function lengthOfLongestsubString(cString as character,cSubString as character)

    local aSet as array:=array(0) // "Conjunto" para armazenar os caracteres na janela

    local cChar as character         // Caractere atual

    local nAT as numeric
    local nEnd as numeric            // indice final da janela
    local nStart as numeric:=1     // indice inicial da janela
    local nMaxLength as numeric:=0 // Comprimento maximo encontrado

    // Percorre a string com o indice nEnd como limite da janela
    for nEnd:=1 to Len(cString)

        cChar:=subStr(cString,nEnd,1)

        // Se o caractere ja estiver na janela,remova ate que ele seja único
        while (aScan(aSet,cChar) > 0)
            nAT:=aScan(aSet,subStr(cString,nStart,1))
            if (nAT>0)
                aSize(aDel(aSet,nAT),Len(aSet)-1)
            endif
            nStart++
        end while

        // Adiciona o caractere ao "conjunto"
        aAdd(aSet,cChar)

        // Atualiza o comprimento máximo e armazena a substring correspondente
        if (nEnd - nStart + 1 > nMaxLength)
            nMaxLength:=nEnd - nStart + 1
            cSubString:=subStr(cString,nStart,nMaxLength)
        endif

    next nEnd

    return nMaxLength as numeric
