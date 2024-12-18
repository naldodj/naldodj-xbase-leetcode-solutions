# [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/description/)

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

`longest_palindromic_substring.5.1.prg`
![image](https://github.com/user-attachments/assets/a4c0ce56-83ae-48ec-8e37-328e27194c7e)

    ```
    +--------------------------------------------------------------------+-----------------------------------------------------------------------+
    | Input                                                              | Brute Force Output                                                    |
    +--------------------------------------------------------------------+-----------------------------------------------------------------------+
    | babad                                                              | ["bab", "aba"]                                                        |
    | cbbd                                                               | ["bb"]                                                                |
    | A Aia cuidava das crianças com dedicação.                          | ["Aia", "ava", "ded", "cac", "aca"]                                   |
    | Quem tem aibofobia sente medo de palíndromos.                      | ["aibofobia", "ibofobi", "bofob", "ofo", "omo"]                       |
    | A ala esquerda do prédio foi reformada.                            | ["ala", "ada"]                                                        |
    | Ele ama viajar para lugares tranquilos.                            | ["Ele", "ama", "aja", "ara"]                                          |
    | A cor foi obtida com anilina natural.                              | ["anilina", "nilin", "ili"]                                           |
    | A ata da reunião foi enviada a todos os participantes.             | ["ata", "ada", "odo", "ici"]                                          |
    | A arara azul é uma ave belíssima.                                  | ["arara", "rar", "ara", "issi", "ss"]                                 |
    | O avião perdeu uma asa no acidente.                                | ["asa"]                                                               |
    | Ele sempre está disposto a ajudar.                                 | ["Ele"]                                                               |
    | Esse livro é um dos meus favoritos.                                | ["Esse", "ss"]                                                        |
    | Os bebês mamam para se alimentar.                                  | ["beb", "ebe", "mamam", "ama", "mam", "ara"]                          |
    | As ondas fortes matam muitos animais marinhos.                     | ["matam", "ata"]                                                      |
    | Eles sempre metem o nariz onde não são chamados.                   | ["Ele", "metem", "ete", "ama"]                                        |
    | O time mirim venceu o campeonato regional.                         | ["mirim", "iri"]                                                      |
    | Um relatório omissíssimo em vários pontos importantes.             | ["omississimo", "mississim", "ississi", "ssiss", "issi", "ss"]        |
    | Viajar para a cidade natal faz muitos reviverem memórias antigas.  | ["aja", "ara", "dad", "ata", "reviver", "evive", "viv", "ere", "mem"] |
    | A discussão acalorada terminou em sopapos.                         | ["ss", "aca", "ada", "sopapos", "opapo", "pap"]                       |
    +--------------------------------------------------------------------+-----------------------------------------------------------------------+
    ```

`longest_palindromic_substring.5.2.prg`
![image](https://github.com/user-attachments/assets/96e4a9da-9298-4dd8-b8f7-e5cf64ac733b)

    ```
    +-------------------------------------------------------------------+-----------------------------------------------------------------------+-----------------------------------------------------------------------+
    |Input                                                              | Brute Force Output                                                    | Manacher Output                                                       |
    +-------------------------------------------------------------------+-----------------------------------------------------------------------+-----------------------------------------------------------------------+
    | babad                                                             | ["bab", "aba"]                                                        | ["bab", "aba"]                                                        |
    | cbbd                                                              | ["bb"]                                                                | ["bb"]                                                                |
    | A Aia cuidava das crianças com dedicação.                         | ["Aia", "ava", "ded", "cac", "aca"]                                   | ["Aia", "ava", "ded", "cac", "aca"]                                   |
    | Quem tem aibofobia sente medo de palíndromos.                     | ["aibofobia", "ibofobi", "bofob", "ofo", "omo"]                       | ["aibofobia", "ibofobi", "bofob", "ofo", "omo"]                       |
    | A ala esquerda do prédio foi reformada.                           | ["ala", "ada"]                                                        | ["ala", "ada"]                                                        |
    | Ele ama viajar para lugares tranquilos.                           | ["Ele", "ama", "aja", "ara"]                                          | ["Ele", "ama", "aja", "ara"]                                          |
    | A cor foi obtida com anilina natural.                             | ["anilina", "nilin", "ili"]                                           | ["anilina", "nilin", "ili"]                                           |
    | A ata da reunião foi enviada a todos os participantes.            | ["ata", "ada", "odo", "ici"]                                          | ["ata", "ada", "odo", "ici"]                                          |
    | A arara azul é uma ave belíssima.                                 | ["arara", "rar", "ara", "issi", "ss"]                                 | ["arara", "rar", "ara", "issi", "ss"]                                 |
    | O avião perdeu uma asa no acidente.                               | ["asa"]                                                               | ["asa"]                                                               |
    | Ele sempre está disposto a ajudar.                                | ["Ele"]                                                               | ["Ele"]                                                               |
    | Esse livro é um dos meus favoritos.                               | ["Esse", "ss"]                                                        | ["Esse", "ss"]                                                        |
    | Os bebês mamam para se alimentar.                                 | ["beb", "ebe", "mamam", "ama", "mam", "ara"]                          | ["beb", "ebe", "mamam", "ama", "mam", "ara"]                          |
    | As ondas fortes matam muitos animais marinhos.                    | ["matam", "ata"]                                                      | ["matam", "ata"]                                                      |
    | Eles sempre metem o nariz onde não são chamados.                  | ["Ele", "metem", "ete", "ama"]                                        | ["Ele", "metem", "ete", "ama"]                                        |
    | O time mirim venceu o campeonato regional.                        | ["mirim", "iri"]                                                      | ["mirim", "iri"]                                                      |
    | Um relatório omissíssimo em vários pontos importantes.            | ["omississimo", "mississim", "ississi", "ssiss", "issi", "ss"]        | ["omississimo", "mississim", "ississi", "ssiss", "issi", "sss", "ss"] |
    | Viajar para a cidade natal faz muitos reviverem memórias antigas. | ["aja", "ara", "dad", "ata", "reviver", "evive", "viv", "ere", "mem"] | ["aja", "ara", "dad", "ata", "reviver", "evive", "viv", "ere", "mem"] |
    | A discussão acalorada terminou em sopapos.                        | ["ss", "aca", "ada", "sopapos", "opapo", "pap"]                       | ["ss", "aca", "ada", "sopapos", "opapo", "pap"]                       |
    +-------------------------------------------------------------------+-----------------------------------------------------------------------+-----------------------------------------------------------------------+
    ```