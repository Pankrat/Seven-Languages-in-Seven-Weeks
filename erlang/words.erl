% Simple word count. Count the number of whitespace characters preceded by
% non-whitespace characters. One could have used string:words instead but
% where is the fun in that.

-module(words).
-export([count/1]).

whitespace($ ) -> 1;
whitespace($\n) -> 1;
whitespace($\t) -> 1;
whitespace(_) -> 0.

count_ws([]) -> 0;
count_ws([_ | []]) -> 0;
count_ws([X | [Y | T]]) ->
    Wx = whitespace(X),
    Wy = whitespace(Y),
    if
        Wy - Wx == 1 ->
            1 + count_ws([Y | T]);
        true ->
            count_ws([Y | T])
    end.

not_empty("") -> 0;
not_empty(_) -> 1.

count(Text) -> 
    Stripped = string:strip(Text),
    not_empty(Stripped) + count_ws(Stripped).
