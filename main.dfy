include "mergeSort.dfy"

module Sort {
    import opened MergeSort

    method Main()
    {
        testTenElements();
        testReverseSortedArray();
        testArrayWithDuplicates();
        testEmptyArray();
        testSingleElementArray();
        testTenSortedElements();
        testTenElementsWithNegatives();
    }

    method testTenElements()
    {
        print "Running testTenElements\n";
        var b := new int[10];
        b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], b[9] := 8, 6, 4, 2, 19, 54, 16, 5, 28, 37;
        print "The sorted version of ";
        printArray(b);
        print " is ";
        var sorted := mergeSort(b);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }

    method testReverseSortedArray()
    {
        print "Running testReverseSortedArray\n";
        var h := new int[10];
        h[0] := 18;
        h[1] := 16;
        h[2] := 14;
        h[3] := 12;
        h[4] := 10;
        h[5] := 8;
        h[6] := 6;
        h[7] := 4;
        h[8] := 2;
        h[9] := 0;
        
        print "The sorted version of ";
        printArray(h);
        print "\n";
        var sorted := mergeSort(h);
        assert isSorted(sorted);
    }

    method testArrayWithDuplicates()
    {
        print "Running testArrayWithDuplicates\n";
        var g := new int[6];
        g[0], g[1], g[2], g[3], g[4], g[5] := 3, 1, 1, 3, 1, 2;
        print "The sorted version of ";
        printArray(g);
        print " is ";
        var sorted := mergeSort(g);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }

    method testEmptyArray()
    {
        print "Running testEmptyArray\n";
        var c := new int[0];
        print "The sorted version of ";
        printArray(c);
        print " is ";
        var sorted := mergeSort(c);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }

    method testSingleElementArray()
    {
        print "Running testSingleElementArray\n";
        var d := new int[1];
        d[0] := 8;
        print "The sorted version of ";
        printArray(d);
        print " is ";
        var sorted := mergeSort(d);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }

    method testTenSortedElements()
    {
        print "Running testTenSortedElements\n";
        var e := new int[10];
        e[0], e[1], e[2], e[3], e[4], e[5], e[6], e[7], e[8], e[9] := 0, 1, 2, 3, 4, 5, 6, 7, 8, 9; 
        print "The sorted version of ";
        printArray(e);
        print " is ";
        var sorted := mergeSort(e);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }

    method testTenElementsWithNegatives()
    {
        print "Running testTenElementsWithNegatives\n";
        var f := new int[10];
        f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7], f[8], f[9] := 2, 5, -3, 0, 8, -1, 6, -2, 4, -4; 
        print "The sorted version of ";
        printArray(f);
        print " is ";
        var sorted := mergeSort(f);
        printArray(sorted);
        print "\n";
        assert isSorted(sorted);
    }
    
    method printArray(a: array<int>)
    {
        print "[";
        var i := 0;
        while i < a.Length
        {
            if i > 0 {
                print ", ";
            }
            print a[i];
            i := i + 1;
        }
        print "]";
    }

    predicate isSorted(a: array<int>)
    reads a
    {
    forall i, j :: 0 <= i < j < a.Length ==> a[i] <= a[j]
    }
}
