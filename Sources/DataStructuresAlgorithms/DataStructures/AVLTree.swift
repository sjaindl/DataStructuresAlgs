//
//  AVLTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 05.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class AVLTreeNode<T: Comparable> {
    
    var left: AVLTreeNode?
    var right: AVLTreeNode?
    var parent: AVLTreeNode?
    var value: T
    var height: Int
    
    init(parent: AVLTreeNode?, value: T, height: Int) {
        self.parent = parent
        self.value = value
        self.height = height
    }
    
    func isRoot() -> Bool {
        return parent == nil
    }
    
    func other() -> AVLTreeNode? {
        if let left = parent?.left, left.value == value {
            return parent?.right
        }
        
        return parent?.left
    }
}

open class AVLTree<T: Comparable> {
    var root: AVLTreeNode<T>?
    
    func insert(val: T) {
        if root == nil {
            root = AVLTreeNode(parent: nil, value: val, height: 1)
            return
        }
        
        var current = root
        while current != nil, let cur = current {
            if cur.value > val {
                if cur.left == nil {
                    cur.left = AVLTreeNode(parent: cur, value: val, height: 1)
                    increaseHeight(cur)
                    return
                } else {
                    current = cur.left
                }
            } else {
                if cur.right == nil {
                    cur.right = AVLTreeNode(parent: cur, value: val, height: 1)
                    increaseHeight(cur)
                    return
                } else {
                    current = cur.right
                }
            }
        }
    }
    
    func increaseHeight(_ node: AVLTreeNode<T>) {
        if node.left != nil, node.right != nil {
            return //must be balanced
        }
        
        var current: AVLTreeNode? = node
        while current != nil, let cur = current {
            let leftHeight = cur.left?.height ?? 0
            let rightHeight = cur.right?.height ?? 0
            
            cur.height = max(leftHeight, rightHeight) + 1
            
            let heightDiff = leftHeight - rightHeight
            
            if heightDiff == 0 {
                return
            } else if heightDiff == -2 {
                let rightLeftHeight = cur.right?.left?.height ?? 0
                let rightRightHeight = cur.right?.right?.height ?? 0
                
                if rightLeftHeight > rightRightHeight {
                    //right left shape -> left + right rotation
                    let nodeToRotate = cur.right?.left
                    rightRotate(n: nodeToRotate)
                    leftRotate(n: nodeToRotate)
                } else {
                    //right right shape -> right rotation
                    leftRotate(n: cur.right)
                }
                current = cur.parent
            } else if heightDiff == 2 {
                let leftLeftHeight = cur.left?.left?.height ?? 0
                let leftRightHeight = cur.left?.right?.height ?? 0
                
                if leftRightHeight > leftLeftHeight {
                    //left right shape -> left + right rotation
                    let nodeToRotate = cur.left?.right
                    leftRotate(n: nodeToRotate)
                    rightRotate(n: nodeToRotate)
                } else {
                    //left left shape -> right rotation
                    rightRotate(n: cur.left)
                }
                current = cur.parent
            } else {
                current = cur.parent
            }
        }
    }
    
    func description() -> Stack<String> {
        var stack = Stack<String>()
        description(node: root, stack: &stack)
        
        return stack
    }
    
    func description(node: AVLTreeNode<T>?, stack: inout Stack<String>) {
        if let node = node {
            stack.push(val: "\(node.value): \(node.height)")
            description(node: node.left, stack: &stack)
            description(node: node.right, stack: &stack)
        }
    }
    
    private func rightRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.value == gp?.left?.value
        
        p?.left = n?.right
        p?.left?.parent = p
        
        n?.right = p;
        p?.parent = n // p? = n?.right
        
        n?.parent = gp
        if gpLeft {
            gp?.left = n
        } else {
            gp?.right = n
        }
        
        if gp == nil {
            root = n
        }
        
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
    
    private func leftRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.value == gp?.left?.value
        
        p?.right = n?.left
        p?.right?.parent = p
        
        n?.left = p
        p?.parent = n
        
        n?.parent = gp
        if gpLeft {
            gp?.left = n
        } else {
            gp?.right = n
        }
        
        if gp == nil {
            root = n
        }
        
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
}
