/*
 *  The implementation of the ACO algorithm.
 *
 * * * * * * * * * * * * * * * * * * * */


public class
AntColony
{
    
    private final static int POPULATION_SIZE = 20;
    private final static int MAX_ITERATIONS = 100;
    public final static int PHEROMONE_BIAS = 1; // NOTE: Influence of the pheromones in choosing a path.
    public final static int HEURISTIC_BIAS = 3; // NOTE: Influence of heuristic in choosing a path.
    
    public ArrayList< Ant > ants = new ArrayList();
    
    
    public
    AntColony()
    {
        ants.add( new Ant() );
    }
    
    
    public void
    run()
    {
        ants.get( 0 ).chooseNext();
    }
    
}