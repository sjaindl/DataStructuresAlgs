//
//  HashTable.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 26.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class HashTable {
    var table: [LinkedList<String>] = []
    
    init(size: Int) {
        table = [LinkedList<String>] (repeating: LinkedList(), count: size)
        for i in 0 ... size - 1 {
            table[i] = LinkedList<String>()
        }
    }
    
    func hash(val: String) -> Int {
        var hash: Int = 0
        var index: Int = 0
        
        for char in Array(val) {
            index += 1
            hash += Int(char.asciiValue!) * index
        }
        
        hash %= table.count
        
        return Int(hash)
    }
    
    func insert(val: String) {
        let h = hash(val: val)
        table[h].add(node: Node(val: val))
    }
    
    func contains(val: String) -> Bool {
        let h = hash(val: val)
        let list = table[h]
        
        var curNode = list.head
        while curNode != nil {
            if curNode?.val == val {
                return true
            }
            curNode = curNode?.next
        }
        return false
    }
}
