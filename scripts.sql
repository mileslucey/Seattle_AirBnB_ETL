CREATE DATABASE IF NOT EXISTS seattle_airbnb_db;
USE seattle_airbnb_db;
ALTER DATABASE seattle_airbnb_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS property_availability;
DROP TABLE IF EXISTS property_reviews;
DROP TABLE IF EXISTS listings;
DROP TABLE IF EXISTS airbnb_hosts;

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


CREATE TABLE property_availability(
    id INT NOT NULL AUTO_INCREMENT,
    listing_id INT,
    available_date DATE,
    available BOOLEAN,
    price FLOAT,
    PRIMARY KEY(id),
    FOREIGN KEY(listing_id) REFERENCES listings(id) ON DELETE CASCADE
);

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
