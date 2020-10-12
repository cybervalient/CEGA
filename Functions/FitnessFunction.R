fitness <- function(object) UseMethod("fitness")

fitness.default <- function(object)"Default Fitness"

fitness.Ackley <- function(object) {
	n <- length(object@x);

	return(-1 * (-20*exp(-.2*sqrt(sum(object@x^2)/n)) - exp(sum(cos(2*pi*object@x))/n) + 20.0 + exp(1.0)));
}

fitness.Rosenbrock <- function(object) {
	n <- length(object@x);
	t0 <- object@x+1;
    	t1 <- t0[2:n]-t0[1:(n-1)]*t0[1:(n-1)]
    
	return(-1 * (1e2*sum(t1*t1) + sum(object@x[1:(n-1)]*object@x[1:(n-1)])))
}

fitness.Griewankg <- function(object) {
	n <- length(object@x);

	return(-1 * (sum(object@x*object@x)/4000-prod(cos(object@x/sqrt(1:n)))+1));
}


fitness.Rastrigin <- function(object) {
	n <- length(object@x);

	return(-1 * (10*n+sum(object@x^2-10*cos(2*pi*object@x))));
}

fitness.Sphere <- function(object) {
	result <- sum(object@x*object@x);
	
	-result;
}

fitness.Water <- function(object) {
	a <- 1.0;
	b <- 50.0;
	c <- 3.0;
	d <- 4.0;
	alfa <- 3 * pi;
	gamma <- 4 * pi;	

	result <- 0.0;
	for (i in 1:length(object@x) / 2) {
		ss <- get("result");
		result <<- ss + a * object@x[2 * i - 1] * object@x[2 * i - 1] + b * object@x[2 * i] * object@x[2 * i] - c * cos(alfa * object@x[2 * i - 1]) - d * cos(gamma * object@x[2 * i]) + c + d;
	}

	#print(result);
	#cat("\n");


	-result;
}

fitness.Plateau <- function(object){
	i = 1;
	f = 0.0;
	while(i <= length(object@x)){

		if ( (object@x[i] == 1) && (object@x[i + 1] == 1) && (object@x[i + 2] == 1) ){
			f = f + 1.0;
		}else{
			f = f + 0.0;
		}
		i = i + 3;
	}
	
	f;
}

fitness.OneMax <- function(object) {
	result <- sum(object@x);
	result;
}

fitness.Quadratic <- function(object){

  f = 0;
  j=1;
  ln <- as.integer(length(object@x) / 2);

  for (i in 1:ln){

	a = object@x[j];
	j <- j + 1;
	b = object@x[j];
	j <- j + 1;
	
      if (a==0){
	  if (b==0){
	     f = f + 0.9;
	  }else{
	     f = f + 0;
        }
      }else if(b==0){
	    f = f + 0;
	   }else{
	    f = f + 1;
         }
	
     }
  f;
}
fitness.Deceptive3 <- function(object) {
	
	f <- 0;
	i <- 1;

	ln <- as.integer(length(object@x) / 3);
	for (k in 1:ln)
	{
		s <- object@x[i];
		i <- i + 1;
		s <- s + object@x[i];
		i <- i + 1;
		s <- s + object@x[i];
		i <- i + 1;

		if (s == 0) {
			f <-  f + 0.9;
		}
		else {
			if (s == 1) {
				f <- f + 0.8;
			}
			else {
				if (s == 3) {
					f <- f + 1.0;
				}
			}
		}
	}
      
	f
}
fitness.F5Cuban1 <- function(object){
  
	F3Cuban1 <-array(dim=8)
	F3Cuban1[1]= 0.595
	F3Cuban1[2]= 0.2
	F3Cuban1[3]= 0.595
	F3Cuban1[4]= 0.1
	F3Cuban1[5]= 1.0
	F3Cuban1[6]= 0.05
	F3Cuban1[7]= 0.09
	F3Cuban1[8]= 0.15

  if ( (object@x[1] == object@x[3]) && (object@x[2] == object@x[4]) ){
   
    t<- (4*F3Cuban1[(4*object@x[1] + 2*object@x[2] + object@x[3])+1 ]);

  }else{
    t <- (0);
  }
t;
}
fitness.Mmdp<-function(object){
		
		v <- 0.0;
   		index <- 0;
   		len <- length(object@x) / 6;
	    	
   		for(i in 1:len)
		{ 
    		unitation <- 0;
	  		for(j in 1:6)
				index <- index +1;
       			unitation = unitation + object@x[index];
	           
			# 6-BIT BIPOLAR DECEPTION
			if(unitation == 0)v = v + 1.000000; break;
			if(unitation == 1)v = v + 0.000000; break;
			if(unitation == 2)v = v + 0.360384; break;
			if(unitation == 3)v = v + 0.640576; break;
			if(unitation == 4)v = v + 0.360384; break;
			if(unitation == 5)v = v + 0.000000; break;
			if(unitation == 6)v = v + 1.000000; break;			


		}

   		v;
	}
fitness.Trap5 <- function(object){

		f = 0.0;
	      ln  <- as.integer(length(object@x)/5);
		
		for (i in 1:ln){

			s = object@x[i];
			i <- i + 1;
			s = s + object@x[i];
			i <- i + 1;
			s = s + object@x[i];
			i <- i + 1;
			s = s + object@x[i];
			i <- i + 1;
			s = s + object@x[i];
			
			if (s < 5){ 
				f = f + (4.0 - s);
			} else{ 
				f = f + 5.0;
			}
		}

		f;
}
fitness.IntDeceptive <- function(object){
		
		f = 0.0;
		individual <- object@x;

		for (i in 1: length(individual))
		{
			ksum = 0;
			for ( j in 1:k)
				ksum = ksum + individual[i];
				i <- i+1;
			if (ksum == object@k * (object@card - 1))
				f = f + object@k * (object@card - 1)
			else
				f = f + object@k * (object@card - 1) - ksum - 1;
		}

		f;
	}

fitness.OneEdge <- function(object){
		
	
		m = length(object@x) / 3;
		sum = 0.0;
		temp1 <- 1;
		temp2 <- temp1 + 2;

		for (i in 1:m)
		{
			sum = sum + oneEdge(c(object@x[(temp1):(temp2)]));
			temp1 <- temp2+1;
			temp2 <- temp2+3;
		}

		sum;
	}
fitness.F3Poly <- function(object){
		
		
		m = length(object@x) / 3;
		sum = 0;
		temp1 <- 1;
		temp2 <- temp1 + 2;

		for (i in 1:m)
		{
			sum = sum + f3Poly(c(object@x[(temp1):(temp2)]));
			temp1 <- temp2+1;
			temp2 <- temp2+3;
			
		}

		sum;
	}
fitness.F5Poly <- function(object){
		
	
		m = length(object@x) / 5;
		sum = 0.0;
	      temp1 <- 1;
		temp2 <- temp1 + 4;
		
		for (i in 1:m)
		{
			sum = sum + f5Poly(c(object@x[(temp1):(temp2)]));
			temp1 <- temp2+1;
			temp2 <- temp2+5;

		}

		as.numeric(sum);
	}

fitness.IsoPeaks <- function(object){

	m = length(object@x) / 2;
	Iso1 = 0;
	Iso2 = 0;

	if (object@x[1] + object@x[2] == 2){
		Iso2 = m;
	 }
	
	i=2	
	while(i<m){
		temp <- i+1
		if(object@x[i] + object@x[temp] == 2){
 
		Iso1 = Iso1 +(m-1)

		}else if(object@x[i] + object@x[temp] == 0){

		Iso1 = Iso1 + m;
		
		}
       i=i+2
	}
	
	return (Iso1 + Iso2);
}

fitness.F5Muhl <- function(object){
	
      m = length(object@x)/5;
	sum = 0.0;
	temp1 <- 1;
	temp2 <- temp1 + 4;

	for (i in 1:m){
			
		sum = sum + f5Muhl(c(object@x[(temp1):(temp2)]));
		temp1 <- temp2+1;
		temp2 <- temp2+5;
			
	}

	return (sum);
}

#Cec Functions
fitness.ShiftedSphere <- function(object){
	
	fit <- cec2005benchmark1(as.vector(object@x));
	print(fit)
	fit;
}
fitness.ShiftedSchwefelProblem1.2 <- function(object){
	
	fit <- cec2005benchmark2(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedHighCondElliptic <- function(object){
	
	fit <- cec2005benchmark3(as.vector(object@x));
	fit;
}
fitness.ShiftedSchwefelProblem1.2Noise <- function(object){
	
	fit <- cec2005benchmark4(as.vector(object@x));
	fit;
}
fitness.SchwefelProblem2.6GOBounds <- function(object){
	
	fit <- cec2005benchmark5(as.vector(object@x));
	fit;
}
fitness.ShiftedRosenbrock <- function(object){
	
	fit <- cec2005benchmark6(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedGriewankWithoutBounds <- function(object){
	
	fit <- cec2005benchmark7(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedAckleyGOBounds <- function(object){
	
	fit <- cec2005benchmark8(as.vector(object@x));
	fit;
}
fitness.ShiftedRastrigin <- function(object){
	
	fit <- cec2005benchmark9(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedRastrigin <- function(object){
	
	fit <- cec2005benchmark10(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedWeierstrass <- function(object){
	
	fit <- cec2005benchmark11(as.vector(object@x));
	fit;
}
fitness.SchwefelsProblem2.13 <- function(object){
	
	fit <- cec2005benchmark12(as.vector(object@x));
	fit;
}
fitness.ShiftedExpandedGriewankplusRosenbrock  <- function(object){
	
	fit <- cec2005benchmark13(as.vector(object@x));
	fit;
}
fitness.ShiftedRotatedExpandedScafferF6 <- function(object){
	
	fit <- cec2005benchmark14(as.vector(object@x));
	fit;
}
fitness.HybridCompositionGO120<- function(object){
	
	fit <- cec2005benchmark15(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGO120<- function(object){
	
	fit <- cec2005benchmark16(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGO120Noise <- function(object){
	
	fit <- cec2005benchmark17(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGO10 <- function(object){
	
	fit <- cec2005benchmark18(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionNarrowBasin <- function(object){
	
	fit <- cec2005benchmark19(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGOBounds <- function(object){
	
	fit <- cec2005benchmark20(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGO360 <- function(object){
	
	fit <- cec2005benchmark21(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionHighCondNumMatrix <- function(object){
	
	fit <- cec2005benchmark22(as.vector(object@x));
	fit;
}
fitness.NonContinuousRotatedHybridComposition <- function(object){
	
	fit <- cec2005benchmark23(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositionGO260 <- function(object){
	
	fit <- cec2005benchmark24(as.vector(object@x));
	fit;
}
fitness.RotatedHybridCompositioWithoutBounds <- function(object){
	
	fit <- cec2005benchmark25(as.vector(object@x));
	fit;
}
