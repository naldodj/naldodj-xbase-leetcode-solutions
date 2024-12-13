/*

    [Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

    You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

    You may assume the two numbers do not contain any leading zero, except the number 0 itself.

    Example 1:

    Input: l1 = [2,4,3], l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.

    Example 2:

    Input: l1 = [0], l2 = [0]
    Output: [0]
    Example 3:

    Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    Output: [8,9,9,9,0,0,0,1]

    Constraints:

    The number of nodes in each linked list is in the range [1, 100].
    0 <= Node.val <= 9
    It is guaranteed that the list represents a number that does not have leading zeros.

    Released to Public Domain.
    --------------------------------------------------------------------------------------
*/
procedure Main()
    ? "Sum: '243'+'564' => " ,addTwoNumbers("243","564")
    ? "</br>"
    ? "Sum: '0'+'0' => " ,addTwoNumbers("0","0")
    ? "</br>"
    ? "Sum: '9999999'+'9999' => " ,addTwoNumbers("9999999","9999")
return

static function addTwoNumbers(a as character,b as character,n as numeric,nBase as numeric)

    local c as array

    local s as character

    local k as numeric
    local y as numeric

    hb_default(@n,Max(Len(a),Len(b)))
    hb_default(@nBase,10)

    a:=PadL(a,n,"0")
    b:=PadL(b,n,"0")

    y:=n+1
    k:=y
    c:=aFill(Array(y),0)

    while (n>0)
        c[k]+=Val(SubStr(a,n,1))+Val(SubStr(b,n,1))
        if (c[k]>=nBase)
            c[k-1]+=1
            c[k]-=nBase
        endif
        --k
        --n
    end while

    s:=""

    aEval(c,{|v as numeric|s+=hb_NToC(v)})

    s:=LeftCharRemove(s,"0",.F.)

    return(strReverse(s,Len(s)))

static function strReverse(c as character,n as numeric)

    local s as character
    local y as numeric

    s:=""
    y:=n
    while (y>0)
        s+=SubStr(c,y--,1)
    end while

    return(s)

static function LeftCharRemove(cStr,cChr,lAll)
    local cStrRet as character
    local nAT as numeric
    local nCHR as numeric
    hb_default(@lAll,.T.)
    cStrRet:=cStr
    nCHR:=len(cChr)
    while (Left(cStrRet,nCHR)==cChr)
        nAT:=1
        nAT+=nCHR
        cStrRet:=subStr(cStrRet,nAT)
        if (!lAll)
            exit
        endif
    end while
    return(cStrRet)
