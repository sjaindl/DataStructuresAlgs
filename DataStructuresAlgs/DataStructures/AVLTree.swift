//
//  AVLTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 05.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class AVLTreeNode<T: Comparable> {
    
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

class AVLTree<T: Comparable> {
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
            cur.height += 1
            
            //let other = cur.other()
            
            let heightDiff = (cur.left?.height ?? 0) - (cur.right?.height ?? 0)    //cur.height - (other?.height ?? 1)
            if heightDiff == 0 {
                return
            } else if heightDiff == -2 {
                if cur.parent?.left?.value == cur.value {
                    //right left shape -> left + right rotation
                    rightRotate(n: cur)
                    leftRotate(n: cur)
                } else {
                    //right right shape -> right rotation
                    leftRotate(n: cur)
                }
            } else if heightDiff == 2 {
                if cur.parent?.right?.value == cur.value {
                    //left right shape -> left + right rotation
                    leftRotate(n: cur)
                    rightRotate(n: cur)
                } else {
                    //left left shape -> right rotation
                    rightRotate(n: cur)
                }
            } else {
                current = cur.parent
            }
        }
    }
    
    private func rightRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        p?.left = n?.right
        p?.left?.parent = p
        n?.right = p;
        n?.parent = p?.parent
        p?.parent = n
//        p?.color = .red
//        n?.color = .black
    }
    
    private func leftRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        p?.right = n?.left
        p?.right?.parent = p
        n?.left = p
        p?.parent = n
//        n?.color = .black
//        p?.color = .red
    }
    
    static func test() {
        debugPrint("AVLTree")
        
        let rootValue = 30
        let tree = AVLTree<Int>()

        tree.insert(val: rootValue)
        tree.insert(val: 10)
        tree.insert(val: 35)

        tree.insert(val: 5)
        tree.insert(val: 20)

        tree.insert(val: 15)

        debugPrint("val: \(tree.root?.value ?? -1), h: \(tree.root?.height ?? -1)")
        debugPrint("val: \(tree.root?.left?.value ?? -1), h: \(tree.root?.left?.height ?? -1)")
        debugPrint("val: \(tree.root?.right?.value ?? -1), h: \(tree.root?.right?.height ?? -1)")
        debugPrint("val: \(tree.root?.left?.left?.value ?? -1), h: \(tree.root?.left?.left?.height ?? -1)")
        debugPrint("val: \(tree.root?.left?.right?.value ?? -1), h: \(tree.root?.left?.right?.height ?? -1)")
    }
}
