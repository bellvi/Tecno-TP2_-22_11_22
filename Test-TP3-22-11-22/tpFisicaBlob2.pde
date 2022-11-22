import netP5.*;
import oscP5.*;

import spout.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

FWorld mundo;
P1 p1;
P2 p2;
Ball ball;
Ball Px1, Px2;
Obstaculos o, o1;
Arcos a1, a2;
FCircle test;
FBox b1, b2, b3, b4;
FBox pared, pared1, pared2, pared3;
String estado = "inicio";
PImage cancha, inicio, rojo, azul, pelota, golImg, pelotaInvisible, defensa, invisible, x3p, roca;
PImage blue, red, marcador, tiempo, cincoK;
boolean golRojo, golAzul, goal;
PFont f;
int golR = 0;
int golA = 0;
int golesToWin = 3;
boolean reiniciarRojo, reiniciarAzul;
int tiempoGol = 120;
int boxesTimer = 120;
int innerTimer = 120;
boolean timeGol = false;
boolean festejo = false;
boolean removeObstaculos = false;
int timer1 = 0;

//sonido
Minim minim;
AudioPlayer arbitro, hinchada, golSound, poder;
AudioSample pase, rocaSonido;

FMouseJoint f1, f2;

//BlobTracker Detect

int PUERTO_OSC = 12345;
Receptor receptor, receptor1;
Administrador admin;

//Poderes

float timerObstaculo = 400;
float timerMultiplicacion = 200;
float timerInvisibilidad = 200;
float timerKilo = 200;

boolean obstaculos = false;
boolean power = false;
float obsY = 500;
float obsY1 = -500;

//resolume

Spout spout;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {

  //size( 1200, 600 );
  fullScreen(P3D);
  textAlign( CENTER );

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(color(20));
  mundo.setGravity(0, 0);


  minim = new Minim(this);

  arbitro = minim.loadFile("Arbitro.mp3");
  pase = minim.loadSample("Pase pelota.mp3");
  rocaSonido = minim.loadSample( "roca.mp3" );
  hinchada = minim.loadFile("ambiente.mp3");
  golSound = minim.loadFile("gol 2.mp3");
  poder = minim.loadFile("poderes.mp3");

  f = createFont( "Evogriaback-Regular.otf", 50 );



  //BBlobTracker

  setupOSC(PUERTO_OSC);

  receptor = new Receptor();

  receptor1 = new Receptor();

  admin = new Administrador(mundo);

  //Juego

  cancha = loadImage( "cancha.jpg" );
  inicio = loadImage( "menu.jpg" );
  rojo = loadImage( "rojo.jpg" );
  azul = loadImage( "azul.jpg" );
  pelota = loadImage( "ball.png" );
  golImg = loadImage( "gol.png" );
  pelotaInvisible = loadImage( "ballInvisible.png" );
  defensa = loadImage( "defensas.png" );
  invisible = loadImage( "invisible.png" );
  x3p = loadImage( "poderes.png" );


  blue = loadImage( "blue.png" );
  red = loadImage( "red.png" );
  tiempo = loadImage( "tiempo.png" );
  roca = loadImage( "roca.png" );
  cincoK = loadImage( "5k.png" );



  marcador = loadImage( "marcador.png" );

  p1 = new P1(130, "p1");
  p1.inicializar( 100, height/2 );
  p1.setFill( 255, 0, 0 );
  p1.attachImage( red );
  mundo.add( p1 );

  p2 = new P2(130, "p2");
  p2.inicializar( width-100, height/2 );
  p2.setFill( 0, 0, 255 );
  p2.attachImage( blue );
  mundo.add( p2 );

  //test = new FCircle( 50 );
  //test.setPosition( 400,height/2 );
  //mundo.add( test );

  ball = new Ball( 50, "ball" );
  ball.inicializar( width/2, height/2 );
  ball.attachImage( pelota );
  mundo.add( ball );

  a1 = new Arcos( 10, 150, "arco1" );
  a1.inicializar( 10, height/2, 255, 0, 0 );
  mundo.add( a1 );

  a2 = new Arcos( 10, 150, "arco2" );
  a2.inicializar( width-10, height/2, 0, 0, 255 );
  mundo.add( a2 );

  //Obstaculos
  b1 = new FBox( 50, 50 );
  b1.setName( "box1" );
  b1.setPosition( random( 50, width-50 ), random( 20, height-20) );
  b1.attachImage( defensa );
  //b1.attachImage( defensas );
  b1.setNoStroke();
  b1.setSensor(true);
  b1.setPosition(-200, 0);
  mundo.add(b1);


  //Multiplicacion
  b2 = new FBox( 50, 50 );
  b2.setName( "box2" );
  b2.setPosition( random( 50, width-50 ), random( 20, height-20) );
  b2.attachImage( x3p );
  //b1.attachImage( defensas );
  b2.setNoStroke();
  b2.setSensor(true);
  b2.setPosition(-200, 0);
  mundo.add( b2 );

  //Invisibilidad
  b3 = new FBox( 50, 50 );
  b3.setName( "box3" );
  b3.setPosition( random( 50, width-50 ), random( 20, height-20) );
  b3.attachImage( invisible );
  //b1.attachImage( defensas );
  b3.setNoStroke();
  b3.setSensor(true);
  b3.setPosition(-200, 0);
  mundo.add( b3 );

  //Pesada
  b4 = new FBox( 50, 50 );
  b4.setName( "box4" );
  b4.setPosition( random( 50, width-50 ), random( 20, height-20) );
  b4.attachImage( cincoK );
  b4.setNoStroke();
  b4.setSensor(true);
  b4.setPosition(-200, 0);
  mundo.add( b4 );


  f1 = new FMouseJoint( p1, 100, height/2 );
  mundo.add( f1 );

  f2 = new FMouseJoint( p2, width-100, height/2 );
  mundo.add( f2 );


  // Poderes

  o = new Obstaculos();
  o.inicializar( 200, 300, 50, height-50 );

  o1 = new Obstaculos();
  o1.inicializar( width-200, width-300, 50, height-50 );

  // Multiplicación

  Px1 = new Ball( 50, "ballx1" );
  Px1.inicializar( ball.getX(), ball.getY() );
  //mundo.add( pow );

  Px2 = new Ball( 50, "ballx2" );
  Px2.inicializar( ball.getX(), ball.getY() );
  //mundo.add( pow1 );

  //Paredes gronchas

  //Pared de arriba
  pared = new FBox( width, 15 );
  pared.setPosition( width/2, 0);
  pared.setStatic( true );
  pared.setFill( 255, 0, 10);
  pared.setName( "pared" );
  mundo.add( pared );
  //Pared de abajo
  pared1 = new FBox( width, 15 );
  pared1.setPosition( width/2, height);
  pared1.setStatic( true );
  pared1.setFill( 255, 0, 10);
  pared1.setName( "pared" );
  mundo.add( pared1 );
  //Pared izquierda
  pared2 = new FBox( 15, height );
  pared2.setPosition( 0, height/2);
  pared2.setStatic( true );
  pared2.setFill( 255, 0, 10);
  pared2.setName( "pared" );
  mundo.add( pared2 );
  //Pared derecha
  pared3 = new FBox( 15, height );
  pared3.setPosition( width, height/2);
  pared3.setStatic( true );
  pared3.setFill( 255, 0, 10);
  pared3.setName( "pared" );
  mundo.add( pared3 );

  //resolume

  spout = new Spout(this);
  spout.setSenderName("Spout Processing Sender");

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("192.168.1.2", 7000);
}

void draw() {
  //println( "estado : " + estado );
  background(150);

  arbitro.play();

  if (!hinchada.isPlaying()) {
    hinchada.rewind();
    hinchada.play();
  }

  if (!golSound.isPlaying()) {
    golSound.rewind();
  }


  //BBlobTracker
  receptor.actualizar(mensajes); //
  receptor.dibujarBlobs(width, height);
  receptor1.actualizar(mensajes); //
  receptor1.dibujarBlobs(width, height);

  //Finales

  if ( golR == golesToWin ) {
    estado = "fin R";
    mundo.remove( Px1 );
    mundo.remove( Px2 );
    mundo.remove( o );
    mundo.remove( o1 );
    ball.attachImage( pelota );
    Px1.attachImage( pelota );
    Px2.attachImage( pelota );
  }

  if ( golA == golesToWin ) {
    estado = "fin A";
    mundo.remove( Px1 );
    mundo.remove( Px2 );
    mundo.remove( o );
    mundo.remove( o1 );
    ball.attachImage( pelota );
    Px1.attachImage( pelota );
    Px2.attachImage( pelota );
  }

  // Eventos de entrada y salida


  //p1 = null;
  //p2 = null;

  for (Blob b : receptor.blobs) {

    //println( b.id + " " + b.centroidX );

    if ( b.centroidX*width < width/2 ) {

      f1.setTarget( b.centroidX*width, b.centroidY*height ) ;    //CAMBIAR POR MOUSE JOINT
      //admin.crearPuntero(b);
      //println("--> entro blob: " + b.id);
    } else {
      f2.setTarget( b.centroidX*width, b.centroidY*height ) ;
    }


    if (b.salio) {
      admin.removerPuntero(b);
      //println("<-- salio blob: " + b.id);
    }

    admin.actualizarPuntero(b);
  }

  //Juego general

  p1.actualizar();
  p2.actualizar();

  // Estado inicio & pasa a estado juego con los mazos.

  if ( estado.equals( "inicio" ) ) {
    image( inicio, 0, 0);
    reiniciarAzul = false;
    reiniciarRojo = false;
    if ( p1.getX() >= 800 && p1.getY() >= 470 && p1.getY() <= 605 && p1.getX() <= 1125 || p2.getX() >= 800 && p2.getY() >= 470 && p2.getY() <= 605 && p2.getX() <= 1125 ) {
      estado = "juego";
    }
  }

  // Estado juego

  if ( estado.equals( "juego" ) || estado.equals ( "gol" ) ) {

    timer1 ++;
    fill( 255 );
    textSize( 20 );
    image( cancha, 0, 0 );
    image( marcador, width/2-200, 50 );
    image( tiempo, width/2-70, 180 );
    text( "PT : " + timer1, width/2, 210 );
    pushStyle();
    textFont( f );
    text( golR, width/2-40, 155 );
    text( golA, width/2+40, 155 );
    popStyle();

    arbitro.play();

    boxesTimer --;
    if ( frameCount % 150 == 0 ) {

      b1.setPosition(-200, 0);
      b2.setPosition(-200, 0);
      b3.setPosition(-200, 0);

      int azar = int( random( 0, 4 ) );
      //println( azar );


      if ( azar == 1 ) {
        b1.setPosition(random(150, width-100), random(100, height-100));
      } else if ( azar == 2) {
        b2.setPosition(random(150, width-100), random(100, height-100));
      } else if ( azar == 3) {
        b3.setPosition(random(150, width-100), random(100, height-100));
      } else if ( azar == 0) {
        b4.setPosition(random(150, width-100), random(100, height-100));
      }
    }

    // Invisibilidad

    invisibilidad();

    // Obstaculos

    sacarObstaculos();
    obstaculoFuncion();

    // Multiplicación

    multiplicacion();

    //Pesada

    pesada();




    // ------------

    if ( timeGol == true ) {
      tiempoGol --;

      if ( tiempoGol > 0 ) {
        image(golImg, 0, 60);
        golSound.play();
      }
    }

    if ( tiempoGol == 0 ) {
      estado = "gol";
      goal = true;
      tiempoGol = 120;
      timeGol = false;
      arbitro.rewind();
      
    }

    if ( estado.equals("gol") && goal == true ) {
      ball.setVelocity( 0, 0 );
      ball.inicializar(width/2, height/2 );
      goal = false;
      festejo = false;
      arbitro.rewind();

      OscMessage myMessage = new OscMessage("/composition/layers/2/clips/1/connect");
      myMessage.add(1);
      
      OscMessage myMessage1 = new OscMessage("/composition/layers/1/clips/3/connect");
      myMessage1.add(1);

      /* send the message */
      oscP5.send(myMessage, myRemoteLocation);
      oscP5.send(myMessage1, myRemoteLocation);
     
    }
  }

  //Finales
  finalR();
  finalA();
  resetCondicion();

  mundo.step();
  mundo.draw();

  spout.sendTexture();
}




void contactStarted( FContact c ) {
  FBody f1 = c.getBody1();
  FBody f2 = c.getBody2();

  println( "c1 : " + f1.getName() );
  println( "c2 : " + f2.getName() );

  //Contacto pelota - jugadores
  if (f1.getName() == "p1" && f2.getName() == "ball" || f1.getName() == "ball" && f2.getName() == "p1" || f1.getName() == "ball" && f2.getName() == "p2" || f1.getName() == "p2" && f2.getName() == "ball") {
    if ( kilogramo ) {
      rocaSonido.trigger();
    } else pase.trigger();
  }
  //Contacto pelota - arco1
  if ( (f1.getName() == "ball" && f2.getName() == "arco1" || f1.getName() == "arco1" && f2.getName() == "ball" || f1.getName() == "ballx2" && f2.getName() == "arco1" || f1.getName() == "arco1" && f2.getName() == "ballx2" ) && !festejo ) {
    golA ++;
    timeGol = true;
    festejo = true;
    OscMessage myMessage = new OscMessage("/composition/layers/1/clips/2/connect");
    myMessage.add(1);

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }
  //Contacto pelota - arco2
  if ( (f1.getName() == "ball" && f2.getName() == "arco2" || f1.getName() == "arco2" && f2.getName() == "ball" || f1.getName() == "ballx1" && f2.getName() == "arco2" || f1.getName() == "arco2" && f2.getName() == "ballx1" ) && !festejo ) {
    golR ++;
    timeGol = true;
    festejo = true;
    OscMessage myMessage = new OscMessage("/composition/layers/2/clips/2/connect");
    myMessage.add(1);

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }
  //Contacto mazo - box1
  if ( (f1.getName() == "p1" && f2.getName() == "box1" || f1.getName() == "box1" && f2.getName() == "p1" || f1.getName() == "p2" && f2.getName() == "box1" || f1.getName() == "box1" && f2.getName() == "p2") && !obstaculos && !power && !estado.equals("fin A") && !estado.equals("fin R") ) {
    obstaculos = true;
    power = true;
  }

  //Contacto mazo - box2
  if ( (f1.getName() == "p1" && f2.getName() == "box2" || f1.getName() == "box2" && f2.getName() == "p1" || f1.getName() == "p2" && f2.getName() == "box2" || f1.getName() == "box2" && f2.getName() == "p2") && !x3 && !power1 && !estado.equals("fin A") && !estado.equals("fin R") ) {
    x3 = true;
    power1 = true;
    pase.trigger();
  }

  //Contacto mazo - box3
  if ( (f1.getName() == "p1" && f2.getName() == "box3" || f1.getName() == "box3" && f2.getName() == "p1" || f1.getName() == "p2" && f2.getName() == "box3" || f1.getName() == "box3" && f2.getName() == "p2") && !invisibilidad && !power2 && !estado.equals("fin A") && !estado.equals("fin R") ) {
    invisibilidad = true;
    power2 = true;
  }

  //Contacto mazo - box4
  if ( (f1.getName() == "p1" && f2.getName() == "box4" || f1.getName() == "box4" && f2.getName() == "p1" || f1.getName() == "p2" && f2.getName() == "box4" || f1.getName() == "box4" && f2.getName() == "p2") && !kilogramo && !power3 && !estado.equals("fin A") && !estado.equals("fin R") ) {
    kilogramo = true;
    power3 = true;
  }

  //Contacto pelota - paredes
  if ( (f1.getName() == "ball" && f2.getName() == "pared" || f1.getName() == "pared" && f2.getName() == "ball" ) ) {

    if ( kilogramo ) {
      rocaSonido.trigger();
    } else pase.trigger();
  }
}











void keyPressed() {


  if ( key == 'w' ) {
    p1.upPress = true;
  }
  if ( key == 's' ) {
    p1.unPress = true;
  }
  if ( key == 'd' ) {
    p1.derPress = true;
  }
  if ( key == 'a' ) {
    p1.izqPress = true;
  }




  if ( keyCode == UP ) {
    p2.upPress = true;
  }
  if ( keyCode == DOWN ) {
    p2.unPress = true;
  }
  if ( keyCode == RIGHT ) {
    p2.derPress = true;
  }
  if ( keyCode == LEFT ) {
    p2.izqPress = true;
  }
}

void keyReleased() {

  if ( key == 'w' ) {
    p1.upPress = false;
  }
  if ( key == 's' ) {
    p1.unPress = false;
  }
  if ( key == 'd' ) {
    p1.derPress = false;
  }
  if ( key == 'a' ) {
    p1.izqPress = false;
  }



  if ( keyCode == UP ) {
    p2.upPress = false;
  }
  if ( keyCode == DOWN ) {
    p2.unPress = false;
  }
  if ( keyCode == RIGHT ) {
    p2.derPress = false;
  }
  if ( keyCode == LEFT ) {
    p2.izqPress = false;
  }
}
