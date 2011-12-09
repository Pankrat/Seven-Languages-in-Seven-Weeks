-module(count).
-export([count/2]).

count(X, Y) when X =< Y ->
    io:fwrite("Count ~w (to ~w)\n", [X, Y]),
    count(X+1, Y);
count(_, _) ->
    io:fwrite("Counting's over. You can go home now.\n").
