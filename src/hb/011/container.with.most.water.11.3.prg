/*
    11. Container With Most Water

    You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i,0) and (i,height[i]).

    Find two lines that together with the x-axis form a container,such that the container contains the most water.

    Return the maximum amount of water a container can store.

    Notice that you may not slant the container.

    Example 1:

    Input: height = [1,8,6,2,5,4,8,3,7]
    Output: 49
    Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case,the max area of water (blue section) the container can contain is 49.

    Example 2:

    Input: height = [1,1]
    Output: 1

    Constraints:

    n == height.length
    2 <= n <= 10^5
    0 <= height[i] <= 10^4

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/
function Main()
return(Container_With_Most_Water())

function Container_With_Most_Water()

    local aInput as array
    local aInputs as array

    local cHTML as character

    local lMatched as logical

    local nInput as numeric
    local nOutPut as numeric

    aInputs:=Array(0)

    aAdd(aInputs,{49,{1,8,6,2,5,4,8,3,7}})
    aAdd(aInputs,{1,{1,1}})
    aAdd(aInputs,{4,{3,1,2}})
    aAdd(aInputs,{45,{15,70,12,21,10,2}})

    cHTML:="<table border='1' cellpadding='5' cellspacing='0' style='width:100%; height:auto;'>"
    cHTML+=    "<caption>"+ProcName()+"</caption>"
    cHTML+=    "<thead>"
    cHTML+=        "<tr style='background-color: #999; color: white; text-align: center;'>"
    cHTML+=            "<th>Input</th>"
    cHTML+=            "<th>OutPut</th>"
    cHTML+=            "<th>Expected</th>"
    cHTML+=            "<th>Matched</th>"
    cHTML+=        "</tr>"
    cHTML+=    "</thead>"
    cHTML+=    "<tbody>"
    for nInput:=1 to Len(aInputs)
        aInput:=aInputs[nInput][2]
        nOutPut:=MaxArea(aInput)
        lMatched:=(nOutPut==aInputs[nInput][1])
        cHTML+=        "<tr>"
        cHTML+=            "<td align='left' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInput)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(nOutPut)+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(aInputs[nInput][1])+"</td>"
        cHTML+=            "<td align='center' style='background-color:"+if(lMatched,"#22560D","#E4080A")+";'>"+hb_JSONEncode(lMatched)+"</td>"
        cHTML+=        "</tr>"
    next nIdx
    cHTML+=    "</tbody>"
    cHTML+="</table>"

    ? cHTML

    return(nil)

static function MaxArea(aHeight as array)

    local nLeft as numeric
    local nRight as numeric
    local nMaxArea as numeric
    local nCurrentArea as numeric

    //Ponteiro esquerdo (Harbour usa índice 1-based)
    nLeft:=1

    //Ponteiro direito
    nRight:=Len(aHeight)

    //Maior volume encontrado
    nMaxArea:=0

    aEval(;
            aHeight;
           ,{||;
                 if((nLeft<nRight),;
                     (;
                         nCurrentArea:=Min(aHeight[nLeft],aHeight[nRight])*(nRight-nLeft);// Calcula o volume atual
                        ,nMaxArea:=Max(nMaxArea,nCurrentArea);// Atualiza o maior volume
                        ,if((aHeight[nLeft]<aHeight[nRight]),nLeft++,nRight--);// Move o ponteiro da menor altura
                    );
                    ,nil;
                );
           };
           ,nLeft;
           ,nRight;
    )

    return(nMaxArea) as numeric
