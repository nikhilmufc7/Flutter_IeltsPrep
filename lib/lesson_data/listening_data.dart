import 'package:ielts/models/listening.dart';

List getListeningData() {
  return [
    Listening(
        title: "Water Pollution",
        s1SubQuestions1Bool: true,
        level: "Band 6",
        indicatorValue: 0.3,
        firstSectionAudio: 'https://ielts-up.com/listening/5.1.mp3',
        firstQuestionImage: 'https://i.imgur.com/zOSHTsh.png',
        s1SubQuestions1: [
          'This is a question 1',
          'This is question 2',
        ],
        intialQuestionNumbers: 'Questions 1-5 _n Write appropriate answers',
        s1SubQuestions1Numbers: 'Questions 6-8',
        s1SubQuestions2Numbers: 'Questions 8-10',
        s1SubQuestions2: [
          'This is summary',
          'This is 2',
        ],
        s1SubQuestions2Bool: true,
        whatToDo:
            'This is a question skim the passage and answer questions that follow',
        answers: [
          "1. Clean",
          "2. Water crisis",
          "3. Green Infrast",
          "4. Health risk"
        ],

        // section 2
        //

        s2WhatToDo:
            'This is the second section of IELTS Listening test. Listen to the audio and complete all the questions. After you finish, press and move on to the next section.',
        section2Audio: 'https://ielts-up.com/listening/9.2.mp3',
        section2Image1: 'https://ielts-up.com/images/9.2.png',
        section2Image1Bool: true,
        s2SubQuestion1Numbers:
            'Label the map below _n Write correct letter A-E next to question 11-15',
        s2SubQuestions1: [
          '11. Science Museum ....',
          '12. Science Museum ....',
          '13. Science Museum ....',
          '14. Science Museum ....',
          '15. Science Museum ....',
        ],
        s2SubQuestions1Bool: false,
        section2Image2: 'https://i.imgur.com/78AdVcF.png',
        section2Image2Bool: true,
        s2SubQuestion2Numbers:
            'Question 16-20 _n _n What is the improvement of each main point of interest in the area? _n _n Choose FIVE answers from the box and write the correct letter, A-G, next to questions 16-20.',
        s2SubQuestions2: [
          "16. Car Park.....",
          "17. Primary School.....",
          "18. Science Museum .... ",
          "19. National History museum....",
          "20. Shopping Mall......"
        ],
        s2SubQuestions2Bool: true,
        section2Answers: [
          "section 2 answers",
          "1. Clean",
          "2. Water crisis",
          "3. Green Infrast",
          "4. Health risk"
        ],

        // section 3
        //
        s3WhatToDo:
            'Listen to the audio and answer the questions. After you finish and move on to the next section.',
        section3Audio: 'https://ielts-up.com/listening/14.3.mp3',
        section3Image1: 'https://i.imgur.com/78AdVcF.png',
        section3Image1Bool: true,
        section3Question1Numbers:
            'Question 21-25 _n _n What is the main opinion of each of the following people? _n _n Choose FIVE answers from the box and write the correct letter, A-G, next to questions 21-25.',
        section3Question1: [
          "21. Ken Simpson......",
          "22. Dave Kepler......",
          "23. Sharon Grey.....",
          "24. Maria Jackson.....",
          "25. Barbara Swallow......",
        ],
        section3Question1bool: true,
        section3Question2Numbers:
            'Question 26-28 _n _n Choose the correct letter, A, B or C. ',
        section3Image2: 'https://i.imgur.com/zOSHTsh.png',
        section3Image2bool: true,
        section3Question2: [
          'Jackson: 26. ......',
          'Roberts: 27. ....',
          'Morris: 28. .....',
        ],
        section3Questions2bool: true,
        section3Question3Numbers:
            'Question 29-30 _n _n Label The Chart below _n _n Choose answers from box',
        section3Image3: 'https://ielts-up.com/images/l73.png',
        section3Question3: [
          'Possible reasons',
          "A uncooperative landlord",
          "B environment",
          "C space",
          "D noisy neighbours",
          "E near city",
        ],
        section3Image3bool: true,
        section3Question3bool: true,
        section3Answers: ["21. A", "22. B", "23. C", "And so on...."],

        //section 4

        //
        s4WhatToDo:
            'This is the last section of IELTS Listening test. Listen to the audio and answer all the questions.',
        section4Audio: 'https://ielts-up.com/listening/5.4.mp3',
        section4Question1Numbers:
            'Questions 31-33 _n _n Choose correct Letter A, B or C',
        section4Question1: [
          "31. Initially, the Great Wall was built to _n _n A. prevent invaders from entering China  _n _n B. function as a psychological barrier _n _n C.  show country’s enduring strength ",
          "32. Initially, the Great Wall was built to _n _n A. prevent invaders from entering China  _n _n B. function as a psychological barrier _n _n C.  show country’s enduring strength ",
          "33. Initially, the Great Wall was built to _n _n A. prevent invaders from entering China  _n _n B. function as a psychological barrier _n _n C.  show country’s enduring strength ",
        ],
        section4Question1Bool: true,
        section4Question2Numbers:
            'Questions 34-37 _n _n Write one word for each answer',
        section4Question2: [
          "Species _n _n We can find Pan or Pan Troglodytes in West and Central Africa. _n The Bonobo or Pan Paniscus are found in Democratic Republic of Congo.",
          "Current research _n _n rule out 31. ......and biological factors. _n _n learn through 32. .......of other chimps' behaviour.",
          "Current research _n _n rule out 31. ......and biological factors. _n _n learn through 32. .......of other chimps' behaviour.",
          "Species _n _n We can find Pan or Pan Troglodytes in West and Central Africa. _n The Bonobo or Pan Paniscus are found in Democratic Republic of Congo.",
        ],
        section4Question2Bool: true,
        section4Question3Numbers:
            'Choose two letter A-E _n _n Which two topics will students discuss next week',
        section4Question3: [
          "  A They are slower than human in different ways.",
          " В They learn things by copying humans' behaviour.",
          " С They develop behaviours generation by genration.",
          " D They have very strong ability of logical thinking.",
          " E They could be modified to adapt to the environment.",
        ],
        section4Question3Bool: true,
        section4Answers: [
          "31. Genetic",
          "32. Observation",
          "33. Tools",
          "34. Open",
          "35. Genetic",
          "36. Observation",
          "37. Tools",
          "38. Open",
          "39. Genetic",
          "40. Observation",
        ]),
  ];
}
