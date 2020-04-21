//
//  IntervalTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 19.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

struct Interval<T: Comparable> {
    var low: T
    var high: T
    
    static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.low == rhs.low && lhs.high == rhs.high
    }
    
    static func < (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.low < rhs.low
    }
    
    static func > (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.low > rhs.low
    }
}

class IntervalNode<T: Comparable> {
    var interval: Interval<T>
    var minMaxInterval: Interval<T>
    var left: IntervalNode?
    var right: IntervalNode?
    var parent: IntervalNode?
    var height: Int
    
    init(parent: IntervalNode? = nil, interval: Interval<T>, height: Int) {
        self.parent = parent
        self.interval = interval
        minMaxInterval = interval
        self.height = height
    }
}

class IntervalTree<T: Comparable> {
    var root: IntervalNode<T>?
    
    init(root: IntervalNode<T>) {
        self.root = root
    }
    
    func overlapsInterval(interval: Interval<T>) -> Interval<T>? {
        guard let root = root else {
            return nil
        }
        
        return overlapsInterval(interval: interval, node: root)
    }
    
    func overlapsInterval(interval: Interval<T>, node: IntervalNode<T>) -> Interval<T>? {
        if interval.low < node.interval.high && interval.high >= node.interval.high      //interval overlaps right
            || interval.low <= node.interval.low && interval.high > node.interval.low    //interval overlaps left
            || interval.low >= node.interval.low && interval.high <= node.interval.high  //interval inside
            || interval.low <= node.interval.low && interval.high >= node.interval.high  //interval completely overlaps
            {
            return node.interval //overlaps
        }
        
        if let leftChild = node.left, leftChild.minMaxInterval.high > interval.low, leftChild.minMaxInterval.low < node.minMaxInterval.high {
            return overlapsInterval(interval: interval, node: leftChild)
        }
        
        if let rightChild = node.right, rightChild.minMaxInterval.high > interval.low, rightChild.minMaxInterval.low < interval.high {
            return overlapsInterval(interval: interval, node: rightChild)
        }
        
        return nil
    }
    
    func insert(interval: Interval<T>) {
        if root == nil {
            root = IntervalNode(parent: nil, interval: interval, height: 1)
            return
        }
        
        var current = root
        while current != nil, let cur = current {
            if cur.interval > interval {
                if cur.left == nil {
                    cur.left = IntervalNode(parent: cur, interval: interval, height: 1)
                    increaseHeightAndSetIntervals(cur)
                    return
                } else {
                    current = cur.left
                }
            } else {
                if cur.right == nil {
                    cur.right = IntervalNode(parent: cur, interval: interval, height: 1)
                    increaseHeightAndSetIntervals(cur)
                    return
                } else {
                    current = cur.right
                }
            }
        }
    }
    
    func increaseHeightAndSetIntervals(_ node: IntervalNode<T>) {
        if node.left != nil, node.right != nil {
            return //must be balanced
        }
        
        var current: IntervalNode? = node
        while current != nil, let cur = current {
            let leftHeight = cur.left?.height ?? 0
            let rightHeight = cur.right?.height ?? 0
            
            cur.height = max(leftHeight, rightHeight) + 1
            
            let leftInterval = cur.left?.minMaxInterval ?? nil
            let rightInterval = cur.right?.minMaxInterval ?? nil
            
            if let interval = leftInterval {
                cur.minMaxInterval.low = min(cur.minMaxInterval.low, interval.low)
                cur.minMaxInterval.high = max(cur.minMaxInterval.high, interval.high)
            }
            
            if let interval = rightInterval {
                cur.minMaxInterval.low = min(cur.minMaxInterval.low, interval.low)
                cur.minMaxInterval.high = max(cur.minMaxInterval.high, interval.high)
            }
            
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
    
    func printTree() {
        printTree(node: root)
    }
    
    func printTree(node: IntervalNode<T>?) {
        if let node = node {
            debugPrint("Low/High: \(node.interval.low)-\(node.interval.high), Min/Max: \(node.minMaxInterval.low)-\(node.minMaxInterval.high), Height: \(node.height)")
            printTree(node: node.left)
            printTree(node: node.right)
        }
    }
    
    private func rightRotate(n: IntervalNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.interval.low == gp?.left?.interval.low && p?.interval.high == gp?.left?.interval.high
        
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
        
        let pLeftInterval = p?.left?.minMaxInterval ?? nil
        let pRightInterval = p?.right?.minMaxInterval ?? nil
        
        if let p = p {
            p.minMaxInterval = p.interval
            
            if let interval = pLeftInterval {
                p.minMaxInterval.low = min(p.minMaxInterval.low, interval.low)
                p.minMaxInterval.high = max(p.minMaxInterval.high, interval.high)
            }
            
            if let interval = pRightInterval {
                p.minMaxInterval.low = min(p.minMaxInterval.low, interval.low)
                p.minMaxInterval.high = max(p.minMaxInterval.high, interval.high)
            }
        }
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
        
        let nLeftInterval = n?.left?.minMaxInterval ?? nil
        let nRightInterval = n?.right?.minMaxInterval ?? nil
        
        if let n = n {
            n.minMaxInterval = n.interval
            
            if let interval = nLeftInterval {
                n.minMaxInterval.low = min(n.minMaxInterval.low, interval.low)
                n.minMaxInterval.high = max(n.minMaxInterval.high, interval.high)
            }
            
            if let interval = nRightInterval {
                n.minMaxInterval.low = min(n.minMaxInterval.low, interval.low)
                n.minMaxInterval.high = max(n.minMaxInterval.high, interval.high)
            }
        }
    }
    
    private func leftRotate(n: IntervalNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.interval.low == gp?.left?.interval.low && p?.interval.high == gp?.left?.interval.high
        
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
        
        let pLeftInterval = p?.left?.minMaxInterval ?? nil
        let pRightInterval = p?.right?.minMaxInterval ?? nil
        
        if let p = p {
            p.minMaxInterval = p.interval
            
            if let interval = pLeftInterval {
                p.minMaxInterval.low = min(p.minMaxInterval.low, interval.low)
                p.minMaxInterval.high = max(p.minMaxInterval.high, interval.high)
            }
            
            if let interval = pRightInterval {
                p.minMaxInterval.low = min(p.minMaxInterval.low, interval.low)
                p.minMaxInterval.high = max(p.minMaxInterval.high, interval.high)
            }
        }
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
        
        let nLeftInterval = n?.left?.minMaxInterval ?? nil
        let nRightInterval = n?.right?.minMaxInterval ?? nil
        
        if let n = n {
            n.minMaxInterval = n.interval
            
            if let interval = nLeftInterval {
                n.minMaxInterval.low = min(n.minMaxInterval.low, interval.low)
                n.minMaxInterval.high = max(n.minMaxInterval.high, interval.high)
            }
            
            if let interval = nRightInterval {
                n.minMaxInterval.low = min(n.minMaxInterval.low, interval.low)
                n.minMaxInterval.high = max(n.minMaxInterval.high, interval.high)
            }
        }
    }
    
    static func test() {
        //https://www.geeksforgeeks.org/interval-tree/
        debugPrint("Interval Tree")
        
        let rootValue = Interval(low: 15, high: 20)
        let rootNode = IntervalNode<Int>(interval: rootValue, height: 1)
        let tree: IntervalTree<Int> = IntervalTree<Int>(root: rootNode)
        
        tree.insert(interval: Interval(low: 10, high: 30))
        tree.insert(interval: Interval(low: 5, high: 20))
        tree.insert(interval: Interval(low: 17, high: 19))
        tree.insert(interval: Interval(low: 12, high: 15))
        tree.insert(interval: Interval(low: 30, high: 40))
        
        tree.printTree()
        
        debugPrint(tree.overlapsInterval(interval: Interval(low: 10, high: 30)) ?? "no interval found")
        debugPrint(tree.overlapsInterval(interval: Interval(low: 0, high: 5)) ?? "no interval found")
        debugPrint(tree.overlapsInterval(interval: Interval(low: 4, high: 6)) ?? "no interval found")
        debugPrint(tree.overlapsInterval(interval: Interval(low: 25, high: 27)) ?? "no interval found")
    }
}
