//
//  FloydWarshall.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 11.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class FloydWarshall {
    let graph: WeightedDirectedGraphWithAdjMatrix
    
    init(graph: WeightedDirectedGraphWithAdjMatrix) {
        self.graph = graph
    }
    
    func findShortestPaths() throws {
        for intermediateIndex in 0 ... graph.vertices.count - 1 {
            for startIndex in 0 ... graph.vertices.count - 1 {
                for endIndex in 0 ... graph.vertices.count - 1 {
                    if graph.adjMatrix[startIndex][intermediateIndex] < Int.max && graph.adjMatrix[intermediateIndex][endIndex] < Int.max
                        && graph.adjMatrix[startIndex][intermediateIndex] + graph.adjMatrix[intermediateIndex][endIndex] < graph.adjMatrix[startIndex][endIndex] {
                        graph.adjMatrix[startIndex][endIndex] = graph.adjMatrix[startIndex][intermediateIndex] + graph.adjMatrix[intermediateIndex][endIndex]
                    }
                }
            }
        }
        
        //Check for negative cycle:
        for index in 0 ... graph.vertices.count - 1 {
            if graph.adjMatrix[index][index] < 0 {
                throw NSError(domain: "FloydWarshall: Negative Cycle", code: 0, userInfo: nil)
            }
        }
    }
    
    static func test() {
        let g = setupTestGraph()
        let floydWarshall = FloydWarshall(graph: g)
        try! floydWarshall.findShortestPaths()
        
        debugPrint("Floyd Warshall")
        debugPrint(floydWarshall.graph.adjMatrix)
    }
    
    private static func setupTestGraph() -> WeightedDirectedGraphWithAdjMatrix {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let g = WeightedDirectedGraphWithAdjMatrix(vertices: vertices)
        
        //https://www.techiedelight.com/pairs-shortest-paths-floyd-warshall-algorithm/
        g.addEdge(v1: vertices[0], v2: vertices[2], weight: -2)
        g.addEdge(v1: vertices[1], v2: vertices[0], weight: 4)
        g.addEdge(v1: vertices[1], v2: vertices[2], weight: 3)
        g.addEdge(v1: vertices[2], v2: vertices[3], weight: 2)
        g.addEdge(v1: vertices[3], v2: vertices[1], weight: -1)
        
        return g
    }
}
