Red[]

random/seed now

words-as-data: load %words.txt
words-as-string: read %words.txt
person: ["je" "tu" "il/elle" "nous" "vous" "ils/elles"]
random_new_verb: func[] [random length? words-as-data]
random_new_pers: func[] [random length? person]
cur_verb: to-integer random_new_verb
cur_person: to-integer random_new_pers

view layout [ 
    title "Verbs-fr"
    on-close [write %words.txt a/text]
    tp: tab-panel mint 460x260 [
        "Learn" [
            text "Infinitif:" font-size 30
            question: text 440x100 font-color coffee font-size 30 bold data (words-as-data/(cur_verb)/1) no-border
            return
            pers: text 130x100 font-size 30 data (copy person/(cur_person)) 
            answer: field 300x60 font-size 30 no-border [
            either equal? words-as-data/(cur_verb)/((cur_person) + 1) answer/text[
                cur_person: to-integer random_new_pers
                cur_verb: to-integer random_new_verb
                question/text: copy words-as-data/(cur_verb)/1
                pers/text: copy person/(cur_person)
                answer/text: copy ""
                answer/color: none
                ][
                answer/data: words-as-data/(cur_verb)/((cur_person) + 1)
                answer/color: red
                ]
            ]
        ]
        "Word list" [
            a: area 440x215 words-as-string on-change ['done]
            ]
        ] on-change [if event/face = tp [
            write %words.txt a/text
            ]
        ]
    ]
