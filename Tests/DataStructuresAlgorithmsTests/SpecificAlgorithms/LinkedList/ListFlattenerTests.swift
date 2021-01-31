//
//  ListFlattenerTests.swift
//  
//
//  Created by Stefan Jaindl on 26.01.21.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class ListFlattenerTests: XCTestCase {
    
    open func testFlatten() {
        /*
         Input:
         1 -> 2 -> 3
              -
              4 -> 5
                   -
                   6
         
         Output: 1 -> 2 -> 4 -> 5 -> 6 -> 3
         */
        let root = ChildNode<Int>(val: 1)
        let four = ChildNode<Int>(val: 4)
        let six = ChildNode<Int>(val: 6)
        let two = ChildNode<Int>(val: 2, next: nil, prev: root, child: four)
        let three = ChildNode<Int>(val: 3, next: nil, prev: two, child: nil)
        let five = ChildNode<Int>(val: 5, next: nil, prev: four, child: six)
        root.next = two
        two.next = three
        four.next = five
        
        let flattener = ListFlattener<Int>()
        var flattened = flattener.flatten(head: root)
        
        var result: [Int] = []
        while let curFlat = flattened {
            result.append(curFlat.val)
            flattened = flattened?.next
        }
        
        XCTAssertEqual(result, [1, 2, 4, 5, 6, 3])
    }
    
    open func testFlattenMultipleChilds() {
        /*
         Input:
         1 -> 2 -> 3
              -
              4 -> 5
                   -
                   6
                   -
                   7
         
         Output: 1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3
         */
        let root = ChildNode<Int>(val: 1)
        let four = ChildNode<Int>(val: 4)
        let seven = ChildNode<Int>(val: 7)
        let six = ChildNode<Int>(val: 6, child: seven)
        let two = ChildNode<Int>(val: 2, next: nil, prev: root, child: four)
        let three = ChildNode<Int>(val: 3, next: nil, prev: two, child: nil)
        let five = ChildNode<Int>(val: 5, next: nil, prev: four, child: six)
        root.next = two
        two.next = three
        four.next = five
        
        let flattener = ListFlattener<Int>()
        var flattened = flattener.flatten(head: root)
        
        var result: [Int] = []
        while let curFlat = flattened {
            result.append(curFlat.val)
            flattened = flattened?.next
        }
        
        XCTAssertEqual(result, [1, 2, 4, 5, 6, 7, 3])
    }
    
    open func testFlattenAlreadyFlat() {
        /*
         Input: 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
         Output: 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
         */
        let root = ChildNode<Int>(val: 1)
        let two = ChildNode<Int>(val: 2, next: nil, prev: root, child: nil)
        let three = ChildNode<Int>(val: 3, next: nil, prev: two, child: nil)
        let four = ChildNode<Int>(val: 4, next: nil, prev: three, child: nil)
        let five = ChildNode<Int>(val: 5, next: nil, prev: four, child: nil)
        let six = ChildNode<Int>(val: 6, next: nil, prev: five, child: nil)
        let seven = ChildNode<Int>(val: 7, next: nil, prev: six, child: nil)
        
        root.next = two
        two.next = three
        three.next = four
        four.next = five
        five.next = six
        six.next = seven
        
        let flattener = ListFlattener<Int>()
        var flattened = flattener.flatten(head: root)
        
        var result: [Int] = []
        while let curFlat = flattened {
            result.append(curFlat.val)
            flattened = flattened?.next
        }
        
        XCTAssertEqual(result, [1, 2, 3, 4, 5, 6, 7])
    }
}
