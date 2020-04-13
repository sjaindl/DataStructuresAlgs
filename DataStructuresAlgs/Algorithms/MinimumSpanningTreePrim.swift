//
//  MinimumSpanningTreePrim.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 13.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class MinimumSpanningTreePrim {
    
    var graph: WeightedUndirectedGraph
    
    init(graph: WeightedUndirectedGraph) {
        self.graph = graph
    }
    
    func minimumSpanningTree() -> [Edge] {
        var mstEdges: [Edge] = []
        var mstVertices: Set<Vertice> = Set()
        let outsideVertices: MinHeap<Vertice> = MinHeap()
        
        for vertice in graph.vertices { // O(V)
            let weight = vertice.id == 0 ? 0 : Int.max
            vertice.weight = weight
            outsideVertices.insert(val: vertice)
        }
        
        while mstVertices.count < graph.vertices.count { // O(V)
            let minVertice = try! outsideVertices.extractMin() //O(log V)
            mstVertices.insert(minVertice)
            
            if let edge = minVertice.minIngoingEdge {
                mstEdges.append(edge)
            }
            
            let neighbours = graph.neighbours(v: minVertice)
            var neighbour = neighbours.head
            
            while let curNeighbour = neighbour { //O(E/V)
                let edge = curNeighbour.val
                let otherVertice = minVertice == edge.from ? edge.to : edge.from
                if !mstVertices.contains(otherVertice) { //O(1)
                    if otherVertice.weight > edge.weight {
                        otherVertice.weight = edge.weight
                        otherVertice.minIngoingEdge = edge
                        outsideVertices.update(otherVertice) //O(V) with MinHeap. Could be O(log V) with IndexPQ.
                        debugPrint("update edge \(minVertice.id) -> \(otherVertice.id): \(otherVertice.weight)")
                    }
                }
                
                neighbour = neighbour?.next
            }
        }
        
        return mstEdges
    }
    
    static func test() {
        let g = setupTestGraph()
        let mstPrim = MinimumSpanningTreePrim(graph: g)
        let mst = mstPrim.minimumSpanningTree()
        
        debugPrint("MST Prim")
        for minEdge in mst {
            debugPrint("\(minEdge.from.id) -> \(minEdge.to.id): \(minEdge.weight)")
        }
    }
    
    private static func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3),
                                   Vertice(id: 4), Vertice(id: 5), Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let g = WeightedUndirectedGraph(vertices: vertices)
        
        //https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/?ref=lbp
        g.addEdge(v1: vertices[0], v2: vertices[1], weight: 4)
        g.addEdge(v1: vertices[0], v2: vertices[7], weight: 8)
        g.addEdge(v1: vertices[1], v2: vertices[2], weight: 9) //changed to 9, as example algo doesn't pick this edge
        g.addEdge(v1: vertices[1], v2: vertices[7], weight: 11)
        g.addEdge(v1: vertices[2], v2: vertices[3], weight: 7)
        g.addEdge(v1: vertices[2], v2: vertices[5], weight: 4)
        g.addEdge(v1: vertices[2], v2: vertices[8], weight: 2)
        g.addEdge(v1: vertices[3], v2: vertices[4], weight: 9)
        g.addEdge(v1: vertices[3], v2: vertices[5], weight: 14)
        g.addEdge(v1: vertices[4], v2: vertices[5], weight: 10)
        g.addEdge(v1: vertices[5], v2: vertices[6], weight: 2)
        g.addEdge(v1: vertices[6], v2: vertices[7], weight: 1)
        g.addEdge(v1: vertices[6], v2: vertices[8], weight: 6)
        g.addEdge(v1: vertices[7], v2: vertices[8], weight: 7)
        
        return g
    }
}
