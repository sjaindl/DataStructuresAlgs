//
//  ListFlattener.swift
//  
//
//  Created by Stefan Jaindl on 26.01.21.
//

import Foundation

open class ListFlattener<T: Hashable & Comparable> {
    public init() { }
    
    open func flatten(head: ChildNode<T>?) -> ChildNode<T>? {
        guard let head = head else {
            return nil
        }
        
        let flattened = flattenRecursive(head: head)
        return flattened.head
    }
    
    private func flattenRecursive(head: ChildNode<T>) -> FlattenResult {
        var curHead = head
        guard curHead.child != nil || curHead.next != nil else {
            return FlattenResult(head: curHead, tail: curHead)
        }
        
        let tempNext = curHead.next
        if let child = curHead.child {
            let childResult = flattenRecursive(head: child)
            curHead.next = childResult.head
            curHead.child = nil
            childResult.tail.next = tempNext
            tempNext?.prev = childResult.tail
            curHead = childResult.tail
        }
        
        if let next = curHead.next {
            let flattened = flattenRecursive(head: next)
            return FlattenResult(head: curHead, tail: flattened.tail)
        }
        
        return FlattenResult(head: head, tail: curHead)
    }
    
    struct FlattenResult {
        let head: ChildNode<T>
        let tail: ChildNode<T>
    }
}

open class ChildNode<T: Hashable & Comparable>: Hashable {
    var val: T
    var prev: ChildNode?
    var next: ChildNode?
    var child: ChildNode?
    
    init(val: T, next: ChildNode? = nil, prev: ChildNode? = nil, child: ChildNode? = nil) {
        self.val = val
        self.next = next
        self.prev = prev
        self.child = child
    }
    
    public static func == (lhs: ChildNode<T>, rhs: ChildNode<T>) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next && lhs.prev == rhs.prev && lhs.child == rhs.child
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next)
        hasher.combine(prev)
        hasher.combine(child)
    }
}
