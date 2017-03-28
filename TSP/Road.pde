/*
 *  This class is just used to draw all the
 *  possible roads. It's kind of useless really...
 *
 *
 *  Created by: Mehdi Rouijel
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Road
{
    public City from;
    public City to;
    // NOTE: We're going to need a value of pheromones between 0 and 1, I think.
    public float pheromones;
    
    
    public
    Road( City theFrom, City theTo )
    {
        this.from = theFrom;
        this.to = theTo;
        this.pheromones = 1.0;
    }
    
    
    public double
    getDistance()
    {
        double distance = 0.0;
        
        distance = from.distanceTo( to );
        
        return distance;
    }
    
    
    public void
    draw()
    {
        stroke( 190 );
        strokeCap( SQUARE );
        line( from.x, from.y, to.x, to.y );
        stroke( 0 );
    }
    
    public void
    draw( int r, int g, int b, int weight )
    {
        stroke( r, g, b );
        strokeWeight( weight );
        strokeCap( SQUARE );
        line( from.x, from.y, to.x, to.y );
        
        stroke( 0 );
        strokeWeight( 1 );
    }
    
    public void
    draw( int r, int g, int b, float a, int weight )
    {
        stroke( r, g, b, a );
        strokeWeight( weight );
        strokeCap( SQUARE );
        line( from.x, from.y, to.x, to.y );
        
        stroke( 0 );
        strokeWeight( 1 );
    }
    
}