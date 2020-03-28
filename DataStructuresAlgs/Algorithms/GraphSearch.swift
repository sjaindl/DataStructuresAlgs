//
//  GraphSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class GraphSearch {
    let g: UndirectedGraph
    let start: Vertice
    var visited: [Bool]
    
    init(g: UndirectedGraph, start: Vertice) {
        self.g = g
        self.start = start
        
        visited = [Bool] (repeating: false, count: g.vertices.count)
    }
    
    func bfs() {
        let q = Queue<Vertice>()
        
        q.enqueue(val: start)
        visited[start.id] = true
        while !q.isEmpty() {
            let v = try! q.dequeue()
            debugPrint(v.id)
            
            let n = g.neighbours(v: v)
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
        let n = g.neighbours(v: v)
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
                
                let n = g.neighbours(v: v)
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
    
    static func testBFS() {
        let g = setupTestGraph()
        
        debugPrint("BFS")
        let gsBfs = GraphSearch(g: g, start: g.vertices[0])
        gsBfs.bfs()
    }
    
    static func testDFS() {
        let g = setupTestGraph()
        
        debugPrint("DFS")
        let gsDfs = GraphSearch(g: g, start: g.vertices[0])
        gsDfs.dfs()
        
        debugPrint("DFS iterative")
        let gsDfsIt = GraphSearch(g: g, start: g.vertices[0])
        gsDfsIt.dfs()
    }
    
    private static func setupTestGraph() -> UndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5),
                                    Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let g = UndirectedGraph(vertices: vertices)
        
        g.addEdge(v1: vertices[0], v2: vertices[1])
        g.addEdge(v1: vertices[0], v2: vertices[2])
        g.addEdge(v1: vertices[0], v2: vertices[3])
        
        g.addEdge(v1: vertices[1], v2: vertices[2])
        g.addEdge(v1: vertices[1], v2: vertices[4])
        g.addEdge(v1: vertices[2], v2: vertices[5])
        g.addEdge(v1: vertices[3], v2: vertices[8])
        g.addEdge(v1: vertices[4], v2: vertices[5])
        g.addEdge(v1: vertices[5], v2: vertices[6])
        g.addEdge(v1: vertices[6], v2: vertices[7])
        g.addEdge(v1: vertices[7], v2: vertices[8])
        g.addEdge(v1: vertices[8], v2: vertices[6])
        
        return g
    }
}
