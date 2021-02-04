//
//  MinElementsFinderTests.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MinElementsFinderTests: XCTestCase {
    
    open func testFindMinElementsSorted() throws {
        let finder = MinElementsFinder()
        
        XCTAssertEqual(try finder.findMinElementsSorted(numberOfElements: 4, array: [1, 2, 3, 4, 5, 6]), [1, 2, 3, 4])
        XCTAssertEqual(try finder.findMinElementsSorted(numberOfElements: 4, array: [6, 5, 4, 3, 2, 1]), [1, 2, 3, 4])
        XCTAssertEqual(try finder.findMinElementsSorted(numberOfElements: 2, array: [6, 5, 4, 3, 2, 2]), [2, 2])
    }
    
    open func testFindMinElements() {
        let finder = MinElementsFinder()
        
        XCTAssertEqual(finder.findMinElementsUnique(numberOfElements: 4, array: [3, 6, 1, 2, 5, 4]).sorted(), [1, 2, 3, 4])
        XCTAssertEqual(finder.findMinElementsUnique(numberOfElements: 4, array: [1, 2, 3, 4, 5, 6]).sorted(), [1, 2, 3, 4])
        XCTAssertEqual(finder.findMinElementsUnique(numberOfElements: 4, array: [6, 5, 4, 3, 2, 1]).sorted(), [1, 2, 3, 4])
        XCTAssertEqual(finder.findMinElementsUnique(numberOfElements: 2, array: [6, 5, 4, 3, 2, 2]), [2, 2])
    }
    
    //e.g. min 3 of array: [3, 6, 1, 2, 5, 3]) = [1, 2, 3] (any order)
    open func testFindMinElementsNonUnique() {
        let finder = MinElementsFinder()
        
        XCTAssertEqual(finder.findMinElementsNonUnique(numberOfElements: 1, array: [3, 6, 1, 2, 5, 3]).sorted(), [1])
        XCTAssertEqual(finder.findMinElementsNonUnique(numberOfElements: 2, array: [3, 6, 1, 2, 5, 3]).sorted(), [1, 2])
        XCTAssertEqual(finder.findMinElementsNonUnique(numberOfElements: 3, array: [3, 6, 1, 2, 5, 3]).sorted(), [1, 2, 3])
        XCTAssertEqual(finder.findMinElementsNonUnique(numberOfElements: 4, array: [3, 6, 1, 2, 5, 3]).sorted(), [1, 2, 3, 3])
        XCTAssertEqual(finder.findMinElementsNonUnique(numberOfElements: 6, array: [3, 6, 1, 2, 5, 3]).sorted(), [1, 2, 3, 3, 5, 6])
    }
}
