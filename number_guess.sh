#!/bin/bash

# Function to check if input is an integer
is_integer() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

# Random number generation
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Prompt for username
echo "Enter your username:"
read USERNAME

# Validate username length
if [[ ${#USERNAME} -gt 22 ]]; then
  echo "Username must be 22 characters or fewer."
  exit 1
fi

# Check if username exists in the database
if [[ -f "user_data.txt" && $(grep -c "^$USERNAME:" user_data.txt) -gt 0 ]]; then
  USER_DATA=$(grep "^$USERNAME:" user_data.txt)
  GAMES_PLAYED=$(echo $USER_DATA | cut -d ':' -f 2)
  BEST_GAME=$(echo $USER_DATA | cut -d ':' -f 3)
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  GAMES_PLAYED=0
  BEST_GAME=1000
fi

# Start guessing game
echo "Guess the secret number between 1 and 1000:"
GUESSES=0
while true; do
  read GUESS
  ((GUESSES++))
  if ! is_integer "$GUESS"; then
    echo "That is not an integer, guess again:"
  elif (( GUESS < SECRET_NUMBER )); then
    echo "It's higher than that, guess again:"
  elif (( GUESS > SECRET_NUMBER )); then
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  fi
done

# Update user data
((GAMES_PLAYED++))
if (( GUESSES < BEST_GAME )); then
  BEST_GAME=$GUESSES
fi

# Save user data
grep -v "^$USERNAME:" user_data.txt > temp.txt
echo "$USERNAME:$GAMES_PLAYED:$BEST_GAME" >> temp.txt
mv temp.txt user_data.txt

# End of script
