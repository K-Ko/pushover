#!/bin/bash
##############################################################################
### @author     Knut Kohl <github@knutkohl.de>
### @copyright  2016 Knut Kohl
### @license    MIT License (MIT) http://opensource.org/licenses/MIT
### @version    1.0.0
##############################################################################
pwd=$(dirname $0)

APIURL=https://api.pushover.net/1/messages.json

. $pwd/opt.sh

: ${CURL:=$(which curl)}

[ "$CURL" ] || usage 'ERROR: Missing curl binary' 1

### Script options
opt_help_app  "pushover "$(<$pwd/.version)
opt_help      "Send message to pushover.net, refer to https://pushover.net/api for details"
opt_help_args "<message ...>"
opt_help_hint "Always the system timestamp is used"

opt_define short=c long=config variable=CONFIG desc='Configuration file, see config.conf.dist for details'
opt_define short=u long=user variable=USER desc='User token' required
opt_define short=a long=token variable=TOKEN desc='Application token' required
opt_define short=d long=device variable=DEVICE desc='Device or group [default:all devices]'
opt_define short=t long=title variable=TITLE desc='Message title [default:application name]'
opt_define short=p long=priority variable=PRIORITY desc='Message priority, (-2..2)' default=0
opt_define short=r long=url variable=URL desc='Supplementary URL'
opt_define short=l long=url_title variable=URLTITLE desc='Title for supplementary URL'
opt_define short=s long=sound variable=SOUND desc='Name of one of the sounds'
opt_define short=e long=retry variable=RETRY desc='How often (in seconds) the Pushover servers will send'
opt_define short=x long=expire variable=EXPIRE desc='How many seconds your notification will continue'
opt_define short=b long=callback variable=CALLBACK desc='Publicly-accessible URL for acknowledgement'

. $(opt_build)

MESSAGE=$@

[ -r "$CONFIG" ] && . "$CONFIG"

[ "$USER" ]    || usage 'ERROR: Missing user token' 1
[ "$TOKEN" ]   || usage 'ERROR: Missing application token' 2
[ "$MESSAGE" ] || usage 'ERROR: Missing message' 127

$CURL --silent \
      --form-string user="$USER" \
      --form-string token="$TOKEN" \
      --form-string device="$DEVICE" \
      --form-string title="$TITLE" \
      --form-string message="$MESSAGE" \
      --form-string url="$URL" \
      --form-string url_title="$URLTITLE" \
      --form-string priority=$PRIORITY \
      --form-string sound="$SOUND" \
      --form-string retry="$RETRY" \
      --form-string expire="$EXPIRE" \
      --form-string callback="$CALLBACK" \
      $APIURL
