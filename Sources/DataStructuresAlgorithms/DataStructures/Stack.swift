//
//  Stack.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class Stack<T> {
    var head: Node<T>?
    var size: Int = 0
    
    func push(val: T) {
        let newHead = Node(val: val, next: head)
        head = newHead
        size += 1
    }
    
    func pop() throws -> T {
        guard let node = head else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        head = node.next
        size -= 1
        return node.val
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }   
}
