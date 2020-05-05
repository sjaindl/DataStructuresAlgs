//
//  MergeSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 28.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

class MergeSortTests: XCTestCase {
    
    func testMergeSort() {
        var array1 = [4, 3, 2, 1]
        MergeSort<Int>.mergeSort(array: &array1)
        XCTAssertEqual([1, 2, 3, 4], array1)
        
        var array2 = [1, 3, 5, 7, 12, 14, 17, 19, 20, 22]
        MergeSort<Int>.mergeSort(array: &array2)
        XCTAssertEqual([1, 3, 5, 7, 12, 14, 17, 19, 20, 22], array2)
        
        var array3 = [22, 20, 19, 17, 14, 12, 7, 5, 3, 1]
        MergeSort<Int>.mergeSort(array: &array3)
        XCTAssertEqual(
        [1, 3, 5, 7, 12, 14, 17, 19, 20, 22], array3)
    }
}
