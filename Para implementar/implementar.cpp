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

