//
//  BalancedTreeChecker.swift
//  
//
//  Created by Stefan Jaindl on 28.06.20.
//

import Foundation

open class NodeSuccessor<T: Comparable> {
    
    public init() { }
    
    //return successor node with in-order-traversal of binary search tree
    open func successor(root: TreeNode<T>) -> TreeNode<T>? {
        if let right = root.right {
            //Case 1: If right child exists, go right, and then until leave node found
            return traverseLeft(node: right)
        } else if root == root.parent?.left {
            //Case 2: If node is left child, parent node is successor
            return root.parent
        } else {
            //Case 3: Node is right child -> traverse up until node with value >= node value found
            return traverseParent(valueToMatch: root.value, node: root.parent)
        }
    }
    
    private func traverseLeft(node: TreeNode<T>) -> TreeNode<T>? {
        var current = node.left
        while let left = current?.left {
            current = left
        }
        
        return current
    }
    
    private func traverseParent(valueToMatch: T, node: TreeNode<T>?) -> TreeNode<T>? {
        var current = node
        if let currentValue = current?.value, currentValue >= valueToMatch {
            return current
        }
        
        while let parent = current?.parent {
            if parent.value >= valueToMatch {
                return parent
            }
            
            current = parent
        }
        
        return nil
    }
}
