F5Cuban1 <- function(buff){
  
	F3Cuban1 <-array(dim=8)
	F3Cuban1[1]= 0.595
	F3Cuban1[2]= 0.2
	F3Cuban1[3]= 0.595
	F3Cuban1[4]= 0.1
	F3Cuban1[5]= 1.0
	F3Cuban1[6]= 0.05
	F3Cuban1[7]= 0.09
	F3Cuban1[8]= 0.15

  if ( (buff[1] == buff[3]) && (buff[2] == buff[4]) ){

    return (4*F3Cuban1[ 4*buff[0] + 2*buff[1] + buff[2] ]);

  }else{
    return (0);
  }
}