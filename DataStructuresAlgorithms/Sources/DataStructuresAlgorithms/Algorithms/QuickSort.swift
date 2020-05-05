//
//  QuickSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 29.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class QuickSort<T: Comparable> {
    static func quickSort(array: inout [T]) {
        if array.count <= 1 {
            return
        }
        
        quickSort(array: &array, min: 0, max: array.count - 1)
    }
    
    private static func quickSort(array: inout [T], min: Int, max: Int) {
        if min < max {
            let pivot = partition(array: &array, min: min, max: max)
            quickSort(array: &array, min: min, max: pivot - 1)
            quickSort(array: &array, min: pivot + 1, max: max)
        }
    }
    
    private static func partition(array: inout [T], min: Int, max: Int) -> Int {
        var left = min
        var pivot = medianOfThree(array: array, min: min, max:  max)
        exchange(array: &array, index1: pivot, index2: max)
        pivot = max
        var right = pivot - 1
        
        while left < right {
            while array[left] < array[pivot] {
                left += 1
            }
             
            while array[right] > array[pivot] {
                right -= 1
            }
            
            if left < right {
                exchange(array: &array, index1: left, index2: right)
            }
        }
        
        exchange(array: &array, index1: pivot, index2: left)
        pivot = left
        
        return pivot
    }
    
    private static func medianOfThree(array: [T], min: Int, max: Int) -> Int {
        if array[min] < array[max / 2] && array[min] > array[max]
            || array[min] > array[max / 2] && array[min] < array[max] {
            return min
        }
        
        if array[max] < array[max / 2] && array[max] > array[min]
            || array[max] > array[max / 2] && array[max] < array[min] {
            return max
        }
        
        return max / 2
    }
    
    private static func exchange(array: inout [T], index1: Int, index2: Int) {
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
}
