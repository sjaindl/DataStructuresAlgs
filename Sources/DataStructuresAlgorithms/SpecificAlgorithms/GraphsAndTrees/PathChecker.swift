//
//  PathChecker.swift
//  
//
//  Created by Stefan Jaindl on 22.06.20.
//

import Foundation

extension DirectedGraph {
    
    open func pathExists(from: Vertice, to: Vertice) -> Bool {
        let queue = Queue<Vertice>()
        
        queue.enqueue(val: from)
        while !queue.isEmpty(), let vertice = try? queue.dequeue() {
            vertice.visited = true
            if vertice == to {
                return true
            }
            
            var currentNode = neighbours(v: vertice).head
            while let neighbour = currentNode {
                if !neighbour.val.visited {
                    queue.enqueue(val: neighbour.val)
                }
                currentNode = neighbour.next
            }
        }
        
        return false
    }
    
    open func pathExistsByBidirectionalSearch(from: Vertice, to: Vertice) -> Bool {
        let fromQueue = Queue<Vertice>()
        let toQueue = Queue<Vertice>()
        var fromMarked = Set<Vertice>()
        var toMarked = Set<Vertice>()
        
        fromQueue.enqueue(val: from)
        toQueue.enqueue(val: to)
        
        fromMarked.insert(from)
        toMarked.insert(to)
        
        while !fromQueue.isEmpty() || !toQueue.isEmpty() {
            if singleBidirectionalTraversal(queue: fromQueue, marked: &fromMarked, otherMarked: toMarked)
                || singleBidirectionalTraversal(queue: toQueue, marked: &toMarked, otherMarked: fromMarked) {
                return true
            }
        }
        
        return false
    }
    
    private func singleBidirectionalTraversal(queue: Queue<Vertice>, marked: inout Set<Vertice>, otherMarked: Set<Vertice>) -> Bool {
        let nextLevelQueue = Queue<Vertice>()
        while !queue.isEmpty(), let vertice = try? queue.dequeue()  {
            if otherMarked.contains(vertice) {
                //Vertice has been seen from other queue
                return true
            }
            
            var currentNode = neighbours(v: vertice).head
            while let neighbour = currentNode {
                if !marked.contains(neighbour.val) {
                    nextLevelQueue.enqueue(val: neighbour.val)
                    marked.insert(neighbour.val)
                }
                currentNode = neighbour.next
            }
        }
        
        while !nextLevelQueue.isEmpty(), let vertice = try? nextLevelQueue.dequeue() {
            queue.enqueue(val: vertice)
        }
        
        return false
    }
}
