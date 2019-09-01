//
//  Translation.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

struct Translation: Equatable {
    enum Keys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
    
    let english: String
    let spanish: String
    
    init(json: Json) {
        english = json[Keys.english] ?? ""
        spanish = json[Keys.spanish] ?? ""
    }
    
    static func == (lhs: Translation, rhs: Translation) -> Bool {
        return lhs.english == rhs.english && lhs.spanish == rhs.spanish
    }
}
