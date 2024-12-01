#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool isDigit(char c)
{
    return c >= '0' && c <= '9';
}

int main(int argc, char *argv[])
{
    char *input = malloc(10000);
    size_t len = 0;
    ssize_t read;
    FILE *file = fopen("input.txt", "r");
    // fread(input, 1, 10000, file);

    int count = 0;
    int total = 0;
    while (fgets(input, 10000, file) != NULL)
    {
        /* code */
        printf("%s", input);
        int result[2] = {};
        char current[6] = {""};
        for (int i = 0; i < strlen(input); i++)
        {
            char c = input[i];
            int currentLength = strlen(current);

            if (isDigit(c))
            {
                current[currentLength] = c;
            }
            else
            {
                current[currentLength] = '\0';
            }

            if (i + 1 < strlen(input) && isDigit(input[i + 1]))
            {
                current[currentLength] = input[i + 1];
            }
            else
            {
                current[currentLength] = '\0';
            }

            if (i + 1 == strlen(input))
            {
                for (int j = 0; j < sizeof(result) / sizeof(result[0]); j++){
                    
                }
            }
        }
    }

    fclose(file);

    return 0;
}