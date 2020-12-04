import XCTest
@testable import DataStructuresAlgorithms

open class DataStructuresAlgorithmsTests: XCTestCase {
    
    open func testAll() throws {
        try testSynchronous()
        testThreading()
    }
    
    open func testSynchronous() throws {
        try testMajorDatastructuresAndAlgorithms()
        try testStringAndArray()
        try testLinkedList()
        try testStackAndQueue()
        try testTreeAndGraph()
        testBitManipulation()
        try testRecursionAndDynamicProgramming()
        testSortingAndSearching()
        try testOtherAlgorithms()
    }
    
    open func testMajorDatastructuresAndAlgorithms() throws {
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
        LRUCacheTests().testCache()
    }
    
    open func testStringAndArray() throws {
        UniqueStringSearchTests().testUniqueStringSearch()
        UrlifierTests().testUrlify()
        PalindromePermutationTests().testPalindromePermutations()
        OneAwayCheckerTests().testOneAwayChecker()
        StringCompresserTests().testStringCompresser()
        MatrixRotationTests().testMatrixRightRotation()
        ZeroMatrixTests().testZeroMatrix()
        StringRotationTests().testStringRotation()
        CircularArrayTests().testCircularArray()
        WordFrequencyCounterTests().testCounts()
        SmallestDifferenceTests().testSmallestDifference()
        try IntToEnglishStringTests().testEnglishString()
        try XMLEncoderTests().testXMLEncoding()
        PatternMatcherTests().testPatterns()
        try T9KeyboardTests().testT9Keyboard()
        SumSwapperTests().testSumSwapper()
        ArrayPairsWithSumTests().testPairs()
    }
    
    open func testLinkedList() throws {
        try DuplicateRemoverTests().testDuplicateRemoval()
        try KToLastTest().testKToLast()
        try DeleteMiddleNodeTest().testDeleteMiddleNode()
        try PartitionLinkedListTests().testPartition()
        try SumListsTests().testReverseSum()
        try SumListsTests().testSumWithPadding()
        try SumListsTests().testSumWithExcessCarry()
        try LoopDetectorTests().testLoopDetector()
    }
    
    open func testStackAndQueue() throws {
        try MultiStackTests().testMultiStack()
        try MinStackTests().testMinStack()
        try AnimalShelterTests().testAnimalShelter()
        try QueueWithStackTests().testQueueWithStacks()
        try StackSetTests().testStackSet()
        try StackSetTests().testStackSet()
        try CalculatorTests().testCalculator()
    }
    
    open func testTreeAndGraph() throws {
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
    
    open func testBitManipulation() {
        BitInserterTests().testBitsInsertion()
        BinaryToStringConverterTests().testDoubleConversion()
        BitFlipperTests().testLongestOneBitSequence()
        BinaryNearbySearcherTests().testNearestBinaryNumbers()
        BinaryNumberConverterTests().testBinaryNumberConverter()
        PairwiseSwapTests().testSwap()
        ScreenManipulatorTests().testDrawLine()
        NumberSwapperTests().testSwap()
        NumberMaxTests().testMaxNumber()
        OperationsTests().testOperations()
        AdderTests().testAddWithoutPlus()
    }
    
    open func testRecursionAndDynamicProgramming() throws {
        TripleStepTests().testTripleSteps()
        GridPathFinderTests().testGridPathFinder()
        PowerSetTests().testPowerSetPermutations()
        PowerSetTests().testPowerSetCombinations()
        PowerSetTests().testPowerSetCombinationsByBitmasking()
        MultiplyTests().testMultiply()
        try TowerOfHanoiTests().testTowersOfHanoi()
        PermutationsTests().testPermutationsWithoutDuplicates()
        ParensBuilderTests().testParens()
        try PaintFillTests().testPaintFill()
        CoinCounterTests().testCoinCounter()
        QueensOnChessboardTests().testQueensArrangements()
        StackOfBoxesTests().testStackOfBoxes()
        try BoolEvaluationTests().testEvaluation()
        FactorialZeroesTests().testTrailingZeroCount()
        DivingBoardTests().testDivingBoard()
        DivingBoardTests().testDivingBoardFast()
        PondSizesTests().testPatterns()
    }
    
    open func testSortingAndSearching() {
        SortedMergeTests().testSortedMerge()
        AnagramGrouperTests().testAnagramGrouper()
        RotatedArraySearchTests().testRotatedArraySearch()
        ListyTests().testListy()
        SparseSearchTests().testSparseSearch()
        DuplicateFinderTests().testFindDuplicates()
        SortedMatrixSearchTests().testSortedMatrixSearch()
        SortedMatrixSearchTests().testSortedMatrixSearchFaster()
        StreamRankTests().testStreamRank()
        PeakSortTests().testPeakSort()
        IntersectionFinderTests().testIntersection()
        LivingPeopleTests().testLivingPeople()
        BestLineSearcherTests().testBestLineSearcher()
        SubSorterTests().testShortestSubsortSequence()
        ContiguousSumTests().testLargestContiguousSum()
    }
    
    open func testThreading() {
        DiningPhilosophersTests().testDiningPhilosophers()
        DeadlockPreventingLockTests().testDeadlockPreventingLock()
        FizzBuzzTests().testFizzBuzz()
    }
    
    open func testOtherAlgorithms() throws {
        SquareConnectorTests().testSquareConnector()
        try MasterMindCheckerTests().testMasterMindChecker()
        LangthonsCellTests().testLangthons()
        Rand7Tests().testRand7()
        DeckShufflerTests().testShuffle()
    }
}
