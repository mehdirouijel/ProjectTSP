/*
 *  In this implementation, an Individual
 *  is a path that connects all cities.
 *
 * * * * * * * * * * * * * * * * * * * */

import java.util.Collections;


public class
Individual
{
    
    public ArrayList< City > path = new ArrayList();
    private double totalDistance = 0.0;
    
    
    public
    Individual( boolean empty )
    {
        if ( empty )
        {
            for ( int i = 0; i < cities.size(); ++i )
            {
                path.add( null );
            }
            
        }
        else
        {
            for ( int i = 0; i < cities.size(); ++i )
            {
                path.add( cities.get( i ) );
            }
        
            Collections.shuffle( path );
        }
    }
    
    public
    Individual()
    {
    }
    
    
    public double
    getTotalDistance()
    {
        if ( totalDistance == 0.0 )
        {
            for ( int i = 0; i < path.size(); ++i )
            {
                if ( i > 0 )
                    this.totalDistance += path.get( i ).distanceTo( path.get( i-1 ) );
                else
                    this.totalDistance += path.get( 0 ).distanceTo( path.get( path.size()-1 ) );
            }
        }
        
        return this.totalDistance;
    }
    
    public void
    draw()
    {
        for ( int i = 0; i < path.size()-1; ++i )
        {
            stroke( 255, 255, 0 );
            strokeCap( SQUARE );
            line( path.get( i ).x,
                  path.get( i ).y,
                  path.get( i+1 ).x,
                  path.get( i+1 ).y );
        }
        
        line( path.get( path.size()-1 ).x,
              path.get( path.size()-1 ).y,
              path.get( 0 ).x,
              path.get( 0 ).y );
              
        stroke( 0 );
    }
    
}