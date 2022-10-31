#ifndef _LIBRARY_H_
# define _LIBRARY_H_

int ft_atoi(char *str)
{
    int index;
    int sign;
    int value;
    
    index = 0;
    sign = 1;
    value = 0;
    while (str[index] >= 9 && str[index] <= 13 || str[index] == ' ')
        index++;
    while (str[index] == '-' || str[index] == '+')
    {
        if (str[index] == '-')
            sign *= -1;
        index++;
    }
    while (str[index] >= 0 && str[index] <= 9)
    {
        value = (value * 10) + (str[index] - '0');
        index++;
    }
    return (value * sign);
}

#endif
