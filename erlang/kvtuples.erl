-module(kvtuples).
-export([getval/2]).

head([H | _]) -> H.

getval(Tuples, Key) ->
    head([V || {K, V} <- Tuples, K == Key]).
