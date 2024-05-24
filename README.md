# Formal Verification Documentation

# MergeSort module ("mergeSort.dfy")
### Split Method

#### Purpose
The `split` method divides an array `a` into two subarrays, `left` and `right`, in order to prepare for the merge sort algorithm.

#### Behavior
- It takes an array `a` as input and returns two subarrays, `left` and `right`.
- The method ensures that the lengths of `left` and `right` together equal the length of the original array `a`.
- It guarantees that the lengths of `left` and `right` are both less than the length of `a`.
- The method ensures that the elements of `a` are divided evenly between `left` and `right`.

#### Checking
- Preconditions:
  - `a.Length >= 2`
- Postconditions:
  - `a.Length == left.Length + right.Length`
  - `left.Length < a.Length && right.Length < a.Length`
  - `a[..] == left[..] + right[..]`
- Loop Invariant:
  - `0 <= i <= left.Length`
  - `left[..i] == a[..i]`
  - `right[..(i - left.Length)] == a[left.Length..i]`
- Assertions:
  - The assertions ensure that the postconditions hold true during execution.

### MergeSort Method

#### Purpose
The `mergeSort` method sorts an array `a` using the merge sort algorithm.

#### Behavior
- It takes an array `a` as input and returns the sorted array `c`.
- The method ensures that the multiset of elements in `c` remains the same as the multiset of elements in the original array `a`.
- It guarantees that the resulting array `c` is sorted.
- The length of `c` remains the same as the length of `a`.

#### Checking
- Postconditions:
  - `multiset(a[..]) == multiset(old(a)[..])`: Elements remain the same.
  - `sorted(c)`: The resulting array `c` is sorted.
  - `c.Length == a.Length`: The length remains unchanged.
- Assertions:
  - The assertions validate the postconditions after the sorting operation.

### Merge Method

#### Purpose
The `merge` method combines two sorted arrays `a` and `b` into a single sorted array `c`.

#### Behavior
- It takes two sorted arrays, `a` and `b`, as input and returns the merged array `c`.
- The method ensures that the resulting array `c` contains all elements from arrays `a` and `b`, preserving their multiset property.
- It guarantees that the resulting array `c` is sorted.
- The length of `c` is the sum of the lengths of `a` and `b`.

#### Checking
- Preconditions:
  - `sorted(a)` and `sorted(b)`: Input arrays are sorted.
  - `a.Length >= 1` and `b.Length >= 1`: Both arrays have at least one element.
- Postconditions:
  - `c.Length == a.Length + b.Length`: Length of merged array.
  - `multiset(c[..]) == multiset(a[..]) + multiset(b[..])`: Elements in merged array.
  - `sorted(c)`: The resulting array `c` is sorted.
- Loop Invariant:
  - Loop invariants ensure correctness during array merging.
- Assertions:
  - The assertions validate the preconditions and postconditions during execution.

### Sorted Predicate

#### Purpose
The `sorted` predicate checks if an array is sorted in non-decreasing order.

#### Behavior
- It takes an array `a` as input and returns true if the array is sorted, and false otherwise.

#### Checking
- Reads clause: Ensures the predicate only reads the array `a`.
- Condition:
  - For all indices `j` and `k` where `0 <= j < k < a.Length`, the elements at indices `j` and `k` are in non-decreasing order.
- Assertions:
  - The assertions validate the condition during execution.

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
