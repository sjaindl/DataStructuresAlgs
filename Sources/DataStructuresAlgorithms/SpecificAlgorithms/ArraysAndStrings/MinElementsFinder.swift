//
//  MinElementsFinder.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation

open class MinElementsFinder {
    public init() { }
    
    //Finds smallest numberOfElements elements and returns them sorted in O(N log N) time using a heap.
    open func findMinElementsSorted(numberOfElements: Int, array: [Int]) throws -> [Int] {
        guard !array.isEmpty else {
            return []
        }
        
        if numberOfElements >= array.count {
            return array
        }
        
        let priorityQueue = MaxHeap<Int>()
        
        for element in array {
            if priorityQueue.numberOfElements() < numberOfElements {
                priorityQueue.insert(val: element)
            } else {
                if element < (try priorityQueue.peekMax()) {
                    try priorityQueue.extractMax()
                    priorityQueue.insert(val: element)
                }
            }
        }
        
        var minElements: [Int] = []
        while !priorityQueue.isEmpty() {
            try minElements.append(priorityQueue.extractMax())
        }
        
        return minElements.reversed()
    }
    
    //Finds smallest numberOfElements elements and returns them unsorted in O(N log N) time using an adapted quicksort partition method
    open func findMinElementsUnique(numberOfElements: Int, array: [Int]) -> [Int] {
        guard !array.isEmpty else {
            return []
        }
        
        if numberOfElements >= array.count {
            return array
        }
        
        var finalIndex = -1
        var minIndex = 0
        var maxIndex = array.count - 1
        var searchedArray = array
        
        while finalIndex != numberOfElements - 1 {
            finalIndex = partition(array: &searchedArray, min: minIndex, max: maxIndex)
            if finalIndex == numberOfElements - 1 {
                break
            } else if finalIndex < numberOfElements - 1 {
                //go right
                minIndex = finalIndex + 1
            } else {
                //go left
                maxIndex = finalIndex - 1
            }
        }
        
        var minElements: [Int] = []
        var index = 0
        while index < numberOfElements {
            minElements.append(searchedArray[index])
            index += 1
        }
        
        return minElements
    }
    
    private func partition(array: inout [Int], min: Int, max: Int) -> Int {
        let pivot = array[medianOfThree(array: array, min: min, max: max)]
        var left = min
        var right = max
        while left <= right {
            if array[left] > pivot {
                array.swapAt(left, right)
                right -= 1
            } else if array[right] <= pivot {
                array.swapAt(left, right)
                left += 1
            } else {
                left += 1
                right -= 1
            }
        }
        
        return left - 1
    }
    
    private func medianOfThree(array: [Int], min: Int, max: Int) -> Int {
        let middle = min + (max - min) / 2
        
        if array[min] < array[middle] && array[min] > array[max]
            || array[min] > array[middle] && array[min] < array[max] {
            return min
        }
        
        if array[max] < array[middle] && array[max] > array[min]
            || array[max] > array[middle] && array[max] < array[min] {
            return max
        }
        
        return middle
    }
    
    open func findMinElementsNonUnique(numberOfElements: Int, array: [Int]) -> [Int] {
        //1. safety checks:
        guard !array.isEmpty, numberOfElements <= array.count, numberOfElements > 0 else {
            return []
        }
        
        //e.g. min 3 of array: [3, 6, 1, 2, 5, 3]) = [1, 2, 3] (any order)
        
        var minIndex = 0
        var maxIndex = array.count - 1
        //2. choose random pivot + partition
        while minIndex < maxIndex {
            let pivot = medianOfThree(array: array, min: minIndex, max: maxIndex)
            let index = partitionNonUnique(array: &array, min: minIndex, max: maxIndex, pivot: pivot)
        }
        
    }
    
    private func partitionNonUnique(array: inout [Int], min: Int, max: Int, pivot: Int) -> Int {
        var left = min
        var mid = min
        var right = max
        
        //e.g. [3, 6, 1, 2, 5, 3], pivot 5 --> [3, 3, 1, 2, 5, 6] -> return 3 (4 - 1)
        //e.g. [3, 6, 1, 2, 5, 3], pivot 3 --> [3, 3, 1, 2, 5, 6] -> return 3 (4 - 1)
        while right > mid {
            if array[mid] == pivot {
                mid += 1
            } else if array[mid] > pivot {
                array.swapAt(mid, right)
                right -= 1
            } else { //array[mid] < pivot
                array.swapAt(left, mid)
                left += 1
                mid += 1
            }
        }
        
        return mid - 1
    }
}
