#!/bin/bash

# Generate a random number between 1 and 1000
secret_number=$(( RANDOM % 1000 + 1 ))

# Function to handle user input and guessing
guess_number() {
  # Implementation here
}

check_user() {
  username=$1
  if grep -q "^$username:" database.txt 2>/dev/null; then
    games_played=$(grep "^username:" database.txt | cut -d ':' -f
2)    
    best_game=$(grep "^username:" database.txt | cut -d ':' -f 3)
    echo "Welcome back, $username! You have played $games_played games
    , and your best game took $best_game guesses."
    return 0
  else 
    echo "Welcome, $username! It looks like this is your first time here."
    return 1
  fi
}


# Main game logic
echo "Enter your username:"
read username

# Check if username exists in database
# Ensure username is not longer than 22 characters
username="${username:0:22}"

check_user "$username"

echo "Guess the secret number between 1 and 1000:"
guess_number