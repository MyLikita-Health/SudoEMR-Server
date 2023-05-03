DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `time_TEST`(`in_param` VARCHAR(50), `in_curr_hour` TIME, `in_date` DATE) RETURNS datetime
BEGIN

  DECLARE next_hour,next_hour2 time DEFAULT "00:00:00";
  DECLARE time_found datetime;

	IF in_param = 'STAT' THEN
    	SET time_found = now();
	ELSE
    	SELECT MIN(time)  INTO next_hour FROM  drug_frequency4  WHERE description=in_param AND time >= in_curr_hour;

	if next_hour is not null then
	set time_found=concat(in_date, ' ', next_hour);
	else
	SELECT MIN(time)  INTO next_hour2 FROM drug_frequency4  WHERE description=in_param;
	set time_found=concat(DATE_ADD(in_date,INTERVAL 1 day) ,' ', next_hour2);
	end if;
    END IF;
    
  RETURN time_found;
END$$
DELIMITER ;
