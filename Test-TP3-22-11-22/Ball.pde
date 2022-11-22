class Ball extends FCircle{
  
  //tam = diametro de la bola
  Ball( float tam, String n ){
    super( tam );
    setName( n );
    setDensity(13);
    setRestitution(1.1);
  }
  
  void inicializar( float x, float y ){
    
    setPosition( x,y );
    
  }
  
}
