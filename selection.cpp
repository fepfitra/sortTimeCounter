#include <iostream>
#include <chrono>
#include <vector>
#include <cstdlib>
#include <cstring>
using namespace std;

void selectionSort(int arr[], int n) {
  for (int i = 0; i < n - 1; i++) {
    int min_idx = i;
    for (int j = i + 1; j < n; j++) {
      if (arr[j] < arr[min_idx])
        min_idx = j;
    }

    if (min_idx != i)
      swap(arr[i], arr[min_idx]);
  }
}

void printArray(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    cout << arr[i] << " ";
  }
  cout << endl;
}

int main(int argc, char *argv[]) {
  bool verbose = false;

  if (argc < 2) {
    cerr << "Usage: " << argv[0] << " <array_length> [-v]" << endl;
    return 1;
  }

  int n;
  try {
    n = atoi(argv[1]);
    if (n <= 0) {
      cerr << "Invalid array length. Please provide a positive integer." << endl;
      return 1;
    }
  } catch (const invalid_argument& ia) {
    cerr << "Invalid argument: " << ia.what() << endl;
    cerr << "The argument must be a valid integer" << endl;
    return 1;
  } catch (const out_of_range& oor) {
    cerr << "Out of range: " << oor.what() << endl;
    return 1;
  }

  for (int i = 2; i < argc; i++) {
    if (strcmp(argv[i], "-v") == 0) {
      verbose = true;
      break;
    }
  }

  vector<int> arr(n);

  for (int i = 0; i < n; i++) {
    arr[i] = rand() % 1000;
  }

  auto start = chrono::high_resolution_clock::now();
  selectionSort(arr.data(), n);
  auto end = chrono::high_resolution_clock::now();

  if (verbose) {
    cout << "Original array: \n";
    printArray(arr.data(), n);
    cout << "Sorted array: \n";
    printArray(arr.data(), n);
  }

  auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
  if (verbose)
    cout << "\nTime taken by selectionSort function: " << duration.count() << " microseconds" << endl;
  else
    cout << duration.count() << endl;

  return 0;
}
