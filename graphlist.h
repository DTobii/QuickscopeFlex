void nextGraph();
void setGraphVal(char* typ,int id);
void setGraphIO(char* input,char* output);


typedef struct s_graphlist {
    int id;
    char typ[5];
    char eingang[100];
    char ausgang[100];
    struct s_graphlist *davor;
    struct s_graphlist *danach;
} graphlist;


graphlist *momgraphlist;
graphlist *firstgraphlist;

int counter;


void nextGraph() {
    momgraphlist->danach = (graphlist*)malloc(sizeof(graphlist));
    momgraphlist->danach->davor = momgraphlist;
    momgraphlist = momgraphlist->danach;
    momgraphlist->danach=0;
    counter++;
}

void setGraphVal(char* typ,int id) {
    strcpy(momgraphlist->typ,typ);
    momgraphlist->id=id;
}

void setGraphIO(char* input,char* output) {
    strcpy(momgraphlist->eingang,input);
    strcpy(momgraphlist->ausgang,output);
}
