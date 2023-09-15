#!/bin/bash

# Default number of attempts
NUM_ATTEMPTS=1

# Check if a -r option is provided and set NUM_ATTEMPTS accordingly
while [[ $# -gt 0 ]]; do
  case "$1" in
    -r|--attempts)
      NUM_ATTEMPTS="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

SORTS=('bubble' 'selection' 'insertion' 'quick')
ARRLENS=(100 200 400 800)

for SORT in "${SORTS[@]}"
do
  if [ ! -f "$SORT".cpp ]; then
    echo "Source file '$SORT.cpp' not found. Skipping $SORT."
    continue
  fi

  if [ "$1" != "--nocompile" ]; then
    echo "Compiling"
    g++ ./"$SORT".cpp -o "$SORT"
    if [ $? -ne 0 ]; then
      echo "Compilation failed for $SORT."
      continue
    fi
  fi

  if [ -x ./"$SORT" ]; then
    echo $SORT
    for ARRLEN in "${ARRLENS[@]}" 
    do
      echo "Running $SORT $NUM_ATTEMPTS times with array length $ARRLEN"
      for ((i=1; i<=$NUM_ATTEMPTS; i++)); do
        output=$(./"$SORT" $ARRLEN)
        echo "Attempt $i: $output microseconds"
      done
      echo -e "\n"
    done
  else
    echo "Executable '$SORT' not found. Compilation may have failed for $SORT."
  fi
done

