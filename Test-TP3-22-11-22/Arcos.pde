class Arcos extends FBox{
  
  Arcos( float w, float h, String n ){
    
    super( w, h );
    setName( n );
    setStatic(true);
    setGrabbable(false);
  }
  
  void inicializar( float x, float y, float a, float b, float c){
    setPosition( x, y );
    setFill( a,b,c );
  }


}
