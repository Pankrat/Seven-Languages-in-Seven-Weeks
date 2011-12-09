-module(success).
-export([check/1]).

check({error, Message}) ->
    io:fwrite("error: ~s\n", [Message]);
check(success) ->
    io:fwrite("success\n").
