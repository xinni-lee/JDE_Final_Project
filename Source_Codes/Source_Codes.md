Using colab notebook<br/>
<br/>
Overall brief steps and thought process:<br/>
- Connecting to PostgreSQL shared database using SQLAlchemy<br/>
- Supply Chain Analysis as one of the problem statements was long delivery time. Review ratings show a correlation with delivery time: Rated 'Very Good' has shorter average delivery days compared to very bad ratings that has almost twice the delivery days on average.<br/>
- Finding the average geolocations with zipcodes, and using geopy to estimate the distance.<br/>
- Plotted using plotly<br/>
- Finding centroids with sklearn using sellers' coordinates<br/>
- Finding the new estimated distance between customers' coordinates to the nearest distribution centres<br/>
<br/>
Proposal #1: Set up distribution centers across different areas to minimize distance between sellers and customers to shorten delivery period. Limiation: Costly to hold stocks, hence could focus on top categories that account for more than 90% of sales. Look into sellers' scorecard that failed at service level or any fulfilment period.</p>
Proposal #2: Set up collection points across cities and states. This will help to lower shipping fees for consumers and streamline delivery routes.</p>
Proposal #3: Extend logistics wing with added manpower to speed up shipping period. Noted that Olist acquired Pax, a logistics specialist in 2020.</p>

List of packages or libraries (e.g., `python`, `pandas`, `numpy`, `matplotlib`, `seaborn`, `plotly`, `SQLAlchemy`, `geopy`, `psycopg2`, `scikitlearn`)<br/>
