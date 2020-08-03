--  ~~~~~~~~~~~~~~~~~~~~USERS DIMENSION TABLE~~~~~~~~~~~~~~~~~~~~~~~

# PURPOSE:: This table is designed to contain user characteristic information.
# FIELDS :: Joining Date, Unique user id, Gender information, Age, Country, FirstName, Last Name.
# PRIMARY KEY DESC:: user_id is the primary key, it is UNIQUE.

CREATE TABLE user_information_table(
    join_date DATE,
    usr_id INT,
    gender Varchar(1),
    age int,
    country Varchar(255),
    name_first Varchar(255),
    name_last Varchar(255),

        PRIMARY KEY(user_id)
            UNIQUE (user_id)
);





--  ~~~~~~~~~~~~~~~~~~~~~CREATE EVENTS TABLE~~~~~~~~~~~~~~~~~~~~~~~~

# PURPOSE:: This table contains the events including suggestion of product, clicked on suggestion, buying of product.
# FIELDS :: Event occurance date, Time of event, user_id: from user information table, Type of Event,
    -- id_of suggested advertisement for this event, provided by Deep-Learning based Recommendation engine offered to user. Ranked 1 - 11
# PRIMARY KEY DESCRIPTION :: Compound key [user_id, event_time, event_date].

CREATE TABLE events_table(
    
    event_date DATE, 
    event_time TIME, 
    user_id INT,
    event_type VARCHAR(1),
    suggested_ad_id_1  INT,
    suggested_ad_id_2  INT,
    suggested_ad_id_3  INT,
    suggested_ad_id_5  INT,
    suggested_ad_id_6  INT,
    suggested_ad_id_7  INT,
    suggested_ad_id_8  INT,
    suggested_ad_id_9  INT,
    suggested_ad_id_10 INT,
    suggested_ad_id_11 INT, 
    suggested_id_clicked_on INT,

        PRIMARY KEY(user_id, event_time, event_type)

);






--  ~~~~~~~~~~~~~~~~~~~~LOGIN HISTORY TABLE~~~~~~~~~~~~~~~~~~~~~~~

# PURPOSE:: The purpose of this table is to create/maintain a persistent record of login sessions from all users.
# FIELDS :: User_id from User information table, login session id, login time and date, ip_address where user
         -- initiated login session from, Type of internet browser used to access the website (G.Chrome, M.Firefox,
         -- OS.Safari etc)
# PRIMARY KEY DESC:: Primary Key is a unique BIGINT number assigned to each login session.
# FOREIGN KEY DESC:: Foreign Key for the login session is the User_id referenced from the User Information Table,
         -- 

CREATE TABLE login_history_table(

    user_id INT,
    login_session_id BIGINT,
    login_time DATETIME,
    login_ip_address VARCHAR(15),
    browser_type VARCHAR(255),

        PRIMARY KEY(login_session_id)
        UNIQUE (login_session_id)

        FOREIGN KEY (user_id) 
            REFERENCES user_information_table(user_id)
                ON DELETE SET NULL
);





--  ~~~~~~~~~~~~~~~~~~~~PURCHASE RECORDS TABLE~~~~~~~~~~~~~~~~~~~~~~~

# PURPOSE:: This table is disigned to contain a history of all the transactions that have taken place.
# FIELDS :: Transaction identification number, User id, Product Id, date and time of transaction, login session id, 
         -- Transaction amount in US-Dollar amount for that day's exchange rate.

# PRIMARY KEY DESC:: Transaction Id is the primary key this is a generated Hash-Code, it is UNIQUE.
# FOREIGN KEY DESC:: Foreign Key is the user id from User information table, and login session id from the
         -- login history table,

CREATE TABLE Purchase_records_table(

    transaction_id VARCHAR(100),
    
    user_id INT,
    product_id BIGINT,
    transaction_time DATETIME,
    login_session_id BIGINT,
    transaction_amount INT,

        PRIMARY KEY (transaction_id)
            UNIQUE (transaction_id)

        FOREIGN KEY (user_id) 
            REFERENCES user_information_table(user_id)
                ON DELETE SET NULL

        FOREIGN KEY (login_session_id) 
            REFERENCES login_history_table(login_session_id)
                ON DELETE SET NULL


);