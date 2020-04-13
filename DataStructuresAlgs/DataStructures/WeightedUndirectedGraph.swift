//
//  WeightedUndirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class WeightedUndirectedGraph {
    let vertices: [Vertice]
    var adjList: [LinkedList<Edge>] = []
    var edgesOfGraph: [Edge] = []
    
    init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(LinkedList<Edge>())
        }
    }
    
    func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        let edge = Edge(from: v1, to: v2, weight: weight) //order of from/to doesn't really matter, as the graph is undirected
        adjList[v1.id].add(node: Node(val: edge))
        adjList[v2.id].add(node: Node(val: edge))
        edgesOfGraph.append(edge)
    }
    
    func neighbours(v: Vertice) -> LinkedList<Edge> {
        return adjList[v.id]
    }
    
    func edges() -> [Edge] {
        return edgesOfGraph
    }
}
