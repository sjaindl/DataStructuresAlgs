//
//  SortedMatrixSearch.swift
//  
//
//  Created by Stefan Jaindl on 26.09.20.
//

import Foundation

open class SortedMatrixSearch<T: Comparable> {
    public init() { }
    
    open func sortedMatrixSearch(matrix: [[T]], searched: T) -> Bool {
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return false
        }
        
        let columnCount = matrix[0].count
        for row in 0 ..< matrix.count {
            if matrix[row].count != columnCount {
                //Matrix has different amount of columns!
                return false
            }
        }
        
        var lookupMatrix: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: matrix.count)
        
        return containsRecursive(matrix: matrix, searched: searched, row: 0, column: 0, lookupMatrix: &lookupMatrix)
    }
    
    private func containsRecursive(matrix: [[T]], searched: T, row: Int, column: Int, lookupMatrix: inout [[Bool]]) -> Bool {
        lookupMatrix[row][column] = true
        let matrixValue = matrix[row][column]
        
        if matrixValue > searched {
            return false
        }
        
        if matrixValue == searched {
            return true
        }
        
        var submatch = false
        if isInBounds(matrix: matrix, row: row + 1, column: column), !lookupMatrix[row + 1][column] {
            submatch = containsRecursive(matrix: matrix, searched: searched, row: row + 1, column: column, lookupMatrix: &lookupMatrix)
        }
        if !submatch, isInBounds(matrix: matrix, row: row, column: column + 1), !lookupMatrix[row][column + 1] {
            submatch = containsRecursive(matrix: matrix, searched: searched, row: row, column: column + 1, lookupMatrix: &lookupMatrix)
        }
        
        return submatch
    }
    
    private func isInBounds(matrix: [[T]], row: Int, column: Int) -> Bool {
        return row >= 0 && column >= 0 && row < matrix.count && column < matrix[0].count
    }
}
