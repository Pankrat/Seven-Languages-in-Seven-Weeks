-module(cart).
-export([compute/1]).

compute(Items) ->
    [{Item, Price * Quantity} || {Item, Quantity, Price} <- Items].
