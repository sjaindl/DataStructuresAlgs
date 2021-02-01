//
//  ListOfDepths.swift
//  
//
//  Created by Stefan Jaindl on 24.06.20.
//

import Foundation

open class ListOfDepths<T: Comparable> {
    
    public init () { }
    
    open func listOfDepths(root: SimpleTreeNode<T>) -> Array<SingleLinkedList<T>> {
        var resultList = Array<SingleLinkedList<T>>()
        
        listOfDepths(resultList: &resultList, depth: 1, treeNode: root)
        
        return resultList
    }
    
    private func listOfDepths(resultList: inout Array<SingleLinkedList<T>>, depth: Int, treeNode: SimpleTreeNode<T>) {
        var levelList: SingleLinkedList<T>
        if resultList.count >= depth {
            levelList = resultList[depth - 1]
        } else {
            levelList = SingleLinkedList<T>()
            resultList.insert(levelList, at: depth - 1)
        }
        
        levelList.add(node: SingleNode(val: treeNode.value))
        
        if let left = treeNode.left {
            listOfDepths(resultList: &resultList, depth: depth + 1, treeNode: left)
        }
        
        if let right = treeNode.right {
            listOfDepths(resultList: &resultList, depth: depth + 1, treeNode: right)
        }
    }
}
