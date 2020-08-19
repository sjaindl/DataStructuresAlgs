//
//  Permutations.swift
//  
//
//  Created by Stefan Jaindl on 19.08.20.
//

import Foundation

open class Permutations {
    public init() { }
    
    open func permutationsWithoutDuplicates(of string: String) -> [String] {
        if string.isEmpty {
            return [""]
        }
        
        var permutations: [String] = []
        for char in string {
            if permutations.isEmpty {
                permutations.append(String(char))
                continue
            }
            
            var newPermutations: [String] = []
            for lastLevelPermutation in permutations {
                for index in 0 ... lastLevelPermutation.count {
                    var newPermutation = lastLevelPermutation
                    newPermutation.insert(char, at: lastLevelPermutation.index(lastLevelPermutation.startIndex, offsetBy: index))
                    newPermutations.append(newPermutation)
                }
            }
            permutations = newPermutations
        }
        
        return permutations
    }
}
