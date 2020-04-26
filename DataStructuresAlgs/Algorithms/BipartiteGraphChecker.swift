//
//  BipartiteGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class BipartiteGraphChecker {
    
    enum Color {
        case red
        case black
        case none
    }
    
    var graph: UndirectedGraph
    
    init(graph: UndirectedGraph) {
        self.graph = graph
    }
    
    func isBipartite() throws -> [Color]? {
        if graph.vertices.count < 1 {
            return []
            //a graph with no edges is also Bipiartite. Note that the Bipartite condition says all edges should be from one set to another.
        }
        
        var colors: [Color]? = [Color] (repeating: .none, count: graph.vertices.count)
        
        for vertice in graph.vertices { //important if graph is not connected
            if colors?[vertice.id] == BipartiteGraphChecker.Color.none {
                colors = try isBipartite(vertice: vertice, colors: colors)
            }
        }
        
        return colors
    }
    
    func isBipartite(vertice: Vertice, colors: [Color]?) throws -> [Color]? {
        guard var colors = colors else {
            return nil
        }
        
        let bfsQueue = Queue<Vertice>()
        let rootNode = graph.vertices[vertice.id]
        
        colors[rootNode.id] = .red
        bfsQueue.enqueue(val: rootNode)
        
        while !bfsQueue.isEmpty() {
            let curNode = try bfsQueue.dequeue()
            
            let neighbours = graph.neighbours(v: curNode)
            var currentHead = neighbours.head
            let colorForNeighbors: Color = colors[curNode.id] == .black ? .red : .black
            while let curHead = currentHead {
                let curVertice = curHead.val
                if colors[curVertice.id] == colors[curNode.id] {
                    return nil //same color between neighbors (not possible cycle)!
                }
                
                if curVertice.id == curNode.id {
                    return nil //graph is not bipartite, if there's a self-loop
                }
                
                if colors[curVertice.id] == .none {
                    colors[curVertice.id] = colorForNeighbors
                    bfsQueue.enqueue(val: curVertice)
                }
                
                currentHead = currentHead?.next
            }
        }
        
        return colors
    }
    
    static func test() {
        let g = setupTestGraph()
        let bipartite = BipartiteGraphChecker(graph: g)
        let colors = try! bipartite.isBipartite()
        
        debugPrint("Bipartite Graph BFS")
        for (index, color) in colors!.enumerated() {
            debugPrint("\(index): \(color)")
        }
    }
    
    private static func setupTestGraph() -> UndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3),
                                   Vertice(id: 4), Vertice(id: 5), Vertice(id: 6), Vertice(id: 7),
                                   Vertice(id: 8), Vertice(id: 9), Vertice(id: 10), Vertice(id: 11)]
        let g = UndirectedGraph(vertices: vertices)
        
        //https://www.geeksforgeeks.org/bipartite-graph/
        g.addEdge(v1: vertices[0], v2: vertices[1])
        g.addEdge(v1: vertices[1], v2: vertices[2])
        g.addEdge(v1: vertices[2], v2: vertices[3])
        g.addEdge(v1: vertices[3], v2: vertices[4])
        g.addEdge(v1: vertices[4], v2: vertices[5])
        g.addEdge(v1: vertices[5], v2: vertices[0])
        
        g.addEdge(v1: vertices[6], v2: vertices[7])
        g.addEdge(v1: vertices[7], v2: vertices[8])
        g.addEdge(v1: vertices[8], v2: vertices[9])
        g.addEdge(v1: vertices[9], v2: vertices[10])
        g.addEdge(v1: vertices[10], v2: vertices[11])
        g.addEdge(v1: vertices[11], v2: vertices[6])
        
        return g
    }
}
