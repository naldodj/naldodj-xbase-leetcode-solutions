/*

    5. Longest Palindromic Substring

    Given a string s, return the longest  palindromic substring in s

    Example 1:

    Input: s = "babad"
    Output: "bab"
    Explanation: "aba" is also a valid answer.
    Example 2:

    Input: s = "cbbd"
    Output: "bb"

    Constraints:

    1 <= s.length <= 1000
    s consist of only digits and English letters.

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/

REQUEST HB_CODEPAGE_UTF8EX

procedure Main()

   local cString as character
   local cLongestPalindrome1 as character
   local cLongestPalindrome2 as character

   hb_cdpSelect("UTF8EX")

   cString := "babad"
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "cbbd"
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A Aia cuidava das crianças com dedicação."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Quem tem aibofobia sente medo de palíndromos."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A ala esquerda do prédio foi reformada."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Ele ama viajar para lugares tranquilos."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A cor foi obtida com anilina natural."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A ata da reunião foi enviada a todos os participantes."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A arara azul é uma ave belíssima."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "O avião perdeu uma asa no acidente."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Ele sempre está disposto a ajudar."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Esse livro é um dos meus favoritos."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Os bebês mamam para se alimentar."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "As ondas fortes matam muitos animais marinhos."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Eles sempre metem o nariz onde não são chamados."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "O time mirim venceu o campeonato regional."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Um relatório omissíssimo em vários pontos importantes."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "Viajar para a cidade natal faz muitos reviverem memórias antigas."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   cString := "A discussão acalorada terminou em sopapos."
   cLongestPalindrome1 := hb_JSONEncode(LongestPalindromicSubstring(cString))
   ? "Input:", cString," => "
   ? "Brute Force Output:", cLongestPalindrome1,"</br></br>"

   return

static function LongestPalindromicSubstring(cString as character)

   local aPalindromicSubstring as array
   local aPalindromicSubstringReturn:=Array(0) as array
   local cStringTmp as character,cPalindromicSubstring as character

   local i as numeric

   cString:=NormalizeString(cString)

   aPalindromicSubstring:=hb_regexSplit(" ",cString)
   for i:=1 to Len(aPalindromicSubstring)
      cStringTmp:=aPalindromicSubstring[i]
      while (!empty(cPalindromicSubstring:=__LongestPalindromicSubstring(@cStringTmp)))
         if ((Len(cPalindromicSubstring)>1).and.(hb_AScan(aPalindromicSubstringReturn,{|s|hb_regexlike(cPalindromicSubstring,s)})==0))
           aAdd(aPalindromicSubstringReturn,cPalindromicSubstring)
         endif
      end while
   next i

return(aPalindromicSubstringReturn) as array

static function __LongestPalindromicSubstring(/*@*/cString)

   local nLen as numeric := Len(cString)
   local cResult as character := ""
   local cSubStr as character
   local i as numeric, j as numeric

   for i := 1 to nLen
      for j := i to nLen
         cSubStr := SubStr(cString, i, j - i + 1)
         if (IsPalindrome(cSubStr) .and. Len(cSubStr) > Len(cResult))
            cResult := cSubStr
         endif
      next j
   next i

   cString:=Stuff(cString,1,1,"")

   return(cResult) as character

static function IsPalindrome(cString as character)

   local lRet as logical :=.T.

   local nStart as numeric := 1
   local nEnd as numeric := Len(cString)

   begin sequence

      while (nStart < nEnd)
         if (Lower(SubStr(cString, nStart, 1)) != Lower(SubStr(cString, nEnd, 1)))
            lRet:=.F.
            break
         endif
         nStart++
         nEnd--
      end while

   end sequence

   return(lRet) as logical

/****************************************************************************************/

static function NormalizeString(cString as character)
   local cNormalized as character := cString
   local aNormalize as array :={;
      {"á","a"};
     ,{"à","a"};
     ,{"ã","a"};
     ,{"â","a"};
     ,{"ä","a"};
     ,{"é","e"};
     ,{"è","e"};
     ,{"ê","e"};
     ,{"ë","e"};
     ,{"í","i"};
     ,{"ì","i"};
     ,{"î","i"};
     ,{"ï","i"};
     ,{"ó","o"};
     ,{"ò","o"};
     ,{"õ","o"};
     ,{"ô","o"};
     ,{"ö","o"};
     ,{"ú","u"};
     ,{"ù","u"};
     ,{"û","u"};
     ,{"ü","u"};
     ,{"ç","c"};
   }
   aEval(aNormalize,{|aNormalizeItem|cNormalized:=hb_StrReplace( cNormalized, { aNormalizeItem[1] => aNormalizeItem[2] } ) } )
   return(cNormalized) as character
