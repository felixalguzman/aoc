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
  char numbers[1024];
  for (int i = 0; i < 8; i++)
  {
    char element = start[i];
    if (element == ')')
    {
      break;
    }

    if ((element >= '0' && element <= '9') || element == ',')
    {
      char temp[2] = {element, '\0'};
      strcat(numbers, temp);
    }
  }

  printf("Numbers: %s\n", numbers);
  return result;
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
      char *next = strstr(copy, startSequence + pendingMult);
      pos = pos != NULL ? pos - copy : -1;
    } while (pendingMult != -1);
  }

  fclose(input);

  printf("Total: %d\n", total);
  return 0;
}