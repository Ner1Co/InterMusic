class CustomKnob extends Knob {

  int current = 0xffff0000;

  float a = 128;

  float na;

  int y;

  // use the convenience constructor of super class Controller
  // MyButton will automatically registered and move to the 
  // default controlP5 tab.

  CustomKnob(ControlP5 cp5, String theName) {
    super(cp5, theName);

    // replace the default view with a custom view.
    setView(new ControllerView() {
      public void display(PGraphics p, Object b) {        
        translate( ( int ) getRadius( ) , ( int ) getRadius( ) );

      pushMatrix( );
      ellipseMode( PApplet.CENTER );
      noStroke( );
      fill( getColor( ).getBackground( ) );
      ellipse( 0 , 0 , getRadius( ) * 2 , getRadius( ) * 2 );
      popMatrix( );
      int c = isActive( ) ? getColor( ).getActive( ) : getColor( ).getForeground( );
      pushMatrix( );
      if ( getViewStyle( ) == Controller.LINE ) {
        rotate( getAngle( ) );
        stroke( c );
        strokeWeight( getTickMarkWeight( ) );
        line( 0 , 0 , getRadius( ) , 0 );
      } else if ( getViewStyle( ) == Controller.ELLIPSE ) {
        rotate( getAngle( ) );
        fill( c );
        ellipse( getRadius( ) * 0.75f , 0 , getRadius( ) * 0.2f , getRadius( ) * 0.2f );
      } else if ( getViewStyle( ) == Controller.ARC ) {
        fill( c );
        arc( 0 , 0 , getRadius( ) * 1.4f , getRadius( ) * 1.4f , getStartAngle( ) , getAngle( ) + ( ( getStartAngle( ) == getAngle( ) ) ? 0.06f : 0f ) );
        fill( red( getColor( ).getBackground( ) ) , green( getColor( ).getBackground( ) ) , blue( getColor( ).getBackground( ) ) , 255 );
        ellipse( 0 , 0 , getRadius( ) * 1.2f , getRadius( ) * 1.2f );
      }
      popMatrix( );

      pushMatrix( );
      rotate( getStartAngle( ) );

      if ( isShowTickMarks( ) ) {
        float step = getAngleRange( ) / getNumberOfTickMarks( );
        stroke( getColor( ).getForeground( ) );
        strokeWeight( getTickMarkWeight( ) );
        for ( int i = 0 ; i <= getNumberOfTickMarks( ) ; i++ ) {
          line( getRadius( ) + 2 , 0 , getRadius( ) + getTickMarkLength( ) + 2 , 0 );
          rotate( step );
        }
      } else {
        if ( isShowAngleRange( ) ) {
          stroke( getColor( ).getForeground( ) );
          strokeWeight( getTickMarkWeight( ) );
          line( getRadius( ) + 2 , 0 , getRadius( ) + getTickMarkLength( ) + 2 , 0 );
          rotate( getAngleRange( ) );
          line( getRadius( ) + 2 , 0 , getRadius( ) + getTickMarkLength( ) + 2 , 0 );
        }
      }
      noStroke( );
      popMatrix( );

      pushMatrix( );
      translate( -getWidth( ) / 2 , -getHeight( ) / 2 );
      if ( isLabelVisible ) {
        _myCaptionLabel.draw( p , 0 , 0  );
        _myValueLabel.align( ControlP5.CENTER , ControlP5.CENTER );
        _myValueLabel.draw( p , 0 , 0);
      }
      popMatrix( );
        
        
      }
    }
    );
  }
}
