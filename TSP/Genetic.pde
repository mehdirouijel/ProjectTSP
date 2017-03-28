/*
 *  The implementation of the genetic algorithm.
 *
 *
 *  Created by: Mehdi Rouijel
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Genetic
{
    
    private final static int POPULATION_SIZE = 20;
    private final static int TOURNAMENT_SIZE = 5;
    private final static double MUTATION_RATE = 0.02; // NOTE: A percentage chance for a gene (i.e. a city in an Individual's path) to be mutated (i.e. swapped with a random other one in that path)
    private final static boolean ELITISM = true;
    private final static int GENERATION_COUNT = 200;
    Population pop = null;
    int currentGeneration = 0;

    
    public
    Genetic()
    {
        pop = new Population( POPULATION_SIZE, true );
    }
    
    
    public Individual
    crossover( Individual parent1, Individual parent2 )
    {        
        Individual child = new Individual( true );
        
        int index1 = ( int )( Math.random() * parent1.path.size() );
        int index2 = ( int )( Math.random() * parent1.path.size() );
        
        for ( int i = 0; i < parent1.path.size(); ++i )
        {
            /* Two cases: 
             *
             *   a     b
             * 0001111100
             *
             *    b  a
             * 1110000111
             *
             * 'a' is 'index1', 'b' is 'index2',
             * '0' are cities that won't be inherited by the child,
             * '1' are cities that will be inherited by the child.
             *
             * * * * */
             
            if ( index1 < index2 )
            {
                if ( ( i > index1 ) && ( i < index2 ) )
                    child.path.set( i, parent1.path.get( i ) );
            }
            else if ( index1 > index2 )
            {
                if ( !( ( i < index1 ) && ( i > index2 ) ) )
                    child.path.set( i, parent1.path.get( i ) );
            }
        }
        
        for ( int i = 0; i < parent2.path.size(); ++i )
        {
            /* The child will inherit from the second parent
             * the cities it didn't inherit from the first. 
             * * * * */
             
            if ( !child.path.contains( parent2.path.get( i ) ) )
            {
                for ( int j = 0; j < child.path.size(); ++j )
                {                
                    if ( child.path.get( j ) == null )
                    {
                        child.path.set( j, parent2.path.get( i ) );
                        break;
                    }
                }
            }
        }
        
        return child;
    }
    
    private Individual
    tournamentSelect( Population population )
    {
        Individual winner;
        Population participants = new Population( TOURNAMENT_SIZE, false );
        
        for ( int i = 0; i < TOURNAMENT_SIZE; ++i )
        {
            int index = ( int )( Math.random() * POPULATION_SIZE );
            participants.paths.set( i, population.paths.get( index ) );
        }
        
        winner = participants.getBest();
        return winner;
    }
    
    public void
    renewGenePool( Individual circuit )
    {
        /* This step is important!
         * Without it, the algorithm converges towards
         * a solution very early and is stuck without
         * examining other possible paths.
         *
         * Probably not the best name for this function, though.
         * Maybe this should be "mutate" and the "mutate()"
         * function below should be "evolve()" ? 
         * * * * */
         
        for ( int i = 0; i < circuit.path.size(); ++i )
        {
            if ( Math.random() < MUTATION_RATE )
            {
                int j = ( int )( Math.random() * circuit.path.size() );
                
                City c1 = circuit.path.get( i );
                City c2 = circuit.path.get( j );
                
                circuit.path.set( i, c2 );
                circuit.path.set( j, c1 );
            }
        }
    }
    
    public Population
    mutate()
    {        
        Population evolvedPop = new Population( POPULATION_SIZE, false );
        int elitismOffset;
        
        if ( ELITISM )
        {
            evolvedPop.paths.set( 0, pop.getBest() );
            elitismOffset = 1;
        }
        else
        {
            elitismOffset = 0;
        }
        
        for ( int i = elitismOffset; i < POPULATION_SIZE; ++i )
        {
            Individual parent1 = tournamentSelect( pop );
            Individual parent2 = tournamentSelect( pop );
            
            Individual child = crossover( parent1, parent2 );
            
            evolvedPop.paths.set( i, child );
        }
        
        for ( int i = elitismOffset; i < evolvedPop.paths.size(); ++i )
            renewGenePool( evolvedPop.paths.get( i ) );
        
        return evolvedPop;
    }
    
}