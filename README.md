# Create Google Calendar Entry

create_google_calendar_entry.sh is a bash script to manipulate a calendar hosted in Google. It isn't full polished. Basically, you just modify the script's main function to make the script do what you need. So when the instructions below say to run something, they mean to modify create_google_calendar_entry.sh's main function, save, and execute the script.

## Tested with
- Mac M2
- Bash 5.x installed from brew.

## Pre-requisites

You need to set several variables in the config file. To get the values, you need to monkey with Google.

### Set my_client_d

0. Set up a Google Cloud project.
  0. I did this awhile ago and forgot how. Maybe the [references](#references) will help.
  1. Start by going to [https://cloud.google.com].
  2. Hamburger -> APIs & Services -> Credentials
1. With the project setup, create an OAuth 2.0 Client ID in the project.
2. For the Authorized Redirect URL, you can put `https://developers.google.com/oauthplayground`.
3. Drill into the details for the Client ID. It will probably end in something like `ppuc.apps.googleusercontent.com`.
4. Set that value in the file `my.config` in this repo.

### Set calendar_id

0. Get your Google calendar_id. See https://www.sociablekit.com/get-find-google-calendar-id/ or google how. It will probably end with '@group.calendar.google.com'
1. Set that value in the file `my.config` as calendar_id in this repo.

### Set my_token

0. Open a web browser and log in to the gmail account with the calendar you want.
1. run get_authorization_token
2. It should open a page in your browswer.
3. Find the response on that page and strip out the authorization token. It will 165 some odd characters long.
4. Paste that as the value for my_token in `my.config`.
5. Run list_calendars to verify the creds work

# Set time_zone and time_zone_numeric

0. Set it to whatever you want. For a list of valid values...I don't know. Search the web? Sorry that there are two versions.
1. Set it in `my.config`.

## Adding entries

Update the script to specify all the entries you want to add 'add_new_entries'.

For example, if you want to add an all day calendar entry on November 27, 2021 that says 'Hello World', then:

```
 add_new_entries(){
    add_all_day_entry '2021-11-27' 'Hello World'
}
```

If you want to add the same entry, but from 8pm to 9pm:
```
 add_new_entries(){
    add_timed_entry '2021-11-27' '20' '21' 'Hello World'
}
```

## References
see:
- https://developers.google.com/calendar/api/v3/reference/events
- https://console.cloud.google.com/apis/credentials?project=running-295721
