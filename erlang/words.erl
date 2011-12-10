% Simple word count. Count the number of whitespace characters preceded by
% non-whitespace characters. One could have used string:words instead but
% where is the fun in that.

-module(words).
-export([count/1]).

whitespace($ ) -> 1;
whitespace($\n) -> 1;
whitespace($\t) -> 1;
whitespace(_) -> 0.

count_ws([], Acc) -> Acc;
count_ws([_ | []], Acc) -> Acc;
count_ws([X | [Y | T]], Acc) ->
    Wx = whitespace(X),
    Wy = whitespace(Y),
    if
        Wy - Wx == 1 ->
            EoW = 1;
        true ->
            EoW = 0
    end,
    count_ws([Y | T], Acc+EoW).

not_empty("") -> 0;
not_empty(_) -> 1.

count(Text) -> 
    Stripped = string:strip(Text),
    not_empty(Stripped) + count_ws(Stripped, 0).
