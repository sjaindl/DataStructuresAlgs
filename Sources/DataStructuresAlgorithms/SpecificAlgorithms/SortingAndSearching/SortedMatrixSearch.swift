//
//  SortedMatrixSearch.swift
//  
//
//  Created by Stefan Jaindl on 26.09.20.
//

import Foundation

open class SortedMatrixSearch<T: Comparable> {
    public init() { }
    
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
        
        return containsRecursiveFaster(matrix: matrix, searched: searched, minRow: 0, maxRow: matrix.count - 1, minColumn: 0, maxColumn: columnCount - 1)
    }
    
    private func containsRecursiveFaster(matrix: [[T]], searched: T, minRow: Int, maxRow: Int, minColumn: Int, maxColumn: Int) -> Bool {
        let currentValue = matrix[minRow][minColumn]
        if currentValue == searched { //found
            return true
        }
        
        if currentValue > searched { //not in matrix
            return false
        }
        
        if (minColumn == maxColumn && minRow == maxRow) { //only 1 field left
            return false
        }
        
        if minColumn == maxColumn { //only 1 column left, move on to next row
            return containsRecursiveFaster(matrix: matrix, searched: searched, minRow: minRow + 1, maxRow: maxRow, minColumn: minColumn, maxColumn: maxColumn)
        }
        
        if minRow == maxRow { //only 1 row left, move on to next column
            return containsRecursiveFaster(matrix: matrix, searched: searched, minRow: minRow, maxRow: maxRow, minColumn: minColumn + 1, maxColumn: maxColumn)
        }
        
        //Move columns diagonally along, until match is found, end of matrix reached or 1 element < searched and 1 element > searched
        //In the latter case, we just have to search the bottom left and upper right part recursively. The other 2 quadrants all have lower (top left) or higher (bottom right) values.
        var lastRow = minRow
        var lastCol = minColumn
        var curRow = minRow
        var curCol = minColumn
        while isInBounds(matrix: matrix, row: curRow, column: curCol) && matrix[curRow][curCol] < searched {
            lastRow = curRow
            lastCol = curCol
            curCol += 1
            curRow += 1
        }
        
        //Might be out of bounds if we moved over the end of the matrix columns
        if isInBounds(matrix: matrix, row: minRow, column: curCol), matrix[curRow][curCol] == searched {
            return true
        }
        
        var found = false
        //search top right
        if isInBounds(matrix: matrix, row: minRow, column: curCol)  {
            found = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: minRow, maxRow: lastRow, minColumn: curCol, maxColumn: maxColumn)
        }
        
        //search bottom left
        if !found && isInBounds(matrix: matrix, row: curRow, column: minColumn)  {
            found = containsRecursiveFaster(matrix: matrix, searched: searched, minRow: curRow, maxRow: maxRow, minColumn: minColumn, maxColumn: lastCol)
        }
        
        return found
    }
}
