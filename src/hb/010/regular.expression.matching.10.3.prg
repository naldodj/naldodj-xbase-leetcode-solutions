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

    local nInput as numeric

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
    for nInput:=1 to Len(aInputs)
        cInput:=aInputs[nInput][2]
        cPattern:=aInputs[nInput][3]
        lOutPut:=IsMatch(cInput,cPattern)
        lMatched:=(lOutPut==aInputs[nInput][1])
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cInput+"</td>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+cPattern+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nInput][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nInput
    cHTML+=    "</tbody>"
    cHTML+="</table>"

    ? cHTML

    return

// Wrapper function
static function IsMatch(cString as character,cPattern as character)
    return(IsMatchDP(cString,cPattern)) as logical

static function IsMatchDP(cStringtring as character,cPattern as character,nMin as numeric,nMax as numeric)

    local lMatch as logical
    local nStrSize as numeric
    local nPatSize as numeric

    hb_default(@nMin,1)
    hb_default(@nMax,20)

    begin sequence

        //1 <= s.length <= 20
        nStrSize:=Len(cStringtring)
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
        lMatch:=hb_RegexMatch(cStringtring,"^[a-z]+$")
        if (!lMatch)
            break
        endif

        //p contains only lowercase English letters, '.', and '*'.
        lMatch:=hb_RegexMatch(cStringtring,"^[a-z.*]+$")
        if (!lMatch)
            break
        endif

        if nPatSize<nStrSize
            cPattern:=PadR(cPattern,nStrSize)
            nStrSize:=nStrSize
        endif

        lMatch:=__IsMatch(cStringtring,cPattern)

    end sequence

    return(lMatch) as logical

/*
    Ref.: https://www.geeksforgeeks.org/implementing-regular-expression-matching/

    #include <iostream>
    #include <vector>
    using namespace std;

    bool isMatch(string t, string p) {
        int n = t.size();
        int m = p.size();

        // DP table where dp[i][j] means whether first i characters in t
        // match the first j characters in p
        vector<vector<bool>> dp(n + 1, vector<bool>(m + 1, false));

        // Empty pattern matches empty text
        dp[0][0] = true;

        // Deals with patterns like a*, a*b*, a*b*c* etc, where '*'
        // can eliminate preceding character
        for (int j = 1; j <= m; ++j) {
            if (p[j - 1] == '*' && j > 1) {
                dp[0][j] = dp[0][j - 2];
            }
        }

        // Fill the table
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {

                // Characters match
                if (p[j - 1] == '.' || t[i - 1] == p[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1];
                }

                else if (p[j - 1] == '*' && j > 1) {

                    // Two cases:
                    // 1. '*' represents zero occurrence of the preceding character
                    // 2. '*' represents one or more occurrence of the preceding character
                    dp[i][j] = dp[i][j - 2] ||
                               (dp[i - 1][j] && (p[j - 2] == t[i - 1] || p[j - 2] == '.'));
                }
            }
        }

        return dp[n][m];
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
static function __IsMatch(t as character,p as character)

    local dp as array

    local n as numeric:=(len(t)+1)
    local m as numeric:=(len(p)+1)

    local i,j

    // DP table where dp[i][j] means whether first i characters in t
    // match the first j characters in p
    dp:=Array(n)
    aFill(dp,Array(m))
    aEval(@dp,{|e|aFill(e,.F.)})

    // Empty pattern matches empty text
    dp[0+1][0+1] := .T.

    // Deals with patterns like a*, a*b*, a*b*c* etc, where '*'
    // can eliminate preceding character
    for j:=1+1 to m
        if (substr(p,j-1,1)=='*' .and. j > 1+1)
            dp[0+1][j] := dp[0+1][j-2]
        endif
    next j

    // Fill the table
    for i:=1+1 to n
        for j:=1+1 to m+1
            // Characters match
            if (subStr(p,j-1,1) == '.' .or. substr(t,i-1,1) == substr(p,j-1,1))
                dp[i][j]=dp[i-1][j-1]
            elseif (subStr(p,j-1,1)=='*'.and.j>1+1)
                // Two cases:
                // 1. '*' represents zero occurrence of the preceding character
                // 2. '*' represents one or more occurrence of the preceding character
                if (dp[i][j-2])
                    dp[i][j]:=(subStr(t,j-2,1)==subStr(t,j-1,1)).or.(substr(p,j-2,1)=='.')
                else
                    dp[i][j]:=(dp[i-1][j].and.(subStr(p,j-2)==subStr(t,i-1).or.substr(p,j-2,1)=='.'))
                endif
            endif
        next j
    next i

    return(dp[n][m]) as logical

static function hb_regexMatch(cStringtring,cPattern)
   local pRegex as pointer:=hb_regexComp(cPattern)
   return(!Empty(hb_regex(pRegex,cStringtring,.T./* Case sensitive */))) as logical
