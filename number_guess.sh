#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=ng -t --no-align -c"
NUMBER=$(($RANDOM % 1000))

echo $NUMBER

echo "Enter your username:"
read USERNAME

USERQUERY=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USERQUERY ]]
then
  INSERTUSER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  GAMES_PLAYED=0
  BEST_GAME=0
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"

GUESS_MADE() {
  read GUESS

  RUNNING_COUNT=$(( $1 + 1 ))

  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:\n"
  fi

  if [[ $GUESS -lt $NUMBER ]]
  then 
    echo "It's higher than that, guess again:"
    GUESS_MADE $RUNNING_COUNT
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


GUESS_MADE 0