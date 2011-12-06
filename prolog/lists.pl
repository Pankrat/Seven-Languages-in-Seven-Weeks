slow_rev([], []).
slow_rev([Head|Tail], Rev) :- slow_rev(Tail, RevTail), append(RevTail, [Head], Rev).

fast_rev([Head|Tail], Acc, Rev) :- fast_rev(Tail, [Head|Acc], Rev).
fast_rev([], Rev, Rev).
fast_rev(List, Rev) :- fast_rev(List, [], Rev).

min(X, [X]).
min(X, [Head|Tail]) :- min(X, Tail), X =< Head.
min(Head, [Head|Tail]) :- min(X, Tail), Head < X.

min_sort(L, A, Sorted) :- min(Min, L), select(Min, L, Lm), min_sort(Lm, [Min|A], Sorted).
min_sort([], A, Sorted) :- fast_rev(A, Sorted).
