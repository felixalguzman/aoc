#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

FILE *input;

const char *startSequence = "mul(";

int multiplyFromPosition(char *line, int position)
{
  int result = -1;

  char *start = line + position + strlen(startSequence);
  char numbers[8] = "";
  for (int i = 0; i < 8; i++)
  {
    char element = start[i];
    if (element == ')')
    {
      break;
    }

    if ((element >= '0' && element <= '9') || element == ',')
    {
      int currentNumbersLength = strlen(numbers);
      numbers[currentNumbersLength] = element;
    }
    else
    {
      return -1;
    }
  }

  printf("numbers joined: %s\n", numbers);

  char *splitted = strtok(numbers, ",");
  printf("numbers 1: %s\n", splitted);
  int first = atoi(splitted);
  if (first == 0)
  {
    return -1;
  }

  splitted = strtok(NULL, ",");
  printf("numbers 2: %s\n", splitted);
  int second = atoi(splitted);
  if (second == 0)
  {
    return -1;
  }

  result = first * second;
  return result;
}

int main(int argc, char const *argv[])
{
  int sequenceLength = strlen(startSequence);

  char line[1024];
  input = fopen("input.txt", "r");
  if (input == NULL)
  {
    printf("Error opening file\n");
    return 1;
  }

  int total = 0;
  while (fgets(line, sizeof(line), input) != NULL)
  {
    char *copy = strdup(line);
    char *pos = strstr(copy, startSequence);
    int pendingMult = pos != NULL ? pos - copy : -1;

    do
    {
      int valid = multiplyFromPosition(copy, pendingMult);
      if (valid != -1)
      {
        total += valid;
      }

      char temp[sizeof(line)];
      strcpy(temp, copy + pendingMult + sequenceLength);
      char *next = strstr(temp, startSequence);
      pendingMult = next != NULL ? next - temp : -1;
      copy = temp;

    } while (pendingMult != -1);
  }

  fclose(input);

  printf("Total: %d\n", total);
  return 0;
}