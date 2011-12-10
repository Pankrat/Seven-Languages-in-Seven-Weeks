-module(translator).
-behaviour(gen_server).

-export([start/0, translate/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

start() -> gen_server:start_link(?MODULE, [], []).
translate(Pid, Phrase) -> gen_server:call(Pid, {translate, Phrase}).

init([]) -> 
    State = [],
    {ok, State}.

handle_call({translate, Phrase}, From, State) ->
    io:format("DEBUG: Server call from ~p: Translate ~s~n", [From, Phrase]),
    Translation = case Phrase of
        "blanca" -> "white";
        "casa" -> "house";
        _ -> "no entiendo"
    end,
    {reply, Translation, State}.

handle_cast(Message, _State) -> 
    io:format("DEBUG: handle_cast: ~p~n", [Message]),
    {noreply, _State}.
handle_info(Message, State) -> 
    io:format("DEBUG: Unexpected message: ~p~n", [Message]),
    {noreply, State}.
terminate(Reason, _State) -> 
    io:format("Terminate ~p~n", [Reason]),
    ok.
code_change(_PreviousVersion, State, _Extra) -> 
    {ok, State}.

