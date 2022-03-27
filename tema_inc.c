#include <iostream>

using namespace std;

int n ;//= 5; 
int m ;//= 1;
//int v[100];// = { -1,1,0,0,0,0,0,3,0,0,0,0,0,0,4,5 };
int s[100] = {0};
int ap[32] = {0};
int sol = 0, ok;


void back (int k)/// setam elementul de pe pozitia k
{
    if(k == 3*n+1)
    {
        sol = 1;
        return;
    }
    if( s[k] != 0)
    {
        back(k+1);
        return;
    }
    for( int i = 1; i<= n; i++ )
        if(ap[i] <= 2 )
        {
            ap[i]++;
            s[k] = i;
            ok = 1;
            
            
            
            if (ok==1)
                back ( k+1 );
            
            
            
            printf("%d ",i);
        }
    return;
}

int main()
{
    scanf("%d%d",&n,&m);
    
    for (int i=1; i<= n * 3; i++)
    {
        scanf("%d",&s[i]);
        ap[s[i]]++;
    }
    back(1);
    printf("%d ",sol);
        
    return 0;
}



