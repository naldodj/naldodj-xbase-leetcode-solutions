/*
    10. Regular Expression Matching

    Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:

    '.' Matches any single character.
    '*' Matches zero or more of the preceding element.

    The matching should cover the entire input string (not partial).

    Example 1:

    Input: s = "aa", p = "a"
    Output: false
    Explanation: "a" does not match the entire string "aa".

    Example 2:

    Input: s = "aa", p = "a*"
    Output: true
    Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
    Example 3:

    Input: s = "ab", p = ".*"
    Output: true
    Explanation: ".*" means "zero or more (*) of any character (.)".

    Constraints:

    1 <= s.length <= 20
    1 <= p.length <= 20
    s contains only lowercase English letters.
    p contains only lowercase English letters, '.', and '*'.

    It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
procedure Main()

    local aInputs as array:=Array(0)

    local cHTML as character
    local cInput as character
    local cPattern as character

    local lOutPut as logical
    local lMatched as logical

    local nIdx as numeric

    aAdd(aInputs,{.T.,"ab",".*"})
    aAdd(aInputs,{.F.,"ab","*."})
    aAdd(aInputs,{.F.,"Aa",".."})
    aAdd(aInputs,{.F.,"Aa",".*"})
    aAdd(aInputs,{.F.,"harbour","h**.ou*"})
    aAdd(aInputs,{.F.,"harbour","h*r.ou*"})
    aAdd(aInputs,{.T.,"harbour","h.r.ou."})
    aAdd(aInputs,{.T.,"aab","a.*"})
    aAdd(aInputs,{.T.,"aab","a*.*"})
    aAdd(aInputs,{.F.,"aa","a"})
    aAdd(aInputs,{.T.,"aa","a.*"})
    aAdd(aInputs,{.F.,"ab","*"})
    aAdd(aInputs,{.F.,"mississippi","mis*is*p*."})
    aAdd(aInputs,{.T.,"mississippi","mis*is*ip.*"})
    aAdd(aInputs,{.T.,"mississippi","mississippi"})

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<caption>"+ProcName()+"</caption>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input</th>"
    cHTML+=            "<th>Pattern</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"
    for nIdx:=1 to Len(aInputs)
        cInput:=aInputs[nIdx][2]
        cPattern:=aInputs[nIdx][3]
        lOutPut:=IsMatch(cInput,cPattern)
        lMatched:=(lOutPut==aInputs[nIdx][1])
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cInput+"</td>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cPattern+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nIdx][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx
    cHTML+=    "</tbody>"
    cHTML+="</table>"

    ? cHTML

    return

// Wrapper function
static function IsMatch(cString as character,cPattern as character,nMin as numeric,nMax as numeric)
    return(IsMatchRecursive(cString,cPattern,nMin,nMax)) as logical

static function IsMatchRecursive(cString as character,cPattern as character,nMin as numeric,nMax as numeric)

    local cTmpChar as character

    local lMatch as logical

    local nPatIdx as numeric
    local nStrSize as numeric
    local nPatSize as numeric
    local nTrimPatSize as numeric

    hb_default(@nMin,1)
    hb_default(@nMax,20)

    begin sequence

        //1 <= s.length <= 20
        nStrSize:=Len(cString)
        lMatch:=((nStrSize>=nMin).and.(nStrSize<=nMax))
        if (!lMatch)
            break
        endif

        //1 <= p.length <= 20
        nPatSize:=Len(cPattern)
        lMatch:=((nPatSize>=nMin).and.(nPatSize<=nMax))
        if (!lMatch)
            break
        endif

        //s contains only lowercase English letters.
        lMatch:=hb_RegexMatch(cString,"^[a-z]+$")
        if (!lMatch)
            break
        endif

        //p contains only lowercase English letters, '.', and '*'.
        lMatch:=hb_RegexMatch(cPattern,"^[a-z.*]+$")
        if (!lMatch)
            break
        endif

        //It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.
        lMatch:=(!("**"$cPattern).and.(!Left(cPattern,1)=="*"))
        if (!lMatch)
            break
        endif

        nTrimPatSize:=Min(nPatSize,Len(hb_StrReplace(cPattern,{".*"=>""})))

        lMatch:=(;
                    (nPatSize==nStrSize);
                    .or.;
                    (;
                        (nTrimPatSize<nStrSize);
                        .and.;
                        (!cPattern$cString);
                    );
        )
        if (!lMatch)
            break
        endif

        for nPatIdx:=1 to nPatSize
            cTmpChar:=subStr(cPattern,nPatIdx,1)
            if (!cTmpChar$".*")
                lMatch:=(cTmpChar$cString)
                if (!lMatch)
                    break
                endif
            endif
        next nPatIdx

        lMatch:=__IsMatch(cString,cPattern,nStrSize+1,nPatSize+1)

    end sequence

    return(lMatch) as logical

/*
    ref.: https://www.geeksforgeeks.org/implementing-regular-expression-matching/

    #include <iostream>
    using namespace std;

    bool isMatchRec(string t, string p, int n, int m) {

        // If pattern is empty, then text must also be
        // empty
        if (m == 0) {
            return n == 0;
        }

        // If text is empty, then pattern can have characters
        // followed by *s
        if (n == 0) {
            return (m >= 2 && p[m - 1] == '*') &&
                     isMatchRec(t, p, n, m - 2);
        }

        // If last characters of both string and pattern
        // match, or pattern has '.'
        if (t[n - 1] == p[m - 1] || p[m - 1] == '.') {
            return isMatchRec(t, p, n - 1, m - 1);
        }

        // Handle '*' in the pattern
        if (p[m - 1] == '*' && m > 1) {

            // Check if '*' can represent zero occurrences
            // of the preceding character
            bool zero = isMatchRec(t, p, n, m - 2);

            // Check if '*' can represent one or more occurrences
            // of the preceding character
            bool oneOrMore = (p[m - 2] == t[n - 1] || p[m - 2] == '.') &&
                                           isMatchRec(t, p, n - 1, m);

            return zero || oneOrMore;
        }

        // If no match
        return false;
    }

    // Wrapper function
    bool isMatch(string t, string p) {
        return isMatchRec(t, p, t.size(), p.size());
    }

    int main() {
        cout << boolalpha << isMatch("ab", ".*") << endl;                   //true
        cout << boolalpha << isMatch("ab", "*.") << endl;                   //false
        cout << boolalpha << isMatch("Aa", "..") << endl;                   //true
        cout << boolalpha << isMatch("Aa", ".*") << endl;                   //true
        cout << boolalpha << isMatch("harbour", "h**.ou*") << endl;         //false
        cout << boolalpha << isMatch("harbour", "h*r.ou*") << endl;         //false
        cout << boolalpha << isMatch("harbour", "h.r.ou.") << endl;         //true
        cout << boolalpha << isMatch("aab", "a.*") << endl;                 //true
        cout << boolalpha << isMatch("aab", "a*.*") << endl;                //true
        cout << boolalpha << isMatch("aa", "a") << endl;                    //false
        cout << boolalpha << isMatch("aa", "a.*") << endl;                  //true
        cout << boolalpha << isMatch("ab", "*") << endl;                    //false
        cout << boolalpha << isMatch("mississippi", "mis*is*p*.") << endl;  //false
        cout << boolalpha << isMatch("mississippi", "mis*is*ip.*") << endl; //true
        cout << boolalpha << isMatch("mississippi", "mississippi") << endl; //true
        return 0;
    }

*/
static function __IsMatch(t as character,p as character,n as numeric, m as numeric)

    local zero as logical:=.F.
    local oneOrMore as logical:=.F.

    // If pattern is empty, then text must also be
    // empty
    if (m == 0)
        return(n == 0) as logical
    endif

    // If text is empty, then pattern can have characters
    // followed by *s
    if (n == 0)
        return((m >= 2 .and. subStr(p,m-1,1) == '*') .and.  __IsMatch(t, p, n, m - 2)) as logical
    endif

    // If last characters of both string and pattern
    // match, or pattern has '.'
    if (subStr(t,n-1,1) == subStr(p,m-1,1) .or. subStr(p,m-1,1) == '.')
        return(__IsMatch(t, p, n - 1, m - 1)) as logical
    endif

    // Handle '*' in the pattern
    if (subStr(p,m-1,1) == '*' .and. m > 1)

        // Check if '*' can represent zero occurrences
        // of the preceding character
        zero = __IsMatch(t, p, n, m - 2)

        // Check if '*' can represent one or more occurrences
        // of the preceding character
        oneOrMore = (subStr(p,m-2,1) == subStr(t,n-1,1) .or. subStr(p,m - 2,1) == '.') .and. __IsMatch(t, p, n - 1, m)

        return(zero .or. oneOrMore) as logical

    endif

    // If no match
    return(.F.) as logical

static function hb_regexMatch(cString,cPattern)
   local pRegex as pointer:=hb_regexComp(cPattern)
   return(!Empty(hb_regex(pRegex,cString,.T./* Case sensitive */))) as logical
