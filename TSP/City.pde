public class
City
{
    int x;
    int y;
    
    public
    City()
    {
        this.x = ( int )( Math.random() * width );
        this.y = ( int )( Math.random() * height );
    }
    
    public
    City( int theX, int theY )
    {
        this.x = theX;
        this.y = theY;
    }
}