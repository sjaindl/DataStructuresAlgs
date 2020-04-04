//
//  TopologicalSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class TopologicalSort {
    var graph: DirectedGraph
    
    init(graph: DirectedGraph) {
        self.graph = graph
    }
    
    func topologicalSort() throws -> Queue<Vertice> {
        let sort = Queue<Vertice>()
        let processNext = Queue<Vertice>()
        
        for vertice in graph.vertices {
            let neighbours = graph.neighbours(v: vertice)
            var currentNeighbour = neighbours.head
            while let current = currentNeighbour {
                current.val.inboundCount += 1
                currentNeighbour = current.next
            }
        }
        
        for vertice in graph.vertices {
            if vertice.inboundCount == 0 {
                processNext.enqueue(val: vertice)
            }
        }
        
        while !processNext.isEmpty(), let vertice = try? processNext.dequeue() {
            sort.enqueue(val: vertice)
            let neighbours = graph.neighbours(v: vertice)
            var currentNeighbour = neighbours.head
            while let current = currentNeighbour {
                current.val.inboundCount -= 1
                if current.val.inboundCount == 0 {
                    processNext.enqueue(val: current.val)
                }
                
                currentNeighbour = current.next
            }
        }
        
        if sort.size != graph.vertices.count {
            throw NSError(domain: "topologicalSort: There is a cycle in the graph", code: 0, userInfo: nil)
        }
        
        return sort
    }
    
    public static func test() {
        let g = setupTestGraph()
        let ts = TopologicalSort(graph: g)
        
        debugPrint("Topological Sort")
        
        let sort = try! ts.topologicalSort()
        while !sort.isEmpty(), let vertice = try? sort.dequeue() {
            debugPrint(vertice.id)
        }
    }
    
    private static func setupTestGraph() -> DirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5),
                                    Vertice(id: 6)]
        let g = DirectedGraph(vertices: vertices)
        
        g.addEdge(v1: vertices[0], v2: vertices[1])
        g.addEdge(v1: vertices[0], v2: vertices[3])
        g.addEdge(v1: vertices[1], v2: vertices[4])
        g.addEdge(v1: vertices[1], v2: vertices[2])
        g.addEdge(v1: vertices[3], v2: vertices[5])
        g.addEdge(v1: vertices[5], v2: vertices[6])
        
        return g
    }
}
