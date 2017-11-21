#!/bin/bash

USER_SUBJECT="Your account is expiring soon"
ROOT_SUBJECT="An account is expiring soon"

SECONDS_IN_DAY=86400
SECONDS_IN_MONTH=2628000

USERS=(`cat /etc/shadow | cut -d: -f1,8 | sed /:$/d`)  

for USER in "${USERS[@]}"
do
  USER_NAME=`echo ${USER} | awk -F: '{print $1}'`
  EXPR_DATE=`echo ${USER} | awk -F: '{print $2}'`

  #
  # The /etc/shadow file stores account expiration as "days since epoch the
  # account has been disabled" so convert days to seconds.
  #
  EXPR_DATE_UNIX=$(($EXPR_DATE*$SECONDS_IN_DAY))
  #
  # Get the current date in UNIX timestamp format.
  #
  CURRENT_DATE=`date +%s`
  #
  # Subtract the current date from the expiration date to get
  # seconds until expiration.
  #
  SECS_TO_EXPR=$((EXPR_DATE_UNIX-CURRENT_DATE))

  #
  # If the time to expiration is less than a month, and hasn't
  # actually expired yet (i.e. > 0), send notification emails.
  #
  if [ "$SECS_TO_EXPR" -lt "$SECONDS_IN_MONTH" ] && [ "$SECS_TO_EXPR" -gt 0 ]
  then
    EXPR_DAYS=$((SECS_TO_EXPR/SECONDS_IN_DAY))

    USER_ADDRESS="${USER_NAME}@localhost"
    ROOT_ADDRESS="root@localhost"

    USER_BODY="In compliance with Harvard Security Level 5, your account will be expiring in ${EXPR_DAYS} days. Please see an EdLabs administrator to extend your account for another year."
    ROOT_BODY="In complaince with Harvard Security Level 5, the account ${USER_NAME} will expire in ${EXPR_DAYS} days. If the account should be renewed, please consult your documentation for extending the account."

    # Send mail to the user
    echo ${USER_BODY} | mail -s "${USER_SUBJECT}" ${USER_ADDRESS}
    # Send mail to root (i.e. EdLabs Admin)
    echo ${ROOT_BODY} | mail -s "${ROOT_SUBJECT}" ${ROOT_ADDRESS}
  fi
done