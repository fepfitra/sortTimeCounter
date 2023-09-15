#include <iostream>
#include <cstdlib>
#include <stdexcept>
#include <chrono>
using namespace std;

void bubbleSort(int arr[], int n) {
  int i, j;
  bool swapped;
  for (i = 0; i < n - 1; i++) {
    swapped = false;
    for (j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        swap(arr[j], arr[j + 1]);
        swapped = true;
      }
    }

    if (swapped == false)
      break;
  }
}

void printArray(int arr[], int size) {
  int i;
  for (i = 0; i < size; i++)
    cout << " " << arr[i];
}

int main(int argc, char *argv[]) {
  bool verbose = false;

  if (argc < 2) {
    cerr << "Usage: " << argv[0] << " <array_length> [-v]" << endl;
    return 1;
  }

  int N;
  try {
    N = stoi(argv[1]);
  } catch (const invalid_argument& ia) {
    cerr << "Invalid argument: " << ia.what() << endl;
    cerr << "The argument must be a valid integer" << endl;
    return 1;
  } catch (const out_of_range& oor) {
    cerr << "Out of range: " << oor.what() << endl;
    return 1;
  }

  if (argc > 2 && string(argv[2]) == "-v") {
    verbose = true;
  }

  int *arr = new int[N]; 

  for (int i = 0; i < N; i++) {
    arr[i] = rand() % 1000; 
  }

  if (verbose) {
    cout << "Not sorted array: \n";
    printArray(arr, N);
  }

  auto start = chrono::high_resolution_clock::now();
  bubbleSort(arr, N);
  auto end = chrono::high_resolution_clock::now();

  if (verbose) {
    cout << "\nSorted array: \n";
    printArray(arr, N);
  }

  delete[] arr; 

  auto duration = chrono::duration_cast<chrono::microseconds>(end - start);

  if (verbose)
    cout << "\nTime taken by bubbleSort function: " << duration.count() << " microseconds" << endl;
  else
    cout << duration.count() << endl;

  return 0;
}

