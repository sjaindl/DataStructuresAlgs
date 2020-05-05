import XCTest
@testable import DataStructuresAlgorithms

final class DataStructuresAlgorithmsTests: XCTestCase {

    func testAll() throws {
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
        MinimumSpanningTreeKruskalTests().testMSTKruskal()
        MinimumSpanningTreePrimTests().testMSTPrim()
        PermuationTests().testPermutations()
        QuickSortTests().testQuickSort()
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
        try QueueTests().testQueue()
        RedBlackTreeTests().testRedBlackTree()
        try StackTests().testStack()
        TrieTests().testTrie()
        UnionFindTests().testUnionFind()
    }
}
