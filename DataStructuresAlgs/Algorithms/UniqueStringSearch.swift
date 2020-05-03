//
//  UniqueStringSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class UniqueStringSearch {
    
    private let alphabetSize: Int
    
    init(alphabetSize: Int) {
        self.alphabetSize = alphabetSize
    }
    
    //V1: HashTable/Set
    func isUniqueStringWithHash(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        var charSet = Set<Character>()
        
        for char in Array(input) {
            if charSet.contains(char) {
                return false
            }
            
            charSet.insert(char)
        }
        
        return true
    }
    
    //V2: BitVector
    func isUniqueStringWithBitVector(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        let bitVector = BitVector(numberOfBits: alphabetSize)
        
        for char in Array(input) {
            guard let ascii = char.asciiValue else {
                continue
            }
            
            if bitVector.isBitSet(index: Int(ascii)) {
                return false
            }
            
            bitVector.setBit(index: Int(ascii))
        }
        
        return true
    }
    
    //V3: Without additional datastructures
    func isUniqueStringWithSorting(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        let sorted = input.sorted()
        var char: Character?
        
        for curChar in Array(sorted) {
            if let char = char, curChar == char {
                return false
            }
            char = curChar
        }
        
        return true
    }
    
    static func test() {
        debugPrint("Unique String - 1. HashTable/Set")
        debugPrint("Unique String - 2. BitVector")
        debugPrint("Unique String - 3. Sorting")
        
        let stringSearch = UniqueStringSearch(alphabetSize: 256) //Extended ASCII alphabet
        
        let testString1 = "test"
        debugPrint(stringSearch.isUniqueStringWithHash(input: testString1))
        debugPrint(stringSearch.isUniqueStringWithBitVector(input: testString1))
        debugPrint(stringSearch.isUniqueStringWithSorting(input: testString1))
        
        let testString2 = "string2"
        debugPrint(stringSearch.isUniqueStringWithHash(input: testString2))
        debugPrint(stringSearch.isUniqueStringWithBitVector(input: testString2))
        debugPrint(stringSearch.isUniqueStringWithSorting(input: testString2))
    }
}
