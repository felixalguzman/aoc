#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

FILE *input;

bool is_safe(int arr[], int length)
{
  bool safe = false;
  int direction = 0;
  for (int i = 0; i < length; i++)
  {
    int current = arr[i];
    bool hasNext = i + 1 < length;
    if (hasNext)
    {

      int next = arr[i + 1];
      int diff = next - current;
      int absDiff = abs(diff);
      int currentDirection = 0;

      if (direction == 0)
      {
        direction = diff > 0 ? 1 : -1;
        currentDirection = direction;
      }
      else
      {
        currentDirection = diff > 0 ? 1 : -1;
      }

      if ((absDiff >= 1 && absDiff <= 3) && absDiff != 0)
      {
        safe = true;
      }
      else
      {
        safe = false;
        break;
      }

      if (direction != currentDirection)
      {

        safe = false;
        break;
      }
    }
  }

  return safe;
}

int main(int argc, char const *argv[])
{
  char line[1024];
  input = fopen("input.txt", "r");
  if (input == NULL)
  {
    printf("Error opening file\n");
    return 1;
  }

  int count = 0;
  while (fgets(line, sizeof(line), input) != NULL)
  {
    char *copy = strdup(line);
    char *token = strtok(copy, " ");

    int *reportLine = (int *)malloc(24 * sizeof(int));
    int index = 0;
    while (token != NULL)
    {
      int number = atoi(token);
      reportLine[index] = number;
      token = strtok(NULL, " ");
      index++;
    }

    if (is_safe(reportLine, index))
    {
      count++;
    }
    free(copy);
  }

  fclose(input);

  printf("Total safe: %d\n", count);
  return 0;
}
