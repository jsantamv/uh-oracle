INSERT INTO regions VALUES   
        ( 1  
        , 'Europe'   
        );  
  
INSERT INTO regions VALUES   
        ( 2  
        , 'Americas'   
        );  
  
INSERT INTO regions VALUES   
        ( 3  
        , 'Asia'   
        );  
  
INSERT INTO regions VALUES   
        ( 4  
        , 'Middle East and Africa'   
        );  





CREATE OR REPLACE PROCEDURE secure_dml    
BEGIN  
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'  
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN  
	RAISE_APPLICATION_ERROR (-20205,   
		'You may only make changes during normal office hours');  
  END IF;  
END secure_dml; 
        