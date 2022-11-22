
boolean x3 = false;
boolean power1 = false;

boolean invisibilidad = false;
boolean power2 = false;

boolean kilogramo = false;
boolean power3 = false;

//Box 2
void multiplicacion() {

  if ( x3 ) {

    if ( power1 ) {
      mundo.add( Px1 );
      mundo.add( Px2 );
      Px1.inicializar( ball.getX()+100, ball.getY()+100 );
      Px2.inicializar( ball.getX()-100, ball.getY()-100 );
      Px1.attachImage( pelota );
      Px2.attachImage( pelota );
      Px1.setVelocity( ball.getVelocityX()+10, ball.getVelocityY()+10 );
      Px2.setVelocity( ball.getVelocityX()-10, ball.getVelocityY()-10 );
      Px1.setRestitution(1);
      Px2.setRestitution(0.8);
      power1 = false;
      poder.play();
      poder.rewind();
      mundo.remove( b2 );
      
    }

    timerMultiplicacion --;

    if ( timerMultiplicacion == 0 ) {
      mundo.remove( Px1 );
      mundo.remove( Px2 );
      timerMultiplicacion = 300;
      x3 = false;
      mundo.add( b2 );
    }
  }
}



//Box3
void invisibilidad() {

  if ( invisibilidad ) {

    if ( power2 ) {
      ball.attachImage( pelotaInvisible );
      Px1.attachImage( pelotaInvisible );
      Px2.attachImage( pelotaInvisible );
      ball.setDensity( 13000 );
      power2 = false;
      poder.play();
      poder.rewind();
      mundo.remove( b3 );
    }

    timerInvisibilidad --;

    if ( timerInvisibilidad == 0 ) {

      ball.attachImage( pelota );
      Px1.attachImage( pelota );
      Px2.attachImage( pelota );
      ball.setDensity( 13 );
      timerInvisibilidad = 200;
      invisibilidad = false;
      mundo.add( b3 );
      //pelota = loadImage("Pelota tejo.png");
    }
  }
}


//Box4
void pesada() {

  if ( kilogramo ) {

    if ( power3 ) {
      ball.attachImage( roca );
      Px1.attachImage( roca );
      Px2.attachImage( roca );
      ball.setDensity( 8000 );
      power3 = false;
      poder.play();
      poder.rewind();
      mundo.remove( b4 );
    }

    timerKilo --;

    if ( timerKilo == 0 ) {

      ball.attachImage( pelota );
      Px1.attachImage( pelota );
      Px2.attachImage( pelota );
      ball.setDensity( 13 );
      timerKilo = 200;
      kilogramo = false;
      mundo.add( b4 );
    }
  }
}
