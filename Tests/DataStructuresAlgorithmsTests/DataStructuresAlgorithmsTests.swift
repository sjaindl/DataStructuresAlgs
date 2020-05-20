import XCTest
@testable import DataStructuresAlgorithms

open class DataStructuresAlgorithmsTests: XCTestCase {

    open func testAll() throws {
        BellmanFordTests().testBellmanFord()
        BipartiteGraphCheckerTests().testBipartiteGraph()
        try DjikstraTests().testDjikstra()
        try FloydWarshallTests().testFloydWarshall()
        GraphSearchTests().testBFS()
        GraphSearchTests().testDFS()
        GraphSearchTests().testDFSIterative()
        KnapsackTests().testKnapsack()
        MapReduceTests().testMapReduceMock()
        MergeSortTests().testMergeSort()
        MergeSortTests().testLargeArrayWithUniqueItems()
        MergeSortTests().testSmallArrayWithUniqueItems()
        MinimumSpanningTreeKruskalTests().testMSTKruskalQuickSort()
        MinimumSpanningTreeKruskalTests().testMSTKruskalHeap()
        MinimumSpanningTreePrimTests().testMSTPrim()
        PermuationTests().testPermutations()
        QuickSortTests().testQuickSort()
        QuickSortTests().testLargeArrayWithUniqueItems()
        QuickSortTests().testSmallArrayWithUniqueItems()
        RabinKarpSubstringSearchTests().testRabinKarp()
        try TopologicalSortTests().testTopologicalSort()
        TravelingSalesmanTests().testTravelingSalesman()
        UniqueStringSearchTests().testUniqueStringSearch()
        try AVLTreeTests().testAVLTree()
        BitVectorTests().testBitVector()
        try BTreeTests().testBTree()
        HashTableTests().testHashTable()
        try IndexedMinPriorityQueueTests().testIndexedMinPriorityQueue()
        try IntervalTreeTests().testIntervalTree()
        LinkedListTests().testLinkedList()
        try MinHeapTests().testMinHeap()
        try MinHeapTests().testMinHeapEqualValues()
        try QueueTests().testQueue()
        RedBlackTreeTests().testRedBlackTree()
        try StackTests().testStack()
        TrieTests().testTrie()
        UnionFindTests().testUnionFind()
        StringPermutationCheckerTests().testStringPermutations()
        UniqueStringSearchTests().testUniqueStringSearch()
        UrlifierTests().testUrlify()
        PalindromePermutationTests().testPalindromePermutations()
        OneAwayCheckerTests().testOneAwayChecker()
        StringCompresserTests().testStringCompresser()
        MatrixRotationTests().testMatrixRightRotation()
        ZeroMatrixTests().testZeroMatrix()
        StringRotationTests().testStringRotation()
    }
}
