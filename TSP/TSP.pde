/*
 *  Solving the Travelling Salesman Problem using two algorithms:
 *  - a Genetic Algorithm
 *  - an Ant Colony Algorithm
 *
 *
 *  Created by: Mehdi Rouijel
 *
 * * * * * * * * * * * * * * * * * * * */


final static int LEFT_PANEL_WIDTH = 192;

static ArrayList< City > cities = new ArrayList();
static ArrayList< Road > roads = new ArrayList();

Genetic GA = null;
AntColony ACO = null;
boolean runGenetic = false;
boolean runAntColony = false;

int elapsedTime = 0;


void
setup()
{
    size( 768, 432 );
    background( 255 );
    frameRate( 60 );
    hint(ENABLE_STROKE_PURE);
}

void
draw()
{
    /* UI stuff.
     * * * * */
     
    fill( 100 );
    rect( 0, 0, LEFT_PANEL_WIDTH, 431 );
     
    fill( 200 );
    rect( LEFT_PANEL_WIDTH+1, 0, width-LEFT_PANEL_WIDTH-2, 431 );
    
    fill( 0 );
    rect( 1, 1, LEFT_PANEL_WIDTH-2, 16 );
    fill( 150 );
    text( "Control Panel", 5, 2, LEFT_PANEL_WIDTH, 16 );
    
    fill( 150 );
    rect( 6, 17, LEFT_PANEL_WIDTH-7, 16 );
    fill( 0 );
    rect( 1, 17, 5, 16 );
    fill( 0 );
    text( "Run Genetic Algorithm", 10, 18, LEFT_PANEL_WIDTH, 16 );
    
    fill( 150 );
    rect( 6, 33, LEFT_PANEL_WIDTH-7, 16 );
    fill( 0 );
    rect( 1, 33, 5, 16 );
    fill( 0 );
    text( "Run Ant Colony Algorithm", 10, 34, LEFT_PANEL_WIDTH, 16 );
    
    fill( 150 );
    rect( 6, 49, LEFT_PANEL_WIDTH-7, 16 );
    fill( 0 );
    rect( 1, 49, 5, 16 );
    fill( 0 );
    text( "Clear", 10, 50, LEFT_PANEL_WIDTH, 16 );
    
    fill( 120 );
    rect( 2, height-109, LEFT_PANEL_WIDTH-4, 106 );
    fill( 250 );
    text( "Click anywhere on the screen to place a city. Each new city will automatically be connected to all the others.",
          5, height-106, LEFT_PANEL_WIDTH-10, 100 );
    
    
    /* Drawing cities and roads.
     * * * * */
     
    for ( int i = 0; i < roads.size(); ++i )
        roads.get( i ).draw();
        
    for ( int i = 0; i < cities.size(); ++i )        
        cities.get( i ).draw();
    
    
    /* Running the algorithms.
     * * * * */
    
    if ( runGenetic )
    {
        if ( GA.pop != null )
        {
            GA.pop.getBest().draw();
            println( "Best distance = "+GA.pop.getBest().getTotalDistance() );
            
            fill( 250 );
            text( "Total Distance:\n"+GA.pop.getBest().getTotalDistance(),
                  5, 100, LEFT_PANEL_WIDTH-10, 50 );
        
            fill( 100 );
            rect( LEFT_PANEL_WIDTH+2, 1, 120, 16 );
            fill( 250 );
            text( "Generation "+GA.currentGeneration+" / "+Genetic.GENERATION_COUNT,
                  LEFT_PANEL_WIDTH+4, 2, 130, 16 );
        }
        
        if ( GA.currentGeneration < Genetic.GENERATION_COUNT )
        {
            GA.pop = GA.mutate();
            GA.currentGeneration++;
        }
        else
        {
            elapsedTime = millis() - elapsedTime;
              
            fill( 250 );
            text( "Elapsed Time: "+elapsedTime+"ms",
                  5, 150, LEFT_PANEL_WIDTH-10, 20 );
            
            runGenetic = false;
            println( "-----------------------" );
            noLoop(); //<>//
        }
    }
    
    
    if ( runAntColony )
    {
        fill( 100 );
        rect( LEFT_PANEL_WIDTH+2, 1, 120, 16 );
        fill( 250 );
        text( "Iteration "+ACO.currentIteration+" / "+AntColony.MAX_ITERATIONS,
              LEFT_PANEL_WIDTH+4, 2, 130, 16 );
        
        if ( ACO.currentIteration < AntColony.MAX_ITERATIONS )
        {
            ACO.run();
            ACO.updatePheromones();
            
            ACO.getBestPath().draw();
            println( "Best distance = "+ACO.getBestPath().getTotalDistance() );
            
            fill( 250 );
            text( "Total Distance:\n"+ACO.getBestPath().getTotalDistance(),
                  5, 100, LEFT_PANEL_WIDTH-10, 50 );
                  
            ACO.currentIteration++;
        }
        else
        {
            elapsedTime = millis() - elapsedTime;
              
            fill( 250 );
            text( "Elapsed Time: "+elapsedTime+"ms",
                  5, 150, LEFT_PANEL_WIDTH-10, 20 );
            
            runAntColony = false;
            println( "-----------------------" );
            noLoop(); //<>//
        }
        
        ACO.getBestPath().draw();
        fill( 250 );
        text( "Total Distance:\n"+ACO.getBestPath().getTotalDistance(),
              5, 100, LEFT_PANEL_WIDTH-10, 50 );
    }
}



void
mouseClicked()
{
    /* A click will add a city
     * and all the roads.
     * * * * */
     
    if ( mouseX > LEFT_PANEL_WIDTH )
    {
        cities.add( new City( mouseX, mouseY ) );
        
        for ( int i = 0; i < cities.size(); ++i )
        {
            for ( int j = i+1; j < cities.size(); ++j )
            {
                roads.add( new Road( cities.get( i ), cities.get( j ) ) );
            }
        }
    }
    else
    {
        /* Clicking in the control panel.
         * * * * */
 
        if ( ( mouseY > 17 ) && ( mouseY < 32 ) )
        {
            /* Run Genetic Algorithm
             * * * * */
             
            println( "Running GA" );
            
            runAntColony = false;
            runGenetic = true;
            
            elapsedTime = millis();
            
            GA = null;
            GA = new Genetic();
            
            loop();
        }
        else if ( ( mouseY > 33 ) && ( mouseY < 48 ) )
        {
            /* Run Ant Colony Algorithm
             * * * * */
             
            println( "Running ACO" );
            
            runAntColony = true;
            runGenetic = false;
            
            elapsedTime = millis();
            
            ACO = null;
            ACO = new AntColony();
            
            loop();
        }
        else if ( ( mouseY > 49 ) && ( mouseY < 65 ) )
        {
            /* Reset button
             * * * * */
             
            println( "Clear button" );
             
            GA = null;
            ACO = null;
            
            runAntColony = false;
            runGenetic = false;
            
            loop();
        }
    }
}