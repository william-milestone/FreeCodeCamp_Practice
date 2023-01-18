#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=ng -t --no-align -c"
NUMBER=$(($RANDOM % 1000))

echo $NUMBER
#FOR SOME REASON: this code keeps putting random users in my sql base, I have no idea why. 
#All tasks are passed but for some reason, it keeps adding usernames "user_###########". 
echo "Enter your username:"
read USERNAME


GUESS_MADE() {
  read GUESS
  if [[ $1 ]] 
  then
  RUNNING_COUNT=$1
  else
  RUNNING_COUNT=0
  fi
  #increment the running count of made guesses
  RUNNING_COUNT=$(( $1 + 1 ))

  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:\n"
  fi
  #Guess too low
  if [[ $GUESS -lt $NUMBER ]]
  then 
    echo "It's higher than that, guess again:"
    GUESS_MADE $RUNNING_COUNT
  #Guess too high
  elif [[ $GUESS -gt $NUMBER ]]
  then 
    echo "It's lower than that, guess again:"
    GUESS_MADE $RUNNING_COUNT
  elif [[ $GUESS = $NUMBER ]]
  then
    echo "You guessed it in $RUNNING_COUNT tries. The secret number was $NUMBER. Nice job!"
    UPDATEGP=$($PSQL "UPDATE users SET games_played =$(($GAMES_PLAYED+1)) WHERE username='$USERNAME'")
    if [[ $RUNNING_COUNT < $BEST_GAME || $BEST_GAME = 0 ]]
    then
      UPDATEBG=$($PSQL "UPDATE users SET best_game='$RUNNING_COUNT' where username='$USERNAME'")
    fi
  fi
}

USERQUERY=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
#update users 
if [[ -z $USERQUERY ]]
then
  INSERTUSER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  #default values for games played and best game set in database default to 0 so no need for explicit definition 
  #per tasks
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
  #per tasks
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
#per tasks
echo "Guess the secret number between 1 and 1000:"


GUESS_MADE 0