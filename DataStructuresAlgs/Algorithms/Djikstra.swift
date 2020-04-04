//
//  Djikstra.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Djikstra {
    var g: WeightedDirectedGraph
    var previous = Dictionary<Vertice, Vertice>()
    var distanceTo = Dictionary<Vertice, Int>()
    
    init(g: WeightedDirectedGraph) {
        self.g = g
        for v in g.vertices {
            distanceTo[v] = Int.max
        }
    }
    
    func djikstra(from: Vertice, to: Vertice) -> Int? {
        distanceTo[from] = 0
        let pq = MinHeap<Vertice>()
        
        for (key, val) in distanceTo {
            key.distanceTo = val
            pq.insert(val: key)
        }
        
        while !pq.isEmpty(), let v = try? pq.extractMin() {
            let neighbours = g.neighbours(v: v)
            var neighbour = neighbours.head
            while let n = neighbour, let curDistToV = distanceTo[v], let curDistToNeighbour = distanceTo[n.val.vertice] {
                let distInPath = curDistToV == Int.max ? Int.max : curDistToV + n.val.weight
                if distInPath < curDistToNeighbour {
                    distanceTo[n.val.vertice] = distInPath
                    previous[n.val.vertice] = v
                    
                    debugPrint("update node \(n.val.vertice.id) to dist \(distInPath) from node \(v.id)")
                    n.val.vertice.distanceTo = distInPath
                    pq.update(n.val.vertice)
                }
                
                neighbour = neighbour?.next
            }
        }
        
        var prev: Vertice? = to
        debugPrint("Path: ")
        while prev != nil {
            debugPrint(" \(prev!.id) > ")
            prev = previous[prev!]
        }
        
        return distanceTo[to]
    }
    
    static func test() {
        let g = setupTestGraph()
        
        debugPrint("Djikstra")
        let djikstra = Djikstra(g: g)
        let distance = djikstra.djikstra(from: g.vertices[0], to: g.vertices[8])
        debugPrint("distance: \(distance)")
    }
    
    private static func setupTestGraph() -> WeightedDirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5),
                                    Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let g = WeightedDirectedGraph(vertices: vertices)
        
        g.addEdge(v1: vertices[0], v2: vertices[1], weight: 5)
        g.addEdge(v1: vertices[0], v2: vertices[2], weight: 3)
        g.addEdge(v1: vertices[0], v2: vertices[4], weight: 2)
        g.addEdge(v1: vertices[1], v2: vertices[3], weight: 2)
        g.addEdge(v1: vertices[2], v2: vertices[1], weight: 5)
        g.addEdge(v1: vertices[2], v2: vertices[3], weight: 1)
        g.addEdge(v1: vertices[3], v2: vertices[0], weight: 1)
        g.addEdge(v1: vertices[3], v2: vertices[6], weight: 2)
        g.addEdge(v1: vertices[3], v2: vertices[7], weight: 1)
        g.addEdge(v1: vertices[4], v2: vertices[0], weight: 1)
        g.addEdge(v1: vertices[4], v2: vertices[7], weight: 4)
        g.addEdge(v1: vertices[4], v2: vertices[8], weight: 7)
        g.addEdge(v1: vertices[5], v2: vertices[1], weight: 3)
        g.addEdge(v1: vertices[5], v2: vertices[6], weight: 1)
        g.addEdge(v1: vertices[6], v2: vertices[2], weight: 3)
        g.addEdge(v1: vertices[6], v2: vertices[8], weight: 2)
        g.addEdge(v1: vertices[7], v2: vertices[6], weight: 2)
        g.addEdge(v1: vertices[7], v2: vertices[2], weight: 2)
        
        return g
    }
}
