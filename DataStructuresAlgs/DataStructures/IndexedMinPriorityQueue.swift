//
//  IndexedMinPriorityQueue.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 15.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class IndexedMinPriorityQueue<T: Comparable> {
    private var keys = [T?]()
    private var keyIndeces: [Int] //qp
    private var heapIndeces = [Int]() //pq
    private var maxElements: Int = 0
    
    public var size: Int = 0
    
    init(maxElements: Int) {
        keyIndeces = [Int] (repeating: -1, count: maxElements)
        heapIndeces = [Int] (repeating: Int.max, count: maxElements)
        keys = [T?] (repeating: nil, count: maxElements)
        self.maxElements = maxElements
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func contains(index: Int) -> Bool {
        return keyIndeces[index] != -1
    }
    
    
    func insert(index: Int, key: T) throws {
        if size >= maxElements {
            throw NSError(domain: "IndexedMinPriorityQueue: PQ is full", code: 0, userInfo: nil)
        }
        
        keys[index] = key
        keyIndeces[index] = size
        heapIndeces[size] = index
        
        swim(index: size)
        size += 1
    }
    
    func minIndex() throws -> Int {
        if size < 1 {
            throw NSError(domain: "IndexedMinPriorityQueue: no elements in PQ", code: 0, userInfo: nil)
        }
        
        return heapIndeces[0]
    }
    
    func minKey() throws -> T? {
        if size < 1 {
            throw NSError(domain: "IndexedMinPriorityQueue: no elements in PQ", code: 0, userInfo: nil)
        }
        
        return keys[heapIndeces[0]]
    }
    
    func extractMin() throws -> T? {
        let key = try minKey()
        let index = try minIndex()
        
        exchange(index1: 0, index2: size - 1)
        size -= 1
        sink(index: 0)
        
        keyIndeces[index] = -1
        keys[index] = nil
        heapIndeces[size] = Int.max
        
        return key
    }
    
    func delete(index: Int) throws {
        if !contains(index: index) {
            throw NSError(domain: "IndexedMinPriorityQueue: Element not in queue", code: 0, userInfo: nil)
        }
        
        let heapIndex = keyIndeces[index]
        exchange(index1: heapIndex, index2: size - 1)
        size -= 1
        swim(index: heapIndex)
        sink(index: heapIndex)
        
        keyIndeces[index] = -1
        keys[index] = nil
        heapIndeces[size] = Int.max
    }
    
    func keyOf(index: Int) -> T? {
        return keys[index]
    }
    
    func changeKey(index: Int, key: T) throws {
        if !contains(index: index) {
            throw NSError(domain: "IndexedMinPriorityQueue: Element not in queue", code: 0, userInfo: nil)
        }
        
        keys[index] = key
        sink(index: keyIndeces[index])
        swim(index: keyIndeces[index])
    }
    
    func decreaseKey(index: Int, key: T) throws {
        if !contains(index: index) {
            throw NSError(domain: "IndexedMinPriorityQueue: Element not in queue", code: 0, userInfo: nil)
        }
        
        if let currentKey = keys[index], currentKey < key {
            throw NSError(domain: "IndexedMinPriorityQueue: Called decreaseKey with increased or equal value", code: 0, userInfo: nil)
        }
        
        keys[index] = key
        swim(index: keyIndeces[index])
    }
    
    func increaseKey(index: Int, key: T) throws {
        if !contains(index: index) {
            throw NSError(domain: "IndexedMinPriorityQueue: Element not in queue", code: 0, userInfo: nil)
        }
        
        if let currentKey = keys[index], currentKey > key {
            throw NSError(domain: "IndexedMinPriorityQueue: Called increaseKey with decreased or equal value", code: 0, userInfo: nil)
        }
        
        keys[index] = key
        sink(index: keyIndeces[index])
    }
    
    private func greater(_ i: Int?, _ j: Int?) -> Bool {
        guard let i = i, let j = j, i >= 0, i < size, j >= 0, j < size,
            heapIndeces[i] < keys.count, heapIndeces[j] < keys.count,
            heapIndeces[i] >= 0, heapIndeces[j] >= 0,
            let key1 = keys[heapIndeces[i]], let key2 = keys[heapIndeces[j]] else {
            return false
        }
        
        return key1 > key2
    }
    
    private func swim(index: Int) {
        if greater((index - 1) / 2, index) {
            exchange(index1: index, index2: ((index - 1) / 2))
            swim(index: (index - 1) / 2)
        }
    }
    
    private func sink(index: Int) {
        let key1Index = 2 * index + 1
        let key2Index = 2 * index + 2
        
        if greater(index, key1Index) || greater(index, key2Index) {
            if greater(key1Index, key2Index) {
                exchange(index1: index, index2: key2Index)
                sink(index: key2Index)
            } else {
                exchange(index1: index, index2: key1Index)
                sink(index: key1Index)
            }
        } else if greater(index, key1Index) {
            exchange(index1: index, index2: key1Index)
            sink(index: key1Index)
        }
    }
    
    private func exchange(index1: Int, index2: Int) {
        let temp = heapIndeces[index1]
        heapIndeces[index1] = heapIndeces[index2]
        heapIndeces[index2] = temp
        
        keyIndeces[heapIndeces[index1]] = index1
        keyIndeces[heapIndeces[index2]] = index2
    }
    
    static func test() {
        debugPrint("IndexedMinPriorityQueue")
        
        let indexPq = IndexedMinPriorityQueue<Int>(maxElements: 10)
        
        try! indexPq.insert(index: 4, key: 8)
        try! indexPq.insert(index: 5, key: 10)
        try! indexPq.insert(index: 3, key: 6)
        try! indexPq.insert(index: 1, key: 2)
        try! indexPq.insert(index: 2, key: 4)
        
        try! indexPq.changeKey(index: 1, key: 10)
        try! indexPq.decreaseKey(index: 5, key: 2)
        
        try! debugPrint("\(indexPq.minKey()!)")
        try! debugPrint("\(indexPq.extractMin()!)")
        
        try! indexPq.increaseKey(index: 2, key: 7)
        
        try! debugPrint("\(indexPq.extractMin()!)")
        try! indexPq.delete(index: 4)
        try! debugPrint("\(indexPq.extractMin()!)")
        try! debugPrint("\(indexPq.extractMin()!)")
        debugPrint("\(indexPq.isEmpty())")
    }
}