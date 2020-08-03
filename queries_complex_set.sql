


# Sample Complex Queries Written for the Data_Schema.

#SELECTS AND GROUPS AD ID and COUNT of AD_ID if it's in the selection
SELECT  clckd_on_ad_id , COUNT(clckd_on_ad_id ) 
        # selection to be performed from events_table.
        FROM events_table 
        # With the following condition :: ad_id is contained in the 4 suggestion columns
        WHERE
            clckd_on_ad_id = suggested_ad_id_1 OR
            clckd_on_ad_id = suggested_ad_id_2 OR
            clckd_on_ad_id = suggested_ad_id_3 OR

            clckd_on_ad_id = suggested_ad_id_4 OR
            clckd_on_ad_id = suggested_ad_id_5 OR
            clckd_on_ad_id = suggested_ad_id_6 OR

            clckd_on_ad_id = suggested_ad_id_7 OR
            clckd_on_ad_id = suggested_ad_id_8 OR
            clckd_on_ad_id = suggested_ad_id_9 OR

            clckd_on_ad_id = suggested_ad_id_10 OR
            clckd_on_ad_id = suggested_ad_id_11
    # COLLATION AND GROUPING done in accordace with ad_id
    GROUP BY clckd_on_ad_id 

        #REVERSE ORDER THE highest frequency values so most frequently clicked is at top.
        ORDER BY COUNT(clckd_on_ad_id) DESC 

        #LIMIT THE RESULT SO TOP 30 most selected advertisments are retrieved.
        LIMIT 30;

    





# TO RETRIEVE CLICKED THROUGH RATE (CTR) FOR USERS Meaned for Age Range Grouping
# THIS IS A 3-TIERED SELECT STATEMENT. Comments should be read inside out, in numbered order.
SELECT

    # 3. SELECTS AND CATEGORIZES THE AGE COLUMNS with the appropriate age ranges and averages them. 
    AVG(CASE WHEN age > 18 and age < 25 THEN result END) as '18-25',
    AVG(CASE WHEN age > 25 and age < 35 THEN result END) as '25-35',


    AVG(CASE WHEN age > 35 and age < 45 THEN result END) as '35-45',
    AVG(CASE WHEN age > 45 and age < 55 THEN result END) as '45-55',


    AVG(CASE WHEN age > 55 and age < 65 THEN result END) as '55-65',
    AVG(CASE WHEN age > 65 and age < 75 THEN result END) as '65-75',

        FROM
            # 2. SELECTS AND PULLS ::  age & user_id columns as well as counts for clicks vs non just shows and 
            #    groups the counts by age and user_id.
            (SELECT user_id, age, 
                        COUNT(CASE WHEN event_type = 2 THEN event_type END) as clicked_id1,
                        COUNT(CASE WHEN event_type = 1 THEN event_type END) as suggested_id2,
                              COUNT(CASE WHEN event_type = 2 THEN event_type END)/
                             (COUNT(CASE WHEN event_type = 2 THEN event_type END) 
                            + COUNT(CASE WHEN event_type = 1 THEN event_type END)) 
                                AS result

                    FROM
                    #  1. SELECTS RELEVANT COLUMNS FROM :: events_table & user_information_table.
                    #     PERFORMS A JOIN with the age field.
                        (SELECT events_table.user_id, event_type , user_information_table.age 
                            FROM events_table JOIN
                            user_information_table
                            ON 
                            events_table.user_id = user_information_table.usr_id ) 
                                AS summary_1 
                    
                    GROUP BY user_id, age) 
                        AS summary2
                
    GROUP BY '18-25';
