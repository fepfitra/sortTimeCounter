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
      output=$(./"$SORT" $ARRLEN)
      echo "$ARRLEN length array takes time $output microseconds"
    done
  else
    echo "Executable '$SORT' not found. Compilation may have failed for $SORT."
  fi
done
