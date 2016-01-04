-module(twilio).
-export([create_message/2]).

create_message(To, Body) ->
  {ok, AccountSid} = application:get_env(twilio_project, account_sid),
  {ok, From} = application:get_env(twilio_project, phone_number),
  {ok, AuthToken} = application:get_env(twilio_project, auth_token),

  httpc:request(post, 
    {"https://api.twilio.com/2010-04-01/Accounts/" ++ AccountSid ++ "/Messages.json",
      [{"Authorization", "Basic " ++ base64:encode_to_string(AccountSid ++ ":" ++ AuthToken)}],
      "application/x-www-form-urlencoded", "Body=" ++ Body ++ "&To=" ++ To ++ "&From="++ From
    }, [], []).
