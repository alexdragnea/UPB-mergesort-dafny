# Formal Verification Documentation
## Introduction

In this project, the corectness of mergeSort implementation is tested using formal verification in Dafny.

**Merge sort** is a sorting algorithm that follows the divide-and-conquer approach. It works by recursively dividing the input array into smaller subarrays and sorting those subarrays then merging them back together to obtain the sorted array.


## Formal Verification Techniques used
- **Preconditions**: Specify conditions that must be true before a function or method is executed. (e.g requires)
- **Postconditions**: Define conditions that must hold true after a function or method has executed. (e.g ensures)
- **Loop Invariants**: Assertions that hold true before and after each iteration of a loop.
- **Assertions**: Statements that validate specific conditions or properties during program execution.

# MergeSort module ("mergeSort.dfy")
## Method `split`

- **Purpose:** Splits an array into two subarrays.
- **Signature:** `method split(a: array<int>) returns (left: array<int>, right: array<int>)`
- **Preconditions:** 
  - `a.Length >= 2`: Ensures the array has at least two elements for splitting.
- **Postconditions:** 
  - `a.Length == left.Length + right.Length`: Guarantees that the lengths of the left and right subarrays sum up to the original array's length.
  - `left.Length < a.Length && right.Length < a.Length`: Ensures both subarrays are smaller than the original array.
  - `a[..] ==  left[..] + right[..]`: Verifies that concatenating the left and right subarrays reproduces the original array.
- **Loop Invariant:** 
  - `0 <= i <= left.Length`: Ensures the index `i` remains within the bounds of the left array during splitting.
  - `left[..i] == a[..i]`: Verifies that elements copied to the left array correspond accurately to the original array `a`.
  - `right[..(i - left.Length)] == a[left.Length..i]`: Ensures elements copied to the right array match the portion of the original array intended for the right side.

## Method `mergeSort`

- **Purpose:** Sorts an array using the MergeSort algorithm.
- **Signature:** `method mergeSort(a: array<int>) returns (c: array<int>)`
- **Formal Verification:**
  - **Postconditions:** 
    - `multiset(a[..]) ==  multiset(old(a)[..])`: Ensures the original array remains unchanged.
    - `sorted(c)`: Confirms that the result array is sorted.
    - `c.Length == a.Length`: Guarantees that the length of the result array is the same as the original array.

## Method `merge`

- **Purpose:** Merges two sorted arrays into a single sorted array.
- **Signature:** `method merge(a: array<int>, b: array<int>) returns (c: array<int>)`
- **Preconditions:** 
  - `sorted(a) && sorted(b)`: Requires both input arrays to be sorted.
  - `a.Length >= 1 && b.Length >= 1`: Ensures both input arrays have at least one element.
- **Postconditions:** 
  - `c.Length == a.Length + b.Length`: Guarantees that the length of the merged array is the sum of the lengths of the input arrays.
  - `multiset(c[..]) ==  multiset(a[..]) + multiset(b[..])`: Verifies that the merged array contains all elements from both input arrays.
  - `sorted(c)`: Confirms that the merged array is sorted.
- **Formal Verification:**
  - **Assertions:** 
    - `multiset(c[..i]) ==  multiset(a[..a_head]) + multiset(b[..b_head])`: Verifies the correctness of the merge operation.
    - `a[..a.Length] == a[..] && b[..b.Length] == b[..]`: Ensures input arrays `a` and `b` remain unchanged.
    - `multiset(c[..]) ==  multiset(a[..]) + multiset(b[..])`: Confirms the integrity of the merged array.
    - `b_head == b.Length`: Validates that all elements from array `b` are merged.
    - `c[..c.Length] == c[..]`: Asserts that the merged array remains unchanged after the merge operation.

## Predicate `sorted`

- **Purpose:** Checks if an array is sorted in non-decreasing order.
- **Signature:** `predicate sorted(a: array<int>)`
- **Behavior:** Returns true if all elements in the array are in non-decreasing order, otherwise returns false.

# Sort Module ("main.dfy")

## Purpose
The Sort module contains test cases to validate the MergeSort algorithm implemented in the MergeSort module.

## Main Method
The `Main` method serves as the entry point for running the test cases. It calls various test methods to validate different scenarios of the MergeSort algorithm.

## Test Methods
- **testTenElements**: Tests sorting an array with ten elements.
- **testReverseSortedArray**: Tests sorting a reverse-sorted array.
- **testArrayWithDuplicates**: Tests sorting an array with duplicate elements.
- **testEmptyArray**: Tests sorting an empty array.
- **testSingleElementArray**: Tests sorting an array with a single element.
- **testTenSortedElements**: Tests sorting an already sorted array.
- **testTenElementsWithNegatives**: Tests sorting an array with negative elements.

## Print Array Method
The `printArray` method is a helper method used to print the contents of an array.

## isSorted Predicate
The `isSorted` predicate checks if an array is sorted in non-decreasing order.

## Assertions
Assertions are used in each test method to ensure that the sorted array satisfies the required sortedness property.
m.
