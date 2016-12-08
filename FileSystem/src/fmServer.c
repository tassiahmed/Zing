#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PORT_STR "-p"
#define CLIENT_NUM_STR "-c"
#define IPADDR_STR "-ip"


struct inputs{
    int port;
    int totalClients;
    char* ipaddr;
};

struct inputs constructParams(int argc, char** args){
    struct inputs params = { 0 };
    for(int i = 0; i < argc; i++){
        if(strcmp(args[i], PORT_STR) == 0){
            params.port = atoi(args[i]);
        } else if(strcmp(args[i], CLIENT_NUM_STR) == 0){
            params.totalClients = atoi(args[i]);
        } else if(strcmp(args[i], IPADDR_STR) == 0){
            i++;
            params.ipaddr = malloc(sizeof(char) * strlen(args[i]));
            strcpy(params.ipaddr, args[i]);
        }
    }
    return params;
}

void start(struct inputs* params){
    printf("- port %d\n- clients %d\n", (*params).port, (*params).totalClients);

    printf(" -- Starting server at %s:%d\n", (*params).ipaddr, (*params).port);
    
}

int main(int argc, char** args){
    struct inputs params = constructParams(argc, args);
    printf(" port: %d\n", params.port);
    printf(" client totals: %d\n", params.totalClients);

    start(&params);    

}
