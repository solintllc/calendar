#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# import the configuration variables
source "${SCRIPT_DIR}/my.config"

# check the variables are set
for variable in my_client_id calendar_id my_token
do
   if [[ "${!variable}" == "YOUR VALUE HERE" ]]
   then
      echo "ERROR: ${variable} not set in config file. See README.md" >&2
      exit 1
   fi
done


get_authorization_token() {
# lanuch a browswer to get the authorization token

   local request=''
      request+='https://accounts.google.com/o/oauth2/v2/auth?'
      request+='scope=https%3A//www.googleapis.com/auth/calendar&'
      request+='include_granted_scopes=true&'
      request+='response_type=token&'
      request+='redirect_uri=https%3A//developers.google.com/oauthplayground&'
      request+="client_id=${my_client_id}"

    open ${request}
}

list_calendars() {
# print a list of calendars to the screen
   curl --request GET \
     'https://www.googleapis.com/calendar/v3/users/me/calendarList?client_id='${my_client_id} \
     --header 'Authorization: Bearer '${my_token} \
     --header 'Accept: application/json' \
     --compressed
}

list_events_in_range() {
# print a list of events on the specified calendar that are within a date range

   local start_date_exclusive=$1 # YYYY-MM-DD
   local end_date_exclusive=$2   # YYYY-MM-DD

   curl --request GET \
     'https://www.googleapis.com/calendar/v3/calendars/'${calendar_id}'/events' \
     --header 'Authorization: Bearer '${my_token} \
     --header 'Accept: application/json' \
     --header 'Content-Type: application/json' \
     --data '{"timeMin": "'${start_date_exclusive}'", "timeMax": "'${end_date_exclusive}'"}' \
     --compressed
}

add_timed_entry(){
# add an entry to the calendar that has a duration
   local day=$1 # YYYY-MM-DD
   local start_time=$2
   local end_time=$3
   local summary="$4"

   add_entry '{"end":{"dateTime":"'${day}'T'${end_time}':00:00'${time_zone_numeric}'"},"start":{"dateTime":"'${day}'T'${start_time}':00:00'${time_zone_numeric}'"}, "summary":"'"${summary}"'"}'
}


add_all_day_entry(){
# add an entry to the calendar that is an all day event

   local day=$1 # YYYY-MM-DD
   local summary="$2"

   add_entry '{"end":{"date":"'${day}'", "timeZone": "'${time_zone}'"},"start":{"date":"'${day}'", "timeZone": "'${time_zone}'"}, "summary":"'"${summary}"'"}'
}

add_entry() {
# helper function that actually adds entries to the calendar
   local data=$1

   curl --request POST \
     'https://www.googleapis.com/calendar/v3/calendars/'${calendar_id}'/events?client_id='${my_client_id} \
     --header 'Authorization: Bearer '${my_token} \
     --header 'Accept: application/json' \
     --header 'Content-Type: application/json' \
     --data "${data}" \
     --compressed
}

add_new_entries(){
# edit this function as needed to
}




main() {
   # get_authorization_token
   # add_timed_entry '2021-11-27' '20' '21' "run 5"
   # list_calendars
   # list_events_in_range '2021-11-27' '2022-01-01'
   # add_new_entries
}

main
