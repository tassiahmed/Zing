#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PORT_STR "-p"


struct inputs{
    int port;
};

struct inputs constructParams(int argc, char** args){
    struct inputs params = { 0 };
    for(int i = 0; i < argc; i++){
        if(strcmp(args[i], PORT_STR) == 0){
            i++;
            params.port = atoi(args[i]);
        }
    }
    return params;
}

int main(int argc, char** args){
    struct inputs params = constructParams(argc, args);
    printf(" port: %d\n", params.port);
}
