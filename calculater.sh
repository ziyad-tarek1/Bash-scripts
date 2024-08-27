#!/bin/bash

# This script prompts the user to enter a mathematical expression,
# evaluates it using bc, and then displays the result.

# Prompt the user to enter a mathematical expression
echo "Enter a mathematical expression:"
read expression

# Evaluate the expression using bc
# 'scale=2' sets the number of decimal places to 2 for the result
result=$(echo "$expression" | bc)

# Display the result
echo "Result: $result"

