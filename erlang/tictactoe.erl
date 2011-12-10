-module(tictactoe).
-export([winner/1, prio/2]).

% Check combo (e.g. one row)
cmp(e, _, _) -> no_winner;
cmp(_, e, _) -> no_winner;
cmp(_, _, e) -> no_winner;
cmp(X, X, X) -> X;
cmp(_, _, _) -> cat.

% Sort the result list: x/o < no_winner < cat.
prio(x, _) -> true;
prio(o, _) -> true;
prio(no_winner, cat) -> true;
prio(_, _) -> false.

% Check each potential winner combination, sort the results by priority and
% return the first result.
winner(L) when length(L) == 9 ->
    {A1, A2, A3, B1, B2, B3, C1, C2, C3} = list_to_tuple(L),
    W = [cmp(A1, A2, A3), 
         cmp(B1, B2, B3), 
         cmp(C1, C2, C3), 
         cmp(A1, B1, C1), 
         cmp(A2, B2, C2), 
         cmp(A3, B3, C3), 
         cmp(A1, B2, C3), 
         cmp(A3, B2, C1)],
    [Winner | _] = lists:sort(fun tictactoe:prio/2, W),
    Winner.
