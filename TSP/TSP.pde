final static int LEFT_PANEL_WIDTH = 192; 
static ArrayList<City> cities = new ArrayList();
static ArrayList<Road> roads = new ArrayList();

void
setup()
{
    size( 768, 432 );
    background( 200 );
}

void
draw()
{
    /* Left UI panel.
     * * * * */
    fill( 128 );
    rect( 0, 0, LEFT_PANEL_WIDTH, 431 );
    
    /* Drawing cities and roads.
     * * * * */
    for ( int i = 0; i < roads.size(); ++i )
        roads.get( i ).draw();

    for ( int i = 0; i < cities.size(); ++i )        
        cities.get( i ).draw();
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
}