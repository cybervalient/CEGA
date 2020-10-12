f5Poly <- function(buff){
	 f1 = c(0,0,0,0,0);
	 f2 = c(0,0,0,0,1);
	 f3 = c(0,0,0,1,0);
	 f4 = c(0,0,0,1,1);
	 f5 = c(0,0,1,0,0);
	 f6 = c(0,0,1,0,1);
	 f7 = c(0,0,1,1,0);
	 f8 = c(0,0,1,1,1);
	 f9 = c(0,1,0,0,0);
	 f10 = c(0,1,0,0,1);
	 f11 = c(0,1,0,1,0);
 	 f12 = c(0,1,0,1,1);
 	 f13 = c(0,1,1,0,0);
 	 f14 = c(0,1,1,0,1);
 	 f15 = c(0,1,1,1,0);
 	 f16 = c(0,1,1,1,1);
 	 f17 = c(1,0,0,0,0);
 	 f18 = c(1,0,0,0,1);
 	 f19 = c(1,0,0,1,0);
 	 f20 = c(1,0,0,1,1);
 	 f21 = c(1,0,1,0,0);
	 f22 = c(1,0,1,0,1);
 	 f23 = c(1,0,1,1,0);
 	 f24 = c(1,0,1,1,1);
 	 f25 = c(1,1,0,0,0);
 	 f26 = c(1,1,0,0,1);
 	 f27 = c(1,1,0,1,0);
 	 f28 = c(1,1,0,1,1);
 	 f29 = c(1,1,1,0,0);
 	 f30 = c(1,1,1,0,1);
 	 f31 = c(1,1,1,1,0);

	if ( all.equal(buff, f1) == TRUE ) {
			return (-1.141);
		} else if ( all.equal(buff, f2) == TRUE ) {
			return (1.334);
		} else if ( all.equal(buff, f3) == TRUE ) {
			return (-5.353);
		} else if ( all.equal(buff, f4) == TRUE ) {
			return (-1.7);
		} else if ( all.equal(buff, f5) == TRUE ) {
			return (0.063);
		} else if ( all.equal(buff, f6) == TRUE ) {
			return (-0.815);
		} else if ( all.equal(buff, f7) == TRUE ) {
			return (-0.952);
		} else if ( all.equal(buff, f8) == TRUE ) {
			return (-0.652);
		} else if ( all.equal(buff, f9) == TRUE ) {
			return (-0.753);
		} else if ( all.equal(buff, f10) == TRUE ) {
			return (1.723);
		} else if ( all.equal(buff, f11) == TRUE ) {
			return (-4.964);
		} else if ( all.equal(buff, f12) == TRUE ) {
			return (-1.311);
		} else if ( all.equal(buff, f13) == TRUE ) {
			return (1.454);
		} else if ( all.equal(buff, f14) == TRUE ) {
			return (0.576);
		} else if ( all.equal(buff, f15) == TRUE ) {
			return (0.439);
		} else if ( all.equal(buff, f16) == TRUE ) {
			return (0.739);
		} else if ( all.equal(buff, f17) == TRUE ) {
			return (-3.527);
		} else if ( all.equal(buff, f18) == TRUE ) {
			return (-1.051);
		} else if ( all.equal(buff, f19) == TRUE ) {
			return (-7.738);
		} else if ( all.equal(buff, f20) == TRUE ) {
			return (-4.085);
		} else if ( all.equal(buff, f21) == TRUE ) {
			return (1.002);
		} else if ( all.equal(buff, f22) == TRUE ) {
			return (0.124);
		} else if ( all.equal(buff, f23) == TRUE ) {
			return (-0.013);
		} else if ( all.equal(buff, f24) == TRUE ) {
			return (0.286);
		} else if ( all.equal(buff, f25) == TRUE ) {
			return (-6.664);
		} else if ( all.equal(buff, f26) == TRUE ) {
			return (-4.189);
		} else if ( all.equal(buff, f27) == TRUE ) {
			return (-10.876);
		} else if ( all.equal(buff, f28) == TRUE ) {
			return (-7.223);
		} else if ( all.equal(buff, f29) == TRUE ) {
			return (-1.133);
		} else if ( all.equal(buff, f30) == TRUE ) {
			return (-2.011);
		} else if ( all.equal(buff, f31) == TRUE ) {
			return (-2.158);
		}else 
			return (-1.849);	
	}

	
