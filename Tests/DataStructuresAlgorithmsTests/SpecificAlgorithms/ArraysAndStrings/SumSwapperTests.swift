//
//  SumSwapperTests.swift
//  
//
//  Created by Stefan Jaindl on 30.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class SumSwapperTests: XCTestCase {
    
    open func testSumSwapper() {
        let swapper = SumSwapper()
        
        let first = [4, 1, 2, 1, 1, 2] //sum: 11
        let second = [3, 6, 3, 3] //sum 15
        XCTAssertEqual(swapper.swap(first: first, second: second), Swappable(first: 1, second: 3))
    }
}
