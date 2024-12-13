/*
    [Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

    Este programa implementa a soma de dois números representados como arrays de dígitos.
    Os números são armazenados em ordem inversa (o dígito menos significativo vem primeiro),
    e o resultado também é retornado como um array na mesma ordem.

    Exemplos:

    1. Entrada: l1 = [2,4,3], l2 = [5,6,4]
       Saída: [7,0,8]
       Explicação: 342 + 465 = 807.

    2. Entrada: l1 = [0], l2 = [0]
       Saída: [0]

    3. Entrada: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
       Saída: [8,9,9,9,0,0,0,1]

    Restrições:
    - O número de nós em cada lista está no intervalo [1, 100].
    - Cada nó contém um único dígito no intervalo [0, 9].
    - Os números não possuem zeros à esquerda, exceto o número 0 em si.

    Released to Public Domain.
*/

#define _SET_DECIMALS 3

procedure Main()
    // Testa a função `addTwoNumbers` com diferentes entradas
    ? "Sum: [2,4,3]+[5,6,4] => ", hb_JSONEncode(addTwoNumbers({2,4,3}, {5,6,4}))
    ? "</br>"
    ? "Sum: [0]+[0] => ", hb_JSONEncode(addTwoNumbers({0}, {0}))
    ? "</br>"
    ? "Sum: [9,9,9,9,9,9,9]+[9,9,9,9] => ", hb_JSONEncode(addTwoNumbers({9,9,9,9,9,9,9}, {9,9,9,9}))
return

/*
    Função: addTwoNumbers
    Realiza a soma de dois números representados como arrays de dígitos, armazenados em ordem inversa.

    Parâmetros:
    - a (array): Primeiro número como array de dígitos.
    - b (array): Segundo número como array de dígitos.
    - n (numeric, opcional): Comprimento máximo dos arrays.
                              Se não fornecido, é calculado como o comprimento máximo entre `a` e `b`.
    - nBase (numeric, opcional): Base numérica da soma (padrão: 10 para sistema decimal).

    Retorno:
    - array: Resultado da soma como um array de dígitos na ordem inversa.
*/
static function addTwoNumbers(a as array, b as array, n as numeric, nBase as numeric)
    local aResult as array       // Array para armazenar o resultado final
    local nSum as numeric        // Soma dos dígitos e o carry
    local nIdx as numeric        // Índice para percorrer os arrays
    local nFill as numeric       // Número de posições para preencher com zeros
    local nCarry as numeric := 0 // Carry (transbordo) para a próxima posição

    set(_SET_DECIMALS, 0)        // Define precisão decimal para evitar arredondamentos

    hb_default(@n, Max(Len(a), Len(b))) // Define comprimento máximo se não especificado
    hb_default(@nBase, 10)              // Define a base numérica padrão (decimal)

    // Ajusta os arrays para o mesmo comprimento, preenchendo com zeros à direita
    if Len(a) < n
        nFill := ((n - Len(a)) + 1)
        aFill(aSize(a, n), 0, nFill, n)
    elseif Len(b) < n
        nFill := ((n - Len(b)) + 1)
        aFill(aSize(b, n), 0, nFill, n)
    endif

    // Inicializa o array de resultados com zeros, incluindo espaço extra para carry final
    aResult := aFill(Array(n + 1), 0)

    // Soma os dígitos correspondentes
    for nIdx := 1 to n
        nSum := a[nIdx] + b[nIdx] + nCarry   // Soma dos dígitos e carry
        nCarry := Int(nSum / nBase)          // Calcula o carry para a próxima posição
        aResult[nIdx] := Mod(nSum, nBase)    // Armazena o dígito resultante
    next nIdx

    // Adiciona carry final, se existir
    if (nCarry > 0)
        aResult[nIdx] := nCarry
    endif

    // Remove zeros à direita do array resultante
    if aResult[nIdx] == 0
        aResult := aSize(aDel(aResult, nIdx), Len(aResult) - 1)
    endif

    return aResult // Retorna o array com o resultado final
