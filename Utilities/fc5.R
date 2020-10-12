 Fc5 <- function(buff){

  m = (length(buff) - 5)/8;

   sum = F5Cuban1(buff);

  for ( i in 1:m){
    sum = sum + F5Cuban2(buff[4*(2*i+1)]) + F5Cuban1(buff[4*(2*i+2)]);
}
  return (sum);
} 