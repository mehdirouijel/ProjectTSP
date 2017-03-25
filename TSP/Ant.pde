/*
 *  Definition of an ant.
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Ant extends Individual
{
    
    public City currentCity = null;
    public Road currentRoad = null;
    public ArrayList< Road > possibleRoads = new ArrayList();
    public ArrayList< Road > pathSoFar = new ArrayList();
    
    
    public
    Ant()
    {
        super( true );
        
        int cityIndex = ( int )( Math.random() * cities.size() );
        this.currentCity = cities.get( cityIndex );
    }
    
    
    public City
    chooseNext()
    {
        City choice = null;
        
        this.path.add( this.currentCity );
        
        findPossibleRoads();
        
        
        /* Choosing a road probabilistically.
         * The heuristic used is the length of a road.
         * * * * */
        
        double denominator = 0.0;
        for ( int i = 0; i < possibleRoads.size(); ++i )
        {
            Road r = possibleRoads.get( i );
            
            denominator += Math.pow( r.pheromones, AntColony.PHEROMONE_BIAS ) * Math.pow( ( 1.0 / r.getDistance() ), AntColony.HEURISTIC_BIAS );
        }
        
        double numerator = 0.0;
        int destinationIndex = 0;
        while ( true )
        {
            Road r = possibleRoads.get( destinationIndex );
            
            numerator = Math.pow( r.pheromones, AntColony.PHEROMONE_BIAS ) * Math.pow( ( 1.0 / r.getDistance() ), AntColony.HEURISTIC_BIAS );
            
            double p = numerator / denominator;
            
            if ( p >= Math.random() )
                break;
                
            destinationIndex++;
            destinationIndex %= possibleRoads.size();
        }
        
        
        Road chosenRoad = possibleRoads.get( destinationIndex );
        
        pathSoFar.add( chosenRoad );
        
        if ( this.currentCity == possibleRoads.get( destinationIndex ).from )
            choice = chosenRoad.to;
        else if ( this.currentCity == possibleRoads.get( destinationIndex ).to )
            choice = chosenRoad.from;
            
        chosenRoad.draw( 255, 255, 0, 1 );
        
        
        return choice;
    }
    
    private void
    findPossibleRoads()
    {
        for ( City c : cities )
        {
            if ( !( this.path.contains( c ) ) )
            {
                for ( Road r : roads )
                {
                    if ( ( currentCity == r.from ) && ( c == r.to ) ||
                         ( currentCity == r.to ) && ( c == r.from ) )
                    {
                        this.possibleRoads.add( r );
                        r.draw( 0, 200, 180, 3 );
                    }
                }
            }
        }
    }

}