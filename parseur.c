#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>

# define BUFF_SIZE 2048

int	str_len(char *c)
{
	int i = 0;
	while (c[i++])
	return (i);
}
void	file_open(char *path)
{
	int file_fd;
	int ret;
	char tmp[1];
	char *buffer;
	char r;
	int x;
	int i;

	i = 0;
	file_fd = open(path, O_RDONLY);
	while ((ret = read(file_fd, tmp, 1))){
		i += ret;
	}
	close(file_fd);
	buffer = (char *)malloc(sizeof (char *) * i);
		if (!buffer)
			return ;
	file_fd = open(path, O_RDONLY);
	r = read(file_fd, buffer, i);
	printf("%c",buffer[x]);
	for (int y = 0; y < i; y++)
		printf("%c",buffer[y]);

}

int main(int argc, char **argv)
{
	(void)argc;
	file_open(argv[1]);
	return(0);
}
