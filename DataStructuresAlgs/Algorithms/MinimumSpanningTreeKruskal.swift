//
//  MinimumSpanningTreeKruskal.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class MinimumSpanningTreeKruskal {
    //1. Sort edges by weight --> O(E log E)
        //alternative use priority queue --> O(E log E)
    //2. Pop min edge
    //3. If there is a cycle, discard (detection with UnionFind)
    //4. Else include in MST
    
    var graph: WeightedUndirectedGraph
    
    init(graph: WeightedUndirectedGraph) {
        self.graph = graph
    }
    
    func minimumSpanningTree() -> [Edge] {
        var mst: [Edge] = []
        var edges = graph.edges()
        QuickSort.quickSort(array: &edges) // O(E log E)
        
        //Alternative:
//        let pq = MinHeap<Edge>()
//        for edge in edges { //O(E log E)
//            pq.insert(val: edge)
//        }
        
        let components = UnionFind(graph: graph)
        
        var index = 0
        while mst.count < graph.vertices.count - 1 {
            
//            let edge = try! pq.extractMin()
//            let firstVertice = edge.from
//            let secondVertice = edge.to
            
            let edge = edges[index]
            let firstVertice = edges[index].from
            let secondVertice = edges[index].to
            
            let parentOfFirstVertice = components.find(index: firstVertice.id)
            let parentOfSecondVertice = components.find(index: secondVertice.id)
            
            if parentOfFirstVertice != parentOfSecondVertice {
                //no cylce, if we take this edge
                mst.append(edge)
                components.union(firstIndex: parentOfFirstVertice, secondIndex: parentOfSecondVertice)
            } // else we have a cycle: ignore edge
            
            index += 1
        }
        
        return mst
    }
    
    static func test() {
        let g = setupTestGraph()
        let mstKruskal = MinimumSpanningTreeKruskal(graph: g)
        let mst = mstKruskal.minimumSpanningTree()
        
        debugPrint("MST Kruskal")
        for minEdge in mst {
            debugPrint("\(minEdge.from.id) -> \(minEdge.to.id): \(minEdge.weight)")
        }
    }
    
    private static func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let g = WeightedUndirectedGraph(vertices: vertices)
        
        //https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/?ref=lbp
        g.addEdge(v1: vertices[0], v2: vertices[1], weight: 10)
        g.addEdge(v1: vertices[0], v2: vertices[2], weight: 6)
        g.addEdge(v1: vertices[0], v2: vertices[3], weight: 5)
        g.addEdge(v1: vertices[1], v2: vertices[3], weight: 15)
        g.addEdge(v1: vertices[2], v2: vertices[3], weight: 4)
        
        return g
    }
}
