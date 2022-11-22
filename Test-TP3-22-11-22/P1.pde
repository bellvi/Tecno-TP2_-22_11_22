class P1 extends FCircle {

  float velocidad;
  boolean unPress, upPress, derPress, izqPress;
  Blob b;
  
  //x_ es el tamaño que se le da al circle
  //n es el nombre para el contacto
  P1( float x_, String n ) {
    super ( x_ );
    b = new Blob();
    setGrabbable(false);
    setDensity(10);
    setRotatable(false);
    setRestitution(1);
    setName( n );
  }

  void inicializar( float x_, float y_ ) {   
    velocidad = 500;
    setPosition( x_, y_ );

    unPress = false;
    upPress = false;
    derPress = false;
    izqPress = false;

  }
  
  void actualizar(){

    if( upPress ){
      setVelocity( getVelocityX(), -velocidad );
    }
    if( unPress ){
      setVelocity( getVelocityX(), velocidad );
    }
    if( derPress ){
      setVelocity( velocidad, getVelocityY() );
    }
    if( izqPress ){
      setVelocity( -velocidad, getVelocityY() );
    }
    
    if( !upPress && !unPress && !derPress && !izqPress  ){
      setVelocity( 0, 0 );
    }
    
  }
  
  
}
