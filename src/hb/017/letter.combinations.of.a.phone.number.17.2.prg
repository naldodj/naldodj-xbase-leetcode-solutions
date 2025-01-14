/*
    17. Letter Combinations of a Phone Number

    Given a string containing digits from 2-9 inclusive,return all possible letter combinations that the number could represent. Return the answer in any order.

    A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

    [keypad](https://assets.leetcode.com/uploads/2022/03/15/1200px-telephone-keypad2svg.png)

    Example 1:

    Input: digits = "23"
    Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

    Example 2:
    Input: digits = ""
    Output: []

    Example 3:
    Input: digits = "2"
    Output: ["a","b","c"]

    Constraints:

    0 <= digits.length <= 4
    digits[i] is a digit in the range ['2','9'].

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    /*
        aInputs contém conjuntos de casos de teste. Cada entrada é uma matriz de dois elementos:
        - O primeiro elemento é o valor esperado (triplets que somam 0).
        - O segundo elemento é o array de entrada para testar a função ThreeSum.
    */
    local aInputs as array
    local aOutPut as array

    /*
        cHTML armazena a saída em formato HTML. Isso facilita a visualização dos resultados
        em uma tabela formatada,destacando correspondências entre a saída e o valor esperado.
    */
    local cHTML as character
    local cInput as character

    local lMatched as logical

    local nIdx as numeric

    aInputs:=Array(0)

    // Casos de teste definidos
    aAdd(aInputs,{{"ad","ae","af","bd","be","bf","cd","ce","cf"},"23"})
    aAdd(aInputs,{{},""})
    aAdd(aInputs,{{"a","b","c"},"2"})
    aAdd(aInputs,{{"da","db","dc","ea","eb","ec","fa","fb","fc"},"32"})

    /*
        Construção da tabela HTML que será gerada como saída.
        Inclui cabeçalhos e estilos para facilitar a leitura.
    */
    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"

    // Itera sobre os casos de teste
    for nIdx:=1 to Len(aInputs)
        cInput:=aInputs[nIdx][2] // Entrada atual
        aOutPut:=LetterCombinations(cInput) // Resultado da função LetterCombinations
        lMatched:=(hb_JSONEncode(aOutPut)==hb_JSONEncode(aInputs[nIdx][1])) // Verifica correspondência com o esperado
        // Gera uma linha na tabela HTML
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(cInput)+"</td>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aOutPut)+"</td>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx

    cHTML+=    "</tbody>"
    cHTML+="</table>"

    // Exibe a tabela HTML no console
    ? cHTML

    return

static function LetterCombinations(cDigits as character)

    local aResult as array

    local hMap as hash

    aResult:=Array(0)

    begin sequence

        if (Empty(cDigits))
            break
        endif

        //Mapeamento de dígitos para letras
        hMap:={;
             "2" => {"a","b","c"};
            ,"3" => {"d","e","f"};
            ,"4" => {"g","h","i"};
            ,"5" => {"j","k","l"};
            ,"6" => {"m","n","o"};
            ,"7" => {"p","q","r","s"};
            ,"8" => {"t","u","v"};
            ,"9" => {"w","x","y","z"};
        }

        GenerateCombinations(hMap,cDigits,1,"",@aResult)

    end sequence

    return(aResult) as array

static procedure GenerateCombinations(hMap as hash,cDigits as character,nIndex as numeric,cCurrent as character,/*@*/aResult as array)

    local aLetters as array

    local cDigit as character
    local cLetter as character


    local i as numeric

    begin sequence

        if (nIndex>Len(cDigits))
            aAdd(@aResult,cCurrent)
            break
        endif

        cDigit:=SubStr(cDigits,nIndex,1)
        aLetters:=hMap[cDigit]

        if (!Empty(aLetters))
            for each cLetter in aLetters
                GenerateCombinations(hMap,cDigits,nIndex+1,cCurrent+cLetter,@aResult)
            next each
        endif

    end sequence

    return
