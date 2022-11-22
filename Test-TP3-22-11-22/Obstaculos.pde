class Obstaculos extends FBox {


  Obstaculos() {
    super( 20, 100 );
  }

  void inicializar(float x, float x1, float y, float y1) {

    setPosition( random( x, x1 ), random( y, y1 ) );
    setDensity( 500000 );
    setFill( 178, 48, 176 );
    setRotatable(false);
    //setStatic(true);
    setGrabbable(false);
    
    
  }

  void actualizar( float y ) {
    setVelocity( getVelocityX(), y);
  }
}


void obstaculoFuncion() {

  if ( estado.equals( "juego" ) || estado.equals( "gol" ) ) {

    if ( obstaculos ) {

      if ( power ) {
        mundo.add( o );
        mundo.add( o1 );
        mundo.remove( b1 );
        power = false;
        poder.play();
        poder.rewind();
      }


      timerObstaculo --;

      if ( o.getY() >= height-100 ) {
        obsY = obsY*-1;
      } else if ( o.getY() <= 100 ) {
        obsY = obsY*-1;
      }
      if ( o.getY() >= height-100 ) {
        obsY1 = obsY1*-1;
      } else if ( o.getY() <= 100 ) {
        obsY1 = obsY1*-1;
      }

      o.actualizar( obsY );
      o1.actualizar( obsY1 );

      if ( timerObstaculo == 0 ) {
        mundo.remove( o );
        mundo.remove( o1 );
        mundo.add( b1 );
        timerObstaculo = 400;
        obstaculos = false;
      }
    }
  }
}

void sacarObstaculos() {
  if ( estado.equals( "final R" ) || estado.equals( "final A" ) ) {
    mundo.remove( o );
    mundo.remove( o1 );
    mundo.add( b1 );
    timerObstaculo = 400;
    obstaculos = false;
  }
}
