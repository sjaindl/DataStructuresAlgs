//
//  BellmanFord.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 09.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class BellmanFord {
    let graph: WeightedDirectedGraph
    
    init(graph: WeightedDirectedGraph) {
        self.graph = graph
    }
    
    func findShortestPath(source: Vertice, target: Vertice) throws -> Int {
        var distTo = [Int] (repeating: Int.max, count: graph.vertices.count)
        distTo[source.id] = 0
        
        var pass = 1
        
        while pass < graph.vertices.count {
            for edge in graph.edges() {
                if distTo[edge.from.id] != Int.max && distTo[edge.to.id] > distTo[edge.from.id] + edge.weight {
                    distTo[edge.to.id] = distTo[edge.from.id] + edge.weight
                }
            }
            pass += 1
        }
        
        //Check for negative cycle: There is one, if edges can be forever relaxed.
        for edge in graph.edges() {
            if distTo[edge.from.id] != Int.max && distTo[edge.to.id] > distTo[edge.from.id] + edge.weight {
                throw NSError(domain: "Bellman Ford: Negative Cycle", code: 0, userInfo: nil)
            }
        }
        
        return distTo[target.id]
    }
    
    static func test() {
        let g = setupTestGraph()
        let bellmanFord = BellmanFord(graph: g)
        let dist = try? bellmanFord.findShortestPath(source: g.vertices[0], target: g.vertices[3])
        
        debugPrint("Bellman Ford")
        debugPrint(dist!)
    }
    
    private static func setupTestGraph() -> WeightedDirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4)]
        let g = WeightedDirectedGraph(vertices: vertices)
        
        //https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/?ref=lbp
        g.addEdge(v1: vertices[0], v2: vertices[1], weight: -1)
        g.addEdge(v1: vertices[0], v2: vertices[2], weight: 4)
        g.addEdge(v1: vertices[1], v2: vertices[2], weight: 3)
        g.addEdge(v1: vertices[1], v2: vertices[3], weight: 2)
        g.addEdge(v1: vertices[1], v2: vertices[4], weight: 2)
        g.addEdge(v1: vertices[3], v2: vertices[1], weight: 1)
        g.addEdge(v1: vertices[3], v2: vertices[2], weight: 5)
        g.addEdge(v1: vertices[4], v2: vertices[3], weight: -3)
        
        return g
    }
}
