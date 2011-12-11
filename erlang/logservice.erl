-module(logservice).
-behaviour(gen_server).

-export([start/0, log/3]).
-export([init/1, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

start() -> gen_server:start_link(?MODULE, [], []).
log(Pid, Level, Message) -> gen_server:cast(Pid, {Level, Message}).

init([]) -> 
    {ok, File} = file:open("test.log", [append]),
    {ok, File}.

handle_cast({Level, Msg}, File) ->
    {{Y, M, D}, {Hr, Min, Sec}} = calendar:universal_time(),
    {_, _, MicroSec} = now(),
    Ms = MicroSec div 1000,
    Format = "~w-~2.2.0w-~2.2.0w ~2.2.0w:~2.2.0w:~2.2.0w.~3.3.0w [~p]: ~p~n",
    Log = io_lib:format(Format, [Y, M, D, Hr, Min, Sec, Ms, Level, Msg]),
    file:write(File, Log),
    {noreply, File}.

handle_info(Message, File) -> 
    io:format("DEBUG: Unexpected message: ~p~n", [Message]),
    {noreply, File}.

terminate(Reason, File) -> 
    file:close(File),
    io:format("Log file closed. Terminate ~p~n", [Reason]),
    ok.

code_change(_PreviousVersion, File, _Extra) -> 
    {ok, File}.

