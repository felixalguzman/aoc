#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *input;


void selectionSort(int arr[], int n)
{
  for (int i = 0; i < n - 1; i++)
  {
    // Find the minimum element in unsorted array
    int min_idx = i;
    for (int j = i + 1; j < n; j++)
      if (arr[j] < arr[min_idx])
        min_idx = j;

    // Swap the found minimum element with the first element
    int temp = arr[min_idx];
    arr[min_idx] = arr[i];
    arr[i] = temp;
  }
}

int count(int arr[], int size, int n)
{
  int count = 0;
  for (int i = 0; i < size; i++)
  {
    if (arr[i] == n)
      count++;
  }
  return count;
}

int main(int argc, char *argv[])
{
  char line[1024];
  input = fopen("input.txt", "r");
  if (input == NULL)
  {
    printf("Error opening file\n");
    return 1;
  }

  int leftCount = 0;
  int rightCount = 0;

  const char *delimiter = " ";
  while (fgets(line, sizeof(line), input) != NULL)
  {
    char *copy = strdup(line);
    char *token = strtok(copy, delimiter);

    // Read integers from the line
    int i = 0;
    while (token != NULL && i < 2)
    {
      int number = atoi(token);
      if (i == 0)
      {
        leftCount++;
      }
      else
      {
        rightCount++;
      }

      token = strtok(NULL, delimiter);
      i++;
    }

    // Free the allocated memory for the copy
    free(copy);
  }

  // Dynamically allocate memory for left and right arrays
  int *left = (int *)malloc(leftCount * sizeof(int));
  if (left == NULL)
  {
    printf("Memory allocation failed\n");
    fclose(input);
    return 1;
  }
  int *right = (int *)malloc(rightCount * sizeof(int));
  if (right == NULL)
  {
    printf("Memory allocation failed\n");
    free(left);
    fclose(input);
    return 1;
  }

  // Reset counters and read actual values into arrays
  fseek(input, 0, SEEK_SET); // Rewind the file pointer to the beginning of the file
  int leftIndex = 0;
  int rightIndex = 0;
  while (fgets(line, sizeof(line), input) != NULL)
  {
    char *copy = strdup(line);
    char *token = strtok(copy, delimiter);

    int i = 0;
    while (token != NULL && i < 2)
    {
      int number = atoi(token);
      if (i == 0)
      {
        left[leftIndex++] = number;
      }
      else
      {
        right[rightIndex++] = number;
      }

      token = strtok(NULL, delimiter);
      i++;
    }

    free(copy);
  }

  fclose(input);

  selectionSort(left, leftCount);
  selectionSort(right, rightCount);

  int total = 0;
  int totalPartTwo = 0;
  for (int i = 0; i < leftCount; i++)
  {
   
   int apperances = count(right, rightCount, left[i]);

    total += abs(left[i] - right[i]);
    totalPartTwo += left[i] * apperances;
  }

  printf("Total part one: %d\n", total);
  printf("Total part two: %d\n", totalPartTwo);

  // Free dynamically allocated memory
  free(left);
  free(right);

  return 0;
}