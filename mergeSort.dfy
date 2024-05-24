
module MergeSort {


method split(a: array<int>) returns (left: array<int>, right: array<int>) 
    requires a.Length >= 2
    ensures a.Length == left.Length + right.Length
    ensures left.Length < a.Length && right.Length < a.Length
    ensures a[..] ==  left[..] + right[..]
{
    if a.Length % 2 == 0 {
        left := new int[a.Length/2];
        right := new int[a.Length/2];
    } else {
        left := new int[a.Length/2];
        right := new int[a.Length/2 + 1];
    }

    var i := 0;
    while i < left.Length
        decreases left.Length - i
        invariant 0 <= i <= left.Length
        invariant left[..i] == a[..i]
    {
        left[i] := a[i];
        i := i + 1;
    }

    while i - left.Length < right.Length 
        decreases right.Length - (i - left.Length)
        invariant 0 <= i <= a.Length
        invariant left[..] == a[..left.Length]
        invariant right[..(i - left.Length)] == a[left.Length..i]
    {
        right[i-left.Length] := a[i];
        i := i + 1;
    }

    assert left[..] == a[..left.Length];
    assert right[..] == a[left.Length..];
}


method mergeSort(a: array<int>) returns (c: array<int>)
    decreases a.Length - 1
    ensures multiset(a[..]) ==  multiset(old(a)[..])
    ensures sorted(c)
    ensures c.Length == a.Length
{ 
    if a.Length > 1 {
        var left, right := split(a); 
        assert left.Length >= 1 && right.Length >= 1;
        var left_res := mergeSort(left);
        var right_res := mergeSort(right);
        c := merge(left_res, right_res);
    } else {
        c := a;
    }
}


method merge(a: array<int>, b: array<int>) returns (c: array<int>)
    requires sorted(a) && sorted(b)
    requires a.Length >= 1 && b.Length >= 1
    ensures c.Length == a.Length + b.Length
    ensures multiset(c[..]) ==  multiset(a[..]) + multiset(b[..])
    ensures sorted(c)
{ 
    c := new int[a.Length + b.Length];


    var i := 0;
    var a_head, b_head := 0, 0;
    while a_head < a.Length && b_head < b.Length 
        decreases c.Length - a_head - b_head
        invariant sorted(a) && sorted(b)
        invariant 0 <= i < c.Length
        invariant 0 <= a_head <= a.Length
        invariant 0 <= b_head <= b.Length
        invariant i == a_head + b_head

        invariant forall r :: 0 <= r < i ==> ( a_head < a.Length ==> c[r] <= a[a_head]);
        invariant forall r :: 0 <= r < i ==> (b_head < b.Length ==> c[r] <= b[b_head]);
        invariant multiset(c[..i]) ==  multiset(a[..a_head]) + multiset(b[..b_head])
        invariant forall j, k :: 0 <= j < k < i ==> c[j] <= c[k]
    {
        if a[a_head] < b[b_head] {
            c[i] := a[a_head];
            a_head := a_head + 1;
        } else {
            c[i] := b[b_head];
            b_head := b_head + 1;
        }
        i := i + 1;
        assert multiset(c[..i]) ==  multiset(a[..a_head]) + multiset(b[..b_head]);
    }

    while a_head < a.Length 
        decreases a.Length - a_head
        invariant sorted(a) && sorted(b)
        invariant a_head <= a.Length
        invariant i == a_head + b_head
        invariant a.Length - a_head > 0 ==>  a.Length - a_head == c.Length - i
        invariant multiset(c[..i]) == multiset(a[..a_head]) + multiset(b[..b_head])
        invariant forall r :: 0 <= r < i && a_head < a.Length ==> a[a_head] >= c[r]
        invariant forall r :: 0 <= r < i ==> (b_head < b.Length ==> b[b_head] >= c[r])
        invariant forall j, k :: 0 <= j < k < i ==> c[j] <= c[k]
    {
        c[i] := a[a_head];
        a_head := a_head + 1;
        i := i + 1;
    }
    assert a[..a.Length] == a[..] && b[..b.Length] == b[..];

    while b_head < b.Length 
        decreases b.Length - b_head
        invariant sorted(a) && sorted(b)
        invariant 0 <= a_head == a.Length
        invariant 0 <= b_head <= b.Length
        invariant i == a_head + b_head
        invariant b.Length - b_head > 0 ==> b.Length - b_head == c.Length - i
        invariant multiset(c[..i]) == multiset(a[..]) + multiset(b[..b_head]);
        invariant forall r :: 0 <= r < i ==> (b_head < b.Length ==> b[b_head] >= c[r])
        invariant forall j, k :: 0 <= j < k < i ==> c[j] <= c[k]
    {
        assert multiset(c[..i]) == multiset(a[..]) + multiset(b[..b_head]);
        c[i] := b[b_head];
        assert multiset(c[..i+1]) == multiset(a[..]) + multiset(b[..b_head+1]);
        b_head := b_head + 1;
        i := i + 1;
    }
    assert b_head == b.Length;
    assert c[..c.Length] == c[..];
    assert multiset(c[..]) ==  multiset(a[..]) + multiset(b[..]);
}

predicate sorted(a: array<int>)
   reads a
{
   forall j, k :: 0 <= j < k < a.Length ==> a[j] <= a[k]
}

}