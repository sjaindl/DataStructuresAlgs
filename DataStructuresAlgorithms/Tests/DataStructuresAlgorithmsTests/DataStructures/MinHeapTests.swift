//
//  MinHeap.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 25.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

class MinHeapTests: XCTestCase {
    
    func testMinHeap() throws {
        let heap = MinHeap<Int>()
        
        heap.insert(val: 1)
        heap.insert(val: 5)
        heap.insert(val: 2)
        heap.insert(val: 10)
        heap.insert(val: -5)
        
        XCTAssertEqual(try heap.peekMin(), -5)
        XCTAssertEqual(try heap.extractMin(), -5)
        XCTAssertEqual(try heap.extractMin(), 1)
        XCTAssertEqual(try heap.extractMin(), 2)
        XCTAssertEqual(try heap.extractMin(), 5)
        
        heap.insert(val: 11)
        heap.insert(val: 7)
        
        XCTAssertEqual(try heap.extractMin(), 7)
        XCTAssertEqual(try heap.extractMin(), 10)
        XCTAssertEqual(try heap.extractMin(), 11)
    }
}
