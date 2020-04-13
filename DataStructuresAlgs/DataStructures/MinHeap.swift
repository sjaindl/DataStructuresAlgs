//
//  MinHeap.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 25.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class MinHeap<T: Comparable> {
    private var array = [T] ()
    
    func insert(val: T) {
        array.append(val)
        swim(key: array.count - 1)
    }
    
    func peekMin() throws -> T {
        if array.count < 1 {
            throw NSError(domain: "Heap: no elements in heap", code: 0, userInfo: nil)
        }
        
        return array[0]
    }
    
    func extractMin() throws -> T {
        let min = try peekMin()
        array[0] = array[array.count - 1]
        array.removeLast()
        sink(key: 0)
        
        return min
    }
    
    func update(_ item: T) {
        for (index, curItem) in array.enumerated() {
            if curItem == item {
                array[index] = item
                
                if item < curItem {
                    sink(key: index)
                } else {
                    swim(key: index)   
                }
                
                return
            }
        }
    }
    
    func isEmpty() -> Bool {
        return array.count == 0
    }
    
    private func swim(key: Int) {
        if array[key] < array[(key-1) / 2] {
            exchange(index1: key, index2: ((key - 1) / 2))
            swim(key: (key - 1) / 2)
        }
    }
    
    private func sink(key: Int) {
        if array.count - 1 >= 2 * key + 2 &&
            array[key] > max(array[2 * key + 1], array[2 * key + 2]) {
            if array[2 * key + 1] > array[2 * key + 2] {
                exchange(index1: key, index2: 2 * key + 2)
            } else {
                exchange(index1: key, index2: 2 * key + 1)
            }
        } else if array.count - 1 >= 2 * key + 1 &&
            array[key] > array[2 * key + 1] {
            exchange(index1: key, index2: 2 * key + 1)
        }
    }
    
    private func exchange(index1: Int, index2: Int) {
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
    
    func test() {
        debugPrint("Heap")
        
        let heap = MinHeap<Int>()
        
        heap.insert(val: 1)
        heap.insert(val: 5)
        heap.insert(val: 2)
        heap.insert(val: 10)
        heap.insert(val: -5)
        
        try! debugPrint(heap.peekMin())
        try! debugPrint(heap.extractMin())
        try! debugPrint(heap.extractMin())
        try! debugPrint(heap.extractMin())
        try! debugPrint(heap.extractMin())
        
        heap.insert(val: 11)
        heap.insert(val: 7)
        
        try! debugPrint(heap.extractMin())
        try! debugPrint(heap.extractMin())
        try! debugPrint(heap.extractMin())
        
    }
}
