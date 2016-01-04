-module(twilio_project_01_news).

-export([init/0, stop/1]).

% This script is first executed at server startup and should
% return a list of WatchIDs that should be cancelled in the stop
% function below (stop is executed if the script is ever reloaded).
init() ->
	ssl:start(),
	application:start(inets),
	{ok, WatchId} = boss_news:watch("text_messages",
		fun(created, NewMessage) ->
		boss_mq:push("new-messages", NewMessage)
		end),
	{ok, [WatchId]}.

stop(ListOfWatchIDs) ->
    lists:map(fun boss_news:cancel_watch/1, ListOfWatchIDs).
