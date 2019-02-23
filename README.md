# Seattle AirBnB ETL Project Proposal
## Team Members
* Shannon Chang
* Madeleine Merken
* Miles Lucey
## Data Sources
* one listings.csv file that contains AirBnB listing information and AirBnB host information
* one calendar.csv file that contains property availability information throughout the year
* one reviews.csv file that contains AirBnB property reviews information
## Where We Got the Data
* Kaggle: https://www.kaggle.com/airbnb/seattle
## Idea for Relational Database Schema
* Four tables:
    * One table for listings information from the listings.csv file
    * One table with hosts information from the listings.csv file
    * One table with property availability information from the calendar.csv file
    * One table with property reviews information from the reviews.csv file
* How the tables will be linked together:
    * listings and hosts tables linked together by host_id
    * listings and availability tables linked together by listing_id
    * listings and reviews tables linked together by listing_id
