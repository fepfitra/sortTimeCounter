#!/bin/bash

NUM_ATTEMPTS=1
OUTPUT_FILE="output.csv"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -r|--attempts)
      NUM_ATTEMPTS="$2"
      shift 2
      ;;
    -o|--output)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

echo "Sorting Algorithm,Array Length,Attempt,Time (microseconds)" > "$OUTPUT_FILE"

SORTS=('bubble' 'selection' 'insertion' 'quick')
ARRLENS=(10000 20000 30000 40000 50000 60000 70000 80000 90000 100000)

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
        echo "$SORT,$ARRLEN,$i,$output" >> "$OUTPUT_FILE"
      done
      echo ""
    done
  else
    echo "Executable '$SORT' not found. Compilation may have failed for $SORT."
  fi
done

