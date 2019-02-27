# Seattle AirBnB ETL Project Proposal
## Background Information
### Team Members
* Shannon Chang
* Madeleine Merken
* Miles Lucey
### Data Sources
* One listings.csv file that contains AirBnB listing information and AirBnB host information
* One calendar.csv file that contains property availability information throughout the year
* One reviews.csv file that contains AirBnB property reviews information
### Data Source
* Kaggle: https://www.kaggle.com/airbnb/seattle
### Idea for Relational Database Schema
* Four tables:
    * One table for listings information from the listings.csv file
    * One table with hosts information from the listings.csv file
    * One table with property availability information from the calendar.csv file
    * One table with property reviews information from the reviews.csv file
* How the tables will be linked together:
    * Listings and hosts tables linked together by host_id
    * Listings and availability tables linked together by listing_id
    * Listings and reviews tables linked together by listing_id
## Extract
* Python is used to extract data from four CSV files (each in the "Resources" folder).
1. listings.csv
   * listing_host_csv = "Resources/listings.csv"
   * listing_host_df = pd.read_csv(listing_host_csv,encoding="utf8")
2. calendar.csv
   * calendar_csv = "Resources/calendar.csv"
   * calendar_df = pd.read_csv(calendar_csv,encoding="utf8")
3. reviews.csv
   * reviews_csv = "Resources/reviews.csv"
   * reviews_df = pd.read_csv(reviews_csv,encoding="utf8")
## Transform 
* Python is used to separate the listing_host_df into two dataframes; One for listings and one for host information:
   * listings dataframe:
      * listing_df = listing_host_df[["id","listing_name","street","neighbourhood_cleansed","neighbourhood_group_cleansed","city","state","zipcode","latitude","longitude","is_location_exact","property_type","room_type","accommodates","bathrooms","bedrooms","beds","bed_type","square_feet","price","weekly_price","monthly_price","security_deposit","cleaning_fee","guests_included","extra_people","minimum_nights","maximum_nights","has_availability","availability_30","availability_60","availability_90","availability_365","number_of_reviews","first_review","last_review","review_scores_rating","review_scores_accuracy","review_scores_cleanliness","review_scores_checkin","review_scores_communication","review_scores_location","review_scores_value","requires_license","instant_bookable","cancellation_policy","require_guest_profile_picture","require_guest_phone_verification","reviews_per_month","host_id"]].copy()
   * hosts dataframe
      * host_df = listing_host_df[["host_id","host_name","host_since","host_location","host_response_time","host_response_rate","host_acceptance_rate","host_is_superhost","host_neighbourhood","host_listings_count","host_has_profile_pic","host_identity_verified"]].copy()
* Python is used to create the calendar dataframe:
   * INSERT CODE HERE
* Python is used to create the reviews dataframe:
   * INSERT CODE HERE
### Cleaning
* All four dataframes are cleaned using the following commands:
   1. "drop_duplicates" to remove all duplicate entries in each dataframe
   2. ".replace" to remove all symbols from numerical columns (e.g. $,%,',', etc.)
      * This is because some of the dataframe columns were being registered as strings rather than as numbers
   3. ".replace. to replace "t" and "f" entries with the booleans "True" and False"
   4. "to_datetime" to convert columns to datetime format that were being registered as strings
   5. "to_numeric" to convert columns to numbers that were being registered as strings
## Load
* A MYSQL database connection is created and an engine is created in Python:
   * rds_connection_string = "root:<PASSWORD HERE>@127.0.0.1/seattle_airbnb_db"
   * engine = create_engine(f"mysql://{rds_connection_string}?charset=utf8", encoding = "utf8")
* The engine is used to populate all the SQL tables
   * host_df.to_sql(name="airbnb_hosts",con=engine,if_exists="append",index=False)
   * listing_df.to_sql(name="listings",con=engine,if_exists="append",index=False)
   * ADD THE REST OF CODE LATER
