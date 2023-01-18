#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#Check if there is an existing input argument from terminal
if [[ -z $1 ]] 
then
echo "Please provide an element as an argument."
else 
  #Check if int=ID else=string-Name/symbol. 
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
    #Pull data using ID, Inner join everything since we need all the data -_-
    ELEMENT_DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
  else 
    #Pull data using ID, Inner join everything since we need all the data -_-
    ELEMENT_DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1'  OR name ='$1'")
  fi

  if [[ -z $ELEMENT_DATA ]]
  then 
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT_DATA" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
    do 
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
fi

#new comment