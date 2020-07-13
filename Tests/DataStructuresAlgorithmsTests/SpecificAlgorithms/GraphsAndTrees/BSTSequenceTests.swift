//
//  BSTSequenceTests.swift
//  
//
//  Created by Stefan Jaindl on 06.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class BSTSequenceTests: XCTestCase {
    
    open func testBSTSequence() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 10)
        root.left = SimpleTreeNode<Int>(value: 8)
        root.left?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.right = SimpleTreeNode<Int>(value: 9)
        
        root.right = SimpleTreeNode<Int>(value: 12)
        root.right?.right = SimpleTreeNode<Int>(value: 14)
        root.right?.left = SimpleTreeNode<Int>(value: 11)
        
        let sequencer = BSTSequence<Int>()
        let possibleSequences = sequencer.BSTSequences(root: root)
        
        var values: [[Int]] = []
        possibleSequences.forEach { sequence in
            let singleValue = sequence.map { $0.value }
            values.append(singleValue)
        }
        
        XCTAssertEqual(values, [[10, 8, 4, 9, 12, 11, 14], [10, 8, 4, 12, 9, 11, 14], [10, 8, 4, 12, 11, 9, 14], [10, 8, 4, 12, 11, 14, 9], [10, 8, 12, 4, 9, 11, 14], [10, 8, 12, 4, 11, 9, 14], [10, 8, 12, 4, 11, 14, 9], [10, 8, 12, 11, 4, 9, 14], [10, 8, 12, 11, 4, 14, 9], [10, 8, 12, 11, 14, 4, 9], [10, 12, 8, 4, 9, 11, 14], [10, 12, 8, 4, 11, 9, 14], [10, 12, 8, 4, 11, 14, 9], [10, 12, 8, 11, 4, 9, 14], [10, 12, 8, 11, 4, 14, 9], [10, 12, 8, 11, 14, 4, 9], [10, 12, 11, 8, 4, 9, 14], [10, 12, 11, 8, 4, 14, 9], [10, 12, 11, 8, 14, 4, 9], [10, 12, 11, 14, 8, 4, 9], [10, 8, 4, 9, 12, 14, 11], [10, 8, 4, 12, 9, 14, 11], [10, 8, 4, 12, 14, 9, 11], [10, 8, 4, 12, 14, 11, 9], [10, 8, 12, 4, 9, 14, 11], [10, 8, 12, 4, 14, 9, 11], [10, 8, 12, 4, 14, 11, 9], [10, 8, 12, 14, 4, 9, 11], [10, 8, 12, 14, 4, 11, 9], [10, 8, 12, 14, 11, 4, 9], [10, 12, 8, 4, 9, 14, 11], [10, 12, 8, 4, 14, 9, 11], [10, 12, 8, 4, 14, 11, 9], [10, 12, 8, 14, 4, 9, 11], [10, 12, 8, 14, 4, 11, 9], [10, 12, 8, 14, 11, 4, 9], [10, 12, 14, 8, 4, 9, 11], [10, 12, 14, 8, 4, 11, 9], [10, 12, 14, 8, 11, 4, 9], [10, 12, 14, 11, 8, 4, 9], [10, 8, 9, 4, 12, 11, 14], [10, 8, 9, 12, 4, 11, 14], [10, 8, 9, 12, 11, 4, 14], [10, 8, 9, 12, 11, 14, 4], [10, 8, 12, 9, 4, 11, 14], [10, 8, 12, 9, 11, 4, 14], [10, 8, 12, 9, 11, 14, 4], [10, 8, 12, 11, 9, 4, 14], [10, 8, 12, 11, 9, 14, 4], [10, 8, 12, 11, 14, 9, 4], [10, 12, 8, 9, 4, 11, 14], [10, 12, 8, 9, 11, 4, 14], [10, 12, 8, 9, 11, 14, 4], [10, 12, 8, 11, 9, 4, 14], [10, 12, 8, 11, 9, 14, 4], [10, 12, 8, 11, 14, 9, 4], [10, 12, 11, 8, 9, 4, 14], [10, 12, 11, 8, 9, 14, 4], [10, 12, 11, 8, 14, 9, 4], [10, 12, 11, 14, 8, 9, 4], [10, 8, 9, 4, 12, 14, 11], [10, 8, 9, 12, 4, 14, 11], [10, 8, 9, 12, 14, 4, 11], [10, 8, 9, 12, 14, 11, 4], [10, 8, 12, 9, 4, 14, 11], [10, 8, 12, 9, 14, 4, 11], [10, 8, 12, 9, 14, 11, 4], [10, 8, 12, 14, 9, 4, 11], [10, 8, 12, 14, 9, 11, 4], [10, 8, 12, 14, 11, 9, 4], [10, 12, 8, 9, 4, 14, 11], [10, 12, 8, 9, 14, 4, 11], [10, 12, 8, 9, 14, 11, 4], [10, 12, 8, 14, 9, 4, 11], [10, 12, 8, 14, 9, 11, 4], [10, 12, 8, 14, 11, 9, 4], [10, 12, 14, 8, 9, 4, 11], [10, 12, 14, 8, 9, 11, 4], [10, 12, 14, 8, 11, 9, 4], [10, 12, 14, 11, 8, 9, 4]])
    }
}