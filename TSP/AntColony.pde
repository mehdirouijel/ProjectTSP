/*
 *  The implementation of the ACO algorithm.
 *
 * * * * * * * * * * * * * * * * * * * */


public class
AntColony
{
    
    private final static int POPULATION_SIZE = 20;
    private final static int MAX_ITERATIONS = 100;
    private final static float PHEROMONE_EVAPORATION_RATE = 0.5;
    public final static int PHEROMONE_BIAS = 1; // NOTE: Influence of the pheromones in choosing a path.
    public final static int HEURISTIC_BIAS = 2; // NOTE: Influence of heuristic in choosing a path.
    
    public ArrayList< Ant > ants = new ArrayList();
    int currentIteration = 0;
    
    
    public
    AntColony()
    {
    }
    
    
    public void
    run()
    {
        ants.clear();
        
        for( int i = 0; i < POPULATION_SIZE; ++i )
            ants.add( new Ant() );

        for ( Ant a : ants )
        {
            a.findPath(); //<>//
            a.backtrack();
        }
        
        /*
        Ant best = getBestPath();
        
        for ( Road r : best.roadSoFar )
            r.draw( 255, 255, 0, 1 );
        */
    }
    
    public void
    updatePheromones()
    {
        for ( Road r : roads )
            r.pheromones = ( 1 - PHEROMONE_EVAPORATION_RATE ) * r.pheromones;
    }
    
    public Ant
    getBestPath()
    {
        Ant best = ants.get( 0 );
        
        for ( int i = 1; i < ants.size(); ++i )
        {
            if ( ants.get( i ).getTotalDistance() < best.getTotalDistance() )
                best = ants.get( i );
        }
        
        return best;
    }
    
}