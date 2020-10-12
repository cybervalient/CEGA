#include <string.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "fitness.h"
#include "sat.h"

#define numFitness 28

static Fitness fitnessDesc[numFitness] = {
  {"By file definition", &table_func, &s_table_fun},
  {"ONEMAX",&onemax,&areAllGenesOne},
  {"Quadratic 0.9 0 0 1",&quadratic,&areAllGenesOne},
  {"Fitness-3 DECEPTIVE",&f3deceptive,&areAllGenesOne},
  {"5-ORDER TRAP (Illinois Report No. 95008)",&trap5,&areAllGenesOne},
  {"3deceptive Bipolar",&f3deceptiveBipolar,&areBlocks6ZeroOrOne},
  {"3deceptive (OVERLAPPING in 1bit)",&f3deceptiveOverlapping,&areAllGenesOne},
  {"Fcuban5",&Fc5,&s_Fc5},
  {"ISOTORUS",&isotorus,&s_isotorus},
  {"FirstPolytree-3 (separable)",&FirstPoly3S,&s_FirstPoly3S},
  {"FirstPolytree-3 (OVERLAPPING in 1bit)",&FirstPoly3Over1,&s_FirstPoly3Over1},
  {"FirstPolytree-5 fun separable",&FirstPoly5S,&s_FirstPoly5S},
  {"FirstPolytree-5 (OVERLAPPING in 1bit)",&FirstPoly5Over1,&s_FirstPoly5Over1},
  {"MMDP-6 Problem", &MMDP6, &areBlocks6ZeroOrOne},
  {"PPEAKS Problem", &PPEAKS, &optimumPPEAKS},
  {"FMS Problem", &FMS, &optimumFMS},
  {"COUNTSAT Problem", &COUNTSAT, &optimumCOUNTSAT},
  {"ECC Problem", &ECC, &optimumECC},
  {"MTTP-20 Problem", &MTTP, &optimumMTTP20},
  {"MTTP-100 Problem", &MTTP, &optimumMTTP100},
  {"MTTP-200 Problem", &MTTP, &optimumMTTP200},
  {"MAXCUT-20.01 Problem", &MAXCUT, &optimumMAXCUT2001},
  {"MAXCUT-20.09 Problem", &MAXCUT, &optimumMAXCUT2009},
  {"MAXCUT-100 Problem", &MAXCUT, &optimumMAXCUT100},
  {"SAT Problem", &SAT, &optimumSAT},
  {"Plateau Problem", &plateau, &optimumPlateau},
  {"IsoPeaks Problem", &isoPeaks, &optimumIsoPeaks},
  {"Muhlenbein Problem", &muhl, &areAllGenesZero}
};

Fitness* fitness;

// ================================================================================
//
// name:          onemax
//
// function:      computes the value of onemax (or bit-count) function
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) the sum of input bits
//
// ================================================================================

double onemax(int* x, int n)
{
   int s;

   s=0;

   for (register int i=0; i<n; i++)
       s += x[i];

   return (double) s;
}

// ================================================================================
//
// name:          quadratic
//
// function:      computes the value of quadratic function
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) sum_{i=0}^{n/2-1}{f2(x[2i],x[2i+1]}, where f2(0,0)=0.9,
//                f2(1,1)=1, and f(0,1)=f(1,0)=0
//
// ================================================================================

double quadratic(int* x, int n)
{
  int a,b;
  double f;
  register int i;

  f = 0;

  for (i=0; i<n;)
    {
      a = x[i++];
      b = x[i++];
      
      if (a==0)
	if (b==0)
	  f += 0.9;
	else
	  f += 0;
      else
	if (b==0)
	  f += 0;
	else
	  f += 1;
    }

  return f;
}

// ================================================================================
//
// name:          f3deceptive
//
// function:      computes the value of 3-deceptive function
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) sum_{i=0}^{n/3-1}{f3(x[3i],x[3i+1],x[3i+2]}, where 
//                f3(0,0,0)=0.9, f3(0,0,1)=f3(0,1,0)=f3(1,0,0)=0.8,
//                f3(0,1,1)=f3(1,0,1)=f3(1,1,0)=0, and f3(1,1,1)=1
//
// ================================================================================

double f3deceptive(int* x, int n)
{
  double f;
  int s;
  register int i;

  f = 0;

  for (i=0; i<n;)
    {
      s  = x[i++];
      s += x[i++];
      s += x[i++];

      if (s==0)
	f+=0.9;
      else
      if (s==1)
	f+=0.8;
      else
      if (s==3)
	f+=1;
    }

  return f;
}

// ================================================================================
//
// name:          trap5
//
// function:      computes the value of trap-5 function
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) the value of a trap5 function
//
// ================================================================================

double trap5(int* x, int n)
{
  int s;
  int u;
  register int i;

  s = 0;

  for (i=0; i<n; )
    {
      u  = x[i++];
      u += x[i++];
      u += x[i++];
      u += x[i++];
      u += x[i++];
      
      if (u<5)
	s += 4-u;
      else
	s += 5;
    };

   return (double) s;
}

// ================================================================================
//
// name:          f3deceptiveBipolar
//
// function:      computes the value of 3-deceptive bipolar function
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) the value of a 3-deceptive bipolar function
//
// ================================================================================

double f3deceptiveBipolar(int* x, int n)
{
  double f;
  int s;
  register int i;
  
  f = 0;
  
  for (i=0; i<n;)
    {
      s  = x[i++];
      s += x[i++];
      s += x[i++];
      s += x[i++];
      s += x[i++];
      s += x[i++];

      s = abs(s-3);

      if (s==0)
	f+=0.9;
      else
	if (s==1)
	  f+=0.8;
	else
	  if (s==3)
	    f+=1;
    }

  return f;
}

// ================================================================================
//
// name:          f3deceptiveOverlapping
//
// function:      computes the value of 3-deceptive function overlapped in 1 bit
//                in a chain-like fashion
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (double) the value of a 3-deceptive function with overlapping
//
// ================================================================================

double f3deceptiveOverlapping(int* x, int n)
{
  double f;
  int s;
  register int i;

  f = 0;

  for (i=0; i<n-1;)
    {
      s  = x[i++];
      s += x[i++];
      s += x[i];

      if (s==0)
	f+=0.9;
      else
      if (s==1)
	f+=0.8;
      else
      if (s==3)
	f+=1;
    }

  return f;
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//-----------------------------------------------------
// IsoTorus
int m;
double IsoT1(int *buff){
  double  r = onemax(buff, 5);

  if( r ==  0) return m;
  if( r ==  5) return(m-1);
  return 0;
}

double IsoT2(int  *buff){
  double r = onemax(buff, 5);

  if( r ==  5) return(m*m);
  return 0;
}

int  s_isotorus(int* x, int n){
  double BestFv=isotorus(x, n);
  if( BestFv == double(m*m*m-m+1) ) return 1;
  return 0;
}

double isotorus(int *buff, int n){
m = int(sqrt((double)n));

int cinco[5], xup, xdown, xleft, xright;
cinco[0] =  buff[n-m];
cinco[1] =  buff[m-1];
cinco[2] =  buff[0];
cinco[3] =  buff[1];
cinco[4] =  buff[m];
double sum = IsoT2(cinco);

for(int i = 0; i < m; i++)
    for(int j = 0; j < m; j++){
       if(!(i+j)) continue;
       xup   = i - 1;
       xdown = i + 1;
       xleft = j - 1;
       xright= j + 1;
       if(i==0)     xup    = m-1;
       if(i==(m-1)) xdown  = 0; 
       if(j==0)     xleft  = m-1;
       if(j==(m-1)) xright = 0; 
       cinco[0] = buff[xup*m+j];
       cinco[1] = buff[i*m+xleft];
       cinco[2] = buff[i*m+j];
       cinco[3] = buff[i*m+xright];
       cinco[4] = buff[xdown*m+j];
       sum += IsoT1(cinco);
    }
return sum;
}

//-----------------------------------------------------
// La informacion mutua entre la primera y la ultima variable es 0,
// entre las otras dos cerca de 0.25
double tabla3[]={-1.18623, 1.07409,  0.468991, 0.0963925, -4.39078, -1.12167, -0.083084, 0.553108}; 
// la sgte linea tiene tiene la InfMutua igual a cero entre la primera y segunda variable
// double tabla3[]={-1.18623, 1.07409,   -4.39078, -1.12167, 0.468991, 0.0963925, -0.083084, 0.553108}; 
double OptimumFromFile = 1.07409;

double FirstPoly3S(int *buff, int n){
double sum;

sum = 0;
for(int i = 0; i < (n-2); i=i+3)
   sum = sum + tabla3[buff[i]+buff[i+1]*2+buff[i+2]*4];

return sum;
}

int s_FirstPoly3S(int* x, int n){
  if( fabs(FirstPoly3S(x, n) - OptimumFromFile*n/3) < 1e-10 ) return 1;
  return(0);
}

double FirstPoly3Over1(int *buff, int n){
double sum;

sum = 0;
for(int i = 0; i < (n-2); i=i+2)
   sum = sum + tabla3[buff[i]+buff[i+1]*2+buff[i+2]*4];

return sum;
}

// el optimo es 111...11100
int s_FirstPoly3Over1(int* x, int n){
  if( areAllGenesOne(x, n-2) && !(x[n-1] + x[n-2]) ) return 1;
  else return 0;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
double tabla5[]={
  -1.14101186338084,
   1.33423026790375,
  -5.35256493576178,
  -1.69965630790094,
   0.06337077315613,
  -0.81465190247913,
  -0.95189307961505,
  -0.65224925867406,
  -0.75258357981453,
   1.72265855147006,
  -4.96413665219548,
  -1.31122802433464,
   1.45442791559591,
   0.57640523996065,
   0.43916406282473,
   0.73880788376572,
  -3.52661569557707,
  -1.05137356429248,
  -7.73816876795801,
  -4.08526014009717,
   1.00182154551807,
   0.12379886988281,
  -0.01344230725311,
   0.28620151368788,
  -6.66424203185691,
  -4.18899990057232,
 -10.87579510423786,
  -7.22288647637701,
  -1.13317593188830,
  -2.01119860752356,
  -2.14843978465948,
  -1.84879596371849};

double Optimum5FromFile = 1.72265855147006;

double FirstPoly5S(int *buff, int n){
double sum;

sum = 0;
for(int i = 0; i < (n-4); i=i+5)
   sum = sum + tabla5[buff[i]+buff[i+1]*2+buff[i+2]*4+buff[i+3]*8+buff[i+4]*16];

return sum;
}

int s_FirstPoly5S(int* x, int n){
  if( fabs(FirstPoly5S(x, n) - Optimum5FromFile*n/5) < 1e-10 ) return 1;
  return(0);
}

double FirstPoly5Over1(int *buff, int n){
double sum;

sum = 0;
for(int i = 0; i < (n-4); i=i+4)
   sum = sum + tabla5[buff[i]+buff[i+1]*2+buff[i+2]*4+buff[i+3]*8+buff[i+4]*16];

return sum;
}

// el optimo es 10010011001100110..00110 
int s_FirstPoly5Over1(int* x, int n){
  if( x[0] && x[3] && !(x[1]+x[2]+x[n-1]) ){
    for(int i=4; i<(n-4); i+=4)
       if( !(x[i]+x[i+1]) && (x[i+2] * x[i+3]) ) 
           continue;
       else
           return 0;
  } else return 0;
return 1;  
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
double F3Cuban1[] = {0.595, 0.2, 0.595, 0.1, 1.0, 0.05, 0.09, 0.15};

double F5Cuban1(int*  buff){
  if ( (buff[1] == buff[3]) && (buff[2] == buff[4]) )
    return 4*F3Cuban1[ 4*buff[0] + 2*buff[1] + buff[2] ];
  else
    return 0;
}

double F5Cuban2(int* buff){
  if ( buff[4] == 0 )
    return onemax(buff, 5);
  else
    if ( (buff[0] == 0) )
      return 0;
    else
      return onemax(buff, 5) - 2;
}
//-----------------------------------------------------------
double  Fc4(int* buff, int n)
{
  int m = (n - 1)/4;
  double sum = 0;
  for (int i=0; i < m; i++)
    sum +=  F5Cuban1(&buff[4*i]);
  return sum;
}
//------------------------------------------------------------
double  Fc5(int* buff, int n)
{
  int m = (n - 5)/8;
  double  sum = F5Cuban1(buff);
  for (int i=0; i < m; i++)
    sum += F5Cuban2(&buff[4*(2*i+1)]) + F5Cuban1(&buff[4*(2*i+2)]);
  return sum;
} 

int s_Fc5(int *buff, int n){
double opitmo, Opt = Fc5(buff, n);
switch(n){
    case 21: opitmo = 14.8; break;
    case 37: opitmo = 25.6; break;
    case 69: opitmo = 47.2; break;
    case 101: opitmo = 68.8; break;
    case 133: opitmo = 90.4; break;
    case 205: opitmo = 138.98;break;
    default:{ printf("No valido numero de variables para FC5\n"); exit(0); }
}
if(opitmo==Opt) return 1;  
return 0;
}

//----------------------------------------------------------------------------
// asumo que el bit menos significativo esta en buff[0]
int toInt(int *buff, int K){
int num = 0, pot = 1;
for (int i=0; i < K; i++, pot*=2)
    num += buff[i] * pot;
 return num;
}

//----------------------------------------------------------------------------
int PatronGeneOptimo[64];
int SizePatron;


// halla si un patron determinado se repite en 
// en una cadena
int FoundGenePatron(int* x, int n)
{
  register int i, j;

  for (i=0; i<n; i+=SizePatron)
      for (j=0; j<SizePatron; j++)
	  if( PatronGeneOptimo[j]!=x[i+j] ) return 0;    
  return 1;
}

// lee el patron a buscar
void Read_pattern(){
  char patron[64];
  printf("cual es el patron (maximo 64 bits):\n");
  scanf("%s", patron);
  printf("patron leido: %s\n", patron);

  memset(PatronGeneOptimo, 0, 64*sizeof(int));

  for(int i=0; i<64; i++){
     if(patron[i]=='1') 
        PatronGeneOptimo[i]=1;
     if(patron[i]==0){
	 SizePatron= i;
	 break;
     }
  }
}
//----------------------------------------------------------------------------
// en el caso de las separables aqui estoy asumiendo que se usa una sola subfuncion
double  table_func(int* buff, int n){
/*double *fv = funvalues[0];
double sum = 0;    
for (int i=0; i < n; i+=Order[0]){
    sum += fv[ toInt(&buff[i], Order[0]) ];
}
return sum;*/
return 0;
}

// en el caso de las separables aqui estoy asumiendo que se usa una sola subfuncion
int s_table_fun(int *buff, int n){
// double Opt = table_func(buff, n);

if( FoundGenePatron(buff, n) ) return 1;  
return 0;
}

// -------------------------------------------------------------------------------
// ***********   Caso overlapping cadena  ********************

int Overlap = 1;

// aqui estoy asumiendo que se usan dos subfunciones alternandose
double  table_funcOver(int* buff, int n){
/*double *fv0 = funvalues[0];
double *fv1 = funvalues[1];
double sum = 0;    
//for (int i=0; i < n; i += (Order[0] + Order[1] - Overlap) ){
    sum += fv0[ toInt(&buff[i], Order[0]) ];
    sum += fv1[ toInt(&buff[i + (Order[0]-Overlap)], Order[1]) ];
}

int l=(n-1)/2;
if( fabs( l - 2*(l/2) ) ){
    sum += fv0[ toInt(&buff[n-Order[0]], Order[0]) ];
}

return sum;
*/
return 0;
}

// aqui estoy asumiendo que se usan a lo sumo dos subfunciones

int s_table_funOver(int *buff, int n){
// double Opt = table_funcOver(buff, n);
if( FoundGenePatron(buff, n) ) return 1;  
return 0;
}

// ================================================================================
//
// name:          areAllGenesOne
//
// function:      checks whether input string is composed of one's only
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (int) non-zero if x=(1,...,1), 0 otherwise
//
// ================================================================================

int areAllGenesOne(int* x, int n)
{
  register int i;

  for (i=0; (i<n)&&(x[i]==1); i++);
    
  return (i==n);
}

int areAllGenesZero(int* x, int n)
{
  register int i;

  for (i=0; (i<n)&&(x[i]==0); i++);
    
  return i == n;
}

// ================================================================================
//
// name:          areAllBlocks6ZeroOrOne
//
// function:      checks whether all tight non-overlapping blocks in an input
//                string are 0...0 or 1...1
//
// parameters:    x............a binary string
//                n............the length of a string
//
// returns:       (int) non-zero if all blocks are 0...0 or 1...1, 0 otherwise
//
// ================================================================================

int areBlocks6ZeroOrOne(int* x, int n)
{
  register int i;
  int j;
  int ok;

  ok = 1;

  for (i=0; i<n;)
    {
      if (x[i++]==0)
	{
	  for (j=1; j<6; j++)
	    if (x[i++]!=0)
	      ok = 0;
	}
      else
	{
	  for (j=1; j<6; j++)
	    if (x[i++]!=1)
	      ok = 0;
	}
    }

  return ok;
}

int setFitness(int n)
{
  if ((n>=0) && (n<numFitness))
    fitness = &(fitnessDesc[n]);
  else
    {
      fprintf(stderr,"ERROR: Specified fitness function doesn't exist (%u)!",n);
      exit(-1);
    }
  
  return 0;
}

// ================================================================================
//
// name:          getFitnessDesc
//
// function:      gets a string description of a particular function
//
// parameters:    n............the number of a fitness to get the description of
//
// returns:       (int*) the string description of the function
//
// ================================================================================

char* getFitnessDesc(int n)
{
  return fitnessDesc[n].description;
};

// ================================================================================
//
// name:          getFitnessValue
//
// function:      evaluates the fitness for an input string
//
// parameters:    x............the string
//                n............the length of the string
//
// returns:       (double) the value of chosen fitness for the input string
//
// ================================================================================

double getFitnessValue(int* x, int n) 
{
  return fitness->fitness(x,n);
}

// ================================================================================
//
// name:          isBestDefined
//
// function:      checks whether the proposition identifying the optimal strings is
//                defined for a chosen function
//
// parameters:    (none)
//
// returns:       (int) non-zero if the proposition function defined, 0 otherwise
//
// ================================================================================

int isBestDefined()
{
  return (int) (fitness->isBest!=NULL);
};

// ================================================================================
//
// name:          isOptimal
//
// function:      checks whether the input string is optimal (assuming the 
//                proposition function is defined)
//
// parameters:    x............the string
//                n............the length of the string
//
// returns:       (int) the value of the proposition
//
// ================================================================================

int isOptimal(int* x, int n) 
{
 return fitness->isBest(x,n);
};

//------------------- Nuevas funciones a partir de ENRIQUE y BERNABE  --------------

double MMDP6(int* ph, int len)
{
	int i, j, index;
	int unitation;
	double        v;

   	v = 0.0;
   	index = 0;
   	len /= 6 ;
    	
   	for(i = 0; i < len; i++)
    { 
    	unitation = 0;
	  	for(j = 0; j<6; j++)
       		unitation += ph[index++];
           
        switch (unitation)           		// 6-BIT BIPOLAR DECEPTION
        { 
        	case 0 : v += 1.000000; break;
            case 1 : v += 0.000000; break;
            case 2 : v += 0.360384; break;
            case 3 : v += 0.640576; break;
            case 4 : v += 0.360384; break;
            case 5 : v += 0.000000; break;
            case 6 : v += 1.000000; break;
		}
	}

   	return v;
}

double PPEAKS(int* ph, int len)
{
	static const int   P          = 100;	// Number of Peaks
	static const int   N          = 100;	// Length of chromosome
	static int peak[P][N];	// The peaks
	static int fitness_counter = 0;

	double fitness = 0.0;		// Fitness of the individual
	int    nearest_peak;		// Bits in common with nearest peak
	int    j, p, hd;		// Counters

	if(fitness_counter == 0) 	// Only the first time create the peaks
	{
		fitness_counter++;
		for(p = 0; p < P; p++)
			for(j = 0; j < N; j++)
				peak[p][j] = rand() & 01; // Random binary value
	}

	fitness_counter++;
	nearest_peak = 0;
	
	for(p = 0; p < P; p++)	// For every peak do
	{
		// Compute Hamming distance
		for(hd = 0, j = 0; j < N; j++) 
			if(peak[p][j] != ph[j])	
				hd++;
		
		if((N-hd) > nearest_peak)	
			nearest_peak = N - hd;
	}
	
	fitness = (double)nearest_peak / (double)N;

	return fitness;
}

//Private use
double EncodeFunction(int* ph, int index, int bits, double min, double max)
{
	double sum = 0;
	double total = min;
	for (int j = bits - 1; j >= 0; j--)
		sum += ph[index + bits - 1 - j] * pow(2.0, j);
	total += ((max - min)/pow(2, bits)) * sum;

	return total;
}

double FMS(int* ph, int len)
{
	static double PI   = 3.14159;		// Constant pi
	static double TITA = 2.0*PI/100.0;	// Base frequency
//	static double MAXF = 5530.76;		// Theoretically 5530.76

	double fitness = 0.0;
	double tptita, y, y0;
	double a1, w1, a2, w2, a3, w3;

	a1 = EncodeFunction(ph, 0, 32, -6.4, 6.35);
	w1 = EncodeFunction(ph, 32, 32, -6.4, 6.35);
	a2 = EncodeFunction(ph, 64, 32, -6.4, 6.35);
	w2 = EncodeFunction(ph, 96, 32, -6.4, 6.35);
	a3 = EncodeFunction(ph, 128, 32, -6.4, 6.35);
	w3 = EncodeFunction(ph, 160, 32, -6.4, 6.35);
	
	for(int t=0; t<101; t++)	// For t from 0 to 100 do
	{	
		tptita = ((double)t)*TITA;
		y  = a1*sin(w1*tptita+a2*sin(w2*tptita+a3*sin(w3*tptita)));
		y0 = 1.0*sin(5.0*tptita-1.5*sin(4.8*tptita+2.0*sin(4.9*tptita)));
		fitness += (y-y0)*(y-y0);	// Sum of the square error
	}
	
/*
	if (fitness == 0.0) 
		fitness = 100;
	else 
		fitness = 1.0 / fitness;
*/
		
	return -fitness;
}

// Satisfiability problem
// n=20 and k=3.  Strlen is 20
// Maximun  fitness ===>    6860
double Fact (double num1, double num2)
// returns num1! / num2!  ;  with num1 >= num2
{
	double res=1.0;

	if (num1 < num2) 
		return 0;
	while (num1 > num2)
	{
		res = num1 * res;
		num1--;
	}

	return res;
}

double COUNTSAT(int* ph, int len)
{
	register int index;
	double fitness = 0.0;
	double s = 0.0;

	for (index = 0; index < len; index++) //NUMBER_OF_VARIABLES; index++)
	{
		s += ph[index];
	}

	//fitness += s+(NUMBER_OF_VARIABLES*(NUMBER_OF_VARIABLES-1)*(NUMBER_OF_VARIABLES-2));
	fitness += s + len * (len - 1) * (len - 2);

	//fitness -= (NUMBER_OF_VARIABLES-2) * Fact(s,s-2);
	fitness -= (len - 2) * s * (s - 1);

	fitness += s * (s - 1) * (s - 2);
	
	return fitness;

}

///////////////////////////////// TELECOMMUNICATIONS ////////////////////////////////////
// ECC
// Error Correcting Code design - Chen, Flann and Watson (IEEE TPDS)
// n=12 and M=24.  Strlen is 288
// Search space 10~87
// Maximun  fitness ===>    0.0674

// CLASS IMPLEMENTATION

// Simplified version of the problem. It 
#define WORD_CARDINAL	24
#define WORD_LENGTH		12

double ECC(int* ph, int len)
{
	register int word_i, word_j, index, pos1, pos2;
	double hamming_distance=0.0;
	double fitness = 0.0;
	
	for(word_i = 0; word_i < WORD_CARDINAL; word_i++)	  	// Hamming distance sum... 
	{
		pos1 = word_i * WORD_LENGTH;
		for(word_j=word_i; word_j<WORD_CARDINAL; word_j++) 
			if(word_i != word_j) 	// ... for every word with the rest
			{
				pos2 = word_j * WORD_LENGTH;
				hamming_distance=0.0;
				for(index=0; index<WORD_LENGTH; index++)
					if (ph[pos1+index] != ph[pos2+index])
						hamming_distance += 1.0;
			
				if (hamming_distance==0.0) 
					return 0.0;
					
				fitness += 1/(hamming_distance*hamming_distance);
			}
	}

	return 1/fitness;
}

// Minimun Tardy Task Problem - Sami Khuri November 2000 (COMB-OPT directory)
// Khuri, Baeck and Heitkotter 94, Procs. ACM Computer Science Conference, pp. 66-73
// NP-Complete and hard
// Solution fitness ===> 1/(min_problem), and min_mttp20=41, min_mttp100=200, min_mttp200=400
// Parameter values ===> 0 and 1
// GOAL: try to get tasks due in minimun time and by satisfying max completion times

#define K_TYPE	int
#define K_FMT	"%d"
#define TARDY_DATA_FILENAME	"./mttp100.dat"
#define _GA			"cEDA"

#include <stdio.h>

void readln(FILE* f, char* format, void* buffer)
{	
	fscanf(f, format, buffer); 	
}

double MTTP(int* x, int Length)
{
	double fitness = 0.0;		// Fitness of the individual
	register int FsbFlg;
   	static int Flg = 1, PrbDim;
	static K_TYPE	*Lengths, *Deadlines;
	static double *Weights, WTot;
	K_TYPE Time;
	double WSum, Penalty;
	int	i;
	
    FILE *fp;

  	if (Flg) 
  	{			/* read the data */
		if ((fp = fopen (TARDY_DATA_FILENAME, "r")) == NULL) 
		{
	    		printf ("%s/f_33: Couldn't open datafile (%s)\n",
		    		_GA, TARDY_DATA_FILENAME);
	    		exit (2);
		}
		readln (fp, "%d", &PrbDim);

		if ((Lengths = (K_TYPE *) calloc((unsigned) PrbDim,
				sizeof(K_TYPE))) == NULL ||
		    (Deadlines = (K_TYPE *) calloc((unsigned) PrbDim,
				sizeof(K_TYPE))) == NULL ||
		    (Weights = (double *) calloc((unsigned) PrbDim,
				sizeof(double))) == NULL) 
		{
			printf("%s/f_33: Calloc failed\n", _GA);
			exit(2);
		}
		
		for (i = 0; i < PrbDim; i++) 
		{	/* read job lengths */
			readln(fp, K_FMT, &(Lengths[i]));
		}
		for (i = 0; i < PrbDim; i++) 
		{	/* read job deadlines */
			readln(fp, K_FMT, &(Deadlines[i]));
		}
		for (WTot = 0.0, i = 0; i < PrbDim; i++) 
		{ /* read penalties */
			readln(fp, "%lf", &(Weights[i]));
			WTot += Weights[i];
		}
		fclose(fp);
		Flg = 0;
	}

	FsbFlg = 1;
	for (Time = 0, WSum = Penalty = 0.0, i = 0; i < PrbDim; i++) 
	{
		if (x[i] == 0)			/* add over elements of T-S */
			WSum += Weights[i];
		if (x[i] == 1) 
		{		/* check constraints */
			if (Time + Lengths[i] > Deadlines[i]) 
			{
				FsbFlg = 0;
				Penalty += Weights[i];
			}
			else			/* new fitness function */
				Time += Lengths[i];
		}
	}
	
	if (FsbFlg == 0)		/* infeasible solution */
		fitness = WSum + WTot + Penalty;
	else
    	fitness = WSum + Penalty;

	return 1.0/fitness;
}

// Maximum Cut Problem - Sami Khuri November 2000 (COMB-OPT directory)
// Khuri, Baeck and Heitkotter 94, Procs. ACM Computer Science Conference, pp. 66-73
// NP-Complete and hard
// Solution fitness ===> 
// Parameter values ===> 0 and 1
// GOAL: make a graph cut with maximum weights for edges having each vertex in 
//		two different sets: v0 and v1
#define MAXCUT_DATA_FILENAME	"./cut100.dat"

double MAXCUT(int* x, int Length)
{
	static int Flg = 1, PrbDim;
	static double** Edges;

	FILE* DatFil;
	int i, j;
	double s1, p1, p2, p3, fitness;

	// Read the data from a configuration file - first time only
	if (Flg) 
	{	if ((DatFil = fopen(MAXCUT_DATA_FILENAME, "r")) == NULL)
		{
			printf("%s/MAXCUT: Couldn't open datafile (%s)\n", 
				_GA, MAXCUT_DATA_FILENAME);
			exit(-1);
		}
		readln(DatFil, "%d", &PrbDim);	
		if (PrbDim != Length)
		{
			printf("%s/MAXCUT: Wrong data dimension (%d, %d)\n", 
				_GA, PrbDim, Length);
			exit(-1);
		}
		if ((Edges = (double **) calloc((unsigned) PrbDim, sizeof(double *))) == NULL)
		{
			printf("%s/MAXCUT: Calloc failed\n", _GA);
			exit(-1);
		}
		for (i = 0; i < PrbDim; i++)
		{
			if ((Edges[i] = (double *) calloc((unsigned) PrbDim, sizeof(double))) == NULL) 
			{
				printf("%s/MAXCUT: Calloc failed\n", _GA);
				exit(-1);
			}
		}
		for (i = 0; i < PrbDim; i++) 
			for (j = 0; j < PrbDim; j++)
				readln(DatFil, "%lf", &(Edges[i][j]));	

		fclose(DatFil);
		Flg = 0;
	}

	p1 = 0.0;
	p2 = 0.0;
	s1 = 0.0;
	for( i = 0; i < PrbDim ; i++ )
	{	p1 = 1.0 - 2.0 * x[i];
		p3 = 0.0;
		for( j = i + 1; j < PrbDim; j++ )
		{	
			p2 = x[j] * p1;
			p3 += Edges[i][j] * (x[i] + p2);
		}
		s1 += p3;
	}
	fitness = s1;
	
	return fitness;
}		

SATFitnessFunction* sat;

double SAT(int* x, int Length)
{
	return sat->Evaluate(x);
}

double plateau(int* x, int Length)
{
	double f;
	register int i;

	f = 0.0;
	for (i = 0; i < Length; i += 3)
		if ( (x[i] == 1) && (x[i + 1] == 1) && (x[i + 2] == 1) )
			f += 1.0;
		else
			f += 0.0;

	return f;
}

double isoPeaks(int* x, int n)
{
	int l = n / 2;
	int Iso1 = 0;
	int Iso2 = 0;

	if (x[0] + x[1] == 2)
		Iso2 = l;
	
	for(int i = 2; i < n; i += 2)
		if (x[i] + x[i+1] == 2)
	      Iso1 = Iso1 + l - 1;
	    else
	    	if (x[i] + x[i+1] == 0)
	       		Iso1 = Iso1 + l;
	
	return Iso1 + Iso2;
}

// This variables are to use in F5Muhl method
static int f1[] = {0,0,0,0,1};
static int f2[] = {0,0,0,1,1};
static int f3[] = {0,0,1,1,1};
static int f4[] = {1,1,1,1,1};
static int f5[] = {0,0,0,0,0};

double f5Muhl(int* buff)
{
	if ( memcmp(buff, f1, 5*sizeof(int)) == 0 )
		return 3.0;
	else if ( memcmp(buff, f2, 5*sizeof(int)) == 0 )
		return 2.0;
	else if ( memcmp(buff, f3, 5*sizeof(int)) == 0 )
		return 1.0;
	else if ( memcmp(buff, f4, 5*sizeof(int)) == 0 )
		return 3.5;
	else if ( memcmp(buff, f5, 5*sizeof(int)) == 0 )
		return 4.0;
	else
		return 0.0;
}

double muhl(int* x, int n)
{
	int m = n/5;

	double sum = 0.0;
	for (int i = 0; i < m; i++)
		sum += f5Muhl(&x[5*i]);

	return sum;
}

int optimumIsoPeaks(int* x, int n)
{
	return isoPeaks(x, n) == double(n * n) / 4.0;
}

int optimumPlateau(int* x, int Length)
{
	return plateau(x, Length) == Length / 3;
}
int optimumSAT(int* x, int Length)
{
	return sat->Optimum(x);
}

int optimumMAXCUT2001(int* ph, int len)
{
	return MAXCUT(ph, len) == (double)10.119812;
}

int optimumMAXCUT2009(int* ph, int len)
{
	return MAXCUT(ph, len) == (double)56.740064;
}

int optimumMAXCUT100(int* ph, int len)
{
	return MAXCUT(ph, len) == (double)1077;
}

int optimumMTTP20(int* ph, int len)
{
	return MTTP(ph, len) == (double)0.02439;
}

int optimumMTTP100(int* ph, int len)
{
	return fabs(MTTP(ph, len) - 0.005) < 0.0001;
}

int optimumMTTP200(int* ph, int len)
{
	return MTTP(ph, len) == (double)0.0025;
}

int optimumECC(int* ph, int len)
{
	return fabs(ECC(ph, len) - 0.1348) <= 0.00001;
}

int optimumCOUNTSAT(int* ph, int len)
{
	return COUNTSAT(ph, len) == (double)6860;
}
int optimumPPEAKS(int* ph, int len)
{
	return PPEAKS(ph, len) == (double)1.0;
}

int optimumFMS(int* ph, int len)
{
	return fabs(FMS(ph, len)) <= (double)0.01;
}
