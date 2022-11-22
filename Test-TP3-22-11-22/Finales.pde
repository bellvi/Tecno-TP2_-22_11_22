void finalR() {
  if ( estado.equals("fin R") ) {
    background( 0 );
    image(rojo, 0, 0);
    golR = 0;
    golA = 0;
    ball.setVelocity( 0, 0 );
    ball.inicializar(width/2, height/2 );



    if ( reiniciarRojo && estado.equals("fin R") ) {
      estado = "inicio";
      tiempoGol = 50;
      timeGol = false;
      goal = false;
      festejo = false;
      arbitro.rewind();
    }
  }
}

void finalA() {
  if ( estado.equals("fin A") ) {
    background( 0 );
    image(azul, 0, 0);
    golA = 0;
    golR = 0;
    ball.setVelocity( 0, 0 );
    ball.inicializar(width/2, height/2 );


    if ( reiniciarAzul && estado.equals("fin A") ) {
      estado = "inicio";
      tiempoGol = 50;
      timeGol = false;
      goal = false;
      festejo = false;
      arbitro.rewind();
    }
  }
}

void resetCondicion() {
  if ( estado.equals( "fin A" ) || estado.equals( "fin R" )) {
    if ( p1.getX() >= 800 && p1.getY() > 860 && p1.getY() < 1000 && p1.getX() <= 1125  || p2.getX() >= 800 && p2.getY() > 860 && p2.getY() < 1000 && p2.getX() <= 1125 ) {
      reiniciarAzul = true;
      reiniciarRojo = true;
    }

    OscMessage myMessageRei = new OscMessage("/composition/layers/2/clips/6/connect");
    myMessageRei.add(1);
    /* send the message */
    oscP5.send(myMessageRei, myRemoteLocation);

    OscMessage myMessageRei1 = new OscMessage("/composition/layers/1/clips/7/connect");
    myMessageRei1.add(1);
    /* send the message */
    oscP5.send(myMessageRei1, myRemoteLocation);
  }
}
