#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_FUNCTION() {
  if [[ -z "$1" ]]
  then
    echo "Please provide an element as an argument."
  else
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      if [[ ${#1} -gt 2 ]]
      then
        ELEMENT_RESULT=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$1'")
        if [[ -z "$ELEMENT_RESULT" ]]
        then
          echo "I could not find that element in the database."
        else
          echo "$ELEMENT_RESULT" | while IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        fi
      else
        ELEMENT_RESULT=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol='$1'")
        if [[ -z "$ELEMENT_RESULT" ]]
        then
          echo "I could not find that element in the database."
        else
          echo "$ELEMENT_RESULT" | while IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        fi
      fi
    else
        ELEMENT_RESULT=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number='$1'")
        if [[ -z "$ELEMENT_RESULT" ]]
        then
          echo "I could not find that element in the database."
        else
          echo "$ELEMENT_RESULT" | while IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        fi
    fi
  fi
}

MAIN_FUNCTION "$1"