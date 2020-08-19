//
//  PermutationsTests.swift
//  
//
//  Created by Stefan Jaindl on 19.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PermutationsTests: XCTestCase {
    
    open func testPermutationsWithoutDuplicates() {
        let permutationBuilder = Permutations()
        let permutations = permutationBuilder.permutationsWithoutDuplicates(of: "abc")
        
        XCTAssertEqual(permutations, ["cba", "bca", "bac", "cab", "acb", "abc"])
    }
}
