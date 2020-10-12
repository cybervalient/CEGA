oneEdge <-function(buff){
		f1 = c(0,0,0);
		f2 = c(0,0,1);
 		f3 = c(0,1,0);
		f4 = c(0,1,1);
 		f5 = c(1,0,0);
 		f6 = c(1,0,1);
 		f7 = c(1,1,0);

		if ( all.equal(buff, f1) == TRUE ) { 
			return ( 1.042);
		} else if ( all.equal(buff, f2) == TRUE ) {
			return ( -0.736);
		} else if ( all.equal(buff, f3) == TRUE ) {
			return ( 0.357);
		} else if ( all.equal(buff, f4) == TRUE ) {
			return ( -1.421);
		} else if ( all.equal(buff, f5) == TRUE ) {
			return ( -0.083);
		} else if ( all.equal(buff, f6) == TRUE ) {
			return ( 0.092);
		} else if ( all.equal(buff, f7) == TRUE){
			return ( -0.768);
		} else 
			return ( -0.592);	
	}