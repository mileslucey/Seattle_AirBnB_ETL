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
    * Listings and property availability tables linked together by listing_id
    * Listings and property reviews tables linked together by listing_id
## Extract
* CSV files are taken from a Kaggle web page and saved in the "Resources" folder
* Data is extracted from the four CSV files in the "Resources" folder
* Python code to extract data from the CSV files is listed below:
1. listings.csv
   ~~~~python
   listing_host_csv = "Resources/listings.csv"
   listing_host_df = pd.read_csv(listing_host_csv,encoding="utf8")
   ~~~~
2. calendar.csv
   ~~~~python	
   availability_file = "Resources/calendar.csv"
   availability_df = pd.read_csv(availability_file,encoding="utf8")
   ~~~~
3. reviews.csv
   ~~~~python
   reviews_file = "Resources/reviews.csv"
   reviews_df = pd.read_csv(reviews_file,encoding="utf8")
   ~~~~
## Transform 
* Python code to separate the listing_host_df into two dataframes; One dataframe for listings information and one dataframe for hosts information:
   * listings dataframe:
      ~~~~python
      listing_df = listing_host_df[["id","listing_name","street","neighbourhood_cleansed","neighbourhood_group_cleansed","city","state","zipcode","latitude","longitude","is_location_exact","property_type","room_type","accommodates","bathrooms","bedrooms","beds","bed_type","square_feet","price","weekly_price","monthly_price","security_deposit","cleaning_fee","guests_included","extra_people","minimum_nights","maximum_nights","has_availability","availability_30","availability_60","availability_90","availability_365","number_of_reviews","first_review","last_review","review_scores_rating","review_scores_accuracy","review_scores_cleanliness","review_scores_checkin","review_scores_communication","review_scores_location","review_scores_value","requires_license","instant_bookable","cancellation_policy","require_guest_profile_picture","require_guest_phone_verification","reviews_per_month","host_id"]].copy()
      ~~~~
   * hosts dataframe
      ~~~~python
      host_df = listing_host_df[["host_id","host_name","host_since","host_location","host_response_time","host_response_rate","host_acceptance_rate","host_is_superhost","host_neighbourhood","host_listings_count","host_has_profile_pic","host_identity_verified"]].copy()
     ~~~~
* All columns in the calendar.csv file are used in the property availability dataframe
* Python code to create the reviews dataframe:
     ~~~~python
   review_df = reviews_df[['review_id', "listing_id", "review_date", "reviewer_id", "reviewer_name", "comments"]].copy()
     ~~~~
### Cleaning
* All four dataframes are cleaned using the following commands:
   1. "drop_duplicates" to remove all duplicate entries in each dataframe
   2. ".replace" to remove all symbols from numerical columns (e.g. $,%,',', etc.)
      * This is because some of the dataframe columns are initially registered as strings rather than as numbers
   3. ".replace." to replace "t" and "f" string entries with the booleans "True" and False"
   4. "to_datetime" to convert columns to datetime format that are initially registered as strings
   5. "to_numeric" to convert columns to numbers that are initially registered as strings
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
   3. property availability dataframe:
   ~~~~python
   # Convert columns to datetime format
   availability_df["available_date"]=pd.to_datetime(availability_df["available_date"])
   
   # Replace columns designated as "t" or "f" as the "True" or "False" booleans
   availability_df["available"].replace(["t","f"], [True,False], inplace=True)
   
   # Convert all currency columns to numeric values
   availability_df["price"] = availability_df["price"].replace({'\$': '', ',': ''}, regex=True)
   availability_df["price"] = pd.to_numeric(availability_df["price"])
   ~~~~
   4. reviews dataframe:
   ~~~~python
   # Convert columns to datetime format
   review_df["review_date"] = pd.to_datetime(review_df["review_date"])
   ~~~~
## Load
### SQL -- Creating the Schema
* We choose AirBnB data because we are interested in studying data from Bay Area companies that are market disrupters. Additionally, we are interested in studying the sharing economy, an economy in which AirBnB is a key player. 
* This analysis creates a schema consisting of four tables (listings, hosts, property availability, and property reviews). We think this is the best way to divide the data because each table has its own unique focus, each table cannot really be divided into smaller tables (i.e. tables that are equally distinct and have fewer rows than before), and it is an intuitive way of dividing information for people who may use the data in the future.
* We choose a relational database structure because we want the data to have a strict structure and to be very consistent across all columns. We also want the database to be easy to update if needed. Lastly, we want to minimize redundancy and to make sure to not have multiple columns displaying the same information.
* In MySQL, we follow the following steps to create the schema:
	* Use a SQL script to establish the database:
  ~~~~sql
  CREATE DATABASE IF NOT EXISTS seattle_airbnb_db;
  USE seattle_airbnb_db;
  ALTER DATABASE seattle_airbnb_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
  
  DROP TABLE IF EXISTS property_availability;
  DROP TABLE IF EXISTS property_reviews;
  DROP TABLE IF EXISTS listings;
  DROP TABLE IF EXISTS airbnb_hosts;
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
    	reviews_per_month FLOAT,
    	host_id INT,
    	PRIMARY KEY(id),
    	FOREIGN KEY(host_id) REFERENCES airbnb_hosts(host_id) ON DELETE CASCADE
	);
   ~~~~
	3. Property availability table
   ~~~~sql
   CREATE TABLE property_availability(
    	id INT NOT NULL AUTO_INCREMENT,
    	listing_id INT,
    	available_date DATE,
    	available BOOLEAN,
    	price FLOAT,
    	PRIMARY KEY(id),
    	FOREIGN KEY(listing_id) REFERENCES listings(id) ON DELETE CASCADE
	);
   ~~~~
	4. Property reviews table
   ~~~~sql
   CREATE TABLE property_reviews(
   	review_id INT,
   	listing_id INT,
   	review_date DATE,
   	reviewer_id INT,
   	reviewer_name VARCHAR(100),
   	comments MEDIUMTEXT,
   	PRIMARY KEY(review_id),
   	FOREIGN KEY(listing_id) REFERENCES listings(id) ON DELETE CASCADE
	);
   ~~~~

### Python -- Connecting to MySQL database and adding in the data
* A MySQL database connection is created and an engine is created in Python (**if reproducing, make sure to add in the appropriate computer password**):
   ~~~~python
   rds_connection_string = "root:<PASSWORD HERE>@127.0.0.1/seattle_airbnb_db"
   engine = create_engine(f"mysql://{rds_connection_string}?charset=utf8", encoding = "utf8")
   ~~~~
* The engine is used to populate all the SQL tables
   ~~~~python
   host_df.to_sql(name="airbnb_hosts",con=engine,if_exists="append",index=False,chunksize=2000)
   
   listing_df.to_sql(name="listings",con=engine,if_exists="append",index=False,chunksize=200)
   
   availability_df.to_sql(name="property_availability",con=engine,if_exists="append",index=False,chunksize=2000)
   
   reviews_df.to_sql(name="property_reviews",con=engine,if_exists="append",index=False,chunksize=2000)
   ~~~~
## Conclusion / Ideas for Future Analysis
* The AirBnB data is very comprehensive. In the future, it could be used to conduct a variety of analyses. The following ideas come to mind:
	* Exploring the differences between superhosts and other hosts across a variety of metrics. For example:
		* Price of listings: Do superhosts or other hosts have more expensive listings?
		* Neighborhoods: Which Seattle neighborhoods do superhosts tend to have properties in?
		* Bedrooms and bathrooms: Do superhosts or other hosts tend to have properties with more bedrooms and bathrooms?
		* Profile picture: Are superhosts more or less likely to have profile pictures?
		* **We think exploring the differences between superhosts and regular hosts would be an interesting analysis. Superhosts become selected as superhosts due to their high ratings, large quantities of property reservations, and minimal cancellations. It would be interesting to find out if those superhosts are associated with certain Seattle neighborhoods, high or low prices of listings, larger or smaller properties, etc.**   
	* Exploring trends in property ratings. For example:
		* Price of listings: Do high reviews tend to be associated with more expensive or less expensive listings?
		* Neighborhoods: Which Seattle neighborhoods have the highest reviewed properties?
		* Bedrooms and bathrooms: Do higher rated properties tend to be larger or smaller?
		* Availability of listings: Do higher rated properties tend to have less availability than lower rated properties?
		* **We think exploring trends in differences between highly rated properties and lowly rated properties would help us paint a picture of the types of listings that Airbnb customers like. Are highly rated listings larger, more expensive, concentrated in certain neighborhoods, etc.?**
	* Examining property availability across a variety of metrics. For example:
		* Security deposit: Do properties that require guests to leave security deposits tend to have more or less availability than properties that do not have that requirement?
		* Requires license: Do properties that require guests to show their IDs tend to have more or less availability than properties that do not have that requirement?
		* Number of reviews: Is having a lot of reviews associated with properties that tend to not have much availability? Or with properties that have a lot of availability?
		* Price: Do cheaper properties tend to have more or less availability than more expensive properties?
		* **We think it would be interesting to observe the factors that are associated with properties that have a lot and a little availability because it would help us gain insight into travelers' buying habits. Are security deposits and license requirements inconveniences for consumers and thus make certain properties less popular? Does having a lot of reviews make listings appear more trustworthy and therefore leads more travelers to book certain properties? Are travelers super price sensitive and are they more or less likely to book cheaper properties?**
		
		
