/*
 *  This class is just used to draw all the
 *  possible roads. It's kind of useless really...
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Road
{
    public City from;
    public City to;
    
    
    public
    Road( City theFrom, City theTo )
    {
        this.from = theFrom;
        this.to = theTo;
    }
    
    
    public void
    draw()
    {
        stroke( 180 );
        strokeCap( SQUARE );
        line( from.x, from.y, to.x, to.y );
        stroke( 0 );
    }
    
}