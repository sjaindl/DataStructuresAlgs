//
//  DirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class DirectedGraph {
    public let vertices: [Vertice]
    private var adjList: [LinkedList<Vertice>] = []
    
    public init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(LinkedList<Vertice>())
        }
    }
    
    open func addEdge(v1: Vertice, v2: Vertice) {
        adjList[v1.id].add(node: Node(val: v2))
    }
    
    open func neighbours(v: Vertice) -> LinkedList<Vertice> {
        return adjList[v.id]
    }
}
