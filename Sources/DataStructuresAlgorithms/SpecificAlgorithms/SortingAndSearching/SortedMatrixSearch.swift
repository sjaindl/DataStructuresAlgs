//
//  SortedMatrixSearch.swift
//  
//
//  Created by Stefan Jaindl on 26.09.20.
//

import Foundation

open class SortedMatrixSearch<T: Comparable> {
    public init() { }
    
    var count = 0
    
    //Searches a path through the matrix: O(M * N) average case. O(M * N) additional space.
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
        
        let rec = containsRecursive(matrix: matrix, searched: searched, row: 0, column: 0, lookupMatrix: &lookupMatrix)
        debugPrint(count)
        return rec
    }
    
    private func containsRecursive(matrix: [[T]], searched: T, row: Int, column: Int, lookupMatrix: inout [[Bool]]) -> Bool {
        count += 1
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
    
    // Faster Implementation and without additional space.
    //Searches from center of matrix onwards to 4 sides (at least eliminates one quarter at each rec. call). No additional space.
    open func sortedMatrixSearchFaster(matrix: [[T]], searched: T) -> Bool {
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
        
        let rec = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: 0, maxRow: matrix.count - 1, minColumn: 0, maxColumn: columnCount - 1)
        debugPrint(count)
        return rec
    }
    
    private func containsRecursiveFaster(matrix: [[T]], searched: T, minRow: Int, maxRow: Int, minColumn: Int, maxColumn: Int) -> Bool {
        count += 1
        let centerRow = (minRow + maxRow) / 2
        let centerColumn = (minColumn + maxColumn) / 2
        let currentValue = matrix[centerRow][centerColumn]
        
        if currentValue == searched {
            return true
        }
        
        if minRow == maxRow, minColumn == maxColumn {
            return false
        }
        
        var submatch = false
        if searched < currentValue && (minRow < centerRow || minColumn < centerColumn) { //search top left side
            submatch = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: minRow, maxRow: centerRow, minColumn: minColumn, maxColumn: centerColumn)
        }
        if !submatch && maxColumn > centerColumn && minRow < centerRow { //search top right side
            submatch = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: minRow, maxRow: centerRow - 1, minColumn: centerColumn + 1, maxColumn: maxColumn)
        }
        if !submatch && maxRow > centerRow { //search bottom left side
            submatch = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: centerRow + 1, maxRow: maxRow, minColumn: minColumn, maxColumn: centerColumn)
            //Possible optimization: Exclude same column based on currentValue
        }
        if !submatch && searched > currentValue && maxColumn > centerColumn { //search bottom right side
            submatch = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: centerRow, maxRow: maxRow, minColumn: centerColumn + 1, maxColumn: maxColumn)
        }
        
        return submatch
    }
}
