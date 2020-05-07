//
//  TravellingSalesman.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class TravelingSalesman {
    
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
}
