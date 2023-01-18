#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

SELECT_SERVICE() {
  #Check if there is an input to print (Not necessary?)
  if [[ $1 ]]
  then
    echo $1
  fi
  echo "Select the ID of the service you want:"
  SERVICES=$($PSQL "SELECT * FROM services"); 
  echo "$SERVICES" | while IFS='|' read NAME SERVICE_ID
  do 
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
  #Make sure the service exists
  if [[ -z $SERVICE_NAME ]]
  then  #if not
    SELECT_SERVICE "I'm sorry that service ID is not valid"
  #If it does
  else 
    echo -e "\nWhat is your phone number "
    read CUSTOMER_PHONE

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    #CHECK IF CUSTOMER EXISTS IN SQL BASE
    if [[ -z $CUSTOMER_NAME ]] 
    then
      echo -e "\nPlease enter your name:"
      read CUSTOMER_NAME

      INSERT_CUST_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    fi

    echo -e "\nWhat time would you like to come in:"
    read SERVICE_TIME 

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, time, service_id) VALUES('$CUSTOMER_ID','$SERVICE_TIME',$SERVICE_ID_SELECTED)")
    echo "I have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'). at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
    #==============================^ For some reason string has built in space? Don't remember why. Sed command replaces space
  fi
  
}

#Call the function for Service
SELECT_SERVICE