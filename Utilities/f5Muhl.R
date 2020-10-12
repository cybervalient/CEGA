f5Muhl <- function(buff){

	f1 = c(0,0,0,0,1);
 	f2 = c(0,0,0,1,1);
 	f3 = c(0,0,1,1,1);
	f4 = c(1,1,1,1,1);
 	f5 = c(0,0,0,0,0);

	if (all.equal(buff, f1) == TRUE ){
		return (3.0);
	}else if (all.equal(buff, f2) == TRUE ){
		return (2.0);
	}else if (all.equal(buff, f3) == TRUE ){
		return (1.0);
	}else if (all.equal(buff, f4) == TRUE ){
		return (3.5);
	}else if (all.equal(buff, f5) == TRUE ){
		return (4.0);
	}else{
		return (0.0);
	}
}