//
//  MapReduce.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 08.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class Document {
    let words: [String]
    
    init(words: [String]) {
        self.words = words
    }
}

open class Result: Comparable {
    let key: String
    let value: Int
    
    init(key: String, value: Int) {
        self.key = key
        self.value = value
    }
    
    public static func < (lhs: Result, rhs: Result) -> Bool {
        return lhs.key < rhs.key
    }
    
    public static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.key == rhs.key
    }
}

open class MapReduceWordCount {
    
    var partialResults: [Result] = []
    var finalResults: [Result] = []
    
    func map(document: Document) {
        for word in document.words {
            emit(partialResult: Result(key: word, value: 1))
        }
    }
    
    func emit(partialResult: Result) {
        partialResults.append(partialResult)
    }
    
    func shuffleAndSort() {
        partialResults.sort()
    }
    
    func reduce(partialResults: [Result]) {
        if partialResults.count > 0 {
            let key = partialResults[0].key
            var sum = 0
            
            for partialResult in partialResults {
                sum += partialResult.value
            }
            
            finalResults.append(Result(key: key, value: sum))
        }
    }
}
