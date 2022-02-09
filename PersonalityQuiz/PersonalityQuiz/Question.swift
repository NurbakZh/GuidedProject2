//
//  Question.swift
//  PersonalityQuiz
//
//  Created by mac on 09.02.2022.
//

import Foundation


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}
 
enum ResponseType {
    case single, multiple, ranged
}
  
struct Answer {
    var text: String
    var type: Khan
}

enum Khan: Character {
    case Kerey = "👳🏻‍♂️", Hak_Nazar = "🧔🏻‍♂️", Tauke = "👨🏻‍⚖️", Abylai = "👨🏻"
    var definition: String {
        switch self {
        case .Kerey:
            return "You are Kerey khan. You are great inventer, since you were the first khan of Qazaq kahanate. Every qazaq person thanks you"
        case .Hak_Nazar:
            return "You are Hak-Nazar khan. You are great traveller and always open to new horizons, since you increased the territory of khanate very much"
        case .Tauke:
            return "You are Tauke khan. You are great leader, since you were the last khan, that could handle all 3 Juzes together and rule them as one"
        case .Abylai:
            return "You are Abylai khan. You are a great warrior and diplomat. You fought with Dzungars and made a great political actions to establish great communication with Russia and China"
        }
    }
}


