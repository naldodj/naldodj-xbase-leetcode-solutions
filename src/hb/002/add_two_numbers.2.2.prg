/*

    [Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

    You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order,and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

    You may assume the two numbers do not contain any leading zero,except the number 0 itself.

    Example 1:

    Input: l1 = [2,4,3],l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.

    Example 2:

    Input: l1 = [0],l2 = [0]
    Output: [0]
    Example 3:

    Input: l1 = [9,9,9,9,9,9,9],l2 = [9,9,9,9]
    Output: [8,9,9,9,0,0,0,1]

    Constraints:

    The number of nodes in each linked list is in the range [1,100].
    0 <= Node.val <= 9
    It is guaranteed that the list represents a number that does not have leading zeros.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/

#define _SET_DECIMALS 3

procedure Main()
    // Testa a função `addTwoNumbers` com diferentes entradas
    ? "Sum: [2,4,3]+[5,6,4] => ",hb_JSONEncode(addTwoNumbers({2,4,3},{5,6,4}))
    ? "</br>"
    ? "Sum: [0]+[0] => ",hb_JSONEncode(addTwoNumbers({0},{0}))
    ? "</br>"
    ? "Sum: [9,9,9,9,9,9,9]+[9,9,9,9] => ",hb_JSONEncode(addTwoNumbers({9,9,9,9,9,9,9},{9,9,9,9}))
return

/*
    Função: addTwoNumbers
    Realiza a soma de dois Numeros representados como arrays de digitos,armazenados em ordem inversa.

    Parâmetros:
    - a (array): Primeiro Numero como array de digitos.
    - b (array): Segundo Numero como array de digitos.
    - n (numeric,opcional): Comprimento maximo dos arrays.
                              Se nao fornecido,e calculado como o comprimento maximo entre `a` e `b`.
    - nBase (numeric,opcional): Base numerica da soma (padrao: 10 para sistema decimal).

    Retorno:
    - array: Resultado da soma como um array de digitos na ordem inversa.
*/
static function addTwoNumbers(a as array,b as array,n as numeric,nBase as numeric)
    local aResult as array       // Array para armazenar o resultado final
    local nSum as numeric        // Soma dos digitos e o carry
    local nIdx as numeric        // Indice para percorrer os arrays
    local nFill as numeric       // Numero de Posicoes para preencher com zeros
    local nCarry as numeric:=0 // Carry (transbordo) para a proxima posicao

    set(_SET_DECIMALS,0)        // Define precisao decimal para evitar arredondamentos

    hb_default(@n,Max(Len(a),Len(b))) // Define comprimento maximo se nao especificado
    hb_default(@nBase,10)              // Define a base numerica padrao (decimal)

    // Ajusta os arrays para o mesmo comprimento,preenchendo com zeros à direita
    if Len(a) < n
        nFill:=((n - Len(a)) + 1)
        aFill(aSize(a,n),0,nFill,n)
    elseif Len(b) < n
        nFill:=((n - Len(b)) + 1)
        aFill(aSize(b,n),0,nFill,n)
    endif

    // Inicializa o array de resultados com zeros,incluindo espaço extra para carry final
    aResult:=aFill(Array(n + 1),0)

    // Soma os digitos correspondentes
    for nIdx:=1 to n
        nSum:=a[nIdx] + b[nIdx] + nCarry   // Soma dos digitos e carry
        nCarry:=Int(nSum / nBase)          // Calcula o carry para a proxima posicao
        aResult[nIdx]:=Mod(nSum,nBase)    // Armazena o dígito resultante
    next nIdx

    // Adiciona carry final,se existir
    if (nCarry > 0)
        aResult[nIdx]:=nCarry
    endif

    // Remove zeros à direita do array resultante
    if aResult[nIdx] == 0
        aResult:=aSize(aDel(aResult,nIdx),Len(aResult) - 1)
    endif

    return aResult // Retorna o array com o resultado final
