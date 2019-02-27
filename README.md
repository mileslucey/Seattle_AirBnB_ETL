# Seattle AirBnB ETL Project
## Background Information
### Team Members
* Shannon Chang
* Madeleine Merken
* Miles Lucey
### Data Source
* Kaggle: https://www.kaggle.com/airbnb/seattle
### Data Files
* One listings.csv file that contains AirBnB listing information and AirBnB host information
* One calendar.csv file that contains property availability information throughout the year
* One reviews.csv file that contains AirBnB property reviews information
### Idea for Relational Database Schema
* Four tables:
    * One table for listings information from the listings.csv file
    * One table with hosts information from the listings.csv file
    * One table with property availability information from the calendar.csv file
    * One table with property reviews information from the reviews.csv file
* How the tables are linked together:
    * Listings and hosts tables linked together by host_id
    * Listings and availability tables linked together by listing_id
    * Listings and reviews tables linked together by listing_id
## Extract
* Data is taken from a Kaggle web page
* Data is extracted from the four CSV files in the "Resources" folder
* Python code to extract data from the CSV files:
1. listings.csv
   ~~~~python
   listing_host_csv = "Resources/listings.csv"
   listing_host_df = pd.read_csv(listing_host_csv,encoding="utf8")
   ~~~~
2. calendar.csv
   ~~~~python	
   calendar_csv = "Resources/calendar.csv"
   calendar_df = pd.read_csv(calendar_csv,encoding="utf8")
   ~~~~
3. reviews.csv
   ~~~~python
   reviews_csv = "Resources/reviews.csv"
   reviews_df = pd.read_csv(reviews_csv,encoding="utf8")
   ~~~~
## Transform 
* Python code to separate the listing_host_df into two dataframes; One dataframe for listings and one dataframe for host information:
   * listings dataframe:
      ~~~~python
      listing_df = listing_host_df[["id","listing_name","street","neighbourhood_cleansed","neighbourhood_group_cleansed","city","state","zipcode","latitude","longitude","is_location_exact","property_type","room_type","accommodates","bathrooms","bedrooms","beds","bed_type","square_feet","price","weekly_price","monthly_price","security_deposit","cleaning_fee","guests_included","extra_people","minimum_nights","maximum_nights","has_availability","availability_30","availability_60","availability_90","availability_365","number_of_reviews","first_review","last_review","review_scores_rating","review_scores_accuracy","review_scores_cleanliness","review_scores_checkin","review_scores_communication","review_scores_location","review_scores_value","requires_license","instant_bookable","cancellation_policy","require_guest_profile_picture","require_guest_phone_verification","reviews_per_month","host_id"]].copy()
      ~~~~
   * hosts dataframe
      ~~~~python
      host_df = listing_host_df[["host_id","host_name","host_since","host_location","host_response_time","host_response_rate","host_acceptance_rate","host_is_superhost","host_neighbourhood","host_listings_count","host_has_profile_pic","host_identity_verified"]].copy()
     ~~~~
* Python code to create the calendar dataframe:
     ~~~~python
   INSERT CODE HERE
     ~~~~
* Python code to create the reviews dataframe:
     ~~~~python
   INSERT CODE HERE
     ~~~~
### Cleaning
* All four dataframes are cleaned using the following commands:
   1. "drop_duplicates" to remove all duplicate entries in each dataframe
   2. ".replace" to remove all symbols from numerical columns (e.g. $,%,',', etc.)
      * This is because some of the dataframe columns were being registered as strings rather than as numbers
   3. ".replace. to replace "t" and "f" entries with the booleans "True" and False"
   4. "to_datetime" to convert columns to datetime format that were being registered as strings
   5. "to_numeric" to convert columns to numbers that were being registered as strings
* Below is the Python code to clean each of the four dataframes:
   1. listings dataframe:
   ~~~~python
   # Remove duplicates
   listing_df.drop_duplicates(keep="first",inplace=True)
   
   # Convert columns to datetime format
   listing_df["first_review"]=pd.to_datetime(listing_df["first_review"])
   listing_df["last_review"]=pd.to_datetime(listing_df["last_review"])
   
   # Replace columns designated as "t" or "f" as the "True" or "False" booleans
   listing_df["is_location_exact"].replace(["t","f"],[True,False],inplace=True)
   listing_df["has_availability"].replace(["t","f"],[True,False],inplace=True)
   listing_df["requires_license"].replace(["t","f"],[True,False],inplace=True)
   listing_df["instant_bookable"].replace(["t","f"],[True,False],inplace=True)
   listing_df["require_guest_profile_picture"].replace(["t","f"],[True,False],inplace=True)
   listing_df["require_guest_phone_verification"].replace(["t","f"],[True,False],inplace=True)
   
   # Convert all currency columns to numeric values
   currency_cols=["price","weekly_price","monthly_price","security_deposit","cleaning_fee","extra_people"]
   listing_df[currency_cols]=listing_df[currency_cols].replace({'\$': '', ',': ''}, regex=True)
   listing_df["price"] = pd.to_numeric(listing_df["price"])
   listing_df["weekly_price"] = pd.to_numeric(listing_df["weekly_price"])
   listing_df["monthly_price"] = pd.to_numeric(listing_df["monthly_price"])
   listing_df["security_deposit"] = pd.to_numeric(listing_df["security_deposit"])
   listing_df["cleaning_fee"] = pd.to_numeric(listing_df["cleaning_fee"])
   listing_df["extra_people"] = pd.to_numeric(listing_df["extra_people"])
   ~~~~
   2. hosts dataframe:
   ~~~~python
   # Remove duplicates
   host_df.drop_duplicates(keep="first",inplace=True)
   
   # Convert columns to datetime format
   host_df["host_since"]=pd.to_datetime(host_df["host_since"])
   
   # Replace columns designated as "t" or "f" as the "True" or "False" booleans
   host_df["host_is_superhost"].replace(["t","f"],[True,False],inplace=True)
   host_df["host_has_profile_pic"].replace(["t","f"],[True,False],inplace=True)
   host_df["host_identity_verified"].replace(["t","f"],[True,False],inplace=True)
   
   # Convert all percentage columns to numeric values
   host_df["host_response_rate"]=host_df["host_response_rate"].replace({'\$': '', ',': '', '%':''}, regex=True)
   host_df["host_acceptance_rate"]=host_df["host_acceptance_rate"].replace({'\$': '', ',': '', '%':''}, regex=True)
   host_df["host_response_rate"] = pd.to_numeric(host_df["host_response_rate"])
   host_df["host_acceptance_rate"] = pd.to_numeric(host_df["host_acceptance_rate"])
   ~~~~
   3. calendar dataframe:
   ~~~~python
   ~~~~
   4. reviews dataframe:
   ~~~~python
   ~~~~
## Load
### SQL -- Creating the Schema
* We chose AirBnB data because we are interested in studying data from Bay Area companies that are market disrupters. Additionally, we are all interested in studying the "sharing economy". 
* This analysis creates a schema consisting of four tables (listings, hosts, calendar, and reviews). We think this is the best way to divide the data because each table has its own unique focus, each table cannot really divided into smaller tables (e.g. smaller tables that are equally distinct and have fewer rows than before), and it is an intuitive way of dividing information for people who may use the data.
* We chose a relational database structure because we wanted our data to have a strict structure and to be very consistent. We also wanted the database to be easy to update if needed. Lastly, we wanted to minimize redundancy and to make sure not to have multiple columns displaying the same information.
* In MySQL, we followed the steps below:
	* Use a SQL script to establish the database:
  ~~~~sql
  CREATE DATABASE seattle_airbnb_db;
  USE seattle_airbnb_db;
  ~~~~
	* In the AirBnB database, create the four separate tables:
	1. Hosts table
   ~~~~sql
   CREATE TABLE airbnb_hosts(
	host_id INT,
    	host_name VARCHAR(150),
    	host_since DATE,
    	host_location VARCHAR(150),
    	host_response_time VARCHAR(200),
    	host_response_rate INT,
    	host_acceptance_rate INT,
    	host_is_superhost BOOLEAN,
    	host_neighbourhood VARCHAR(100),
    	host_listings_count INT,
    	host_has_profile_pic BOOLEAN,
    	host_identity_verified BOOLEAN,
    	PRIMARY KEY(host_id)
	);
   ~~~~

	2. Listings table
   ~~~sql
   CREATE TABLE listings(
	id INT,
    	listing_name VARCHAR(100),
    	street VARCHAR(300),
    	neighbourhood_cleansed VARCHAR(150),
    	neighbourhood_group_cleansed VARCHAR(150),
    	city VARCHAR(150),
    	state VARCHAR(5),
    	zipcode VARCHAR(20),
    	latitude FLOAT,
    	longitude FLOAT,
    	is_location_exact BOOLEAN,
    	property_type VARCHAR(150),
    	room_type VARCHAR(150),
    	accommodates INT,
    	bathrooms INT,
    	bedrooms INT,
    	beds INT,
    	bed_type VARCHAR(200),
    	square_feet INT,
    	price FLOAT,
    	weekly_price FLOAT,
    	monthly_price FLOAT,
    	security_deposit FLOAT,
    	cleaning_fee FLOAT,
    	guests_included INT,
    	extra_people FLOAT,
    	minimum_nights INT,
    	maximum_nights INT,
    	has_availability BOOLEAN,
    	availability_30 INT,
    	availability_60 INT,
    	availability_90 INT,
    	availability_365 INT,
    	calendar_updated DATE,
    	number_of_reviews INT,
    	first_review DATE,
    	last_review DATE,
    	review_scores_rating INT,
    	review_scores_accuracy INT,
    	review_scores_cleanliness INT,
    	review_scores_checkin INT,
    	review_scores_communication INT,
    	review_scores_location INT, 
    	review_scores_value INT,
    	requires_license BOOLEAN,
    	instant_bookable BOOLEAN,
    	cancellation_policy VARCHAR(200),
    	require_guest_profile_picture BOOLEAN,
    	require_guest_phone_verification BOOLEAN,
    	reviews_per_month FlOAT,
    	host_id INT,
    	PRIMARY KEY (id),
    	FOREIGN KEY (host_id) REFERENCES airbnb_hosts(host_id) ON DELETE CASCADE 
	);
   ~~~~
	3. Calendar table
   ~~~~sql
   	INSERT CODE HERE
   ~~~~
	4. Reviews table
   ~~~~sql
   	INSERT CODE HERE
   ~~~~

### Python -- Connecting to MySQL database and adding in the data
* A MySQL database connection is created and an engine is created in Python:
   ~~~~python
   rds_connection_string = "root:<PASSWORD HERE>@127.0.0.1/seattle_airbnb_db"
   engine = create_engine(f"mysql://{rds_connection_string}?charset=utf8", encoding = "utf8")
   ~~~~
* The engine is used to populate all the SQL tables
   ~~~~python
   host_df.to_sql(name="airbnb_hosts",con=engine,if_exists="append",index=False)
   listing_df.to_sql(name="listings",con=engine,if_exists="append",index=False)
   ADD THE REST OF CODE LATER
   ~~~~
