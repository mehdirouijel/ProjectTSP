/*
 *  The definition of a city.
 *
 *
 *  Created by: Mehdi Rouijel
 *
 * * * * * * * * * * * * * * * * * * * */


public class
City
{
    int x;
    int y;
    
    
    public
    City()
    {
        this.x = ( int )( LEFT_PANEL_WIDTH + Math.random() * width );
        this.y = ( int )( LEFT_PANEL_WIDTH + Math.random() * height );
    }
    
    public
    City( int theX, int theY )
    {
        this.x = theX;
        this.y = theY;
        this.y = theY;
    }
    
    
    public double
    distanceTo( City to )
    {
        int a = Math.abs( this.x - to.x );
        int b = Math.abs( this.y - to.y );
        double distance = Math.sqrt( a*a + b*b );
        
        return distance;
    }
    
    public void
    draw()
    {
        fill( 0 );
    
        ellipse( x, y, 8, 8 );
    }
}