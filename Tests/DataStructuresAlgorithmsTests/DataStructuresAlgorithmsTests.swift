import XCTest
@testable import DataStructuresAlgorithms

open class DataStructuresAlgorithmsTests: XCTestCase {

    open func testAll() throws {
        try testMajorDatastructuresAndAlgorithms()
        testStringAndArray()
        try testLinkedList()
        try testStackAndQueue()
        try testTreeAndGraph()
        testBitManipulation()
    }
    
    private func testMajorDatastructuresAndAlgorithms() throws {
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
    }
    
    private func testStringAndArray() {
        UniqueStringSearchTests().testUniqueStringSearch()
        UrlifierTests().testUrlify()
        PalindromePermutationTests().testPalindromePermutations()
        OneAwayCheckerTests().testOneAwayChecker()
        StringCompresserTests().testStringCompresser()
        MatrixRotationTests().testMatrixRightRotation()
        ZeroMatrixTests().testZeroMatrix()
        StringRotationTests().testStringRotation()
    }
    
    private func testLinkedList() throws {
        try DuplicateRemoverTests().testDuplicateRemoval()
        try KToLastTest().testKToLast()
        try DeleteMiddleNodeTest().testDeleteMiddleNode()
        try PartitionLinkedListTests().testPartition()
        try SumListsTests().testReverseSum()
        try SumListsTests().testSumWithPadding()
        try SumListsTests().testSumWithExcessCarry()
        try LoopDetectorTests().testLoopDetector()
    }
    
    private func testStackAndQueue() throws {
        try MultiStackTests().testMultiStack()
        try MinStackTests().testMinStack()
        try AnimalShelterTests().testAnimalShelter()
        try QueueWithStackTests().testQueueWithStacks()
        try StackSetTests().testStackSet()
        try StackSetTests().testStackSet()
    }
    
    private func testTreeAndGraph() throws {
        PathCheckerTests().testPathChecker()
        try MinTreeTests().testMinTree()
        ListOfDepthsTests().testListOfDepths()
        BalancedTreeCheckerTests().testBalancedTree()
        BalancedTreeCheckerTests().testUnbalancedTree()
        ValidateBSTTests().testValidTree()
        ValidateBSTTests().testInvalidTree()
        NodeSuccessorTests().testNodeSuccessorCaseOne()
        NodeSuccessorTests().testNodeSuccessorCaseTwo()
        NodeSuccessorTests().testNodeSuccessorCaseThree()
        FirstCommonAncestorTests().testFirstCommonAncestor()
        BSTSequenceTests().testBSTSequence()
        SubtreeCheckerTests().testSubtreeChecker()
        RandomBinarySearchTreeTests().testRandomBinarySearchTree()
        PathSumTests().testPathSum()
    }
    
    private func testBitManipulation() {
        BitInserterTests().testBitsInsertion()
        BinaryToStringConverterTests().testDoubleConversion()
        BitFlipperTests().testLongestOneBitSequence()
        BinaryNearbySearcherTests().testNearestBinaryNumbers()
    }
}
