/*
 *  Definition of an ant.
 *
 * * * * * * * * * * * * * * * * * * * */


public class
Ant extends Individual
{
    
    public City currentCity = null;
    public City startingCity = null;
    public Road currentRoad = null;
    public ArrayList< Road > possibleRoads = new ArrayList();
    public ArrayList< Road > roadSoFar = new ArrayList();
    public float pheromonePool = 100.0; // NOTE: Will be used as 'alpha' parameter for the line color.
    
    
    public
    Ant()
    {
        super();
        
        int cityIndex = ( int )( Math.random() * cities.size() );
        this.startingCity = cities.get( cityIndex );
        this.currentCity = this.startingCity;
    }
    
    
    public void
    backtrack()
    {
        for ( Road r : this.roadSoFar )
        {
            r.pheromones += this.pheromonePool / this.roadSoFar.size();
            
            r.draw( 255, 255, 255, r.pheromones, 3 );
        }
    }
    
    public void
    findPath()
    {        
        while ( this.path.size() < cities.size()-1 )
        {
            this.currentCity = chooseNext(); //<>//
        }
        
        /* Now we need to add the last road (to the first city)
         * to complete the loop.
         * * * * */
        
        for ( Road r : roads )
        {
            if ( ( currentCity == r.from ) && ( this.startingCity == r.to ) ||
                 ( currentCity == r.to ) && ( this.startingCity == r.from ) )
            {
                this.roadSoFar.add( r );
            }
        }
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
        
        double totalWeight = 0.0;
        for ( Road r : this.possibleRoads )
        {
            totalWeight += Math.pow( r.pheromones, AntColony.PHEROMONE_BIAS ) * Math.pow( ( 1.0 / r.getDistance() ), AntColony.HEURISTIC_BIAS );
        }
        
        double roadWeight = 0.0; //<>//
        int destinationIndex = 0;
        double diceThrow = Math.random() * totalWeight;
         //<>//
        for ( Road r : this.possibleRoads )
        {
            roadWeight += Math.pow( r.pheromones, AntColony.PHEROMONE_BIAS ) * Math.pow( ( 1.0 / r.getDistance() ), AntColony.HEURISTIC_BIAS );
            if ( roadWeight >= diceThrow )
                break;
            
            destinationIndex++;
        }
        
        
        Road chosenRoad = this.possibleRoads.get( destinationIndex );
        
        roadSoFar.add( chosenRoad );
        
        if ( this.currentCity == this.possibleRoads.get( destinationIndex ).from )
            choice = chosenRoad.to;
        else if ( this.currentCity == this.possibleRoads.get( destinationIndex ).to )
            choice = chosenRoad.from;
        
        return choice;
    }
    
    private void
    findPossibleRoads()
    {
        this.possibleRoads.clear();
        
        for ( Road r : roads )
        {
            if ( this.currentCity == r.from )
            {
                if ( !( this.path.contains( r.to ) ) ) 
                    this.possibleRoads.add( r );
            }
            else if ( this.currentCity == r.to )
            {
                if ( !( this.path.contains( r.from ) ) ) 
                    this.possibleRoads.add( r );
            }
        }
    }
    
    @Override
    public double
    getTotalDistance()
    {
        double result = 0.0;
        
        for ( Road r : this.roadSoFar )
        {
            result += r.getDistance();
        }
        
        return result;
    }
    
    @Override
    public void
    draw()
    {
        for ( Road r : this.roadSoFar )
            r.draw( 255, 255, 0, 1 );
    }

}