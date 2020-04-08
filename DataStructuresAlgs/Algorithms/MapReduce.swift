//
//  MapReduce.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 08.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Document {
    let words: [String]
    
    init(words: [String]) {
        self.words = words
    }
}

class Result: Comparable {
    let key: String
    let value: Int
    
    init(key: String, value: Int) {
        self.key = key
        self.value = value
    }
    
    static func < (lhs: Result, rhs: Result) -> Bool {
        return lhs.key < rhs.key
    }
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.key == rhs.key
    }
}

class MapReduceWordCount {
    
    var partialResults: [Result] = []
    var finalResults: [Result] = []
    
    func map(document: Document) {
        for word in document.words {
            emit(partialResult: Result(key: word, value: 1))
        }
    }
    
    private func emit(partialResult: Result) {
        partialResults.append(partialResult)
    }
    
    private func shuffleAndSort() {
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
    
    static func testMapReduceMock() {
        let words = ["Test", "document", "for", "map", "reduce", "Lorem", "Ipsum", "Dolores", "map", "map", "reduce"]
        let document = Document(words: words)
        let mapReduce = MapReduceWordCount()
        
        mapReduce.map(document: document)
        mapReduce.shuffleAndSort()
        
        if mapReduce.partialResults.count > 0 {
            var currentKey = mapReduce.partialResults[0].key
            var currentResults: [Result] = []
            
            for result in mapReduce.partialResults {
                if result.key == currentKey {
                    currentResults.append(result)
                } else {
                    mapReduce.reduce(partialResults: currentResults)
                    currentKey = result.key
                    currentResults = []
                    currentResults.append(result)
                }
            }
        }
        
        debugPrint("Map Reduce (word count demo)")
        
        for result in mapReduce.finalResults {
            debugPrint("\(result.key): \(result.value)")
        }
    }
}
