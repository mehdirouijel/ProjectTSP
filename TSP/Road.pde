public class
Road
{
    public City from;
    public City to;
    public double distance;
    
    
    public
    Road( City theFrom, City theTo )
    {
        this.from = theFrom;
        this.to = theTo;
        
        int a = to.x - from.x;
        int b = to.y - from.y;
        this.distance = Math.sqrt( a*a + b*b );
    }
    
    
    public void
    draw()
    {
        stroke( 190 );
        strokeCap( SQUARE );
        line( from.x, from.y, to.x, to.y );
    }
    
}