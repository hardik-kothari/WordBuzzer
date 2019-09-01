//
//  GameServices.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

class GameServices: NSObject {
    
    static let shared = GameServices()
    
    var allTranslations: [Translation] = []
    
    private override init() {
        super.init()
        readWordsFromJson()
    }
    
    private func readWordsFromJson() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                guard let json = jsonResult as? [Json] else {
                    return
                }
                allTranslations = json.map({
                    return Translation(json: $0)
                })
            } catch {}
        }
    }
}
