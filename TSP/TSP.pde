//final static int CITIES_COUNT = 20;

static ArrayList<City> cities = new ArrayList();


void
setup()
{
    size( 600, 480 );
    
    /*
    for ( int i = 0; i < CITIES_COUNT; ++i )
    {
        cities.add( new City( width, height ) );
    }
    */
}

void
draw()
{
    fill( 0 );

    for ( int i = 0; i < cities.size(); ++i )
    {
        ellipse( cities.get( i ).x, cities.get( i ).y, 10, 10 );
    }
}



void
mouseClicked()
{
    cities.add( new City( mouseX, mouseY ) );
}