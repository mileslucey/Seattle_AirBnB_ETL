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
   
