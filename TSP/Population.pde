/*
 *  A Population represents all individuals in
 *  a generation.
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Population
{
    
    public ArrayList< Individual > paths = new ArrayList();
    
    
    public
    Population( int nbOfIndividuals, boolean generate )
    {
        for ( int i = 0; i < nbOfIndividuals; ++i )
        {
            if ( generate )
                paths.add( new Individual( false ) );
            else
                paths.add( null );
        }
    }
    
    
    public Individual
    getBest()
    {
        Individual best = paths.get( 0 );
        
        for ( int i = 1; i < paths.size(); ++i )
        {
            if ( paths.get( i ).getTotalDistance() < best.getTotalDistance() )
                best = paths.get( i );
        }
        
        return best;
    }
    
    public void
    draw()
    {
        for ( int i = 0; i < paths.size(); ++i )
        {
            paths.get( i ).draw();
        }
    }
    
}