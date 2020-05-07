//
//  Djikstra.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Djikstra {
    var graph: WeightedUndirectedGraph
    var previous = Dictionary<Vertice, Vertice>()
    var distanceTo = Dictionary<Vertice, Int>()
    
    init(graph: WeightedUndirectedGraph) {
        self.graph = graph
        for vertice in graph.vertices {
            vertice.distanceTo = Int.max
            distanceTo[vertice] = Int.max
        }
    }
    
    func djikstra(from: Vertice, to: Vertice) throws -> Int? {
        distanceTo[from] = 0
        let pq = IndexedMinPriorityQueue<Vertice>(maxElements: graph.vertices.count)

        for vertice in graph.vertices {
            try? pq.insert(index: vertice.id, key: vertice)
        }
        
        while !pq.isEmpty(), let vertice = try? pq.extractMin() {
            let neighbours = graph.neighbours(v: vertice)
            var neighbour = neighbours.head
            
            while let n = neighbour, let curDistToV = distanceTo[vertice], let curDistToNeighbour = distanceTo[n.val.to] {
                let distInPath = curDistToV == Int.max ? Int.max : curDistToV + n.val.weight
                
                if distInPath < curDistToNeighbour {
                    distanceTo[n.val.to] = distInPath
                    previous[n.val.to] = vertice
                    
                    n.val.to.distanceTo = distInPath
                    try? pq.changeKey(index: n.val.to.id, key: n.val.to)
                }
                
                neighbour = neighbour?.next
            }
        }
        
        return distanceTo[to]
    }
    
    func path(to: Vertice) -> [Vertice] {
        var path: [Vertice] = []
        
        var prev: Vertice? = to
        while let prevVertice = prev {
            path.append(prevVertice)
            prev = previous[prevVertice]
        }
        
        return path.reversed()
    }
}
