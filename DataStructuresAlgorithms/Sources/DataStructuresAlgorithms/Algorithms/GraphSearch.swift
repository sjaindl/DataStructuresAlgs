//
//  GraphSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class GraphSearch {
    let graph: UndirectedGraph
    let start: Vertice
    var visited: [Bool]
    
    init(graph: UndirectedGraph, start: Vertice) {
        self.graph = graph
        self.start = start
        
        visited = [Bool] (repeating: false, count: graph.vertices.count)
    }
    
    func bfs() {
        let q = Queue<Vertice>()
        
        q.enqueue(val: start)
        visited[start.id] = true
        while !q.isEmpty() {
            let v = try! q.dequeue()
            debugPrint(v.id)
            
            let n = graph.neighbours(v: v)
            var curNode = n.head
            while curNode != nil {
                if !visited[curNode!.val.id] {
                    q.enqueue(val: curNode!.val)
                    visited[curNode!.val.id] = true
                }
                curNode = curNode!.next
            }
        }
    }
    
    func dfs() {
        visited[start.id] = true
        dfs(v: start)
    }
    
    func dfs(v: Vertice) {
        debugPrint(v.id)
        let n = graph.neighbours(v: v)
        var curVertice = n.head
        
        while curVertice != nil {
            if !visited[curVertice!.val.id] {
                visited[curVertice!.val.id] = true
                dfs(v: curVertice!.val)
            }
            
            curVertice = curVertice?.next
        }
    }
    
    func dfsIterative() {
        let s = Stack<Vertice>()
        s.push(val: start)
        visited[start.id] = true
        
        while !s.isEmpty() {
            do {
                let v = try s.pop()
                debugPrint(v.id)
                
                let n = graph.neighbours(v: v)
                var curVertice = n.head
                
                while curVertice != nil {
                    if !visited[curVertice!.val.id] {
                        visited[curVertice!.val.id] = true
                        s.push(val: curVertice!.val)
                    }
                    
                    curVertice = curVertice?.next
                }
                
            }
            catch {
                fatalError()
            }
        }
    }
}
