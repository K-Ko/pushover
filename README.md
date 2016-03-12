# pushover
Shell script wrapper for [Pushover API](https://pushover.net/api)

Supports all parameters of API

    $ ./pushover.sh -h

    Send message to pushover.net, refer to https://pushover.net/api for details

    usage: ./pushover.sh (-u|--user) <user> (-a|--token) <token> [options] <message ...>

    options:
        -u, --user               User token (required)
        -a, --token              Application token (required)
        -d, --device             Device or group [default:all devices]
        -t, --title              Message title [default:application name]
        -r, --url                Supplementary URL
        -l, --url_title          Title for supplementary URL
        -p, --priority           Message priority, (-2..2) [default:0]
        -s, --sound              Name of one of the sounds [default:pushover]
        -h, --help               This usage help

    Always the system timestamp is used

Your own scripts starting with `cron` will be irgored by git.
