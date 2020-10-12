Fc4 <- function(buff){

  m = (length(buff) - 1)/4;

 sum = 0;

  for ( i in 1:m){

    sum = sum +  F5Cuban1(buff[4*i]);
  }
  return (sum);
}
