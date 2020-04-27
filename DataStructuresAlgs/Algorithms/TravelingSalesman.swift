//
//  TravellingSalesman.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class TravelingSalesman {
    
    var graph: WeightedUndirectedGraphWithAdjMatrix
    var minimumDistance = Int.max
    
    init(graph: WeightedUndirectedGraphWithAdjMatrix) {
        self.graph = graph //this should be a complete graph
    }
    
    func travelingSalesman(startCity: Vertice) -> [Int] {
        var cities: [Int] = []
        
        for city in graph.vertices {
            if city != startCity {
                cities.append(city.id)
            }
        }
        
        var permutations = Permuation<Int>().heapsPermutations(array: &cities)
        
        var minimumRoute: [Int] = []
        
        while var currentPermutation = permutations.popLast() {
            
            currentPermutation.append(startCity.id)
            
            var currentDistance = 0
            var currentCity = startCity.id
            for city in currentPermutation {
                currentDistance += graph.adjMatrix[currentCity][city]
                currentCity = city
            }
            
            if currentDistance < minimumDistance {
                minimumDistance = currentDistance
                currentPermutation.insert(startCity.id, at: 0)
                minimumRoute = currentPermutation
            }
        }
        
        return minimumRoute
    }
    
    static func test() {
        let graph = setupTestGraph()
        let travelingSalesman = TravelingSalesman(graph: graph)
        debugPrint("Traveling Salesman")
        let minRoute = travelingSalesman.travelingSalesman(startCity: graph.vertices[0])
        debugPrint("\(minRoute) with distance \(travelingSalesman.minimumDistance)")
    }
    
    private static func setupTestGraph() -> WeightedUndirectedGraphWithAdjMatrix {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let g = WeightedUndirectedGraphWithAdjMatrix(vertices: vertices)
        
        //https://www.geeksforgeeks.org/traveling-salesman-problem-tsp-implementation
        g.addEdge(v1: vertices[0], v2: vertices[1], weight: 10)
        g.addEdge(v1: vertices[0], v2: vertices[2], weight: 15)
        g.addEdge(v1: vertices[0], v2: vertices[3], weight: 20)
        g.addEdge(v1: vertices[1], v2: vertices[2], weight: 35)
        g.addEdge(v1: vertices[1], v2: vertices[3], weight: 25)
        g.addEdge(v1: vertices[2], v2: vertices[3], weight: 30)
        
        return g
    }
}
