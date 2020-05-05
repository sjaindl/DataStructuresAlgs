//
//  QuickSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 29.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

class QuickSortTests: XCTestCase {
    
    func testQuickSort() {
        var array1 = [2, 6, 5, 3, 8, 7, 1, 0]
        QuickSort<Int>.quickSort(array: &array1)
        XCTAssertEqual(array1, [0, 1, 2, 3, 5, 6, 7, 8])
        
        var array2 = [0, 1, 2, 4, 5]
        QuickSort<Int>.quickSort(array: &array2)
        XCTAssertEqual(array2, [0, 1, 2, 4, 5])
        
        var array3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        QuickSort<Int>.quickSort(array: &array3)
        XCTAssertEqual(array3, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        var array4: [Int] = []
        QuickSort<Int>.quickSort(array: &array4)
        XCTAssertEqual(array4, [])
    }
}
