//
//  WeightedUndirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class WeightedUndirectedGraph {
    let vertices: [Vertice]
    private var adjList: [LinkedList<Edge>] = []
    private var edgesOfGraph: [Edge] = []
    
    init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(LinkedList<Edge>())
        }
    }
    
    func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        let edge = Edge(from: v1, to: v2, weight: weight)
        adjList[v1.id].add(node: Node(val: edge))
        edgesOfGraph.append(edge)
        
        let edge2 = Edge(from: v2, to: v1, weight: weight)
        adjList[v2.id].add(node: Node(val: edge2))
        edgesOfGraph.append(edge2)
    }
    
    func neighbours(v: Vertice) -> LinkedList<Edge> {
        return adjList[v.id]
    }
    
    func edges() -> [Edge] {
        return edgesOfGraph
    }
}
