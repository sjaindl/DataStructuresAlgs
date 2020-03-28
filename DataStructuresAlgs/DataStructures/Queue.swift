//
//  Queue.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Queue<T> {
    
    var items: [Node<T>?]
    var size: Int = 0
    var capacity: Int = 10
    var nextPos: Int = 0
    var frontPos: Int = 0
    
    init() {
        items = [Node<T>?](repeating: nil, count: capacity)
    }
    
    func enqueue(val: T) {
        if size == items.count {
            resizeArray(newSize: size * 2)
        }
        
        if nextPos == items.count {
            rebuildArray()
        }
        
        let node = Node<T>(val: val)
        items[nextPos] = node
        size += 1
        nextPos += 1
    }
    
    func dequeue() throws -> T {
        if size == 0 {
            throw NSError(domain: "No element in queue", code: 0, userInfo: nil)
        }
        
        if items.count < size / 4 {
            resizeArray(newSize: size / 4)
        }
        
        let item = items[frontPos]
        frontPos += 1
        size -= 1
        
        return item!.val
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    private func rebuildArray() {
        var newArr = [Node<T>?] (repeating: nil, count: items.count)
        for n in frontPos ... nextPos {
            newArr.append(items[n])
        }
        items = newArr
        nextPos -= frontPos
        frontPos = 0
    }
    
    private func resizeArray(newSize: Int) {
        var newArr = [Node<T>?] (repeating: nil, count: newSize)
        for n in frontPos ... nextPos {
            newArr.append(items[n])
        }
        items = newArr
        nextPos -= frontPos
        frontPos = 0
        size = newSize
    }
    
    func test() {
        debugPrint("Queue")
        
        let q = Queue<Int>()
        
        q.enqueue(val: 1)
        q.enqueue(val: 2)
        
        var v = try? q.dequeue()
        debugPrint(v as Any)
        
        v = try? q.dequeue()
        debugPrint(v as Any)
    }
}
