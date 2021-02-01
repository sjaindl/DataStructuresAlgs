//
//  MinTree.swift
//  
//
//  Created by Stefan Jaindl on 23.06.20.
//

import Foundation

open class MinTree<T: Comparable> {
    
    //Given: Ascendingly sorted array without duplicates
    //Return: Root of build binary search tree
    open func minTree(array: [T]) throws -> SimpleTreeNode<T>? {
        guard !array.isEmpty else {
            throw NSError(domain: "MinTree: Empty input", code: 0, userInfo: nil)
        }
        
        return insert(array: array, minIndex: 0, maxIndex: array.count - 1)
    }
    
    private func insert(array: [T], minIndex: Int, maxIndex: Int) -> SimpleTreeNode<T>? {
        guard minIndex <= maxIndex else {
            return nil
        }
        
        let middleIndex = minIndex + (maxIndex - minIndex) / 2
        let node = SimpleTreeNode(value: array[middleIndex])
        
        node.left = insert(array: array, minIndex: minIndex, maxIndex: middleIndex - 1)
        node.right = insert(array: array, minIndex: middleIndex + 1, maxIndex: maxIndex)
        
        return node
    }
}
