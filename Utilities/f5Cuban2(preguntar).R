F5Cuban2 <- function(buff){

 object1 <- new("OneMax",x = buff);

  if ( buff[4] == 0 ){

    return (fitness(object1));

  }else{

    if ( (buff[0] == 0) ){

      return (0);

    }else{

      return (fitness(object1)- 2);
    }
}
}