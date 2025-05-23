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
function Main()
    return(Regular_Expression_Matching())

static function Regular_Expression_Matching()

    local aInputs as array:=Array(0)

    local cHTML as character
    local cInput as character
    local cPattern as character

    local lOutPut as logical
    local lMatched as logical

    local nIdx as numeric

    aAdd(aInputs,{.T.,"ab",".*"})
    aAdd(aInputs,{.F.,"ab","*."})
    //s contains only lowercase English letters.
    aAdd(aInputs,{.F.,"Aa",".."})
    //s contains only lowercase English letters.
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

    return(nil)

// Wrapper function
static function IsMatch(cString as character,cPattern as character)
    return(IsMatchDP(cString,cPattern)) as logical

// Wrapper function
static function IsMatchDP(cString as character,cPattern as character,nMin as numeric,nMax as numeric)
    return(__IsMatch(cString as character,cPattern as character)) as logical

static function __IsMatch(cString as character,cPattern as character,nMin as numeric,nMax as numeric)

    local cTmpChar as character

    local cCurrentChar as character
    local cLastChar as character:=""

    local cCurrentToken as character
    local cLastToken as character

    local lMatch as logical,lMatch1 as logical:=.T. ,lMatch2 as logical:=.F.
    local lAcceptChar,lSameSize,lSameIndex as logical

    local nIdx,nStrSize,nPatSize,nStrIdx,nPatIdx,nTrimPatSize as numeric

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

        lMatch:=.T.
        lSameSize:=(nPatSize==nStrSize)

        nIdx:=1

        for nStrIdx=1 to nStrSize
            cCurrentChar:=subStr(cString,nStrIdx,1)
            lAcceptChar:=if(cLastChar=="",.T.,cCurrentChar==cLastChar)
            cLastToken:=if(nIdx>1,subStr(cPattern,nIdx-1,1),"")
            for nPatIdx:=nIdx to nPatSize
                lSameIndex:=(nPatIdx==nStrIdx)
                cCurrentToken:=subStr(cPattern,nPatIdx,1)
                if (!lAcceptChar)
                    lAcceptChar:=((cCurrentToken$cCurrentChar+".").and.(lSameSize).and.(lSameIndex))
                endif
                if (cCurrentToken=="*")
                    lMatch1:=(;
                                ((lMatch).or.(lMatch2));
                                .and.(;
                                        (((lSameSize).and.(lSameIndex).and.(lAcceptChar))).and.(cCurrentToken$cCurrentChar+"*");
                                        .or.;
                                        (((lSameSize).or.(lSameIndex)).and.(lAcceptChar).and.(cCurrentToken$cCurrentChar+"*"));
                                        .or.;
                                        ((lAcceptChar).and.(".*"$cPattern).and.(cCurrentToken$cCurrentChar+".*"));
                                        .or.;
                                        (cLastToken==".");
                                );
                    )
                else
                    lMatch2:=(;
                                ((lMatch).or.(lMatch1));
                                .and.;
                                (;
                                    (((lSameSize).and.(lSameIndex).and.(lAcceptChar)).and.((cCurrentToken$cCurrentChar+".")).or.("*."$cLastToken+cCurrentToken));
                                    .or.;
                                    (((lSameSize).or.(lSameIndex)).and.(lAcceptChar).and.(cCurrentToken$cCurrentChar+"."));
                                    .or.;
                                    ((lAcceptChar).and.(".*"$cPattern).and.(cCurrentToken$cCurrentChar+"."));
                                    .or.;
                                    ("*"$cLastToken+cCurrentToken).or.(cLastToken=="");
                                );
                    )
                endif
                if ((!lMatch1).and.(!lMatch2))
                    break
                else
                    exit
                endif
            next nPatSize
            cLastChar:=cCurrentChar
            nIdx++
            lMatch:=((lMatch1).and.(lMatch2))
        next nStrIdx

    end sequence

    return(lMatch) as logical

static function hb_regexMatch(cString,cPattern)
   local pRegex as pointer:=hb_regexComp(cPattern)
   return(!Empty(hb_Regex(pRegex,cString,.T./*Case sensitive*/))) as logical
