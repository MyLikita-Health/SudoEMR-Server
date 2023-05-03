DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addExpensesRemarks`(IN `in_remarks_id` VARCHAR(20), IN `in_request_no` VARCHAR(50), IN `in_remarks` VARCHAR(100), IN `in_remarks_by` VARCHAR(50), IN `in_date` VARCHAR(20), IN `in_general_remarks` VARCHAR(100), IN `in_facilityId` VARCHAR(50))
    NO SQL
INSERT INTO remarks(remarks_id,request_no,remarks,remarks_by,date,general_remarks,facilityId)
VALUES(in_remarks_id,in_request_no,in_remarks,in_remarks_by,in_date,in_general_remarks,in_facilityId)$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewExpenses`(IN `in_date` VARCHAR(20), IN `in_month` VARCHAR(20), IN `in_branch_name` VARCHAR(50), IN `in_request_no` VARCHAR(20), IN `in_particulars` VARCHAR(50), IN `in_quantity` VARCHAR(50), IN `in_price` VARCHAR(50), IN `in_amount` VARCHAR(50), IN `in_remarks` VARCHAR(100), IN `in_status` VARCHAR(50), IN `in_expense` VARCHAR(100), IN `in_facilityId` VARCHAR(50), IN `in_type_of_expenses` VARCHAR(100))
    NO SQL
BEGIN

INSERT INTO expense(date,month,branch_name,request_no,particulars,quantity,price,amount,remarks,status,expense_id,facilityId,type_of_expenses)
        VALUES(in_date,in_month,in_branch_name,in_request_no,in_particulars,in_quantity,
        in_price,in_amount,in_remarks,in_status,in_expense,in_facilityId,in_type_of_expenses);
        call update_number_generator("exp",in_request_no);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_drug`(IN `drug` VARCHAR(50), IN `unit_of_issue` VARCHAR(30), IN `quantity` INT(11), IN `price` INT(11), IN `expiry_date` VARCHAR(20), IN `generic` VARCHAR(50), IN `reorderlevel` VARCHAR(10), IN `expiryalert` VARCHAR(10), IN `facId` VARCHAR(50))
BEGIN
    INSERT INTO drugs (drug,genericName,expiry_date,quantity,price,unit_of_issue,reorder_level,expiryAlert,facilityId) VALUES (drug,generic,expiry_date,quantity,price,unit_of_issue,reorderlevel,expiryalert,facId);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_lab_head`(IN `labhead` VARCHAR(50), IN `labsubhead` VARCHAR(50), IN `spec` VARCHAR(50), IN `facId` VARCHAR(50), IN `descr` VARCHAR(50), IN `no_of_label` VARCHAR(50))
BEGIN
    INSERT INTO lab_setup(head, subhead, description, facilityId, specimen, noOfLabels,sort_index) VALUES (labhead, labsubhead,descr , facId,spec,no_of_label,1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_lab_service`(IN `labhead` VARCHAR(50), IN `labsubhead` VARCHAR(50), IN `unit` VARCHAR(50), IN `test` VARCHAR(50), IN `facId` VARCHAR(50), IN `test_from` VARCHAR(50), IN `test_to` VARCHAR(50), IN `spec` VARCHAR(50), IN `test_price` INT, IN `userId` VARCHAR(50), IN `descr` VARCHAR(50), IN `no_of_labels` INT, IN `in_percentage` INT, IN `in_index` INT)
BEGIN
    INSERT INTO lab_setup(head, subhead, description, noOfLabels, unit, facilityId, range_from, range_to, specimen, price, percentage, created_by,sort_index) VALUES (labhead, labsubhead, descr, no_of_labels, unit, facId, test_from, test_to, spec, test_price, in_percentage, userId,in_index);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_store`(IN `in_receive_date` VARCHAR(20), IN `in_item_name` VARCHAR(50), IN `in_po_no` VARCHAR(20), IN `in_qty_in` VARCHAR(50), IN `in_qty_out` VARCHAR(50), IN `in_store_type` VARCHAR(20), IN `in_grm_no` VARCHAR(20), IN `query_type` VARCHAR(20), IN `in_expiring_date` VARCHAR(20), IN `in_unit_price` VARCHAR(30), IN `in_mark_up` VARCHAR(20), IN `in_selling_price` VARCHAR(10), IN `in_transfer_from` VARCHAR(50), IN `in_status` VARCHAR(20), IN `in_transfer_to` VARCHAR(50), IN `in_branch_name` VARCHAR(30), IN `in_facilityId` VARCHAR(50), IN `in_trn_no` INT(50), IN `in_uniqueId` VARCHAR(50), IN `in_item_category` VARCHAR(100))
    NO SQL
BEGIN
if query_type= "received" then
##update purchase_order set status="received" where po_id=in_po_no;
INSERT INTO store (receive_date, item_name, po_no, qty_in,qty_out,store_type,grm_no,expiring_date,unit_price,mark_up,selling_price,transfer_from,transfer_to, branch_name,facilityId,uniqueId,item_category) VALUES(in_receive_date,in_item_name,in_po_no,in_qty_in, in_qty_out,in_store_type,in_grm_no, in_expiring_date,in_unit_price,in_mark_up,in_selling_price,in_transfer_from,in_transfer_to,in_branch_name,in_facilityId,in_uniqueId,in_item_category);
call update_number_generator("grn",in_grm_no);

ELSEIF query_type="transfer" then
INSERT INTO store (receive_date, item_name, po_no, qty_in,qty_out,store_type,grm_no,expiring_date,unit_price,mark_up,selling_price,transfer_from,transfer_to, branch_name,facilityId,trn_number,uniqueId,item_category) VALUES(in_receive_date,in_item_name,in_po_no,in_qty_in, in_qty_out,in_store_type,in_grm_no, in_expiring_date,in_unit_price,in_mark_up,in_selling_price,in_transfer_from,in_transfer_to,in_branch_name,in_facilityId,in_trn_no,uniqueId,in_item_category);

call add_sale_department(in_trn_no,in_item_name,in_qty_out,in_expiring_date,in_selling_price,in_transfer_to,in_receive_date,in_item_category);
end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_supplier`(IN `name` VARCHAR(50), IN `address` VARCHAR(255), IN `phone` VARCHAR(20), IN `code` VARCHAR(10), IN `facId` VARCHAR(50))
BEGIN
       INSERT INTO suppliersinfo(supplier_name, address, phone, code,facilityId) VALUES (name,address,phone,code,facId);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_purchase_order`(IN `in_po_no` INT(40), IN `in_date` DATE, IN `in_type` VARCHAR(50), IN `in_vendor` VARCHAR(100), IN `in_client` VARCHAR(100), IN `in_total_amount` VARCHAR(100), IN `in_status` VARCHAR(100), IN `in_facilityId` VARCHAR(50), IN `in_exchange_type` VARCHAR(50), IN `in_exchange_rate` INT(50), IN `in_supplier_code` INT(10), IN `in_processed_by` VARCHAR(50))
    NO SQL
BEGIN 
INSERT INTO purchase_order(po_id,date,type,vendor,client,total_amount,status,facilityId,exchange_type,exchange_rate,supplier_code,processed_by)VALUES
(in_po_no,in_date,in_type,in_vendor,in_client,in_total_amount,in_status,in_facilityId,in_exchange_type,in_exchange_rate,in_supplier_code,in_processed_by);
call update_number_generator("po",in_po_no);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_purchase_order_list`(IN `in_exchange_rate` INT(50), IN `in_item_name` VARCHAR(100), IN `in_specification` VARCHAR(100), IN `in_quantity_available` INT(100), IN `in_propose_quantity` INT(100), IN `in_price` INT(100), IN `in_propose_amount` INT(100), IN `in_exchange_type` VARCHAR(50), IN `in_po_id` VARCHAR(50), IN `in_type` VARCHAR(100), IN `in_identifier` VARCHAR(100), IN `in_facilityId` VARCHAR(100), IN `in_date` DATE, IN `in_status` VARCHAR(100), IN `in_remark` VARCHAR(100), IN `in_remarks_id` VARCHAR(50), IN `in_item_category` VARCHAR(100), IN `in_expired_status` VARCHAR(11))
    NO SQL
INSERT INTO purchase_order_list(
      exchange_rate,
      item_name,
      specification,
      quantity_available,
      propose_quantity,
      price,
      propose_amount,
  
      exchange_type,
      po_id,
      type,
      identifier,
    remark,
    remarks_id,
      facilityId,
    date,
    status,
    item_category,
    expired_status
      )
      VALUES(
          in_exchange_rate,
      in_item_name,
      in_specification,
      in_quantity_available,
      in_propose_quantity,
      in_price,
      in_propose_amount,
    
      in_exchange_type,
      in_po_id,
      in_type,
      in_identifier,
          in_remark,
          in_remarks_id,
      in_facilityId,
          in_date,
          in_status,
          in_item_category,
          in_expired_status
      )$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sale_department`(IN `in_trn_number` INT(50), IN `in_item_name` VARCHAR(100), IN `in_qty_in` INT(100), IN `in_expiring_date` VARCHAR(100), IN `in_selling_price` INT(100), IN `in_branch_location` VARCHAR(100), IN `in_transaction_date` VARCHAR(20), IN `in_item_category` VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO sale_department(trn_number,	item_name,	qty_in	,expiring_date,	selling_price	,location_from,location_to,transaction_date,qty_out,item_category) VALUES(in_trn_number,in_item_name,in_qty_in,in_expiring_date,in_selling_price,in_branch_location,"pos",in_transaction_date,0,in_item_category);

UPDATE sale_department SET selling_price=in_selling_price WHERE item_name=in_item_name AND location_from=in_branch_location;
-- INSERT INTO branch_store(trn_number,item_name,qty_out,expiring_date,selling_price,location_to,location_from,transaction_date) VALUES(in_trn_number,in_item_name,in_qty_in,in_expiring_date,in_selling_price,in_branch_location,"pos",in_transaction_date);

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `appointment`(IN `in_user_id` VARCHAR(30), IN `patient_id` VARCHAR(20), IN `patient_n` VARCHAR(90), IN `appointType` VARCHAR(50), IN `loc` VARCHAR(70), IN `in_text` VARCHAR(100), IN `in_from` DATETIME, IN `in_to` DATETIME, IN `facId` VARCHAR(60), IN `query_type` VARCHAR(40), IN `in_id` VARCHAR(11))
BEGIN
IF query_type = 'insert' THEN
INSERT INTO `appointment`(user_id,`patientId`, `patient_name`, `appointmentType`, `location`, `notes`, `start_at`, `end_at`, `facilityId`) VALUES (in_user_id,patient_id,patient_n,appointType,loc,in_text,in_from,in_to,facId);
ELSEIF query_type = 'select' THEN
SELECT * from appointment WHERE facilityId=facId AND user_id=in_user_id;
ELSEIF query_type = 'select_user' THEN
SELECT * from appointment WHERE facilityId=facId AND patientId=patient_id;
ELSEIF query_type = 'select_one' THEN
SELECT * from appointment WHERE id=in_id AND facilityId=facId;
ELSEIF query_type = 'delete' THEN
DELETE from appointment WHERE id=in_id AND facilityId=facId;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign`(IN `doctor` VARCHAR(20), IN `patientId` VARCHAR(10), IN `facId` VARCHAR(50), IN `in_query_type` VARCHAR(50))
BEGIN
if in_query_type = 'assign' THEN
    update patientrecords set assigned_to = doctor, date_assigned = now()
    #, assign_type = in_assign_type 
    where id = patientId AND facilityId=facId;
ELSEIF in_query_type = 'waiting' THEN
	select concat(firstname, ' ',surname) as name, id, date_assigned  FROM patientrecords WHERE assigned_to='waiting' AND facilityId=facId ORDER BY date_assigned ASC;
ELSEIF in_query_type='specialists' THEN
	select concat(a.firstname, ' ',a.surname) as name, a.id, date_assigned, concat(b.firstname,' ',b.lastname) as doctorName FROM patientrecords a JOIN users b ON a.assigned_to = b.username WHERE assigned_to!='' AND assigned_to!='waiting' AND a.facilityId=facId ORDER BY date_assigned ASC;
ELSEIF in_query_type = 'by_doc' THEN
	SELECT concat(firstname, ' ',surname) as name, id, date_assigned  FROM patientrecords WHERE assigned_to=doctor AND facilityId=facId;
ELSEIF in_query_type = 'end' THEN
	UPDATE patientrecords SET assigned_to='', date_assigned='' where id = patientId AND facilityId=facId;
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bed_allocation`(IN `in_query_type` VARCHAR(20), IN `in_bed` VARCHAR(50), IN `in_user` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_date` TIMESTAMP, IN `in_patientId` VARCHAR(50), IN `in_allocation_id` VARCHAR(50), IN `in_status` VARCHAR(20))
    NO SQL
IF in_query_type = 'new' THEN
	INSERT INTO bed_allocation (bed_id,patient_id,allocated,allocation_status,allocated_by,facilityId) VALUES (in_bed, in_patientId, in_date,in_status, in_user, in_facId);
    UPDATE patientrecords SET patientStatus='admitted', date_seen='', seen_by='' WHERE id=in_patientId AND facilityId=in_facId;
    
ELSEIF in_query_type = 'discharge' THEN
	UPDATE bed_allocation SET ended=in_date, allocation_status='discharged', ended_by=in_user WHERE id=in_allocation_id;
    UPDATE patientrecords SET patientStatus='', date_seen='', seen_by='' WHERE id=in_patientId AND facilityId=in_facId;
    
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `charges`(IN `p_id` VARCHAR(20), IN `u_id` VARCHAR(20), IN `amt` FLOAT, IN `in_cr` FLOAT, IN `decr` VARCHAR(100), IN `in_status` VARCHAR(30), IN `facId` VARCHAR(60), IN `date_from` DATE, IN `date_to` DATE, IN `query_type` VARCHAR(20), IN `patient_type` VARCHAR(30))
BEGIN
 declare old_balance int;
 declare main_balance int;
 declare paid_balance int;
 declare new_amt int;
 select balance into old_balance  from hospitals where  id=facId;
 set main_balance = old_balance + amt;
 set paid_balance = old_balance - in_cr;

IF query_type = 'insert'  THEN
 IF in_status ='Follow-up' THEN
 SET new_amt = amt DIV 2;
 ELSE
 SET new_amt = amt;
 END IF;
INSERT INTO `charges_fees`(`patient_id`, `user_id`,`dr`, `cr`, `description`, `status`,facilityId,patientType) VALUES (p_id,u_id,new_amt,in_cr,decr,in_status,facId,patient_type);
IF amt > 0 then	
UPDATE `hospitals` SET `balance`=main_balance WHERE id = facId;
ELSE
UPDATE `hospitals` SET `balance`=paid_balance WHERE id = facId;
END IF;

ELSEIF query_type = 'select' THEN
SELECT * FROM charges_fees where facilityId=facId AND date(created_at) BETWEEN date(date_from) AND date(date_to) ORDER BY id DESC;
ELSEIF query_type = 'select_charges' THEN
SELECT * FROM charges_fees where description=decr AND facilityId=facId AND date(created_at) BETWEEN date(date_from) AND date(date_to) ORDER BY id DESC;
ELSEIF query_type = 'balance' THEN
SELECT balance from hospitals WHERE id = facId;
ELSEIF query_type = 'last' THEN
SELECT created_at FROM `charges_fees` WHERE patient_id='7401-1' AND dr != 0 AND dr >150 ORDER BY created_at DESC LIMIT 1;
ELSEIF query_type = 'select_time' THEN 
SELECT time_laps FROM charges_fees_temp WHERE revenueSource = 'Consultation';
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `charges_temp`(IN `head` INT, IN `query_type` VARCHAR(20))
BEGIN
IF query_type = 'select' THEN
SELECT DISTINCT revenueSource FROM charges_fees_temp;
ELSE
SELECT amount,revenueSource FROM `charges_fees_temp` WHERE accountHead=head;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultation_record`(IN `in_query_type` VARCHAR(50), IN `in_consultation_note` VARCHAR(4000), IN `in_decision` VARCHAR(50), IN `in_dressing_request` VARCHAR(500), IN `in_nursing_request` VARCHAR(500), IN `in_user_id` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_consult_id` VARCHAR(90), IN `in_pid` VARCHAR(100), IN `in_treatment_plan` VARCHAR(4000), IN `in_report_type` VARCHAR(50), IN `in_date` VARCHAR(50), IN `in_admissionStatus` VARCHAR(50), IN `dateFrom` DATE, IN `dateTo` DATE, IN `in_patient_name` VARCHAR(100), IN `created_by` VARCHAR(70))
    NO SQL
IF in_query_type = 'insert' THEN
        INSERT INTO consultations (id, consultation_notes,userId, decision, dressing_request, nursing_request,facilityId,patient_id,treatmentPlan,patient_name,seen_by) VALUES (in_consult_id, in_consultation_note, in_user_id, in_decision, in_dressing_request, in_nursing_request,in_facId,in_pid,in_treatment_plan,in_patient_name,created_by);
        IF in_admissionStatus = 'pending' THEN
                UPDATE patientrecords SET patientStatus='pending-admission', seen_by=in_user_id, date_seen=now() WHERE id=in_pid AND facilityId=in_facId;
        END IF;

ELSEIF in_query_type = 'update' THEN
UPDATE consultations SET consultation_notes=in_consultation_note, treatmentPlan=in_treatment_plan WHERE id=in_consult_id;

ELSEIF in_query_type = 'list by patient' THEN
        IF in_report_type = 'by_date' THEN
        SELECT a.id, a.patient_id, a.userId, concat(b.firstname,' ',b.lastname) as reviewedBy, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at FROM consultations a JOIN users b ON a.userId = b.username WHERE patient_id=in_pid AND date(created_at)=in_date ORDER BY created_at DESC;
    ELSE
                SELECT a.id, a.patient_id, a.userId, concat(b.firstname,' ',b.lastname) as reviewedBy, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at FROM consultations a JOIN users b ON a.userId = b.username WHERE patient_id=in_pid ORDER BY created_at DESC;
    END IF;
ELSEIF in_query_type = 'by_id' THEN
        SELECT * FROM consultations WHERE id=in_consult_id;
ELSEIF in_query_type = 'pending nursing requests' THEN
        SELECT id, nursing_request,dressing_request, nursing_request_status,treatmentPlan FROM consultations WHERE nursing_request_status='pending' AND facilityId=in_facId;
ELSEIF in_query_type='nursing_req_by_patient' THEN
        SELECT a.id, a.created_at, nursing_request,dressing_request, nursing_request_status, concat(b.firstname,' ',b.lastname) as doctor_name FROM consultations a JOIN users b ON a.userId = b.username WHERE a.facilityId=b.facilityId AND patient_id=in_pid AND nursing_request_status='pending' AND  a.facilityId=in_facId AND (nursing_request!='' OR dressing_request!='') ORDER BY a.created_at DESC;
ELSEIF in_query_type='treatment_plan_by_patient' THEN
        SELECT a.id, a.created_at, treatmentPlan, concat(b.firstname,' ',b.lastname) as doctor_name FROM consultations a JOIN users b ON a.userId = b.username WHERE a.facilityId=b.facilityId AND patient_id=in_pid AND treatment_plan_status='pending' AND  a.facilityId=in_facId AND treatmentPlan!='' ORDER BY a.created_at DESC;
ELSEIF in_query_type = 'complete nursing req' THEN
        UPDATE consultations SET nursing_request_status='completed' WHERE id=in_consult_id;
ELSEIF in_query_type = 'treatment-done' THEN
        UPDATE consultations SET treatment_plan_status='completed', treatment_by=in_user_id WHERE id=in_consult_id;
ELSEIF in_query_type = 'visit_days' THEN
        SELECT DISTINCT date(created_at) as created_at FROM consultations WHERE patient_id=in_pid ORDER BY created_at DESC;
ELSEIF in_query_type = 'surgery_days' THEN
        SELECT DISTINCT date(createdAt) as created_at FROM operationnotes WHERE patientId=in_pid ORDER BY createdAt DESC;
        ELSEIF in_query_type = 'history' THEN
  SELECT a.patient_id, a.userId, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at, a.treatment_plan_status, a.treatment_by, concat(b.surname, ' ', b.firstname, ' ', ifnull(b.other, '')) as full_name FROM `consultations` a JOIN patientrecords b WHERE a.patient_id=b.id and a.facilityId=b.facilityId AND a.userId=in_user_id AND a.facilityId=in_facId AND DATE(a.created_at) BETWEEN date(dateFrom) AND date(dateTo) ORDER BY a.created_at DESC;
END if$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_bed`(IN `in_query_type` VARCHAR(20), IN `in_class` VARCHAR(20), IN `in_price` INT, IN `in_bed` VARCHAR(100), IN `in_facId` VARCHAR(50), IN `noOfBeds` INT)
    NO SQL
IF in_query_type  = 'newBed' THEN
	INSERT INTO bedlist (class_type, price, name,facilityId,no_of_beds) VALUES (in_class, in_price, in_bed,in_facId,noOfBeds);
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_discount`(IN `in_query_type` VARCHAR(50), IN `in_discount_type` VARCHAR(50), IN `in_discount_name` VARCHAR(50), IN `in_discount_amount` INT, IN `in_discount_head` VARCHAR(50), IN `in_discount_head_name` VARCHAR(50), IN `in_user` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_receiptNo` VARCHAR(50))
    NO SQL
IF in_query_type = 'new' THEN
	INSERT INTO discount (discountName, discountType, discountAmount, discountHead, discountHeadName,created_by,facilityId) VALUES (in_discount_name, in_discount_type, in_discount_amount, in_discount_head, in_discount_head_name,in_user,in_facId);
ELSEIF in_query_type = 'select' THEN
	SELECT * FROM discount WHERE facilityId=in_facId;
ELSEIF in_query_type = 'pending' THEN
	SELECT patient_name, created_at, SUM(price) as total_amount, receiptNo, discount, discount_head, discount_amount FROM lab_requisition WHERE approval_status = 'pending_discount' AND facilityId = in_facId GROUP BY patient_name, created_at, discount, discount_head, discount_amount;
ELSEIF in_query_type = 'approval' THEN
	update lab_requisition SET approval_status = 'pending' WHERE receiptNo=in_receiptNo AND facilityId=in_facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_client_acc`(IN `accType` VARCHAR(20), IN `s_name` VARCHAR(50), IN `f_name` VARCHAR(50), IN `p_gender` VARCHAR(20), IN `dob` DATE, IN `maritalStatus` VARCHAR(20), IN `p_occupation` VARCHAR(20), IN `address` VARCHAR(100), IN `depositAmount` INT, IN `in_modeOfPayment` VARCHAR(20), IN `c_name` VARCHAR(50), IN `c_address` VARCHAR(100), IN `c_phone` VARCHAR(20), IN `c_email` VARCHAR(50), IN `web` VARCHAR(20), IN `facId` VARCHAR(50), IN `userId` VARCHAR(50), IN `patientId` VARCHAR(50), IN `kName` VARCHAR(200), IN `kPhone` VARCHAR(100), IN `kRel` VARCHAR(20), IN `kEmail` VARCHAR(50), IN `kAddress` VARCHAR(200), IN `in_receiptsn` VARCHAR(50), IN `in_receiptno` VARCHAR(50), IN `in_sourceAcct` VARCHAR(50), IN `paybles_head` VARCHAR(50), IN `recievables_head` VARCHAR(50), IN `in_description` VARCHAR(50), IN `in_type` VARCHAR(50))
    NO SQL
BEGIN
	DECLARE acc_no INT;
    select ifnull(max(accountNo), 0) + 1 INTO acc_no FROM patientfileno WHERE facilityId=facId;
    
    IF in_type = 'update' THEN
    	INSERT INTO patientfileno (accountNo, facilityId,accountType,accName,contactName,
                                       contactAddress,contactPhone, contactEmail, contactWebsite,
                                       firstname,surname) 
               VALUES (acc_no, facId, accType, concat(s_name,' ',f_name), c_name, 
                                               c_address, c_phone, c_email, web, f_name, s_name);
		UPDATE patientrecords set accountNo=acc_no, beneficiaryNo=1, id=concat(acc_no,'-',1) WHERE patient_id = patientId AND facilityId=facId;
    
    ELSE
    	IF accType = 'family' THEN
        	INSERT INTO patientfileno (accountNo, facilityId,accountType,accName,contactName,
                                       contactAddress,contactPhone, contactEmail, contactWebsite,
                                       firstname,surname) 
               VALUES (acc_no, facId, accType, concat(s_name,' ',f_name), c_name, 
                                               c_address, c_phone, c_email, web, f_name, s_name);
        	INSERT INTO patientrecords (accountNo, beneficiaryNo, id, facilityId,surname,firstname,
                                        gender,maritalstatus,DOB,phoneNo,email, occupation,
                                        address,patient_id,kinName,kinRelationship,kinPhone,
                                        kinEmail,kinAddress) 
               VALUES (acc_no,1,concat(acc_no,'-',1), facId,s_name,f_name,gender,maritalStatus, dob, 
                                                c_phone,c_email,p_occupation, c_address, 
                                                patientId,kName,kRel,kPhone,kEmail,kAddress);

    	ELSE
        	INSERT INTO patientfileno (accountNo,facilityId,accountType,contactName,contactAddress,contactPhone,contactEmail, contactWebsite,description,accName) VALUES (acc_no,facId,accType,c_name,c_address,c_phone,c_email,web,f_name,s_name);

    	END IF;
    END IF;
    
    IF depositAmount > 0 THEN
    	CALL customer_deposit(acc_no,depositAmount,userId,in_receiptsn, in_receiptno, in_description, in_modeOfPayment, facId,in_sourceAcct,concat(s_name,' ', f_name),accType,NOW(),c_address,c_phone,c_email,web,paybles_head,recievables_head,'','','','');
   	END IF;
    
COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_lab_client`(IN `client_acc` VARCHAR(50), IN `acc_no` VARCHAR(50), IN `ben_no` VARCHAR(50), IN `first_name` VARCHAR(50), IN `last_name` VARCHAR(50), IN `other_name` VARCHAR(50), IN `p_gender` VARCHAR(50), IN `birth` DATE, IN `mail` VARCHAR(50), IN `facId` VARCHAR(50), IN `labno` VARCHAR(50), IN `phone` VARCHAR(13))
BEGIN 

INSERT INTO patientrecords (accountNo,beneficiaryNo,id,firstname,surname,other,Gender, DOB,email,facilityId,phoneNo) VALUES (acc_no,ben_no,CONCAT(acc_no,'-',ben_no),first_name, last_name,other_name, p_gender,birth,mail,facId,phone); 


END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_org_acc`(IN `in_acct` VARCHAR(50), IN `Amount_paid` INT, IN `userId` VARCHAR(50), IN `receiptDateSN` VARCHAR(20), IN `receiptNo` VARCHAR(20), IN `modeOfPayment` VARCHAR(30), IN `in_facId` VARCHAR(50), IN `in_cash_head` VARCHAR(50), IN `acc_name` VARCHAR(100), IN `acc_type` VARCHAR(20), IN `in_date` DATETIME, IN `in_address` VARCHAR(50), IN `in_phone` VARCHAR(20), IN `in_email` VARCHAR(50), IN `in_website` VARCHAR(50), IN `in_payables_head` VARCHAR(50), IN `in_recievables_head` VARCHAR(50), IN `in_guarantor_name` VARCHAR(100), IN `in_guarantor_address` VARCHAR(100), IN `in_guarantor_phone` VARCHAR(20), IN `in_bank_name` VARCHAR(30), IN `in_pid` VARCHAR(20), IN `in_txn_status` VARCHAR(50), IN `in_description` VARCHAR(200))
BEGIN

DECLARE next_payable_code VARCHAR(20);
DECLARE next_receivable_code VARCHAR(20);

CALL customer_deposit(in_acct, Amount_paid,userId,receiptDateSN,receiptNo,
        in_description,modeOfPayment,in_facId,in_cash_head,acc_name,acc_type,in_date,
in_address,in_phone,in_email,in_website,in_payables_head,in_recievables_head,in_guarantor_name,
        in_guarantor_address,in_guarantor_phone,in_bank_name,in_pid,in_txn_status);

SELECT ifnull(max(head), 0) + 1 into next_payable_code FROM account where subhead=in_payables_head
        AND facilityId=in_facId;
SELECT ifnull(max(head), 0) + 1 into next_receivable_code FROM account where subhead=in_recievables_head
        AND facilityId=in_facId;

call new_acc_head(concat(acc_name, ' Payables'),in_payables_head,next_payable_code,0,in_facId,0);
call new_acc_head(concat(acc_name, ' Receivables'),in_recievables_head,next_receivable_code,0,in_facId,0);
UPDATE patientfileno SET payable_head=next_payable_code, payable_head_name=concat(acc_name, ' Payables'), receivable_head=next_receivable_code, receivable_head_name=concat(acc_name, ' Receivables') WHERE accountNo=in_acct AND facilityId=in_facId;

end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createbooking_list`(IN `in_request_id` VARCHAR(50))
    NO SQL
BEGIN
	DECLARE test_data,department_data INTEGER;
	declare finished integer default 0;
	DECLARE print_type_data,patient_id_data,test_group_data varchar(100) ;
	

	DEClARE curLabtest 
		CURSOR FOR 
        
            SELECT test,print_type,department,patient_id,test_group FROM lab_requisition where  request_id=in_request_id;
            
            
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curLabtest;

	getLab: LOOP
		FETCH curLabtest INTO test_data,print_type_data,department_data,patient_id_data,test_group_data;

		
		IF finished = 1 THEN 
			LEAVE getLab;
		END IF;
		
    if  print_type_data='single' then 
		BLOCK2: begin
                declare maxCode, labCodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		        select  max(booking)+1,concat(year_code,max(booking)+1) from booking_no GROUP by year_code;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
                LOOP2: loop
                    fetch cursor2 into  maxCode, labCodeNumber;
                    
                    
                    update lab_requisition set booking_no=labCodeNumber where test=test_data and print_type='single' and
                        request_id=in_request_id ;
            
                    update booking_no set booking=maxcode;
    
	
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
	

                end loop LOOP2;
            end BLOCK2;
    elseif  print_type_data = 'grouped' then 
		BLOCK2: begin
                declare maxCode, labCodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		        select  max(booking)+1,concat(year_code,max(booking)+1) from booking_no GROUP by year_code;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
                LOOP2: loop
                    fetch cursor2 into  maxCode, labCodeNumber;
                    
                    update lab_requisition set booking_no=labCodeNumber where  department=department_data and print_type = 'grouped' and  request_id=in_request_id;

                update booking_no set booking=maxcode;
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		

                

                end loop LOOP2;
               
            end BLOCK2;

    elseif  print_type_data='singular_group' then 
		BLOCK2: begin
                declare maxCode, labCodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		 select  max(booking)+1,concat(year_code,max(booking)+1) from booking_no GROUP by year_code;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
                LOOP2: loop
                    fetch cursor2 into  maxCode, labCodeNumber;
                    
                    
                    update lab_requisition set booking_no=labCodeNumber where  department=department_data and print_type='singular_group' 
                        and request_id=in_request_id;
                    update booking_no set booking=maxcode;
	
	
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		

                end loop LOOP2;
               	
            end BLOCK2;
    
	 end if;

	END LOOP getLab;
	CLOSE curLabtest;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createlabcode_list`(IN `in_request_id` VARCHAR(100))
BEGIN
	DECLARE test_data,department_data, test_group_data INTEGER;
	declare finished integer default 0;
	DECLARE booking_no_data,label_type_data,patient_id_data varchar(100) ;
	

	DEClARE curLabtest 
		CURSOR FOR 
        
			SELECT booking_no,test,label_type,department,patient_id,test_group FROM lab_requisition where  request_id=in_request_id;
            
            
        

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curLabtest;

	getLab: LOOP
		FETCH curLabtest INTO booking_no_data,test_data,label_type_data,department_data,patient_id_data,test_group_data;

		
		IF finished = 1 THEN 
			LEAVE getLab;
		END IF;
		
  if  label_type_data='single' then 
		BLOCK2: begin
                declare maxCode, barcodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		 select  max(barcode)+1,concat(initials,year_code,max(barcode)+1) from barcode where lab_code=department_data;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
               LOOP2: loop
                    fetch cursor2 into  maxCode, barcodeNumber;
                    
                    
 update lab_requisition set code=barcodeNumber where booking_no=booking_no_data and test=test_data and label_type='single' and  request_id=in_request_id ;
		
    update barcode set barcode=maxcode where lab_code=department_data;
    
	
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		



                end loop LOOP2;
            end BLOCK2;
elseif  label_type_data = 'grouped' then 
		BLOCK2: begin
                declare maxCode, barcodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		 select  max(barcode)+1,concat(initials,year_code,max(barcode)+1) from barcode where lab_code=department_data;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
               LOOP2: loop
                    fetch cursor2 into  maxCode, barcodeNumber;
                    
                    
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		

 update lab_requisition set code=barcodeNumber where department=department_data and label_type = 'grouped' and  request_id=in_request_id;
           update barcode set barcode=maxcode where lab_code=department_data;

                end loop LOOP2;
               
            end BLOCK2;

            elseif  label_type_data='grouped_single' then 
		BLOCK2: begin
                declare maxCode, barcodeNumber int;
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		 select  max(barcode)+1,concat(initials,year_code,max(barcode)+1) from barcode where lab_code=department_data;
		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
               LOOP2: loop
                    fetch cursor2 into  maxCode, barcodeNumber;
                    
                    
  update lab_requisition set code=barcodeNumber where  label_type='grouped_single'and  request_id=in_request_id and test_group=test_group_data;
                update barcode set barcode=maxcode where lab_code=department_data;
	
	
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		

            

                end loop LOOP2;
               	
            end BLOCK2;
    
	 end if;

	END LOOP getLab;
	CLOSE curLabtest;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_deposit`(IN `in_acct` INT, IN `amount_paid` INT, IN `userId` VARCHAR(50), IN `in_receiptDateSN` VARCHAR(50), IN `in_receiptSN` VARCHAR(50), IN `in_description` VARCHAR(1000), IN `in_mode_of_payment` VARCHAR(60), IN `in_facId` VARCHAR(50), IN `sourceAcct` VARCHAR(50), IN `acc_name` VARCHAR(100), IN `acc_type` VARCHAR(20), IN `in_date` DATETIME, IN `in_address` VARCHAR(100), IN `in_phone` VARCHAR(20), IN `in_email` VARCHAR(50), IN `in_website` VARCHAR(50), IN `in_payables_head` VARCHAR(50), IN `in_recievables_head` VARCHAR(50), IN `in_guarantor_name` VARCHAR(50), IN `in_guarantor_address` VARCHAR(100), IN `in_guarantor_phone` VARCHAR(20), IN `in_bank_name` VARCHAR(50), IN `in_pid` VARCHAR(50), IN `in_txn_status` VARCHAR(50))
BEGIN
	declare client_balance double;
	declare main_balance double;
    #DECLARE remaining_balance double;
	select balance into client_balance from patientfileno where accountNo=in_acct AND facilityId=in_facId LIMIT 1;

	#SET remaining_balance = Amount_paid - client_balance;
	set main_balance = client_balance+Amount_paid;

	-- # IF customer is a NEW client,
    -- # We create a new account for the customer and deposit the amount
	if client_balance is null and amount_paid < 0 then
  
        	insert into patientfileno (accountNo,accName,balance,facilityId,status,accountType,contactAddress,contactPhone,contactEmail,contactWebsite,guarantor_name,
               guarantor_address,guarantor_phone)
		values(in_acct,acc_name,Amount_paid,in_facId,'approved',acc_type,in_address,in_phone,in_email,in_website,in_guarantor_name,
               in_guarantor_address,in_guarantor_phone);

       insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
		values (in_acct,abs(Amount_paid),0,in_receiptDateSN,in_description,in_facId,in_date,in_pid,in_txn_status);
        
		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,
                                  patient_id,facilityId,createdAt,bank_name)
		values (in_description,sourceAcct,abs(Amount_paid),0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,
                                  patient_id,facilityId,createdAt,bank_name)
		values (in_description,in_recievables_head,0,abs(Amount_paid) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);
            
            
            
            
            
            ELSEif client_balance is null then
    
		insert into patientfileno (accountNo,accName,balance,facilityId,status,accountType,contactAddress,contactPhone,contactEmail,contactWebsite,guarantor_name,
               guarantor_address,guarantor_phone)
		values(in_acct,acc_name,Amount_paid,in_facId,'approved',acc_type,in_address,in_phone,in_email,in_website,in_guarantor_name,
               in_guarantor_address,in_guarantor_phone);

       insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
		values (in_acct,abs(Amount_paid),0,in_receiptDateSN,in_description,in_facId,in_date,in_pid,in_txn_status);
        
		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,sourceAcct,abs(Amount_paid),0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,in_payables_head,0,abs(Amount_paid) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

	end if;
    
    -- # IF customer has an account, but the deposit amount nullifies his account balance
    -- # i.e. he's paying up his debt
	if  main_balance = 0 then
 
		update patientfileno set balance= main_balance  where accountNo=in_acct AND facilityId=in_facId;

		insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
		values (in_acct,abs(Amount_paid),0,in_receiptDateSN,in_description,in_facId,in_date,in_pid,in_txn_status);
		 
		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment, enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,sourceAcct,abs(Amount_paid),0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment, enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,in_recievables_head,0,abs(client_balance) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

	-- # IF customer has an account, and his new account balance after the deposit is a top up
    -- # to his initial account balance
	elseif main_balance  > 0  then
 
		update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

		insert into account_entries (acct,dr,cr, reference_no, description, facilityId, createdAt,client_id,txn_status)
		values (in_acct,Amount_paid,0,in_receiptDateSN, in_description,in_facId, in_date,in_pid,in_txn_status);

		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,sourceAcct,abs(Amount_paid),0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

		-- # IF customer's was owing us some money, then
		if  client_balance < 0 then

			insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                      client_acct,patient_id,facilityId,createdAt,bank_name)
			values (in_description,in_recievables_head,0,abs(client_balance) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                    userId,in_acct,in_acct,in_facId,in_date,in_bank_name);

			insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                      client_acct,patient_id,facilityId,createdAt,bank_name)
			values (in_description,in_payables_head,0,abs(main_balance) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                    userId,in_acct,in_acct,in_facId,in_date,in_bank_name);
            
		-- # ELSE IF customer had some money in his/her account
		elseif client_balance >= 0 then
			insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
                                      client_acct,patient_id,facilityId,createdAt,bank_name)
			values (in_description,in_payables_head,0,abs(Amount_paid) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                    userId,in_acct,in_acct,in_facId,in_date,in_bank_name);
		end if;

	-- # IF the customer was owing some money and the deposit amount is not upto the amount owed
	elseif main_balance  < 0 then
		update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

		insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
		values (in_acct,abs(Amount_paid),0,in_receiptDateSN,in_description,in_facId,in_date,in_pid,in_txn_status);

		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,
                                  modeOfPayment,enteredBy,
                                  client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,sourceAcct,abs(Amount_paid),0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
                userId,in_acct,in_acct,in_facId,in_date,in_bank_name);
        
		insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,
                                  enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name)
		values (in_description,in_recievables_head,0,abs(Amount_paid) ,in_receiptDateSN,
                in_receiptSN,in_mode_of_payment,userId,in_acct,in_acct,in_facId,in_date,in_bank_name);
        
        
	end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOperationNote`(IN `in_id` INT, IN `facId` VARCHAR(50))
    NO SQL
DELETE FROM operationnotes where id=in_id and facilityId=facId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_drug`(IN `drugId` VARCHAR(11), IN `facId` VARCHAR(50))
BEGIN
    DELETE FROM drugs WHERE drug_id = drugId AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_service`(IN `serviceId` VARCHAR(11), IN `facId` VARCHAR(50))
BEGIN
    DELETE FROM services WHERE service_id = serviceId AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_supplier`(IN `supplierId` VARCHAR(50), IN `facId` VARCHAR(50))
BEGIN
	DELETE FROM suppliersinfo WHERE id=supplierId AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(IN `id` INT(100), IN `facilityId` INT(20))
    NO SQL
DELETE FROM `users` WHERE `users`.`id` = id AND facilityId = facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `department`(IN `in_query_type` VARCHAR(10), IN `in_facId` VARCHAR(50), IN `in_name` VARCHAR(50), IN `in_user_id` VARCHAR(50))
    NO SQL
if in_query_type = 'new' THEN
	INSERT INTO department (dept_name, created_by, facilityId) VALUES (in_name,in_user_id,in_facId);
ELSEIF in_query_type = 'get' THEN
	SELECT * FROM department WHERE facilityId=in_facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deposit`(IN `amt` INT, IN `patientId` VARCHAR(50), IN `descr` VARCHAR(100), IN `source_head` VARCHAR(100), IN `userId` VARCHAR(50), IN `receiptsn` VARCHAR(50), IN `receiptno` VARCHAR(50), IN `payment_mode` VARCHAR(50), IN `dest_head` VARCHAR(100), IN `facId` VARCHAR(100), IN `in_date` DATETIME)
    NO SQL
BEGIN 
  DECLARE acc_balance int;
  SELECT balance INTO acc_balance FROM patientfileno WHERE accountNo = patientId AND facilityId=facId;
  UPDATE patientfileno SET balance = acc_balance + amt WHERE accountNo = patientId AND facilityId=facId;
  INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, modeOfPayment,client_acct,facilityId,createdAt) 
    VALUES (descr,source_head,0,amt,userId,receiptsn,receiptno,payment_mode,patientId,facId,in_date);
  INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, modeOfPayment,client_acct,facilityId, createdAt) 
    VALUES (descr,dest_head,amt,0,userId,receiptsn,receiptno,payment_mode,patientId,facId,in_date);
  
  COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `doctorLabRequest`(IN `in_department` VARCHAR(50), IN `in_test` VARCHAR(100), IN `in_percentage` VARCHAR(5), IN `in_price` VARCHAR(11), IN `in_code` VARCHAR(50), IN `in_noOfLabels` VARCHAR(7), IN `in_test_group` VARCHAR(30), IN `in_print_type` VARCHAR(30), IN `in_label_type` VARCHAR(30), IN `in_patient_id` VARCHAR(50), IN `in_requested_by` VARCHAR(50), IN `in_facilityId` VARCHAR(50), IN `in_status` VARCHAR(11), IN `query_type` VARCHAR(20), IN `in_req_id` VARCHAR(50), IN `in_description` VARCHAR(100), IN `in_patient_status` VARCHAR(20), IN `in_from` VARCHAR(20), IN `in_to` VARCHAR(20), IN `in_created_by` VARCHAR(50), IN `in_receiptDateSN` VARCHAR(50), IN `in_payment_status` VARCHAR(20), IN `in_old_price` VARCHAR(10), IN `in_payables_head` VARCHAR(10), IN `in_recievables_head` VARCHAR(10), IN `in_account` VARCHAR(10), IN `in_account_name` VARCHAR(50), IN `in_patient_name` VARCHAR(100), IN `in_department_code` VARCHAR(10), IN `in_unit_code` VARCHAR(10), IN `in_unit_name` VARCHAR(50), IN `in_unit` VARCHAR(10), IN `in_range_from` VARCHAR(10), IN `in_range_to` VARCHAR(10), IN `in_client_type` VARCHAR(20), IN `in_client_account` VARCHAR(10), IN `in_discount` VARCHAR(10), IN `in_discount_head` VARCHAR(10), IN `in_discount_head_name` VARCHAR(50), IN `in_approval_status` VARCHAR(20), IN `in_discount_amount` VARCHAR(10), IN `in_request_id` VARCHAR(20))
    NO SQL
BEGIN
IF query_type= 'insert' THEN

    INSERT INTO lab_requisition(test,patient_id,facilityId,price,percentage,
        department,test_group,status,created_by,receiptNo,payment_status,label_type,noOfLabels,
        print_type,payable_head,receivable_head,account,account_name,
        patient_name,department_code,unit_code,unit_name,unit,range_from,range_to,client_type,
        client_account,discount,discount_head,discount_head_name,approval_status,discount_amount,request_id, patient_status, requested_by,description) 
    VALUES (in_test,in_patient_id,in_facilityId,in_price,in_percentage,in_department,in_test_group,
        in_status,in_created_by,in_receiptDateSN,in_payment_status,in_label_type,in_noOfLabels,
        in_print_type,in_payables_head,in_recievables_head,in_account,in_account_name,
        in_patient_name,in_department_code,in_unit_code,in_unit_name,in_unit,in_range_from, in_range_to,
        in_client_type,in_client_account,in_discount,in_discount_head,in_discount_head_name,in_approval_status,
        in_discount_amount,in_req_id,in_patient_status,in_requested_by,in_description);
    COMMIT;

ELSEIF query_type='ordered_list' THEN 
SELECT patient_name as name, created_at, patient_id,'' as DOB,request_id, patient_status FROM lab_requisition 
WHERE status='ordered' AND date(created_at) BETWEEN date(in_from) AND date(in_to) GROUP BY patient_id;

ELSEIF query_type = 'lab_processed' THEN
UPDATE lab_requisition SET status = 'Sample Collected' WHERE request_id = in_req_id;
   call createbooking_list(in_req_id);
  call  createlabcode_list(in_req_id);
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `drug_expiry_alert`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM drugpurchaserecords WHERE DATE_FORMAT(expiry_date, '%Y-%m-%d') BETWEEN DATE_FORMAT(NOW(), '%Y-%m-%d') AND DATE_FORMAT(DATE_ADD(NOW(),INTERVAL 6 MONTH), '%Y-%m-%d') AND (facilityId=facId) ORDER by expiry_date ASC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `drug_freq_setup`(IN `in_query_type` VARCHAR(50), IN `in_desc` VARCHAR(100), IN `in_time` VARCHAR(10), IN `in_time_int` INT)
    NO SQL
IF in_query_type = 'hours' THEN
	SELECT * FROM hour_list;
ELSEIF in_query_type = 'new' THEN 
	INSERT INTO drug_frequency4 (description, time, drug_time) VALUES (in_desc, in_time, in_time_int);
ELSEIF in_query_type = 'list' THEN
	SELECT * FROM drug_frequency4;
ELSEIF in_query_type = 'delete' THEN
	DELETE FROM drug_frequency4 WHERE description=in_desc;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `drug_qtty_alert`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM drugpurchaserecords WHERE drugpurchaserecords.balance < drugpurchaserecords.reorder_level AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `drug_schedule`(IN `in_patient_id` VARCHAR(50))
    NO SQL
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE id_data varchar(150) DEFAULT "";
	

	DEClARE curLabtest 
		CURSOR FOR 
        
			SELECT id   FROM dispensary WHERE patient_id=in_patient_id AND schedule_status='pending';

            
            
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curLabtest;

	getLab: LOOP
		FETCH curLabtest INTO id_data ;

		
		IF finished = 1 THEN 
			LEAVE getLab;
		END IF;
		
 
		BLOCK2: begin
                DECLARE id_data2, patient_id_data, drug_data,frequency_data, facilityId_data, prescribed_by_data varchar(150) DEFAULT "";
		DECLARE duration_data, no_of_days_data,times_per_day_data, drug_count_data, no_times_data int;
		DECLARE startTime_data,end_date_data DATETIME;

		DECLARE i,d datetime default '0000-00-00 00:00:00';
    		declare j int default 0;
		
                declare no_more_rows2 integer default 0;
                declare cursor2 cursor for
                   
 		 SELECT id, patient_id, drug, duration, no_of_days, frequency, startTime, times_per_day, end_date, drugCount,
          facilityId, prescribed_by, no_times  
                        FROM dispensary WHERE id=id_data;

		
                declare continue handler for not found
                    set no_more_rows2 =1;
                open cursor2;
               LOOP2: loop
                    fetch cursor2 INTO id_data, patient_id_data, drug_data, duration_data, no_of_days_data, 
                        frequency_data, startTime_data, times_per_day_data, end_date_data, drug_count_data, facilityId_data,
                        prescribed_by_data, no_times_data;
                    
			   
                IF i< startTime_data then
                    set i=startTime_data;
                    set d=end_date_data;
                end if;
                WHILE i <=d  and j < drug_count_data DO
                INSERT INTO drug_schedule( time_stamp,	drug_name, patient_id,prescription_id, facilityId, administered_by ) 
                    VALUES(i,drug_data,patient_id_data,id_data,facilityId_data, prescribed_by_data) ;
                    SET i = (select DATE_ADD((select max(time_stamp) from drug_schedule where prescription_id=id_data ), INTERVAL no_times_data hour) );
                    set j = j + 1;   
                END WHILE;
                
	CALL update_dispensary('new schedule', 'scheduled', id_data);
                    if no_more_rows2 =1 then
                        close cursor2;
                        leave LOOP2;
                    end if;
		



                end loop LOOP2;
            end BLOCK2;

	 

	END LOOP getLab;
	CLOSE curLabtest;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_by_doctor`(IN `doctor` VARCHAR(20), IN `facId` VARCHAR(50))
BEGIN
    select * from patientrecords where assigned_to = doctor AND facilityId=facId limit 20;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fluid_chart`(IN `in_patient_id` VARCHAR(50), IN `in_input_volume` VARCHAR(50), IN `in_input_route` VARCHAR(30), IN `in_input_type` VARCHAR(50), IN `in_output_volume` VARCHAR(50), IN `in_output_route` VARCHAR(30), IN `in_output_type` VARCHAR(55), IN `in_created_at` DATETIME, IN `query_type` VARCHAR(30), IN `in_created_by` VARCHAR(50))
BEGIN
IF query_type='insert' THEN
INSERT INTO `fluid_chart`(`patient_id`, `input_volume`, `input_route`, `input_type`, `output_volume`, `output_route`, `output_type`, `created_at`, created_by) VALUES (in_patient_id,in_input_volume,input_route,in_input_type,in_output_volume,in_output_route,in_output_type,in_created_at,in_created_by);
ELSEIF query_type='select' THEN 
SELECT * FROM fluid_chart WHERE patient_id=in_patient_id;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `frequency_test`(IN `in_param` VARCHAR(50), IN `in_curr_hour` TIME, IN `in_date` DATE, IN `in_no_of_days` INT)
BEGIN

 select distinct no_times, description,time_TEST(in_param,in_curr_hour, `in_date`) next_time, date_add(time_TEST(in_param,in_curr_hour, `in_date`), INTERVAL in_no_of_days day) end_time,
 COUNT(description) no_of_times, in_no_of_days * COUNT(description) as drug_count FROM drug_frequency4 WHERE description=in_param;

end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLabReceipt`(IN `in_receiptNo` VARCHAR(50), IN `in_facilityId` VARCHAR(50), IN `in_query_type` VARCHAR(50))
    NO SQL
IF in_query_type = 'summary' THEN
SELECT description as patient_name, sum(debit) as amount, receiptDateSN as receiptNo FROM transactions3 WHERE receiptDateSN = in_receiptNo AND facilityId=in_facilityId;
ELSE 
SELECT description, price, patient_id,created_at,created_by as enteredBy,modeOfPayment FROM  lab_info    WHERE receiptNo = in_receiptNo AND price >0  AND facilityId=in_facilityId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getQTY`(IN `in_item_name` VARCHAR(40))
    NO SQL
SELECT SUM(qty_in-qty_out) as qty FROM `store` WHERE item_name=in_item_name$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getReturnDrug`(IN `in_recepit` INT(20), IN `in_drug_code` INT(20))
SELECT * FROM drugs WHERE receipt_no=in_recepit AND drug=in_drug_code AND source='sold_items'$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUnitOfIssue`(IN `drugName` VARCHAR(50), IN `facId` VARCHAR(50))
BEGIN
	SELECT DISTINCT unit_of_issue FROM drugs WHERE  drug = drugName AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_chart`(IN `facId` VARCHAR(50))
BEGIN
	SELECT head as title,subhead,description,price FROM account WHERE facilityId=facId;
    #SELECT head,subhead title FROM account WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_head_for_acc`(IN `in_description` VARCHAR(100), IN `in_facId` VARCHAR(50))
    NO SQL
SELECT * from account where description=in_description AND facilityId=in_facId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_account`(IN `facId` VARCHAR(50))
BEGIN
    select ifnull(max(accountNo),0) + 1 as 'max(accountNo) + 1' from patientrecords WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all`(IN `facId` VARCHAR(50))
BEGIN
    select * from patientrecords WHERE facilityId=facId limit 50;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_acc_heads`(IN `facId` VARCHAR(50))
BEGIN
    SELECT head, subhead, description FROM account WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_consultation`(IN `date_from` DATE, IN `date_to` DATE, IN `doc_name` VARCHAR(50), IN `query_type` VARCHAR(30), IN `facId` VARCHAR(80))
BEGIN
IF query_type='select_all' THEN
SELECT * from consultations WHERE facilityId=facId AND DATE(created_at) BETWEEN DATE(date_from) AND DATE(date_to);
ELSEIF query_type = 'select_by_doc' THEN
SELECT * from consultations WHERE userId=doc_name AND facilityId=facId AND DATE(created_at) BETWEEN DATE(date_from) AND DATE(date_to);
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_lab_services`(IN `facId` VARCHAR(50), IN `in_query_type` VARCHAR(50), IN `in_description` VARCHAR(100))
    NO SQL
IF in_query_type = 'search' THEN
	SELECT head as subhead, subhead as title, department_code,unit_code,unit_name, unit, range_from, range_to, account,account_name, payable_head,payable_head_name, receivable_head,receivable_head_name, description, price, old_price, noOfLabels, label_type,specimen, percentage, sort_index, qms_dept_id, selectable, collect_sample, to_be_analyzed, to_be_reported, print_type, upload_doc FROM lab_setup WHERE facilityId=facId AND description like in_description AND selectable != 'not allowed';
ELSEIF in_query_type = 'children' THEN
SELECT head as subhead, subhead as title, department_code,unit_code,unit_name, unit, range_from, range_to, account,account_name, payable_head,payable_head_name, receivable_head,receivable_head_name, description, price, old_price, noOfLabels, label_type,specimen, percentage, sort_index, qms_dept_id, selectable, collect_sample, to_be_analyzed, to_be_reported, print_type, upload_doc FROM lab_setup WHERE facilityId=facId AND head = in_description;
ELSE
	SELECT head as subhead, subhead as title, department_code,unit_code,unit_name, unit, range_from, range_to, account,account_name, payable_head,payable_head_name, receivable_head,receivable_head_name, description, price, old_price, noOfLabels, label_type,specimen, percentage, sort_index, qms_dept_id, selectable, collect_sample, to_be_analyzed, to_be_reported, print_type, upload_doc FROM lab_setup WHERE facilityId=facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_op_notes`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM operationnotes WHERE facilityId=facId ORDER BY id DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_patient_trans`(IN `in_client_id` VARCHAR(30), IN `date_from` VARCHAR(20), IN `date_to` VARCHAR(20), IN `facId` VARCHAR(60), IN `query_type` VARCHAR(30))
BEGIN
IF query_type = 'drug' THEN
SELECT * FROM `account_entries` WHERE client_id = in_client_id AND facilityId=facId AND date(createdAt) BETWEEN date_from AND date_to AND quantity > 0;
ELSEIF query_type='test' THEN
SELECT * FROM `account_entries` WHERE client_id = in_client_id AND facilityId=facId AND date(createdAt) BETWEEN date_from AND date_to AND quantity = 0 AND dr = 0;

END if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_prescriptions`(IN `facId` VARCHAR(50))
BEGIN
    SELECT *  FROM prescriptionrequests WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_services`(IN `facId` VARCHAR(50))
BEGIN
   SELECT * FROM `services` WHERE facilityId=facId ORDER BY createdAt DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_suppliers`(IN `facId` VARCHAR(50))
BEGIN
SELECT * FROM suppliersinfo WHERE facilityId=facId ORDER BY date DESC;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_transactions`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * from `transactions` WHERE facilityId=facId ORDER BY createdAt DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_user_byId`(IN `in_id` INT, IN `facId` VARCHAR(50))
    NO SQL
SELECT * FROM users where id = in_id AND facilityId = facId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_amount_handed_over`(IN `userId` VARCHAR(50), IN `date` DATE, IN `facId` VARCHAR(50))
BEGIN
    SELECT sum(ifnull(amountHandedOver,0)) as amountHandedover FROM transfers WHERE transfer_from = userId and date(date) = date AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_amount_received`(IN `userId` VARCHAR(10), IN `date` DATE, IN `facId` VARCHAR(50))
BEGIN
    SELECT sum(amountReceived) as amountReceived FROM transfers WHERE transfer_to = userId AND date(date) = date AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_avail_receipt_no`(IN `facId` VARCHAR(50))
BEGIN
    SELECT max(receiptNo) + 1 FROM `transactions` WHERE DATE_FORMAT(createdAt, "%d%m%y") = DATE_FORMAT(NOW(), "%d%m%y") AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_balance`(IN `accNo` VARCHAR(10), IN `facId` VARCHAR(50))
BEGIN
    SELECT balance, accName as name, firstname, surname FROM `patientfileno` WHERE accountNo = accNo AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_beds`(IN `in_query_type` VARCHAR(20), IN `in_facId` VARCHAR(50))
    NO SQL
IF in_query_type = 'classes' THEN
	SELECT DISTINCT class_type FROM bedlist WHERE facilityId=in_facId;
ELSEIF in_query_type = 'bedlist' THEN
	SELECT * FROM bedlist_view WHERE facilityId=in_facId;
ELSEIF in_query_type = 'available' THEN
	SELECT * FROM bedlist_view WHERE occupied != no_of_beds AND facilityId=in_facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_beneficiary_no`(IN `accNo` VARCHAR(10), IN `facId` VARCHAR(50))
BEGIN
	SELECT count(id) + 1 as beneficiaryNo FROM patientrecords where accountNo = accNo;
    #AND facilityId=facId;
    # SELECT IFNULL(MAX(beneficiaryNo),0) + 1 as beneficiaryNo from patientrecords where accountNo = accNo AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_best_selling_staff`(IN `facId` VARCHAR(50), IN `dateFrom` DATE, IN `dateTo` DATE)
    NO SQL
SELECT SUM(a.qty_out) + SUM(a.price) AS amount, concat(b.firstname, ' ', b.lastname) as staff FROM drugs a JOIN users b on a.created_by = b.id WHERE date(a.created_at) BETWEEN date(dateFrom) AND date(dateTo) AND a.source='dispensary' AND a.facilityId=facId GROUP BY staff ORDER BY amount DESC$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_client_acc_stmt`(IN `clientId` VARCHAR(20), IN `dateFrom` DATE, IN `dateTo` DATE, IN `facId` VARCHAR(50))
BEGIN
	SELECT acct, description, dr as debit, cr as credit, reference_no, createdAt from account_entries WHERE 
    acct=clientId AND
     date(createdAt) BETWEEN date(dateFrom) AND date(dateTo) AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_client_accounts`(IN `in_facId` VARCHAR(50))
    NO SQL
SELECT * FROM patientfileno WHERE facilityId=in_facId AND accountType !='Walk-In' AND accountType !='Family'$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_deposit_acc_head`(IN `facId` VARCHAR(50))
BEGIN
    SELECT head FROM account WHERE head = 'Deposit' AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_diagnoses_by_id`(IN `patientId` VARCHAR(20), IN `facId` VARCHAR(50))
BEGIN
    SELECT *  FROM diagnosis where patient_id = patientId AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_dispensary_records`(IN `facId` VARCHAR(50))
    NO SQL
BEGIN
    SELECT concat(a.drug, ' (', a.generic_name,')') as drug,a.cost_price,a.balance as quantity, dispensary_balance as dispensary_quantity ,a.expiry_date,a.created_at,b.supplier_name as supplier 
    FROM drugpurchaserecords a JOIN suppliersinfo b ON a.supplier=b.id WHERE a.facilityId=facId AND dispensary_balance!=0 ORDER BY created_at DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_doctors`(IN `facId` VARCHAR(50), IN `in_query_type` VARCHAR(20))
IF in_query_type = 'specialist' THEN
    	SELECT * FROM users WHERE role = 'doctor' AND speciality != 'General' AND facilityId=facId;
    ELSE
    	SELECT * FROM users WHERE role = 'doctor' AND facilityId=facId;
	END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drug_freq`(IN `facId` VARCHAR(50), IN `in_query_type` VARCHAR(50), IN `in_param` VARCHAR(50), IN `in_curr_hour` VARCHAR(20), IN `in_date` DATE, IN `in_no_of_days` INT)
    NO SQL
IF in_query_type = 'freq_details' THEN
call frequency_test(in_param, in_curr_hour, in_date, in_no_of_days);

#select distinct no_times, description,time_TEST(in_param,in_curr_hour, `in_date`) next_time, COUNT(description) no_of_times FROM drug_frequency4 WHERE description=in_param;
	#SELECT description, no_times, time_TEST(in_param, in_curr_hour, `in_date`) next_time, COUNT(description) no_of_times FROM drug_frequency4 WHERE description=in_param;

ELSE
	SELECT description FROM drug_frequency;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drug_price_by_id`(IN `id` INT(4), IN `facId` VARCHAR(50))
BEGIN
    SELECT price FROM `drugs` WHERE drug_id=id AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drugs_list`(IN `facId` VARCHAR(50))
BEGIN
    SELECT SUM(quantity) as quantity, drug from drugpurchaserecords WHERE facilityId=facId GROUP BY drug;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drugs_sold`(IN `facId` VARCHAR(50), IN `dateFrom` DATE, IN `dateTo` DATE)
    NO SQL
SELECT SUM(qty_out) AS quantity, drug FROM drugs WHERE date(created_at) BETWEEN date(dateFrom) AND date(dateTo) AND source='dispensary' AND facilityId=facId GROUP BY drug  ORDER BY quantity DESC LIMIT 5$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_expenses_acc_heads`(IN `facId` VARCHAR(50))
BEGIN
    SELECT head, description from account where subhead like '3%' AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_expired_drugs`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM `drugs` WHERE DATE_FORMAT(expiry_date, '%Y-%m-%d') < DATE_FORMAT(NOW(), '%Y-%m-%d') AND (facilityId=facId);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_facility_info`(IN `fac_id` VARCHAR(50))
    NO SQL
SELECT *, id as facility_id, name as facility_name FROM hospitals WHERE id = fac_id$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_homepage`(IN `in_facId` VARCHAR(50), IN `in_role` VARCHAR(30))
    NO SQL
SELECT home_page FROM pagenavigation WHERE role = in_role AND facilityId=in_facId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_id`(IN `facId` VARCHAR(50))
BEGIN
    select ifnull(max(accountNo), 0) + 1 as nextId from patientrecords WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_ids`(IN `facId` VARCHAR(50))
BEGIN
    select distinct accountNo from patientrecords WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_individual_report`(IN `account` VARCHAR(10), IN `fromDate` VARCHAR(30), IN `toDate` VARCHAR(30), IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM `transactions` WHERE (transaction_source=account OR destination = account) AND (createdAt BETWEEN fromDate AND toDate) AND (facilitatorId = facId);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_inventory`()
    NO SQL
SELECT * from list_items WHERE balance>0$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_item_category`(IN `in_subhead` VARCHAR(50), IN `in_fadId` VARCHAR(50))
    NO SQL
SELECT * FROM `item_description` where subhead = in_subhead and facilityId=in_fadId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab`(IN `in_query_type` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_status` VARCHAR(50))
    NO SQL
BEGIN
	IF in_query_type = 'sample collection' THEN
    	SELECT DISTINCT concat(b.surname, ' ', b.firstname) as name,a.booking_no as labno,  code,
        COUNT(DISTINCT department) AS no_of_tests, department_head AS department, a.patient_id
        FROM lab_process a JOIN patientrecords b ON a.patient_id=b.patient_id 
        WHERE a.status = in_status AND a.facilityId=in_facId AND b.facilityId=in_facId
        GROUP BY booking_no,name;
    END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_by_booking`(IN `in_booking` VARCHAR(20), IN `in_facId` VARCHAR(50), IN `in_dept` VARCHAR(50))
    NO SQL
IF in_dept='all' THEN
SELECT distinct booking_no, department, status, specimen, description, subhead as test,
        group_head, sn, price, old_price,
        ifnull(sop_instance_id, '') sop_instance_id, unit, range_from, range_to, ifnull(result,'') result,
        ifnull(appearance, '') appearance, ifnull(serology, '') serology,ifnull(culture_yielded, '') culture_yielded,
        IFNULL(sensitivity, '') AS sensitiveTo, IFNULL(intermediaryTo, '') AS intermediaryTo, IFNULL(resistivity, '')
        AS resistantTo, sample_collected_by, sample_collected_at,department_head, commission_type, percentage,
        report_type, print_type, IFNULL(o_value,'') as o_value, IFNULL(h_value,'') as h_value, created_at
        FROM lab_process
        WHERE booking_no=in_booking
        AND status IN ('Sample Collected', 'analyzed', 'result','saved', "printed", "uploaded")
        AND test != test_group
        AND facilityId=in_facId
        ORDER BY created_at DESC;
ELSE
        SELECT distinct booking_no, department, status, specimen, description, subhead as test,
        group_head, sn, price, old_price,
        ifnull(sop_instance_id, '') sop_instance_id, ifnull(n_unit,unit) as unit, ifnull(n_range_from,range_from) as range_from, ifnull(n_range_to,range_to) as range_to, ifnull(result,'') result,
        ifnull(appearance, '') appearance, ifnull(serology, '') serology,ifnull(culture_yielded, '') culture_yielded,
        IFNULL(sensitivity, '') AS sensitiveTo, IFNULL(intermediaryTo, '') AS intermediaryTo, IFNULL(resistivity, '')
        AS resistantTo, sample_collected_by, sample_collected_at,department_head, commission_type, percentage,
        report_type, print_type, IFNULL(o_value,'') as o_value, IFNULL(h_value,'') as h_value
        FROM lab_process
        WHERE booking_no=in_booking AND (department_head=in_dept OR department=in_dept)
        AND status IN ('Sample Collected', 'analyzed', 'result','saved', "printed", "uploaded")
        AND test != test_group
        AND facilityId=in_facId
        ORDER BY created_at DESC;
END if$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_by_status`(IN `in_query_type` INT, IN `in_status` INT, IN `facId` INT)
    NO SQL
IF in_query_type = 'list' THEN
	SELECT a.booking_no, concat(b.firstname, ' ', b.surname) as name,a.patient_id,a.created_at,
        a.department
        FROM lab_requisition a JOIN patientrecords b ON a.patient_id=b.id
        WHERE a.status IN (in_status) AND
        a.facilityId=facId AND b.facilityId=facId
        GROUP BY booking_no,a.patient_id,date(a.created_at),name
        order by a.created_at DESC;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_list`(IN `in_query_type` VARCHAR(10), IN `in_facId` VARCHAR(50), IN `in_pid` VARCHAR(50), IN `date_from` DATE, IN `date_to` DATE)
    NO SQL
IF in_query_type = 'all' THEN
	SELECT a.booking_no, concat(b.firstname, ' ', b.surname) as name,a.patient_id,a.created_at,a.department,count(a.status) as tests,
    (SELECT COUNT(*) FROM lab_requisition WHERE status IN ('pending') AND booking_no=a.booking_no ) as pending,
	(SELECT COUNT(*) FROM lab_requisition WHERE status IN ('Sample Collected', 'saved') AND booking_no=a.booking_no ) as collected,
	(SELECT COUNT(*) FROM lab_requisition WHERE status IN ('analyzed') AND booking_no=a.booking_no ) as analyzed,
    (SELECT COUNT(*) FROM lab_requisition WHERE status='result' AND booking_no=a.booking_no AND facilityId=in_facId) as completed
		FROM lab_requisition a JOIN patientrecords b ON a.patient_id=b.id 
        WHERE a.facilityId=in_facId AND a.status!='printed'
        AND (a.created_at BETWEEN date(date_from) AND date(date_to)) AND b.facilityId=in_facId 
        GROUP BY booking_no, a.patient_id, a.created_at, name order by count(a.status)-completed, count(a.status)-analyzed, 
        a.created_at DESC;
    ELSE
    	
       SELECT booking_no, patient_id,created_at,department,count(status) as tests,(SELECT COUNT(*) FROM lab_requisition WHERE status='result' AND booking_no=booking_no AND facilityId=in_facId) as completed
		FROM lab_requisition WHERE patient_id=in_pid AND facilityId=in_facId GROUP BY booking_no, created_at order by count(status)-completed, created_at DESC;
        END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_requisitions`(IN `facId` VARCHAR(50))
    NO SQL
SELECT concat(firstname, ' ', surname) as name, id, dateCreated FROM `patientrecords` WHERE status = 'lab_requisition' AND facilityId=facId ORDER BY dateCreated DESC$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_result`(IN `query_type` VARCHAR(20), IN `in_labno` VARCHAR(50), IN `facId` VARCHAR(50), IN `in_request_id` VARCHAR(50), IN `query_date` DATE)
    NO SQL
IF query_type = 'completed' THEN
	SELECT sn, sn as sort_index, specimen,code,receiptNo,booking_no, description as test, description, group_head as test_group, 
        group_head, a.department, ifnull(a.result, '') result, unit, 
        range_from, range_to, o_value, h_value, appearance,serology,culture_yielded,resistivity,sensitivity, intermediaryTo,
        a.status, a.created_by, a.created_at, a.sample_collected_by,a.report_type,
        CONCAT(b.firstname, ' ', b.lastname) AS result_by,
        result_at, reviewed_by 
        FROM lab_process 
        a JOIN users b ON a.result_by = b.username
        WHERE booking_no=in_labno AND a.facilityId=facId 
        AND b.facilityId=facId
        GROUP BY description
        ORDER BY sn asc;
ELSEIF query_type = 'uncompleted' THEN
	SELECT sn, sn as sort_index, specimen,code, receiptNo,booking_no, description as test, description, group_head as test_group, 
        group_head, department, ifnull(result,'') result, unit,  o_value, h_value,
        range_from, range_to, appearance,serology,culture_yielded,resistivity,sensitivity, intermediaryTo,
        status, created_by, created_at, sample_collected_by, result_by, result_at, reviewed_by, report_type
        FROM lab_process 
        WHERE booking_no=in_labno AND facilityId=facId
        group by description
        ORDER BY sn asc;
ELSEIF query_type = 'doctor' THEN
SELECT sn, sn as sort_index, specimen,code, receiptNo,booking_no, description as test, description, group_head as test_group, 
        group_head, department, ifnull(result,'') result, unit,  o_value, h_value,
        range_from, range_to, appearance,serology,culture_yielded,resistivity,sensitivity, intermediaryTo,
        status, created_by, created_at, date(created_at) as requested_date, sample_collected_by, result_by, result_at, reviewed_by, report_type
        FROM lab_process 
        WHERE patient_id=in_labno AND facilityId=facId
        ORDER BY sn ASC;
ELSEIF query_type = 'by_req_id' THEN
SELECT sn, sn as sort_index, specimen,code, receiptNo,booking_no, description as test, description, group_head as test_group, 
        group_head, department, ifnull(result,'') result, unit,  o_value, h_value,
        range_from, range_to, appearance,serology,culture_yielded,resistivity,sensitivity, intermediaryTo,
        status, created_by, created_at, date(created_at) as requested_date, sample_collected_by, result_by, result_at, reviewed_by, report_type
        FROM lab_process 
        WHERE patient_id=in_labno AND request_id=in_request_id AND facilityId=facId
        ORDER BY sn ASC;
ELSEIF query_type = 'by_date' THEN
SELECT sn, sn as sort_index, specimen,code, receiptNo, booking_no, description as test, description, group_head as test_group, 
        group_head, department, ifnull(result,'') result, unit,  o_value, h_value,
        range_from, range_to, appearance,serology,culture_yielded,resistivity,sensitivity, intermediaryTo,
        status, created_by, created_at, date(created_at) as requested_date, sample_collected_by, result_by, result_at, reviewed_by, report_type
        FROM lab_process 
        WHERE patient_id=in_labno AND date(created_at)=date(query_date) AND facilityId=facId
        ORDER BY sn ASC;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lab_services_tree`(IN `facId` VARCHAR(50))
    NO SQL
BEGIN
	SELECT head title,subhead,price  FROM lab_setup WHERE facilityId=facId;
#SELECT id, head,subhead title  FROM lab_setup WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_drugs`(IN `in_name` VARCHAR(80), IN `in_generic_name` VARCHAR(80), IN `in_id` INT, IN `query_type` VARCHAR(20))
BEGIN
IF query_type='insert' THEN
INSERT INTO `druglist`(`name`, `generic_name`) VALUES (in_name,in_generic_name);
ELSEIF query_type='update' THEN
UPDATE druglist SET name=in_name, generic_name=in_generic_name WHERE id=in_id;
ELSEIF query_type='delete' THEN
DELETE FROM `druglist` WHERE id=in_id;
ELSE
    SELECT DISTINCT id,name as drug, generic_name FROM druglist ORDER BY created_at DESC;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_next_lab_id`(IN `facId` VARCHAR(50))
    NO SQL
BEGIN
	SELECT IFNULL(max(id),0) + 1 AS labId from lab_requisition WHERE facilityId=facId; 

	COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_next_transaction_id`(IN `facId` VARCHAR(50))
BEGIN
    select max(transaction_id) + 1 from transactions WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_number_generator`(IN `in_prefix` VARCHAR(10))
SELECT code_no + 1 as code_no FROM number_generator WHERE prefix = in_prefix$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_nursing_reports`(IN `query_type` VARCHAR(10), IN `facId` VARCHAR(50))
    NO SQL
IF query_type = 'all' THEN
	SELECT * FROM nursing_report where facilityId=facId ORDER BY created_at DESC;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_acc_stmt`(IN `patientId` VARCHAR(20), IN `dateFrom` DATE, IN `dateTo` DATE, IN `facId` VARCHAR(50))
BEGIN
	SELECT t.transaction_id, t.acct,t.day,t.description, t.credit, t.debit,
       @running_total:=@running_total + t.balance AS bal, @running_total:=@running_total opening
        FROM
        ( SELECT transaction_id, acct,
          date(createdAt) as day,description,credit credit, debit debit,
          sum(credit-debit) as balance
          FROM transactions WHERE client_acct = patientId  AND date(createdAt) BETWEEN dateFrom AND dateTo AND facilityId=facId
          GROUP BY transaction_id,day,description,credit,debit,acct ) t
        JOIN (SELECT @running_total:=0) r
        ORDER BY t.transaction_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_drug_schedule`(IN `query_type` VARCHAR(20), IN `in_patient_id` VARCHAR(50), IN `facId` VARCHAR(50), IN `in_date` DATE)
    NO SQL
IF query_type = 'all_schedule' THEN
	SELECT id, allocation_id, patient_id, prescription_id, drug_name, time_stamp, date(time_stamp) time_stamp_date, status, administered_by, facilityId, served_by, stopped_by, reason, frequency FROM drug_schedule where patient_id = in_patient_id AND status != 'stop' ORDER BY time_stamp ASC, id;
ELSEIF query_type = 'by_date' THEN
	IF in_patient_id = 'all' THEN
    	SELECT a.id, b.patient_name as name, a.patient_id, b.name as bed_name, b.class_type, a.drug as drug_name, a.dosage, a.route, time_stamp, a.status, administered_by, a.facilityId, a.frequency FROM drug_schedule_view a JOIN in_patient_list b ON a.patient_id = b.patient_id where a.status != 'stop' AND date(time_stamp) = in_date AND a.facilityId=facId ORDER BY time_stamp ASC, id;
    ELSE
		SELECT * FROM drug_schedule where patient_id = in_patient_id AND status != 'stop' AND date(time_stamp) = in_date ORDER BY time_stamp ASC,id;
    END IF;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_list`(IN `in_facilityId` VARCHAR(50), IN `in_condition` VARCHAR(20), IN `in_query_type` VARCHAR(20))
    NO SQL
IF in_query_type = 'in_patients' THEN
	SELECT * FROM in_patient_list WHERE facilityId=in_facilityId ORDER BY sort_index;
ELSEIF in_query_type = 'in_patient' THEN
	SELECT * FROM in_patient_list  WHERE allocation_id=in_condition AND facilityId=in_facilityId ORDER BY sort_index;
ELSEIF in_query_type = 'in_patient_by_id' THEN
	SELECT * FROM in_patient_list  WHERE patient_id=in_condition AND facilityId=in_facilityId ORDER BY sort_index;
ELSEIF in_query_type = 'by_status' THEN
	SELECT * FROM in_patient_list  WHERE status=in_condition AND facilityId=in_facilityId ORDER BY sort_index;
    ELSEIF in_query_type='pending-admission' THEN 
    SELECT * FROM `patientrecords` WHERE patientStatus = 'pending-admission';
ELSE
	SELECT id, patient_id, concat(surname, ' ', firstname) as name, dob, Gender as gender, ifnull(phoneNo,'') as phoneNo, ifnull(email, '') as email
        FROM patientrecords WHERE surname!=in_condition  AND facilityId=in_facilityId ORDER BY dateCreated DESC;
        END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_records`(IN `facId` VARCHAR(50))
BEGIN
    select * from patientrecords WHERE facilityId=facId order by accountNo desc;
   END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_reg_breakdown_per_year`(IN `year` INT(4))
    NO SQL
SELECT COUNT(*) no_of_patients, MONTH(dateCreated) month FROM `patientrecords`  
WHERE YEAR(dateCreated) = year
GROUP BY MONTH(dateCreated)$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_txn`(IN `query_type` VARCHAR(20), IN `in_patient_id` VARCHAR(50), IN `facId` VARCHAR(50))
    NO SQL
IF query_type = 'all' THEN
	SELECT * FROM transactions where patient_id=in_patient_id AND debit<>0 AND facilityId=facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patients`(IN `_query_type` VARCHAR(50), IN `_facility_id` VARCHAR(50), IN `_patient_id` VARCHAR(10))
BEGIN
	IF _query_type='all' THEN
    SELECT concat(surname," ", firstname)as name, address,Gender,DOB,patient_id,email,id,
        accountNo, accountType FROM patientrecords WHERE facilityId=_facility_id ORDER BY accountNo DESC;
    ELSEIF _patient_id IS NOT NULL THEN
    SELECT concat(surname," ", firstname)as name, address,Gender,DOB,patient_id,email,id,
        accountNo, accountType FROM patientrecords WHERE facilityId=_facility_id AND id=_patient_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patients_by_doctor`(IN `doc` VARCHAR(50), IN `facId` VARCHAR(50))
BEGIN
    select * from patientrecords where assigned_to = doc AND facilityId=facId ORDER BY date_assigned DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_lab`(IN `query_type` VARCHAR(10), IN `in_dept` VARCHAR(50), IN `facId` VARCHAR(50), IN `fromDate` DATE, IN `toDate` DATE)
    NO SQL
BEGIN SELECT DISTINCT a.booking_no as labno, concat(b.surname, ' ', b.firstname) as name, a.department_head AS department, COUNT(distinct description) AS no_of_tests, a.patient_id, description,a.subhead,a.code FROM lab_info a JOIN patientrecords b ON a.patient_id=b.id WHERE a.status = query_type AND a.department_head=in_dept AND a.facilityId=facId AND b.facilityId=facId 
AND date(created_at) BETWEEN date(fromDate) AND date(toDate)
GROUP by labno, description,a.patient_id; END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_lab_request`(IN `facId` VARCHAR(50))
BEGIN 
SELECT id,concat(surname, ' ', firstname, ' ', other) fullname,DOB,gender,phoneNo,assigned_to, count(lab.patient_id) no_of_test
  FROM patientrecords JOIN lab
    ON patientrecords.id = lab.patient_id WHERE lab.status = 'request' and lab.facilityId = facId GROUP BY lab.patient_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_prescription_requests`(IN `facId` VARCHAR(50))
BEGIN
    #SELECT * FROM `prescriptionrequests` WHERE facilityId=facilityId ORDER BY date DESC;
SELECT id,firstname,surname,DOB,gender,phoneNo,assigned_to FROM `patientrecords` WHERE id in (SELECT patient_id from dispensary where status = "request") and facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_purchase_order`(IN `in_query_type` VARCHAR(10), IN `from_date` DATE, IN `to_date` DATE)
    NO SQL
IF in_query_type = 'reviewer' THEN
	SELECT a.id,po_id,date,type,vendor,client,item_name,specification,quantity_in_stock,
    	proposed_quantity,exchange_type,exchange_rate,unit_price,a.amount,
        status,insected_by,renew,po_number,total_amount+SUM( ifNull(b.amount,0)) as total_amount,grn_number,
        auditor_remark,management_remark,supplier_code,supplier_account,processed_by 
	FROM purchase_order a LEFT JOIN other_expenses b ON a.po_id=b.PONo 
    where status IN ("pending","ManagementReject", "BackToAuditor") 
    GROUP BY po_id ORDER by po_id;
    
ELSEIF in_query_type = 'auditor' THEN
	SELECT a.id,po_id,date,type,vendor,client,item_name,specification,quantity_in_stock,
    	proposed_quantity,exchange_type,exchange_rate,unit_price,a.amount,
        status,insected_by,renew,po_number,total_amount+SUM( ifNull(b.amount,0)) as total_amount,grn_number,
        auditor_remark,management_remark,supplier_code,supplier_account,processed_by 
	FROM purchase_order a LEFT JOIN other_expenses b ON a.po_id=b.PONo 
    where status IN ("BackToAuditor", "ManagementApproved","Reviewer") 
    GROUP BY po_id ORDER by po_id;
    
ELSEIF in_query_type = 'account' THEN
    SELECT a.id,po_id,date,type,vendor,client,item_name,specification,quantity_in_stock,
    	proposed_quantity,exchange_type,exchange_rate,unit_price,a.amount,
        status,insected_by,renew,po_number,total_amount+SUM( ifNull(b.amount,0)) as total_amount,grn_number,
        auditor_remark,management_remark,supplier_code,supplier_account,processed_by 
		FROM purchase_order a LEFT JOIN other_expenses b ON a.po_id=b.PONo 
    where status = "ReviewerApproved"
    	GROUP BY po_id 
    	ORDER by po_id;
ELSEIF in_query_type = 'all' THEN
	#SELECT * FROM purchase_order where facilityId=in_facilityId ORDER BY po_id DESC
    SELECT a.id,po_id,date,type,vendor,client,item_name,specification,quantity_in_stock,
    	proposed_quantity,exchange_type,exchange_rate,unit_price,a.amount,
        status,insected_by,renew,po_number,total_amount+SUM( ifNull(b.amount,0)) as total_amount,grn_number,
auditor_remark,management_remark,supplier_code,supplier_account,processed_by 
		FROM purchase_order a LEFT JOIN other_expenses b ON a.po_id=b.PONo   WHERE date(date)BETWEEN date(from_date) AND date(to_date) 
    	GROUP BY po_id 
    	ORDER by po_id;
ELSEIF in_query_type = 'management' THEN
	SELECT a.id, po_id,date,type,vendor,client,item_name, specification, quantity_in_stock, proposed_quantity,
exchange_type, exchange_rate, unit_price, a.amount, status, insected_by, renew,po_number,
total_amount+SUM( ifNull(b.amount,0)) as total_amount, grn_number, auditor_remark, management_remark, supplier_code, supplier_account, processed_by 
FROM purchase_order a LEFT JOIN other_expenses b ON a.po_id=b.PONo where status IN ("Audited","BackToManagement","ReviewerReject") GROUP BY po_id ORDER by po_id;

END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_purchases`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM drugpurchaserecords WHERE payment_status='pending' AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_transactions`(IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM `transactions` WHERE status = "pending" AND facilityId=facId ORDER BY createdAt DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pharm_sales_summary`(IN `fac_id` VARCHAR(50), IN `dateFrom` DATE, IN `dateTo` DATE)
    NO SQL
SELECT  ifnull(SUM(debit), 0) totalAmount, count(debit) totalSales FROM transactions WHERE DATE(createdAt) BETWEEN date(dateFrom) AND date(dateTo) AND facilityId=fac_id AND acct='Drug Sales'$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pharm_total_stock`(IN `fac_id` VARCHAR(50))
    NO SQL
SELECT sum(balance) AS totalStock, sum(balance*cost_price) AS totalStockAmount, sum(dispensary_balance) as totalDisp, sum(dispensary_balance*(cost_price+markUp)) as totalDispAmount FROM drugpurchaserecords WHERE facilityId = fac_id$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prescribed_drugs`(IN `query_type` VARCHAR(50), IN `in_patient_id` VARCHAR(50), IN `facId` VARCHAR(50))
    NO SQL
IF query_type = 'pending' THEN
	SELECT route,drug,dosage,patient_id,id as prescription_id, created_at,duration,period,frequency, startTime,times_per_day,end_date FROM dispensary WHERE patient_id=in_patient_id AND schedule_status='pending' AND decision='admit' AND facilityId = facId;
	#SELECT route,drug,dosage,patient_id,a.id as prescription_id, created_at,duration,period,frequency, b.time_start, b.interval_, b.interval_uom FROM dispensary a JOIN drug_frequency b on a.frequency=b.description WHERE patient_id=in_patient_id AND schedule_status='pending' AND decision='admit' AND facilityId = facId;
ELSEIF query_type ='current' THEN
	SELECT created_at, concat(route,' ', drug,' ',dosage, ' ', frequency, ' for ', duration, ' ', period) as medication, duration, period, id, created_at FROM dispensary WHERE id in (SELECT prescription_id FROM drug_schedule WHERE status = 'scheduled') AND patient_id=in_patient_id AND facilityId = facId;
ELSEIF query_type = 'by_req_id' THEN
	SELECT drug,dosage,patient_id,id, created_at,duration,period,frequency, route FROM dispensary WHERE request_id=in_patient_id AND facilityId = facId;
ELSEIF query_type = 'out-patient' THEN
	SELECT request_id, route,drug,dosage,patient_id,id as prescription_id, created_at,duration,period,frequency, startTime FROM dispensary WHERE patient_id=in_patient_id AND schedule_status='pending' AND decision='out-patient' AND facilityId = facId;
ELSEIF query_type = 'out-patient-list' THEN
	SELECT concat(b.firstname,' ',b.surname,' (',b.id,')') as patient_info, route,drug,dosage,a.patient_id,a.id as prescription_id,request_id, created_at,duration,period,frequency, startTime FROM dispensary a JOIN patientrecords b ON a.patient_id = b.id WHERE schedule_status='pending' AND date(a.end_date) >= date(now()) AND decision='out-patien' AND a.facilityId = facId;
ELSEIF query_type = 'med-report' THEN
	SELECT * FROM medication_report WHERE patient_id=in_patient_id ORDER BY time_stamp DESC;
ELSEIF query_type = 'close outpatient prescription' THEN
	UPDATE dispensary SET schedule_status='ended' WHERE request_id=in_patient_id AND facilityId=facId;

    
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_purchase_records`(IN `facId` VARCHAR(50))
BEGIN
    SELECT a.drug,a.cost_price,a.balance as quantity, quantity as quantity_bought ,a.expiry_date,a.created_at,b.supplier_name as supplier 
    FROM drugpurchaserecords a JOIN suppliersinfo b ON a.supplier=b.id WHERE a.facilityId=facId ORDER BY created_at DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_receipt_date_sn`(IN `dateAppend` VARCHAR(30), IN `facId` VARCHAR(50))
BEGIN
    select receiptDateSN like dateAppend from transaction WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_report_by_type`(IN `type` VARCHAR(50), IN `facId` VARCHAR(50), IN `fromDate` DATE, IN `toDate` DATE)
    NO SQL
BEGIN
	IF type = 'revenue' THEN
    	SELECT transaction_id, transaction_date, description, acct, credit, receiptDateSN, modeOfPayment,client_acct, concat(b.surname, ' ', b.firstname) as patient_id FROM `transactions` a JOIN patientrecords b ON (a.patient_id = b.id AND a.facilityId=b.facilityId) where credit <> 0 AND acct like '20%'  AND a.facilityId=facId AND date(transaction_date) BETWEEN date(fromDate) AND date(toDate);
        
    ELSEIF type = 'expenses' THEN
    	SELECT transaction_id, transaction_date, description, acct, debit, receiptDateSN, modeOfPayment,client_acct FROM `transactions` where debit <> 0 AND acct like '30%' AND facilityId=facId AND date(transaction_date) BETWEEN date(fromDate) AND date(toDate);
        
    ELSEIF type = 'trialbalance' THEN
    	SELECT a.head AS head,a.subhead AS subhead,a.des AS des,a.acct AS acct,b.description AS description,(sum(a.debit) - sum(a.credit)) AS debit,(sum(a.credit) - sum(a.debit)) AS credit,a.transaction_date AS date,a.facilityId AS facilityId 
		FROM (test1 a JOIN account b ON ((a.subhead = b.head))) 
    	WHERE a.transaction_date BETWEEN date(fromDate) and date(toDate)
    	GROUP BY head,a.subhead,a.head,a.des,a.acct,(b.description <> 0);
    
    ELSEIF type = 'profitloss' THEN
    	SELECT a.head AS head,a.subhead AS subhead,a.des AS des,a.acct AS acct,b.description AS description,(sum(a.debit) - sum(a.credit)) AS debit,(sum(a.credit) - sum(a.debit)) AS credit,a.transaction_date AS date,a.facilityId AS facilityId 
		FROM (test1 a JOIN account b ON ((a.subhead = b.head))) 
    	WHERE a.subhead like '200%' OR a.subhead like '300%' AND a.transaction_date BETWEEN date(fromDate) and date(toDate)
    	GROUP BY head,a.subhead,a.head,a.des,a.acct,(b.description <> 0);
    	
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_reports`(IN `fromDate` VARCHAR(30), IN `toDate` VARCHAR(30), IN `facId` VARCHAR(50))
BEGIN
    SELECT * FROM `transactions` WHERE createdAt BETWEEN fromDate AND toDate AND facilityId = facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_request_no`(IN `in_facilityId` VARCHAR(50))
SELECT ifnull(max(request_id), 0) + 1 as request_id FROM lab_requisition WHERE facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rev_acc_heads`(IN `facId` VARCHAR(50))
BEGIN
    SELECT head as title, subhead, description, price FROM account WHERE subhead = '20000' and facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_roles`(IN `facId` VARCHAR(50))
BEGIN
    select distinct role from users WHERE facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_by_patient`(IN `patientId` VARCHAR(20), IN `facId` VARCHAR(50))
    NO SQL
SELECT * from lab WHERE patient_id = patientId AND facilityId=facId AND status in ('request')$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_5_popular_drugs`(IN `fac_id` VARCHAR(50), IN `today` DATE)
    NO SQL
SELECT drug, COUNT(*) count FROM dispensary WHERE facilityId=fac_id AND DATE(created_at) = today GROUP BY drug ORDER BY count DESC LIMIT 5$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_sales`(IN `user` VARCHAR(50), IN `date` DATE, IN `facId` VARCHAR(50))
BEGIN
    SELECT SUM(credited-debited) as totalSales, date(createdAt) as date from transactions WHERE enteredBy = user and date(createdAt) = date AND facilityId=facId GROUP by date(createdAt);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unassigned`(IN `facId` VARCHAR(50))
BEGIN
    select title,surname,firstname,other, concat(firstname,' ',surname,' ',other) fullname,Gender,age,maritalstatus,DOB,dateCreated,phoneNo,email,state,lga,occupation,address,kinName,kinRelationship,kinPhone,kinEmail,kinAddress,accountNo,beneficiaryNo,balance,id,enteredBy,patientStatus,assigned_to,createdAt from patientrecords WHERE facilityId=facId order by accountNo desc;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_by_id`(IN `id` VARCHAR(10), IN `facId` VARCHAR(50))
BEGIN
    select * from patientrecords where id=id AND facilityId=facId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`(IN `facId` VARCHAR(50))
BEGIN
    SELECT *  FROM users where facilityId = facId AND role != 'developer';
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `good_received`(IN `in_status` VARCHAR(50), IN `in_id` INT(50))
    NO SQL
BEGIN

if in_status="unfinished purchase" 
THEN
select a.item_name,a.price,a.type,a.item_category,a.propose_quantity,a.po_id,a.exchange_rate,sum(b.qty_in) as qty_in, (a.propose_quantity - (select sum(b.qty_in) from store a where a.po_no=in_id GROUP by po_no )) as quantity,expired_status from purchase_order_list a join store b on a.po_id=b.po_no AND a.po_id =in_id GROUP by a.item_name,a.price,a.type, a.propose_quantity,a.po_id,a.exchange_rate;

ELSEIF in_status ="new order" THEN
SELECT id,item_name, price,propose_quantity ,type,item_category, po_id,identifier,exchange_rate,date,received_qty, expired_status FROM purchase_order_list WHERE po_id=in_id AND status="new order";
end if;
End$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `good_transfer`(IN `in_version_id` VARCHAR(100), IN `in_qty_in` INT(6), IN `in_expiring_date` DATE, IN `in_selling_price` FLOAT(10), IN `in_location_from` VARCHAR(100), IN `in_location_to` VARCHAR(100), IN `in_facilityId` VARCHAR(100), IN `in_item_name` VARCHAR(100), IN `in_receive_date` DATE, IN `in_unit_price` FLOAT(10), IN `in_mark_up` FLOAT(10), IN `supplyName` VARCHAR(50), IN `supply_code` VARCHAR(50))
BEGIN
DECLARE trn int;
declare item_code_data,description_data,price_data,balance_data, facilityId_data varchar(50);
declare expiry_date_data date;
declare new_item_balance,transfers_balance,new_transfers_balance int;

declare item_code_data1,description_data1,price_data1,balance_data1, facilityId_data1 varchar(50);
declare expiry_date_data1 date;
declare new_item_balance1 int;

SELECT max(ifNull(code_no,0)+1)  INTO trn from number_generator WHERE prefix='trn';

SELECT item_code,drug_name,price,balance, facilityId, expiry_date 
into item_code_data1,description_data1,price_data1,balance_data1, facilityId_data1,expiry_date_data1 
FROM `pharm_store` where drug_name=in_item_name and price=in_unit_price and expiry_date=in_expiring_date and store=in_location_from; 

set new_item_balance1=balance_data1-in_qty_in;

update `pharm_store`set balance=new_item_balance1  where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store=in_location_from; 

SELECT balance INTO transfers_balance from pharm_store where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store = in_location_to;

IF transfers_balance is null then 
INSERT INTO `pharm_store`(`balance`, `drug_name`, `price`, `facilityId`, `item_id`, `expiry_date`, `store`, `selling_price`, `supplier_name`, `supplier_code`, `insert_date`, `store_location`) VALUES (in_qty_in,in_item_name,in_unit_price,in_facilityId,in_version_id,in_expiring_date,in_location_to,in_selling_price,supplyName,supply_code,now(),in_location_from);

INSERT INTO pharm_store_entries(receive_date,drug_name,expiry_date,`transfer_from`,qty_out,qty_in,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,in_expiring_date,in_location_from,in_qty_in, 0,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_from,in_facilityId,in_location_from,supply_code,supplyName,concat("Transfer to ", in_location_to));

INSERT INTO pharm_store_entries(receive_date,drug_name,expiry_date,`transfer_from`,qty_out,qty_in,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,in_expiring_date,in_location_from,0 ,in_qty_in,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_to,in_facilityId,in_location_to,supply_code,supplyName,concat("Transfer to ", in_location_to));


ELSE
SET new_transfers_balance = transfers_balance + in_qty_in;
UPDATE pharm_store SET balance = new_transfers_balance  where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store = in_location_to;


INSERT INTO pharm_store_entries(receive_date,drug_name,expiry_date,`transfer_from`,qty_out,qty_in,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type,branch_name)
VALUES(now(),in_item_name,in_expiring_date,in_location_from,in_qty_in, 0,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_from,in_facilityId,in_location_from,supply_code,supplyName,concat("Transfer to ", in_location_to));

INSERT INTO pharm_store_entries(receive_date,drug_name,expiry_date,`transfer_from`,qty_out,qty_in,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,in_expiring_date,in_location_from,0 ,in_qty_in,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_to,in_facilityId,in_location_to,supply_code,supplyName,concat("Transfer to ", in_location_to));
	
end IF;


#INSERT INTO `sale_department`(`version_id`, `item_name`, `qty_in`, `qty_out`, `expiring_date`, `selling_price`, `location_from`, `location_to`,`facilityId`,supplier_name,supplier_code)
#VALUES (in_version_id,in_item_name,0,new_item_balance1,expiry_date_data1,in_selling_price,in_location_from,in_location_to,in_facilityId,supplyName,supply_code);

#SELECT item_code,description,price,ifnull(balance,0), facilityId, expiry_date 
#into item_code_data,description_data,price_data,balance_data, facilityId_data,expiry_date_data 
#FROM `item_description` where description=in_item_name and price=in_selling_price and expiry_date=in_expiring_date and store=in_location_from; 

#set new_item_balance=balance_data+ifnull(in_qty_in,0);

#insert into store(description,price,balance, facilityId, expiry_date,store )
#values (in_item_name,in_selling_price,new_item_balance, in_facilityId,in_expiring_date ,in_location_from) on duplicate key update balance=new_item_balance;

#INSERT INTO `sale_department`(`version_id`, `item_name`, `qty_in`, `qty_out`, `expiring_date`, `selling_price`, `location_from`, `location_to`, `facilityId`,supplier_name,supplier_code,item_status,trn_number)
#VALUES (concat(in_version_id,'-1'),in_item_name,in_qty_in,0,in_expiring_date,in_selling_price,in_location_from,in_location_to,in_facilityId,supplyName,supply_code,"Pending",trn);
call update_number_generator('trn',trn);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `good_transfer_report`(IN `date_from` VARCHAR(30), IN `date_to` VARCHAR(30), IN `facId` VARCHAR(60))
SELECT * FROM `pharm_store_entries` WHERE transfer_to !='' AND transfer_to !='pos' AND transfer_from !='Purchase order' AND qty_in > 0 AND date(inserted_time) BETWEEN date_from AND date_to and facilityId=facId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `group_service`(IN `in_head` VARCHAR(30), IN `in_subhead` VARCHAR(30), IN `in_descr` VARCHAR(90), IN `facId` VARCHAR(56), IN `query_type` VARCHAR(30), IN `in_price` FLOAT, IN `in_qty` FLOAT)
BEGIN
IF query_type = 'insert' THEN
INSERT INTO `group_service`(`head`, `subhead`, `description`, `facilityId`,price,quantity) VALUES (in_head,in_subhead,in_descr,facId,in_price,in_qty);
ELSEIF query_type = 'select' THEN
SELECT DISTINCT description,SUM(price)as price FROM group_service WHERE facilityId=facId GROUP BY description;
ELSEIF query_type = 'group_list' THEN
SELECT a.head, a.subhead, a.description, a.price, g.quantity FROM account a JOIN group_service g ON a.head = g.head WHERE g.description = in_descr AND g.facilityId = facId;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `lab_summary`(IN `in_query_type` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_fromdate` DATE, IN `in_todate` DATE, IN `in_report_by` VARCHAR(50))
    NO SQL
BEGIN
	IF in_query_type = 'patient income' THEN
    	if in_report_by = 'all' THEN
    	SELECT concat(b.firstname,' ',b.surname) as fullname, sum(debit)as debit, sum(credit) as credit, sum(debit - credit) as balance, a.createdAt FROM transactions a JOIN patientrecords b ON a.patient_id=b.id AND a.facilityId=b.facilityId WHERE a.facilityId=in_facId AND date(a.createdAt) between in_fromdate AND in_todate GROUP BY fullname, date(a.createdAt) ORDER BY createdAt DESC;
        ELSE
        	SELECT concat(b.firstname,' ',b.surname) as fullname, sum(debit) as debit, sum(credit) as credit, sum(debit - credit) as balance, a.createdAt FROM transactions a JOIN patientrecords b ON a.patient_id=b.id AND a.facilityId=b.facilityId WHERE a.facilityId=in_facId AND a.enteredBy=in_report_by AND date(a.createdAt) between in_fromdate AND in_todate GROUP BY fullname, date(a.createdAt) ORDER BY createdAt DESC;
            END IF;
        
    ELSEIF in_query_type = 'daily total' THEN
    	IF in_report_by = 'all' THEN
    	SELECT date(createdAt) as createdAt, Acct_source, sum(debit) as amount, acct FROM trial_balance where facilityId=in_facId AND acct in (400021,400022,400023,400024,400025) AND date(createdAt) between in_fromdate AND in_todate GROUP BY Acct_source, acct, date(createdAt) ORDER BY createdAt desc;
        ELSE 
        	SELECT date(createdAt) as createdAt, Acct_source, sum(debit) as amount, acct FROM trial_balance where facilityId=in_facId AND enteredBy=in_report_by AND acct in (400021,400022,400023,400024,400025) AND date(createdAt) between in_fromdate AND in_todate GROUP BY Acct_source, acct, date(createdAt) ORDER BY createdAt desc;
            END IF;
        
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ldl_formula`(IN `TC` INT, IN `HDL` INT, IN `TG` INT, OUT `LDL` INT)
    NO SQL
BEGIN

SELECT TC - HDL - (TG/2.2) AS LDL;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `move_items_to_dispensary`(IN `drug_name` VARCHAR(100), IN `cost` INT, IN `expiry` VARCHAR(20), IN `d_code` VARCHAR(50), IN `d_price` INT, IN `unit` INT, IN `in_qty` INT, IN `userId` VARCHAR(50), IN `generic` VARCHAR(100), IN `facId` VARCHAR(50), IN `supplierId` VARCHAR(50), IN `itemSource` VARCHAR(10), IN `mark_up` INT, IN `in_receiptno` VARCHAR(50), IN `in_shift` VARCHAR(20))
BEGIN
  DECLARE store_qty int;
  DECLARE dispensary_qty int;
  DECLARE drug_id INT;
  
  SELECT id INTO drug_id FROM druglist WHERE name=drug_name AND generic_name=generic;
  IF drug_id IS null THEN
  INSERT INTO druglist (name,generic_name) VALUES (drug_name,generic);
  end IF;
  
  IF itemSource = 'store' THEN
  select balance, dispensary_balance into store_qty, dispensary_qty FROM drugpurchaserecords WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry AND supplier=supplierId;
  
  UPDATE drugpurchaserecords SET balance = store_qty - in_qty, dispensary_balance = dispensary_qty + in_qty WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry AND supplier=supplierId;

  INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,0,in_qty,'purchases',userId,generic,facId,mark_up,in_receiptno,in_shift);
        
   INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,in_qty,0,'dispensary',userId,generic,facId,mark_up,in_receiptno,in_shift);
        
        ELSE
        select dispensary_balance into dispensary_qty FROM drugpurchaserecords WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry AND supplier=supplierId;
        
        IF dispensary_qty IS NOT null THEN
  
  UPDATE drugpurchaserecords SET balance=dispensary_qty + in_qty, dispensary_balance = dispensary_qty + in_qty WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry AND supplier=supplierId;
  
   INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,supplier,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,0,in_qty,'purchases',
                userId,generic,facId,mark_up,supplierId,in_receiptno,in_shift);
        
   INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,supplier,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,in_qty,0,'dispensary',
                userId,generic,facId,mark_up,supplierId,in_receiptno, in_shift);
  
  else 
  
        INSERT into drugpurchaserecords (drug_code,drug,generic_name,unit_of_issue,cost_price,markUp,quantity, by_whom,supplier,receipt_no,payment_status,expiry_date,dispensary_balance,facilityId) VALUES (d_code,drug_name,generic,unit,cost,mark_up,in_qty,userId,supplierId,'0','paid',expiry,in_qty,facId);
        
        INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,supplier,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,0,in_qty,'purchases',userId,
                generic,facId,mark_up,supplierId,in_receiptno,in_shift);
        
   INSERT INTO drugs(drug_code,drug,expiry_date,price,
        unit_of_issue,
        qty_in,
        qty_out,
        source,
        created_by,
        genericName,
        facilityId,markup,supplier,receipt_no,shift)
        values (d_code,drug_name,expiry,cost,unit,in_qty,0,'dispensary',userId,
                generic,facId,mark_up,supplierId,in_receiptno,in_shift);
        
        END IF;
        end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_acc_head`(IN `in_head` VARCHAR(100), IN `in_subhead` VARCHAR(100), IN `description` VARCHAR(200), IN `balance` INT(11), IN `facId` VARCHAR(50), IN `in_price` INT, IN `in_query_type` VARCHAR(50))
BEGIN
	IF in_query_type = 'next child' THEN
    	SELECT ifnull(MAX(head)+ 1, concat(in_subhead,'1'))  as next_code FROM account WHERE subhead=in_subhead AND facilityId=facId;
    ELSE
    	INSERT INTO account(head, subhead, description, balance, facilityId,price) VALUES (description,in_subhead,in_head,balance, facId,in_price);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_drug_sale`(IN `drug_name` VARCHAR(100), IN `cost` INT, IN `expiry` VARCHAR(20), IN `genericName` VARCHAR(100), IN `unit` VARCHAR(50), IN `quantity_in` INT, IN `userId` VARCHAR(50), IN `supplierId` VARCHAR(50), IN `descr` VARCHAR(100), IN `source_head` VARCHAR(100), IN `amt` INT, IN `receiptsn` VARCHAR(50), IN `receiptno` VARCHAR(50), IN `payment_mode` VARCHAR(50), IN `dest_head` VARCHAR(100), IN `facId` VARCHAR(50), IN `d_code` VARCHAR(50), IN `selling_price` INT, IN `accNo` VARCHAR(50), IN `transactionType` VARCHAR(20), IN `txn_date` DATE)
BEGIN 
  DECLARE balance_dispensary int;
  DECLARE acc_balance int;
  
  IF transactionType='insta' THEN
  
  SELECT dispensary_balance INTO balance_dispensary FROM drugpurchaserecords WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry ;
  
  UPDATE drugpurchaserecords set dispensary_balance = balance_dispensary - quantity_in WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry;
  
  INSERT INTO drugs (drug_code,drug,expiry_date,price,unit_of_issue,qty_in,qty_out,source,supplier,receipt_no,created_by,genericName,facilityId,client_acct) VALUES (d_code,drug_name,expiry,selling_price,unit,quantity_in,0,'sold_items',supplierId,receiptsn,userId,genericName,facId,accNo);
  
  INSERT INTO drugs (drug_code,drug,expiry_date,price,unit_of_issue,qty_in,qty_out,source,supplier,receipt_no,created_by,genericName,facilityId,client_acct) VALUES (d_code,drug_name,expiry,selling_price,unit,0,quantity_in,'dispensary',supplierId,receiptsn,userId,genericName,facId,accNo);


 -- INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo,
 --                           modeOfPayment,facilityId,client_acct) 
 --       VALUES (descr,source_head,0,amt,userId,receiptsn,receiptno,payment_mode,facId,accNo);
 -- INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, 
 --                           modeOfPayment,facilityId,client_acct) 
 --     VALUES (descr,dest_head,amt,0,userId,receiptsn,receiptno,payment_mode,facId,accNo);
      
     ELSEIF transactionType='deposit' THEN
      
      SELECT dispensary_balance INTO balance_dispensary FROM drugpurchaserecords WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry;
  
  UPDATE drugpurchaserecords set dispensary_balance = balance_dispensary - quantity_in WHERE drug=drug_name AND cost_price=cost AND expiry_date=expiry;
  
 INSERT INTO drugs (drug_code,drug,expiry_date,price,unit_of_issue,qty_in,qty_out,source,supplier,receipt_no,created_by,genericName,facilityId,client_acct) VALUES (d_code,drug_name,expiry,selling_price,unit,quantity_in,0,'sold_items',supplierId,receiptsn,userId,genericName,facId,accNo);
  
  INSERT INTO drugs (drug_code,drug,expiry_date,price,unit_of_issue,qty_in,qty_out,source,supplier,receipt_no,created_by,genericName,facilityId,client_acct) VALUES (d_code,drug_name,expiry,selling_price,unit,0,quantity_in,'dispensary',supplierId,receiptsn,userId,genericName,facId,accNo);


 -- INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo,
   --                         modeOfPayment,facilityId,client_acct) 
     --   VALUES (descr,source_head,0,amt,userId,receiptsn,receiptno,payment_mode,facId,accNo);
 -- INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, 
   --                         modeOfPayment,facilityId,client_acct) 
     -- VALUES (descr,dest_head,amt,0,userId,receiptsn,receiptno,payment_mode,facId,accNo);
      
	--  SELECT balance into acc_balance from patientfileno WHERE accountNo=accNo AND facilityId=facId;
	--  UPDATE patientfileno SET balance = acc_balance - amt WHERE accountNo = accNo AND facilityId=facId;
   END IF;
COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_expense`(IN `facId` VARCHAR(50), IN `descr` VARCHAR(100), IN `source_head` VARCHAR(100), IN `dest_head` VARCHAR(100), IN `receiptsn` VARCHAR(50), IN `receiptno` VARCHAR(50), IN `payment_mode` VARCHAR(50), IN `userId` VARCHAR(50), IN `amt` INT, IN `collected` VARCHAR(100), IN `in_date` DATETIME, IN `in_txn_date` DATE)
BEGIN 
    INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, modeOfPayment,facilityId,client_acct,createdAt,transaction_date) 
        VALUES (descr,source_head,0,amt,userId,receiptsn,receiptno,payment_mode,facId,collected,in_date,in_txn_date);
    INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, modeOfPayment,facilityId,client_acct,createdAt,transaction_date) 
      VALUES (descr,dest_head,amt,0,userId,receiptsn,receiptno,payment_mode,facId,collected,in_date,in_txn_date);
      
   #    INSERT INTO transactions (description, acct, debit, credit, enteredBy, receiptDateSN, receiptNo, modeOfPayment,facilityId,client_acct,createdAt) 
    #  VALUES (descr,'500011',amt,0,userId,receiptsn,receiptno,payment_mode,facId,collected,in_date);
    
    COMMIT;
  END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_nursing_report`(IN `query_type` VARCHAR(10), IN `in_facId` VARCHAR(50), IN `in_user` VARCHAR(50), IN `in_report` VARCHAR(1000), IN `in_created_at` TIMESTAMP, IN `in_id` INT)
    NO SQL
IF query_type = 'new' THEN
	INSERT into nursing_report (created_by,created_at,report,facilityId) VALUES (in_user,in_created_at,in_report,in_facId);
    ELSEIF query_type = 'update' THEN
    UPDATE nursing_report SET report=in_report WHERE id=in_id AND created_by=in_user AND facilityId=in_facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_prescription`(IN `in_drug` VARCHAR(100), IN `in_dosage` VARCHAR(50), IN `in_period` VARCHAR(20), IN `in_duration` VARCHAR(20), IN `in_frequency` VARCHAR(20), IN `in_patient_id` VARCHAR(50), IN `in_prescribed_by` VARCHAR(50), IN `in_facilityId` VARCHAR(50), IN `in_status` VARCHAR(50), IN `in_request_id` VARCHAR(50), IN `in_route` VARCHAR(20), IN `in_additionalInfo` VARCHAR(200), IN `in_decision` VARCHAR(20), IN `in_startTime` DATETIME, IN `in_times_per_day` INT, IN `in_id` VARCHAR(50), IN `in_end_date` DATETIME, IN `in_no_of_days` INT, IN `in_drug_count` INT, IN `in_no_times` INT)
    NO SQL
insert into dispensary(drug,dosage,period,duration, frequency, patient_id, prescribed_by, facilityId, status, request_id, route, additionalInfo, decision, startTime, times_per_day, id, end_date, no_of_days, drugCount, no_times) VALUES (in_drug,in_dosage,in_period,in_duration, in_frequency, in_patient_id, in_prescribed_by, in_facilityId, in_status, in_request_id, in_route, in_additionalInfo, in_decision, in_startTime, in_times_per_day, in_id, in_end_date, in_no_of_days, in_drug_count, in_no_times)$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nursing_note`(IN `in_report` VARCHAR(150), IN `in_patient_id` VARCHAR(50), IN `in_created_at` DATETIME, IN `in_created_by` VARCHAR(50), IN `query_type` VARCHAR(30))
BEGIN
IF query_type='insert' THEN
INSERT INTO nursing_note (report,patient_id,created_at,created_by) VALUES(in_report,in_patient_id,in_created_at,in_created_by);
ELSEIF query_type='select' THEN
SELECT * FROM nursing_note WHERE patient_id=in_patient_id;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `patient_history`(IN `in_patient_id` VARCHAR(50), IN `in_req_id` VARCHAR(50), IN `in_history` VARCHAR(1000), IN `in_file` VARCHAR(200), IN `in_query_type` VARCHAR(50), IN `in_facId` VARCHAR(50))
    NO SQL
IF in_query_type='insert' THEN
        INSERT INTO patient_history (patient_id,request_id,history,file,facilityId) VALUES (in_patient_id,in_req_id,in_history,in_file,in_facId);
ELSEIF in_query_type = 'get_history' THEN
        SELECT concat(a.firstname, ' ', a.surname) as name, a.dob, a.Gender as gender, a.Gender as sex, a.id,
        DOB as dob, ifnull(a.phoneNo,'') as phoneNo,b.history
        FROM patientrecords a JOIN patient_history b
        WHERE a.id = in_patient_id AND b.request_id=in_req_id AND a.facilityId=in_facId;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `patient_nursing_notes`(IN `in_report` VARCHAR(200), IN `pat_id` VARCHAR(20), IN `create_at` DATETIME, IN `create_by` VARCHAR(50), IN `facId` VARCHAR(60), IN `query_type` VARCHAR(30))
BEGIN
IF query_type='insert' THEN
INSERT INTO `nursing_note`( `report`, `patient_id`, `created_at`, `created_by`,facilityId) 
VALUES (in_report,pat_id,create_at,create_by,facId);
ELSEIF query_type='select' THEN
SELECT * FROM nursing_note WHERE patient_id=pat_id AND facilityId=facId;

END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pending_prescription`(IN `query_type` VARCHAR(50), IN `in_status` VARCHAR(50), IN `facId` VARCHAR(50), IN `in_request_id` VARCHAR(50), IN `in_from` DATE, IN `in_to` DATE)
    NO SQL
BEGIN IF query_type='patient-drugs' THEN SELECT drug,drug as drug_name, dosage, frequency, duration, additionalInfo, route, period, request_id FROM dispensary WHERE request_id=in_request_id AND status=in_status; ELSEIF query_type='general-data' THEN SELECT a.request_id, a.patient_id, count(drug) as count, prescribed_by, concat(b.firstname, ' ', b.surname) as name FROM dispensary a JOIN patientrecords b ON (a.patient_id=b.id) WHERE a.status=in_status and a.facilityId=facId AND date(a.created_at) BETWEEN in_from AND in_to group by a.request_id, a.patient_id, prescribed_by,name LIMIT 50; END IF; 
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_add_new_drug_purchase`(IN `in_receive_date` DATE, IN `in_item_name` VARCHAR(50), IN `in_po_no` VARCHAR(20), IN `in_qty_in` INT(11), IN `in_qty_out` INT(11), IN `in_store_type` VARCHAR(20), IN `in_grm_no` INT(11), IN `query_type` VARCHAR(20), IN `in_expiry_date` DATE, IN `in_unit_price` FLOAT(11), IN `in_mark_up` FLOAT(11), IN `in_selling_price` FLOAT(11), IN `in_transfer_from` VARCHAR(50), IN `in_status` VARCHAR(20), IN `in_transfer_to` VARCHAR(50), IN `in_branch_name` VARCHAR(30), IN `in_facilityId` VARCHAR(50), IN `in_trn_no` VARCHAR(50), IN `in_uniqueId` VARCHAR(50), IN `in_item_category` VARCHAR(100), IN `in_item_code` VARCHAR(70), IN `in_version_id` VARCHAR(50), IN `in_req_no` VARCHAR(50), IN `in_truck_no` VARCHAR(50), IN `in_waybill_no` VARCHAR(50), IN `in_other_info` VARCHAR(100), IN `in_cost_price` FLOAT, IN `in_supplier_code` VARCHAR(100), IN `in_supplier_name` VARCHAR(100), IN `in_reorder_level` INT, IN `in_receipt_no` VARCHAR(50), IN `in_user_id` VARCHAR(50), IN `in_generic_name` VARCHAR(100), IN `in_uom` VARCHAR(100), IN `in_barcode` VARCHAR(100))
    NO SQL
BEGIN

declare supplier_balance,new_supplier_balance float;
declare drug_code_data,drug_name_data,balance_data,store_data, facilityId_data varchar(50);
DECLARE supplier_name_data varchar(100);
DECLARE selling_price_data,price_data float;
declare expiry_date_data date;
declare new_drug_balance int;
declare var_amount float;
set var_amount=in_qty_in*in_cost_price ;
if query_type= "received" then

select balance  into supplier_balance from suppliersinfo where supplier_code=in_supplier_code;

set new_supplier_balance=supplier_balance-var_amount;
-- update the supplier info balance
update suppliersinfo set balance=new_supplier_balance where supplier_code=in_supplier_code;

-- insert into account entries
INSERT INTO supplier_entries (supplier_id,dr,cr,reference_no,facilityId,created_at,truckNo,waybillNo,description,version_id,cost_price,quantity)
VALUES (in_supplier_code,var_amount,0,'',in_facilityId,now(),in_truck_No,in_waybill_no,in_item_name,in_version_id,in_cost_price ,in_qty_in);


-- insert into store

INSERT INTO pharm_store_entries (receive_date, drug_name, po_no, qty_in,qty_out,store_type,grn_no, expiry_date,unit_price,mark_up,selling_price,transfer_from,transfer_to, branch_name,facilityId,uniqueId,drug_category,item_code,version_id, truckNo, waybillNo, otherInfo, cost_price, supplier_code, supplier_name, reorder_level, inserted_by,inserted_time,sales_type,barcode) 
VALUES(in_receive_date,in_item_name,in_po_no,in_qty_in, in_qty_out, in_store_type,in_grm_no,in_expiry_date, in_cost_price ,in_mark_up, in_selling_price,in_transfer_from,in_transfer_to, in_branch_name, in_facilityId,in_uniqueId, in_item_category,in_item_code,in_version_id, in_truck_no,in_waybill_no,in_other_info, in_cost_price, in_supplier_code, in_supplier_name,in_reorder_level,in_user_id,now(),"Purchase Order",in_barcode);

SELECT item_code,drug_name,price,balance, facilityId, expiry_date,selling_price,store, supplier_name into 
drug_code_data,drug_name_data,price_data,balance_data, facilityId_data,expiry_date_data ,selling_price_data,store_data, supplier_name_data
FROM `pharm_store` where drug_name=in_item_name and store=in_branch_name and expiry_date=in_expiry_date and barcode=in_barcode and
supplier_name= in_supplier_name and price = in_cost_price ; 

update pharm_store set selling_price=in_selling_price WHERE barcode=in_barcode and drug_name=in_item_name  and facilityId= in_facilityId  and store=in_branch_name;

if  drug_name_data=in_item_name and price_data=in_cost_price and store_data=in_branch_name and facilityId_data= in_facilityId and expiry_date_data=in_expiry_date and supplier_name_data=in_supplier_name THEN

set new_drug_balance=ifnull(balance_data,0)+in_qty_in;


update pharm_store set balance=new_drug_balance WHERE drug_name=in_item_name and selling_price=in_selling_price 
and  facilityId= in_facilityId and expiry_date=in_expiry_date and store=in_branch_name and supplier_name= in_supplier_name and price = in_cost_price;

ELSE

insert into pharm_store(item_code,drug_name,price,balance, facilityId, expiry_date,supplier_name,supplier_code,selling_price,store,generic_name,insert_date,reoder_level,uom,drug_category, barcode, grn_no)
values (in_item_code,in_item_name,in_cost_price,in_qty_in, in_facilityId,in_expiry_date,in_supplier_name,in_supplier_code,in_selling_price,in_branch_name,in_generic_name,now(),
        in_reorder_level,in_uom,in_item_category,in_barcode, in_grm_no);

end if;


-- call update_number_generator("grn",in_grm_no);

ELSEIF query_type="transfer" then
INSERT INTO pharm_store_entries (receive_date, item_name, po_no, qty_in,qty_out,store_type,grm_no,
        expiring_date,unit_price,mark_up,selling_price,transfer_from,transfer_to, 
        branch_name,facilityId,trn_number,uniqueId,item_category,item_code,version_id,
        truckNo, waybillNo, otherInfo, supplier_code, supplier_name,reorder_level,inserted_by,sales_type,barcode) 
VALUES(in_receive_date,in_item_name,in_po_no,in_qty_in, in_qty_out,
        in_store_type,in_grm_no, in_expiry_date,in_cost_price,
        in_mark_up,in_selling_price,in_transfer_from,in_transfer_to,
        in_branch_name,in_facilityId,in_trn_no,uniqueId,in_item_category,
        in_item_code,in_version_id,in_truck_no,in_waybill_no,in_other_info, 
        in_supplier_code, in_supplier_name,in_reorder_level,in_user_id,'Purchase Order',in_barcode);

call pharm_add_sale_department(in_trn_no, in_item_name, in_qty_in,in_expiry_date, in_selling_price,in_transfer_from, in_receive_date,in_item_category, in_item_code,in_transfer_to, in_version_id,in_facilityId, 0,in_status,in_req_no,
in_truck_no,in_waybill_no, in_other_info,in_supplier_code, in_supplier_name, in_receipt_no, in_user_id, in_barcode);
end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_add_new_pharm_store`(IN `in_store_name` VARCHAR(100), IN `in_store_location` VARCHAR(100), IN `in_phone_number` VARCHAR(100), IN `in_store_type` VARCHAR(100), IN `in_address` VARCHAR(100), IN `in_manage_by` VARCHAR(100), IN `in_facilityId` VARCHAR(100), IN `in_created_by` VARCHAR(100), IN `in_pharm_name` VARCHAR(100), IN `in_store_code` VARCHAR(100), IN `status` VARCHAR(50))
    NO SQL
BEGIN
if status='insert' THEN

INSERT INTO `pharm_branches`( `branch_name`, `location`, `address`, `phone`, `store_type`, `created_time`, `facilityId`, `admin_name`, `created_by`,store_code,manage_by) VALUES (in_store_name,in_store_location,in_address,in_phone_number,in_store_type,now(),in_facilityId,in_created_by,in_manage_by,in_store_code,in_manage_by);
ELSE
UPDATE `pharm_branches` SET `location`=in_store_location,`phone`=in_phone_number,`store_type`=in_store_type,`address`=in_address,`manage_by`=in_manage_by WHERE store_code=in_store_code and facilityId=in_facilityId;
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_add_new_supplier`(IN `in_facilityId` VARCHAR(50), IN `in_supplier_name` VARCHAR(100), IN `in_address` VARCHAR(100), IN `in_phone` VARCHAR(20), IN `in_supplier_code` VARCHAR(50), IN `in_tinnumber` INT, IN `in_supplier_type` VARCHAR(50), IN `in_website` VARCHAR(40), IN `in_vat` INT, IN `in_email` VARCHAR(50), IN `in_other_info` VARCHAR(50), IN `in_version_id` VARCHAR(50), IN `in_balance` INT)
begin
declare supplier_balance,new_supplier_balance float;

SELECT balance into supplier_balance from suppliersinfo WHERE supplier_code=in_supplier_code ;

if supplier_balance is null  THEN
INSERT INTO suppliersinfo(facilityId,supplier_name,address,phone,supplier_code,tinnumber,supplier_type,website,vat, email,other_info,version_id, balance)
  VALUES (in_facilityId,in_supplier_name,in_address,in_phone,in_supplier_code,in_tinnumber,in_supplier_type,in_website,in_vat, in_email,in_other_info,in_version_id, in_balance);
 	IF in_balance != 0 THEN
	INSERT INTO `supplier_entries`(`supplier_id`, `dr`, `cr`, `reference_no`, `facilityId`, `created_at`, `description`, `truckNo`, `waybillNo`, `version_id`, `cost_price`, `quantity`) 
    VALUES (in_supplier_code, 0,in_balance, '', in_facilityId, now(), 'Opening Balance', 
           '', '', in_version_id, 0, 0);
           end if;
	ELSEIF in_balance = 0 THEN 
    INSERT INTO suppliersinfo(facilityId,supplier_name,address,phone,supplier_code,tinnumber,supplier_type,website,vat, email,other_info,version_id, balance)
  VALUES (in_facilityId,in_supplier_name,in_address,in_phone,in_supplier_code,in_tinnumber,in_supplier_type,in_website,in_vat, in_email,in_other_info,in_version_id, in_balance);
  ELSEIF in_balance>0 THEN
    SET new_supplier_balance=supplier_balance+ in_balance;
    
    update suppliersinfo set balance=new_supplier_balance WHERE supplier_code=in_supplier_code;
    
	INSERT INTO `supplier_entries`(`supplier_id`, `dr`, `cr`, `reference_no`, `facilityId`, `created_at`, `description`, `truckNo`, `waybillNo`, `version_id`, `cost_price`, `quantity`) 
    VALUES (in_supplier_code, 0,abs(in_balance), '', in_facilityId, now(), 'Opening Balance', 
           '', '', in_version_id, 0, 0);
           ELSEIF in_balance < 0 THEN
    SET new_supplier_balance=supplier_balance+ in_balance;
    
    update suppliersinfo set balance=new_supplier_balance WHERE supplier_code=in_supplier_code;
    
	INSERT INTO `supplier_entries`(`supplier_id`, `dr`, `cr`, `reference_no`, `facilityId`, `created_at`, `description`, `truckNo`, `waybillNo`, `version_id`, `cost_price`, `quantity`) 
    VALUES (in_supplier_code, 0,in_balance, '', in_facilityId, now(), 'Opening Balance', 
           '', '', in_version_id, 0, 0);
end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_add_sale_department`(IN `in_trn_number` VARCHAR(50), IN `in_item_name` VARCHAR(100), IN `in_qty_in` INT(100), IN `in_expiry_date` DATE, IN `in_selling_price` FLOAT(10), IN `in_branch_location` VARCHAR(100), IN `in_transaction_date` VARCHAR(20), IN `in_item_category` VARCHAR(50), IN `in_item_code` VARCHAR(90), IN `in_movement_source` VARCHAR(50), IN `in_version_id` VARCHAR(50), IN `in_facilityId` VARCHAR(50), IN `in_qty_out` INT(11), IN `in_status` VARCHAR(50), IN `in_req_no` VARCHAR(50), IN `in_truck_no` VARCHAR(50), IN `in_waybill_no` VARCHAR(50), IN `in_other_info` VARCHAR(100), IN `in_supplier_code` VARCHAR(50), IN `in_supplier_name` VARCHAR(200), IN `in_receipt_no` VARCHAR(50), IN `in_user_id` VARCHAR(50), IN `in_userName` VARCHAR(50), IN `_branch` VARCHAR(50), IN `in_barcode` VARCHAR(100))
    NO SQL
BEGIN

declare quantity int;
declare quantity_approved int;
declare requisition_number int;
DECLARE items varchar(50);
DECLARE balance_quantity int;
DECLARE new_status varchar(50);
DECLARE approved_balance,new_item_balance1,balance_data1 int;

   
SELECT ifnull(balance,0) into balance_data1
FROM pharm_store where drug_name=in_item_name and selling_price=in_selling_price and expiry_date=in_expiry_date and store=in_branch_location AND item_code=in_item_code; 

set new_item_balance1=balance_data1-ifnull(in_qty_out,0);

update pharm_store set balance=new_item_balance1  where drug_name=in_item_name and selling_price=in_selling_price and expiry_date=in_expiry_date and store=in_branch_location and item_code=in_item_code; 

INSERT INTO pharm_store_entries(version_id, trn_number,drug_name,qty_in,expiry_date,selling_price,transfer_from,
transfer_to,receive_date,qty_out,drug_category,item_code,facilityId,branch_name, grn_no, truckNo,waybillNo,otherInfo,supplier_code,supplier_name,uniqueId,inserted_time,inserted_by,userName,sales_type, barcode)
 VALUES(in_version_id,in_trn_number,in_item_name,in_qty_in,in_expiry_date,in_selling_price,in_branch_location,in_movement_source,now(),in_qty_out,
in_item_category,in_item_code,in_facilityId,in_branch_location,in_req_no,in_truck_no,in_waybill_no,in_other_info,in_supplier_code,in_supplier_name,in_receipt_no,now(),in_user_id,in_userName,"sales", in_barcode);


END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_drug_transfer`(IN `in_version_id` VARCHAR(100), IN `in_qty_in` INT(6), IN `in_expiry_date` DATE, IN `in_selling_price` FLOAT(10), IN `in_location_from` VARCHAR(100), IN `in_location_to` VARCHAR(100), IN `in_facilityId` VARCHAR(100), IN `in_item_name` VARCHAR(100), IN `in_receive_date` DATE, IN `in_unit_price` FLOAT(10), IN `in_mark_up` FLOAT(10), IN `supplier_name` VARCHAR(50), IN `supplier_code` VARCHAR(50))
BEGIN
DECLARE trn int;
declare item_code_data,description_data,price_data,balance_data, facilityId_data varchar(50);
declare expiry_date_data date;
declare new_item_balance,transfers_balance,new_transfers_balance int;

declare item_code_data1,description_data1,price_data1,balance_data1 varchar(50);
declare expiry_date_data1 date;
declare new_item_balance1 int;

-- SELECT max(ifNull(code_no,0)+1)  INTO trn from number_generator WHERE prefix='trn';

SELECT item_code,drug_name,price,balance, expiry_date
into item_code_data1,description_data1,price_data1,balance_data1,expiry_date_data1 
FROM `pharm_store` where drug_name=in_item_name and price=in_unit_price and expiry_date=in_expiry_date and store=in_location_from AND facilityId=in_facilityId; 

set new_item_balance1=balance_data1-in_qty_in;

update `pharm_store`set balance=new_item_balance1  where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store=in_location_from; 

SELECT balance INTO transfers_balance from pharm_store where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store = in_location_to;

IF transfers_balance is null then 
INSERT INTO `pharm_store`(`balance`, `drug_name`,`item_code`, `price`, `facilityId`, `expiry_date`, `store`, `selling_price`, `supplier_name`, `supplier_code`, `insert_date`) 
VALUES (in_qty_in,in_item_name,item_code_data1,in_unit_price,in_facilityId,in_expiry_date,in_location_to,in_selling_price,supplier_name,supplier_code,now());

INSERT INTO pharm_store_entries(receive_date,drug_name,item_code,`expiry_date`,qty_out,qty_in,transfer_from,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,item_code_data1,in_expiry_date,in_qty_in, 0,in_location_from,in_location_to,in_unit_price,in_selling_price,in_mark_up, in_location_to ,in_facilityId,in_version_id,supplier_code,supplier_name,concat("Transfer to ", in_location_to));

INSERT INTO pharm_store_entries(receive_date,drug_name,item_code,expiry_date,qty_out,qty_in,transfer_from,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,item_code_data1,in_expiry_date,0 ,in_qty_in,in_location_from,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_to,in_facilityId, in_version_id,supplier_code,supplier_name,concat("Transfer to ", in_location_to));


ELSE
SET new_transfers_balance = transfers_balance + in_qty_in;
UPDATE pharm_store SET balance = new_transfers_balance  where drug_name=description_data1 and price=price_data1 and expiry_date=expiry_date_data1  and store = in_location_to;


INSERT INTO pharm_store_entries(receive_date,drug_name,`item_code`,expiry_date,qty_out,qty_in,transfer_from,`transfer_to`,unit_price,selling_price,mark_up,facilityId,supplier_code,supplier_name,version_id,sales_type,branch_name)
VALUES(now(),in_item_name,item_code_data1,in_expiry_date,in_qty_in, 0,in_location_from,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_facilityId,supplier_code,supplier_name,in_version_id ,concat("Transfer to ", in_location_to), in_location_to);

INSERT INTO pharm_store_entries(receive_date,drug_name,`item_code`,expiry_date,qty_out,qty_in,transfer_from,`transfer_to`,unit_price,selling_price,mark_up,branch_name,facilityId,version_id,supplier_code,supplier_name,sales_type)
VALUES(now(),in_item_name,item_code_data1,in_expiry_date,0 ,in_qty_in,in_location_from,in_location_to,in_unit_price,in_selling_price,in_mark_up,in_location_to,in_facilityId,in_location_to,supplier_code,supplier_name,concat("Transfer to ", in_location_to));
	
end IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_getReceiptData`(IN `in_receipt_no` VARCHAR(100), IN `in_facilityId` VARCHAR(100))
    NO SQL
SELECT description, description as item_name, dr as amount, (dr/quantity) as price , dr as debit, quantity as qty,acct, (dr/quantity) as unit_price  from account_entries where reference_no=in_receipt_no and facilityId=in_facilityId AND dr > 0$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_client`(IN `in_facilityId` VARCHAR(50))
    NO SQL
SELECT accountNo,accName,balance,contactEmail,contactAddress,contactPhone FROM patientfileno WHERE facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_drug_sale_search`(IN `in_drug_name` VARCHAR(50), IN `in_facilityId` VARCHAR(100), IN `in_from` INT, IN `in_to` INT, IN `in_store` VARCHAR(100))
SELECT * FROM `pharm_store` WHERE  balance>0 and (drug_name like in_drug_name or drug_category LIKE  in_drug_name or uom LIKE in_drug_name or generic_name LIKE in_drug_name or barcode LIKE in_drug_name) and facilityId =in_facilityId and store=in_store LIMIT in_from,in_to$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_drug_search`(IN `query_type` VARCHAR(100), IN `facId` VARCHAR(50), IN `in_from` INT, IN `in_to` INT)
SELECT * FROM `pharm_store` WHERE drug_name like query_type AND facilityId = facId LIMIT in_from, in_to$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_drug_view`(IN `in_branch_name` VARCHAR(100), IN `in_item_code` VARCHAR(100), IN `in_facilityId` VARCHAR(50), IN `in_date_from` DATE, IN `in_date_to` DATE, IN `in_drug_name` VARCHAR(100), IN `in_expiry_date` DATE)
    NO SQL
SELECT expiry_date,receive_date,drug_name,branch_name as store,qty_in,qty_out,selling_price FROM `pharm_store_entries` WHERE expiry_date=in_expiry_date and item_code=in_item_code and facilityId=in_facilityId and date(inserted_time) between in_date_from and in_date_to$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_druglist`(IN `facId` VARCHAR(70), IN `query_type` VARCHAR(20))
    NO SQL
BEGIN
IF query_type = 'stock' THEN
SELECT balance, price,drug_name,expiry_date,selling_price,supplier_name,insert_date,barcode,grn_no from pharm_store WHERE balance>0 AND facilityId = facId  ORDER BY `drug_name` ASC;
ELSEIF query_type = 'out_of_stock' THEN 
SELECT balance, price,drug_name,expiry_date,selling_price,supplier_name,insert_date,barcode,grn_no from pharm_store WHERE balance <= 0 AND facilityId = facId ORDER BY `grn_no` DESC;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_expiry_alert`(IN `facId` VARCHAR(50))
    NO SQL
SELECT * FROM pharm_store WHERE DATE_FORMAT(expiry_date, '%Y-%m-%d') BETWEEN DATE_FORMAT(NOW(), '%Y-%m-%d') AND DATE_FORMAT(DATE_ADD(NOW(),INTERVAL 6 MONTH), '%Y-%m-%d')  AND (facilityId=facId) ORDER by expiry_date ASC$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_pharm_store`(IN `in_facilityId` VARCHAR(50))
    NO SQL
SELECT branch_name as store_name,store_code,location as location,phone as phone,store_type as storeType,address,manage_by as manage_by FROM `pharm_branches` WHERE facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_pharm_users`(IN `in_facilityId` VARCHAR(50))
    NO SQL
SELECT * FROM users where facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_purchase_drugs`(IN `in_facilityId` VARCHAR(50), IN `in_from` INT(15), IN `in_to` INT(15), IN `query_type` VARCHAR(60), IN `in_store` VARCHAR(100))
    NO SQL
begin
if query_type="by_store" THEN
SELECT * FROM `pharm_store` WHERE store = in_store AND facilityId=in_facilityId and balance>0 LIMIT in_from,in_to;
ELSE 
SELECT * FROM `pharm_store` WHERE facilityId=in_facilityId AND balance > 0;
end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_reorder_level`(IN `facId` VARCHAR(50))
    NO SQL
SELECT * FROM pharm_store WHERE balance < reoder_level AND facilityId=facId and balance>0$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_sales_drugs`(IN `in_facilityId` VARCHAR(50), IN `query_type` VARCHAR(50), IN `in_from` INT, IN `in_to` INT)
    NO SQL
BEGIN
if query_type='Show All' THEN 
SELECT ifnull(drug_category ,"") as drug_category,ifnull(generic_name ,"") as generic_name,ifnull(uom ,"") as uom,balance,drug_name,item_code,facilityId,expiry_date,store,selling_price FROM `pharm_store` WHERE facilityId=in_facilityId and balance>0 ORDER BY `drug_name` ASC;
 ELSE 
SELECT ifnull(drug_category ,"") as drug_category,ifnull(generic_name ,"") as generic_name,ifnull(uom ,"") as uom,balance,drug_name,item_code,facilityId,expiry_date,store,selling_price FROM `pharm_store` WHERE facilityId=in_facilityId and store=query_type and balance>0 ORDER BY `drug_name` ASC LIMIT in_from,in_to;
 end if;
 end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_supplier`(IN `_supplier_code` VARCHAR(50))
    NO SQL
SELECT `facilityId`, `supplier_name`, `date`, `address`, `phone`, `supplier_code`, `balance`, `tinnumber` `email` FROM `suppliersinfo` WHERE supplier_code=_supplier_code$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_supplier_count`(IN `in_facilityId` VARCHAR(50))
    NO SQL
SELECT COUNT(*) as num FROM `suppliersinfo` WHERE facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_supplier_info`(IN `in_facilityId` VARCHAR(50))
    NO SQL
SELECT `facilityId`, `supplier_name`, `date`, `address`, `phone`, `supplier_code`, `balance`, `tinnumber` `email` FROM `suppliersinfo` WHERE facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_get_supplierr_statement`(IN `in_supplier_code` VARCHAR(50), IN `in_date_from` DATE, IN `in_date_to` DATE, IN `in_facilityId` VARCHAR(60))
SELECT  0 AS `total`,`entry_id`, `supplier_id`, `dr`, `cr`, `reference_no`, `facilityId`, `created_at`, `description`, `truckNo`, `waybillNo`, `version_id`, `cost_price`, `quantity` FROM supplier_entries where supplier_id=in_supplier_code and date(created_at) between in_date_from and in_date_to AND  facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_reports_dashboard`(IN `in_date_from` DATE, IN `in_date_to` DATE, IN `in_facilityid` VARCHAR(100), IN `query_type` VARCHAR(50))
    NO SQL
begin

if query_type ='Purchase summary' then

SELECT sum(qty_in*unit_price) as total FROM `pharm_store_entries` where sales_type ='Purchase Order' AND date(receive_date) BETWEEN in_date_from and in_date_to and facilityId=in_facilityid;

elseif query_type ='Purchase category summary' then

SELECT receive_date,drug_name as description,qty_in as qty,selling_price, unit_price,unit_price*qty_in as amount,inserted_by, branch_name,supplier_name FROM `pharm_store_entries` where sales_type ='Purchase Order' AND date(receive_date) BETWEEN in_date_from and in_date_to and facilityId=in_facilityid;

elseif query_type ='Sales summary' then

SELECT sum(qty_out*selling_price) as total FROM `pharm_store_entries` where date(receive_date) BETWEEN in_date_from and in_date_to and facilityId=in_facilityid AND qty_out > 0 AND sales_type="sales" ;

elseif query_type ='Sales category summary' then
SELECT  receive_date,drug_name as description,qty_out as qty,selling_price, selling_price*qty_out as amount,inserted_by,sales_type, branch_name,otherInfo, grn_no as mop FROM `pharm_store_entries` where date(receive_date) BETWEEN in_date_from and in_date_to and facilityid=in_facilityid AND qty_out > 0 AND sales_type="sales";


elseif query_type ='Expenses summary' then

SELECT sum(credit) as total FROM `transactions` where acct ='EXPENSES' and facilityId=in_facilityid and date(createdAt) between in_date_from and in_date_to;
elseif query_type ='Expenses summary' then

SELECT sum(credit) as total FROM `transactions` where acct ='EXPENSES' and facilityId=in_facilityid and date(createdAt) between in_date_from and in_date_to;


elseif query_type ='Discount summary' then
SELECT sum(credit) as total FROM `transactions` where acct ='60000' and facilityId=in_facilityid and date(createdAt) between in_date_from and in_date_to;

elseif query_type ='Discount category summary' then
SELECT description,credit,enteredBy,createdAt,customer_name, branch_name FROM `transactions` where acct ='60000' and facilityId=in_facilityid and date(createdAt) between in_date_from and in_date_to;

elseif query_type ='Debt summary' then

SELECT sum(balance) as total FROM patientfileno where facilityId=in_facilityid AND balance < 0  AND accountNo != in_facilityid;
elseif query_type ='Debt summary' then


select date(createdAt) as receive_date, accname as description,contactPhone,balance as amount from patientfileno where facilityId=in_facilityid AND balance < 0 AND accountNo != '';

elseif query_type ='Debt category summary' then

select date(createdAt) as receive_date, accname as description,contactPhone,balance as amount from patientfileno where facilityId=in_facilityid AND balance < 0 AND accountNo != '';

elseif query_type ='reprint' then
select *,SUM(dr) FROM account_entries where facilityId=in_facilityid AND date(createdAt) between in_date_from and in_date_to GROUP BY reference_no;


end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_service_transaction`(IN `in_description` VARCHAR(1000), IN `in_acct` VARCHAR(50), IN `service_amount` INT, IN `in_receiptDateSN` VARCHAR(70), IN `in_receiptSN` VARCHAR(50), IN `in_mode_of_payment` VARCHAR(20), IN `patientId` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `sourceAcct` VARCHAR(50), IN `userId` VARCHAR(50), IN `in_service_head` VARCHAR(50), IN `txnType` VARCHAR(10), IN `in_date` DATETIME, IN `in_payables_head` VARCHAR(50), IN `in_recievables_head` VARCHAR(50), IN `in_bank_name` VARCHAR(50), IN `in_txn_date` DATE, IN `in_discount` INT, IN `in_discount_head` VARCHAR(50), IN `in_customer_name` VARCHAR(50), IN `in_branch_name` VARCHAR(50), IN `qty` VARCHAR(50), IN `in_version_id` VARCHAR(50), IN `cus_phone` VARCHAR(20), IN `cus_bank` VARCHAR(30), IN `cus_acc_no` VARCHAR(20), IN `transaction_amount` VARCHAR(50), IN `bus_bank` VARCHAR(30), IN `bus_bank_acc_no` VARCHAR(100), IN `in_amount_paid` INT, IN `in_truck_no` VARCHAR(50), IN `in_waybill_no` VARCHAR(50), IN `in_item_list` VARCHAR(500), IN `in_payment_type` VARCHAR(100), IN `in_price` INT(11), IN `in_item_code` VARCHAR(100), IN `in_expiry_date` DATE, IN `in_salesFrom` VARCHAR(100), IN `in_userName` VARCHAR(100), IN `_branch` VARCHAR(100))
BEGIN
    declare client_balance int;
    declare main_balance int;
    declare receivable int;
    DECLARE instant_balance int;
    DECLARE cash_amount int;
    DECLARE new_bal int;

    select balance into client_balance  from `patientfileno` where accountNo=in_acct AND facilityId=in_facId;

    set cash_amount = service_amount - in_discount;
    set main_balance = client_balance-cash_amount;
    set receivable  = cash_amount-client_balance;
    set instant_balance = client_balance + cash_amount;
    set new_bal = client_balance - cash_amount;


    IF txnType = 'insta' THEN

        update  `patientfileno` set balance= new_bal where accountNo=in_acct AND facilityId=in_facId;

        -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
         --   values (in_version_id, in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,in_truck_no,in_waybill_no,qty);

        INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
        -- `client_entries`(`acct`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
        VALUES (in_acct,in_description,abs(service_amount),0,in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
        insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
        -- transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
           -- values (in_version_id, in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
        values (in_facId,in_txn_date, in_description,in_service_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);


        IF in_discount > 0 THEN
            -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
            -- values (concat(in_version_id, '-2'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
      
            -- transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
            -- values (concat(in_version_id, '-2'), concat('Discount on (', in_item_list,')'),in_discount_head,0,in_discount ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,0,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
            values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);

            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,concat('Discount on (', in_item_list,')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
            INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
            VALUES (in_acct,concat('Discount on (', in_item_list,')'),0,abs(in_discount),in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
            update `patientfileno`  set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
        END IF;


    -- if the customer is registered
    ELSE

        -- if the customer has balance more than what is buying
        if main_balance  > 0  then
            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,in_description,0,abs(service_amount),in_facId,in_mode_of_payment,in_receiptSN,qty);

            update `patientfileno`  set balance= new_bal where accountNo=in_acct AND facilityId=in_facId;

         INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
            VALUES (in_acct,in_description,abs(service_amount), 0,in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
           insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
           values (in_facId,in_txn_date, in_description,in_service_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);

            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
            -- insert into transactions  (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
            values (in_facId,in_txn_date, in_description,in_payables_head,abs(cash_amount),0 ,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);


            -- if there is discount
            IF in_discount > 0 THEN
               -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
                -- values (concat(in_version_id, '-6'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                -- values (concat(in_version_id, '-6'), concat('Discount on (', in_item_list,')'),in_discount_head,0,in_discount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
                
                INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
                -- VALUES (in_acct,in_version_id,concat('Discount on (', in_item_list,')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
                VALUES (in_acct,0,concat('Discount on (', in_item_list,')'),abs(in_discount),in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
                update  `patientfileno` set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
  
            END IF;

        -- if the customer has not enough balance
        elseif main_balance < 0 then
            update  `patientfileno` set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

            -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
            -- values (concat(in_version_id, '-7'), in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,in_truck_no,in_waybill_no,qty);
 
            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,in_description,0,abs(service_amount),in_facId,in_mode_of_payment,in_receiptSN,qty);
            INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
            VALUES (in_acct,in_description,abs(service_amount),0, in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
            update  `patientfileno` set balance= new_bal where accountNo=in_acct AND facilityId=in_facId;
            
            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
            values (in_facId,in_txn_date, in_description,in_service_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);

            -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date,     customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
            -- values (concat(in_version_id, '-8'), in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);


            -- if the current balance is zero
            if client_balance = 0 then
               -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date,     customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
               -- values (concat(in_version_id, '-9'), in_description,in_recievables_head,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, in_description,in_recievables_head,abs(cash_amount),0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);


                IF in_discount > 0 THEN
                 --   insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
                 --   values (concat(in_version_id, '-10'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
                   -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date,     customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                  --  values (concat(in_version_id, '-10'), concat('Discount on (', in_item_list,')'),in_discount_head,0,in_discount ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                    insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                    values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
            
                   --  INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
                   --  VALUES (in_acct,in_version_id,concat('Discount',' for (', in_item_list, ')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
                    INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
              
                    VALUES (in_acct,concat('Discount on (', in_item_list,')'), 0, abs(in_discount),in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
                    update  `patientfileno` set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
  
                END IF;

            elseif client_balance > 0  then

                --  insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
               --  values (concat(in_version_id, '-11'), in_description,in_payables_head,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, in_description,in_payables_head,abs(client_balance),0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);

                -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date,     customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                -- values (concat(in_version_id, '-12'), in_description,in_recievables_head,abs(receivable),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
               -- insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`)
               -- values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId);
            
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, in_description,in_recievables_head,abs(receivable),0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
        


                IF in_discount > 0 THEN
                -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
                -- values (concat(in_version_id, '-13'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
                -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                
                -- values (concat(in_version_id, '-13'), concat('Discount on (', in_item_list,')'),in_discount_head,0 ,in_discount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                 insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,abs(in_discount),userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);


              --  INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
              --  VALUES (in_acct,in_version_id,concat('Discount on (', in_item_list,')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
                INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
              
                VALUES (in_acct,concat('Discount on (', in_item_list,')'),0, abs(in_discount), in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
                update  `patientfileno` set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
                END IF;

            elseif client_balance < 0  then

               -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                -- values (concat(in_version_id, '-14'), in_description,in_recievables_head,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, in_description,in_recievables_head,abs(receivable),0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
    
                -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
                -- VALUES (in_acct,in_version_id,in_description,0,abs(service_amount),in_facId,in_mode_of_payment,in_receiptSN,qty);
                -- update  `patientfileno` set balance= new_bal where accountNo=in_acct AND facilityId=in_facId;

                IF in_discount > 0 THEN
                   -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
           -- values (concat(in_version_id, '-15'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
                -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                -- values (concat(in_version_id, '-15'), concat('Discount on (', in_item_list,')'),in_discount_head,0 ,in_discount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
                insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
                values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
            
                -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
                -- VALUES (in_acct,in_version_id,concat('Discount on (', in_item_list,')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
                INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
              
                VALUES (in_acct,concat('Discount on (', in_item_list,')'), 0,abs(in_discount), in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
                update  `patientfileno` set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
                
                END IF;

            end if;
        
        -- if the current balance is equal to what he has in the account
        elseif  main_balance = 0 then

            update  `patientfileno` set balance= main_balance  where accountNo=in_acct AND facilityId=in_facId;

            -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
            -- values (concat(in_version_id, '-16'), in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,in_truck_no,in_waybill_no,qty);
            
            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,in_description,0,abs(service_amount),in_facId,in_mode_of_payment,in_receiptSN,qty);
             INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
            VALUES (in_acct,in_description,abs(service_amount),0, in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
            update  `patientfileno` set balance= new_bal where accountNo=in_acct AND facilityId=in_facId;
  
            -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
            -- values (concat(in_version_id, '-17'), in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
            values (in_facId,in_txn_date, in_description,in_service_head,0,service_amount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
    

            -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
            -- values (concat(in_version_id, '-18'), in_description,in_payables_head,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
            values (in_facId,in_txn_date, in_description,in_payables_head,abs(client_balance),0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);


            IF in_discount > 0 THEN
               -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
          --  values (concat(in_version_id, '-19'), in_acct,in_discount,0,in_receiptDateSN,concat('Discount on (', in_item_list,')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);
                -- insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date, customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
                -- values (concat(in_version_id, '-19'), concat('Discount on (', in_item_list,')'),in_discount_head,0,in_discount ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
            insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`)
            values (in_facId,in_txn_date, concat('Discount on (', in_item_list,')'),in_discount_head,0,in_discount,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
                
                
            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,concat('Discount on (', in_item_list,')'),abs(in_discount),0,in_facId,in_mode_of_payment,in_receiptSN,0);
            INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
              
            VALUES (in_acct,concat('Discount on (', in_item_list,')'), 0,abs(in_discount), in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);
 
            
            update  `patientfileno` set balance= new_bal+in_discount where accountNo=in_acct AND facilityId=in_facId;
   
            END IF;


        end if;

        IF in_amount_paid > 0 THEN
           -- insert into account_entries (version_id, acct,dr,cr,reference_no,description,facilityId,createdAt,truckNo,waybillNo,quantity)
           -- values (concat(in_version_id, '-20'), in_acct,in_amount_paid,0,in_receiptDateSN,concat(in_payment_type,' for (', in_item_list, ')'),in_facId,in_date,in_truck_no,in_waybill_no,qty);

           --  insert into transactions (version_id, description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date,     customer_name,branch_name,quantity,txn_amount,customer_phone, customer_bank,customer_acc_no, bank_account,truckNo,waybillNo,salesFrom,item_code,expiry_date)
           --  values (concat(in_version_id, '-20'), concat(in_payment_type, ' for (', in_item_list, ')'),in_service_head,in_amount_paid,0,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date,in_customer_name,in_branch_name,qty,transaction_amount,cus_phone, cus_bank, cus_acc_no, bus_bank_acc_no,in_truck_no,in_waybill_no,in_salesFrom,in_item_code,in_expiry_date);
        --    insert into `transactions` (`facilityId`, `transaction_date`, `description`, `acct`, `debit`, `credit`, `enteredBy`, `receiptDateSN`, `receiptNo`, `modeOfPayment`, `bank_name`, `status`, `client_acct`, `patient_id`,`qty`,`unit_price`,`branch_name`)
        --     values (in_facId,in_txn_date, concat(in_payment_type, ' for (', in_item_list, ')'),in_service_head,in_amount_paid,0,userId, in_receiptDateSN, in_receiptSN, in_mode_of_payment,in_bank_name,'copleted',cus_acc_no,patientId,qty,in_price,_branch);
               
           -- Haltingx`
           
            -- INSERT INTO `client_entries`(`accountNo`, `version_id`, `description`, `dr`, `cr`, `facilityId`,mode_of_payment,receiptNo,quantity) 
            -- VALUES (in_acct,in_version_id,concat(in_payment_type,' for (', in_item_list, ')'),in_amount_paid,0,in_facId,in_mode_of_payment,in_receiptSN,0);
            INSERT INTO `account_entries`(`acct`,`description`, `dr`, `cr`, `facilityId`,  `mode_of_payment`, `reference_no`, `client_id`, `txn_status`, `quantity`)
            VALUES (in_acct,concat(in_payment_type,' for (', in_item_list, ')'),0, in_amount_paid, in_facId,in_mode_of_payment,in_receiptSN,patientId,'completed',qty);

            update  `patientfileno` set balance= new_bal+in_amount_paid where accountNo=in_acct AND facilityId=in_facId;
  
        END IF;

    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_supplier_payment`(IN `in_facId` VARCHAR(50), IN `userId` VARCHAR(50), IN `in_acct` VARCHAR(50), IN `Amount_paid` INT, IN `in_receiptDateSN` VARCHAR(50), IN `in_receiptSN` VARCHAR(50), IN `in_mode_of_payment` VARCHAR(50), IN `sourceAcct` VARCHAR(50), IN `in_description` VARCHAR(100), IN `in_date` DATETIME, IN `in_payables_head` VARCHAR(50))
BEGIN

declare supplier_balance double;
    declare main_balance double;
    DECLARE balance_paid DOUBLE;
    
    select balance into supplier_balance from suppliersinfo where supplier_code=in_acct AND facilityId=in_facId;

    set main_balance = supplier_balance+Amount_paid;
    
    update suppliersinfo set balance= main_balance  where supplier_code=in_acct AND facilityId=in_facId;
    
    
     insert into supplier_entries (supplier_id,dr,cr,reference_no,facilityId,description)
           values (in_acct,0,Amount_paid,in_receiptDateSN,in_facId,in_description);
           
      
     -- insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,facilityId,createdAt,version_id)
        --   values (in_description,sourceAcct,0,Amount_paid,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,in_facId,in_date,in_version_id);
          
           
          -- insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,facilityId,createdAt,version_id)
         --  values (in_description,in_payables_head,0,abs(Amount_paid) ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,in_facId,in_date, concat(in_version_id,'-1'));
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pharm_update_store`(IN `in_selling_price` FLOAT(11), IN `in_expiry_date` DATE, IN `in_drug_name` VARCHAR(100), IN `in_item_code` VARCHAR(100), IN `in_store` VARCHAR(100), IN `in_facilityId` VARCHAR(100), IN `in_balance` INT)
update pharm_store set selling_price=in_selling_price,balance=in_balance,drug_name=in_drug_name  WHERE expiry_date=in_expiry_date and item_code=in_item_code and store=in_store and facilityId=in_facilityId$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `previous_doc`(IN `in_patient_id` VARCHAR(20), IN `in_file_type` VARCHAR(50), IN `in_file_url` VARCHAR(200), IN `in_file_date` DATE, IN `query_type` VARCHAR(50))
    NO SQL
BEGIN 
IF query_type='insert' THEN
INSERT INTO previous_doc (patient_id,file_type,file_url,file_date) VALUES(in_patient_id,in_file_type,in_file_url,in_file_date);
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `query_lab_setup`(IN `in_head` INT, IN `facId` VARCHAR(50), IN `in_query_type` VARCHAR(50), IN `in_subhead` INT, IN `in_description` VARCHAR(100), IN `in_label_name` VARCHAR(50), IN `in_no_of_labels` INT, IN `in_unit` VARCHAR(10), IN `in_range_from` VARCHAR(10), IN `in_range_to` VARCHAR(10), IN `in_report_type` VARCHAR(50), IN `in_form_mode` VARCHAR(50), IN `in_unit_name` VARCHAR(50), IN `in_specimen` VARCHAR(50), IN `in_to_collect_sample` VARCHAR(5), IN `in_to_be_analyzed` VARCHAR(5), IN `in_to_be_reported` VARCHAR(5), IN `in_upload_doc` VARCHAR(5), IN `in_label_type` VARCHAR(50), IN `in_print_type` VARCHAR(50), IN `in_price` INT(30), IN `in_old_price` INT)
    NO SQL
IF in_query_type = 'next subhead' THEN
	SELECT ifnull(MAX(subhead)+ 1, concat(in_head,'1'))  as next_code FROM lab_setup WHERE head=in_head AND facilityId=facId;
ELSEIF in_query_type = 'report_type' THEN
	SELECT DISTINCT report_type from lab_setup WHERE report_type is not null;
    ELSEIF in_query_type ="update_lab_setup_account" THEN
update lab_setup set price=in_price, old_price=in_old_price where subhead=in_subhead;
ELSEIF in_query_type = 'new_test' THEN
	INSERT INTO lab_setup (head,subhead,description, label_name, noOfLabels, unit, range_from, range_to, report_type,facilityId, specimen, collect_sample, to_be_analyzed, to_be_reported, upload_doc) VALUES (in_head,in_subhead,in_description, in_label_name, in_no_of_labels, in_unit, in_range_from, in_range_to, in_report_type, facId,in_specimen, in_to_collect_sample, in_to_be_analyzed, in_to_be_reported, in_upload_doc);
ELSEIF in_query_type = 'update_test' THEN
UPDATE lab_setup SET head=in_head, description=in_description, label_name=in_label_name, noOfLabels=in_no_of_labels, unit=in_unit, range_from=in_range_from, range_to=in_range_to, report_type=in_report_type, specimen=in_specimen, collect_sample=in_to_collect_sample, to_be_analyzed=in_to_be_analyzed, to_be_reported=in_to_be_reported, upload_doc=in_upload_doc WHERE subhead=in_subhead AND facilityId=facId;
ELSEIF in_query_type = 'delete' THEN 
	DELETE FROM lab_setup WHERE subhead = in_subhead AND facilityId=facId;
ELSEIF in_query_type = 'code_setup' THEN
	UPDATE lab_setup SET label_type=in_label_type, print_type=in_print_type WHERE (subhead=in_subhead OR head=in_subhead) AND facilityId=facId;
ELSEIF in_query_type = 'test_info' THEN
	SELECT * FROM lab_setup WHERE subhead=in_subhead;
ELSEIF in_query_type = 'group_list' THEN
SELECT * FROM lab_setup WHERE subhead IN (SELECT DISTINCT head FROM lab_setup);
ELSEIF in_query_type = 'unit_list' THEN
	IF in_head = 'all' THEN
		SELECT DISTINCT unit_name,unit_code FROM lab_setup;
    ELSE 
    	SELECT DISTINCT unit_name,unit_code FROM lab_setup WHERE lab_code = in_head;
    END IF;
ELSEIF in_query_type = 'department_list' THEN
	SELECT * FROM lab_setup WHERE head=1000;
ELSEIF in_query_type = 'Barcode Setup' THEN
	IF in_form_mode = 'Stand Alone Test' THEN 
    	SELECT * FROM lab_setup WHERE label_type='single';
    ELSE 
    	SELECT * FROM lab_setup WHERE label_type IN ('grouped', 'singular_group', 'grouped_single');
    END IF;
   	ELSEIF in_query_type = 'by_group' THEN
    call get_lab_setup_account('','', in_subhead, facId);
    ELSEIF in_query_type = 'by_head' THEN
    	SELECT * FROM lab_setup WHERE head=in_head;
    ELSEIF in_query_type = 'all' THEN
    	SELECT * FROM lab_setup WHERE facilityId=facId; #AND old_price = '';
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `query_only_consultation`(IN `query_type` VARCHAR(30))
BEGIN
SELECT * FROM `consultations` WHERE consultation_notes LIKE query_type LIMIT 100;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_operation_note`(IN `op_date` VARCHAR(30), IN `patient_id` VARCHAR(10), IN `diagnosis` VARCHAR(150), IN `surgery` VARCHAR(150), IN `surgeons` VARCHAR(150), IN `anesthetist` VARCHAR(80), IN `anesthetic` VARCHAR(20), IN `scrubNurse` VARCHAR(30), IN `remarks` VARCHAR(50), IN `name` VARCHAR(100), IN `pintsGiven` VARCHAR(10), IN `bloodLoss` VARCHAR(15), IN `intraOpAntibiotics` VARCHAR(20), IN `intraOpFindings` VARCHAR(2000), IN `procedureNotes` VARCHAR(2000), IN `pathologyRequest` VARCHAR(200), IN `postOpOrder` VARCHAR(1000), IN `facId` VARCHAR(50), IN `uid` VARCHAR(50), IN `in_query_type` VARCHAR(50), IN `in_report_type` VARCHAR(50))
BEGIN
    DECLARE p_name VARCHAR(300);

    IF in_query_type = 'new' THEN
        SELECT concat(surname, ' ', firstname) INTO p_name FROM patientrecords WHERE patientrecords.id = patient_id;

        INSERT INTO operationnotes(
            date,
            patientId,
            diagnosis,
            surgery,
            surgeons,
            anesthetist,
            anesthetic,
            scrubNurse,
            remarks,
            NAME,
            pintsGiven,
            bloodLoss,
            intraOpAntibiotics,
            intraOpFindings,
            procedureNotes,
            pathologyRequest,
            postOpOrder,
            facilityId,
            uuid
        )
                VALUES(
            op_date,
            patient_id,
            diagnosis,
            surgery,
            surgeons,
            anesthetist,
            anesthetic,
            scrubNurse,
            remarks,
            p_name,
            pintsGiven,
            bloodLoss,
            intraOpAntibiotics,
            intraOpFindings,
            procedureNotes,
            pathologyRequest,
            postOpOrder,
            facId,
            uid
                );
    ELSEIF in_query_type = 'list by patient' THEN
        IF in_report_type = 'by_date' THEN
                SELECT * FROM operationnotes WHERE patientId=patient_id AND date(createdAt) = op_date AND facilityId = facId;
        END IF;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_pending_lab_tx`(IN `in_query_type` VARCHAR(50), IN `in_account` INT, IN `in_description` VARCHAR(100), IN `in_group_head` VARCHAR(20), IN `in_price` INT, IN `in_test` VARCHAR(20), IN `in_req_id` VARCHAR(50), IN `in_status` VARCHAR(10))
    NO SQL
IF in_query_type = 'new' THEN
	INSERT INTO pending_lab_txn (account, description,group_head,price,test,request_id,status) VALUES (in_account,in_description,in_group_head,in_price,in_test,in_req_id,in_status);
ELSEIF in_query_type='by_req' THEN
	SELECT account, description,test_group as group_head,price, test,request_id,status FROM lab_requisition WHERE request_id=in_req_id and price > 0;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_vitals`(IN `in_query_type` VARCHAR(20), IN `in_b_temp` VARCHAR(10), IN `in_pulse` VARCHAR(10), IN `in_b_p` VARCHAR(10), IN `in_resp_rate` VARCHAR(10), IN `in_fasting` VARCHAR(10), IN `in_random` VARCHAR(10), IN `in_user` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_patient_id` VARCHAR(50), IN `in_created_at` VARCHAR(20), IN `in_spo2` VARCHAR(50))
    NO SQL
IF in_query_type = 'new' THEN
        INSERT INTO vital_signs (body_temp, pulse_rate,  blood_pressure, respiratory_rate,
  fasting_blood_sugar, random_blood_sugar, created_by, facilityId, patient_id,created_at,spo2) VALUES (in_b_temp,in_pulse,in_b_p,in_resp_rate, in_fasting, in_random, in_user,in_facId, in_patient_id, in_created_at,in_spo2);
ELSEIF in_query_type = 'list by patient' THEN
        SELECT * FROM vital_signs WHERE patient_id=in_patient_id ORDER BY created_at DESC;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_transaction`(IN `in_description` VARCHAR(1000), IN `in_acct` INT, IN `service_amount` INT, IN `in_receiptDateSN` VARCHAR(50), IN `in_receiptSN` VARCHAR(50), IN `in_mode_of_payment` VARCHAR(20), IN `patientId` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `sourceAcct` VARCHAR(50), IN `userId` VARCHAR(50), IN `in_service_head` VARCHAR(50), IN `txnType` VARCHAR(10), IN `in_date` DATETIME, IN `in_payables_head` VARCHAR(50), IN `in_recievables_head` VARCHAR(50), IN `in_bank_name` VARCHAR(50), IN `in_txn_date` DATE, IN `in_discount` INT, IN `in_discount_head` VARCHAR(50), IN `_txn_status` VARCHAR(30), IN `amount_paid` INT, IN `services_list` VARCHAR(90))
BEGIN

    declare client_balance int;
    declare main_balance int;
    declare receivable int;
    DECLARE instant_balance int;
    DECLARE cash_amount int;
   
--    declare service_description varchar(200);
    select balance into client_balance  from patientfileno where accountNo=in_acct AND facilityId=in_facId;
    
    set cash_amount = service_amount - in_discount;
    set main_balance = client_balance-cash_amount;
    set receivable  = cash_amount-client_balance;
    set instant_balance = client_balance + cash_amount;
   
    
    IF txnType = 'insta' THEN
    
        -- update patientfileno set balance= instant_balance where accountNo=in_acct AND facilityId=in_facId;
        
     --   insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
        --    values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,patientId,_txn_status);
    
        insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

#insert into transactions 
#  (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
#                          client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
 #           values (in_description,'500011',0,service_amount,in_receiptDateSN,in_receiptSN,
  #                  in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);


            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,sourceAcct,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;
    
    ELSE

        -- IF the service amount is equal to the customer account balance (initial deposit amount)
        -- IF after the service amount is deducted, the client is still a debtor,

        if main_balance  > 0  then

            update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,patientId,_txn_status);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

# insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,
 #                         client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
  #          values (in_description,'500011',0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
  #                  userId,in_acct,patientId,in_facId,in_date,in_bank_name);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

        elseif main_balance < 0 then
            update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,patientId,_txn_status);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

#insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,
 #                         enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
  #          values (in_description,'500011',0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,
   #                 userId,in_acct,patientId,in_facId,in_date,in_bank_name);

            if client_balance = 0 then
            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

            -- IF client had some amount  in their deposit
        elseif client_balance > 0  then

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,abs(receivable),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;
            
        elseif client_balance < 0  then

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

            end if;
        elseif  main_balance = 0 then

            update patientfileno set balance= main_balance  where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date,patientId,_txn_status);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

#insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,
 #                         enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name)
  #          values (in_description,'500011',0,service_amount,in_receiptDateSN,in_receiptSN,
   #                 in_mode_of_payment,userId,in_acct,patientId,in_facId,in_dat,in_bank_name,in_txn_date);

            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
                insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

        -- IF the service amount is less the customer account balance
        end if;

    END IF;

    IF amount_paid > 0 THEN
            insert into transactions (description,acct,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,0,amount_paid,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
  insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt,client_id,txn_status)
   values (in_acct,amount_paid,0,in_receiptDateSN,in_description,in_facId,in_date,patientId,_txn_status);
 update patientfileno set balance= (client_balance + amount_paid ) where accountNo=in_acct AND facilityId=in_facId;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_transaction3`(IN `in_description` VARCHAR(1000), IN `in_acct` INT, IN `service_amount` INT, IN `in_receiptDateSN` VARCHAR(50), IN `in_receiptSN` VARCHAR(50), IN `in_mode_of_payment` VARCHAR(20), IN `patientId` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `sourceAcct` VARCHAR(50), IN `userId` VARCHAR(50), IN `in_service_head` VARCHAR(50), IN `txnType` VARCHAR(10), IN `in_date` DATETIME, IN `in_payables_head` VARCHAR(50), IN `in_recievables_head` VARCHAR(50), IN `in_bank_name` VARCHAR(50), IN `in_txn_date` DATE, IN `in_discount` INT, IN `in_discount_head` VARCHAR(50), IN `txn_status` VARCHAR(30), IN `in_payables_head_name` VARCHAR(150), IN `in_recievables_head_name` VARCHAR(150), IN `in_discount_head_name` VARCHAR(150), IN `sourceAcct_name` VARCHAR(150), IN `in_service_head_name` VARCHAR(150), IN `in_patient_name` VARCHAR(150))
BEGIN
	declare client_balance int;
	declare main_balance int;
    declare receivable int;
    DECLARE instant_balance int;
    DECLARE cash_amount int;
   
--    declare service_description varchar(200);
	select balance into client_balance  from patientfileno where accountNo=in_acct AND facilityId=in_facId;
	
    set cash_amount = service_amount - in_discount;
    set main_balance = client_balance-cash_amount;
    set receivable  = cash_amount-client_balance;
    set instant_balance = client_balance + cash_amount;
   
    
    IF txnType = 'insta' THEN
    
    	update patientfileno set balance= instant_balance where accountNo=in_acct AND facilityId=in_facId;
        
        insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date);
    
    	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,in_service_head_name,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

            insert into transactions3 (description,acct,acc_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,sourceAcct,sourceAcct_name,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head, in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;
    
    ELSE

        -- IF the service amount is equal to the customer account balance (initial deposit amount)
        -- IF after the service amount is deducted, the client is still a debtor,

        if main_balance  > 0  then

            update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date);

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,in_service_head_name,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head, in_payables_head_name,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,accName,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head, in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

        elseif main_balance < 0 then
            update patientfileno set balance= main_balance where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date);

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,in_service_head_name,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);


            if client_balance = 0 then
            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,in_recievables_head_name,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

            -- IF client had some amount in their deposit
        elseif client_balance > 0  then

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head,in_payables_head_name,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,in_recievables_head_name,abs(receivable),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;
            
        elseif client_balance < 0  then

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_recievables_head,in_recievables_head_name,abs(cash_amount),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

            end if;
        elseif  main_balance = 0 then

            update patientfileno set balance= main_balance  where accountNo=in_acct AND facilityId=in_facId;

            insert into account_entries (acct,dr,cr,reference_no,description,facilityId,createdAt)
            values (in_acct,0,service_amount,in_receiptDateSN,in_description,in_facId,in_date);

            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_service_head,in_service_head_name,0,service_amount,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);


            insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_payables_head,in_payables_head_name,abs(client_balance),0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            
            IF in_discount > 0 THEN
            	insert into transactions3 (description,acct,acct_name,debit,credit,receiptDateSN,receiptNo,modeOfPayment,enteredBy,client_acct,patient_id,facilityId,createdAt,bank_name,transaction_date)
            values (in_description,in_discount_head,in_discount_head_name,in_discount,0 ,in_receiptDateSN,in_receiptSN,in_mode_of_payment,userId,in_acct,patientId,in_facId,in_date,in_bank_name,in_txn_date);
            END IF;

        -- IF the service amount is less the customer account balance
        end if;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `surgeon`(IN `in_name` VARCHAR(100), IN `in_type` VARCHAR(100), IN `in_id` VARCHAR(11), IN `facId` VARCHAR(50), IN `query_type` VARCHAR(20))
    NO SQL
BEGIN
IF query_type = 'select' THEN
SELECT name, type, id FROM surgeons_list WHERE facilityId =facId;
ELSEIF query_type = 'by_type' THEN
SELECT name, type, id FROM surgeons_list WHERE type=in_type AND facilityId =facId;
ELSEIF  query_type = 'update' THEN
UPDATE surgeons_list SET name=in_name, type=in_type where id=in_id and facilityId =facId;
ELSEIF  query_type = 'delete' THEN
DELETE from surgeons_list WHERE id=in_id and facilityId =facId;
ELSEIF  query_type = 'select_one' THEN
SELECT * from surgeons_list WHERE id=in_id and facilityId =facId;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `surgical_note`(IN `in_template` VARCHAR(4324), IN `in_patient_name` VARCHAR(80), IN `in_relative` VARCHAR(80), IN `in_agreed` VARCHAR(10), IN `in_witness_by` VARCHAR(80), IN `in_patient_id` VARCHAR(15), IN `in_created_at` DATETIME, IN `in_created_by` VARCHAR(50), IN `facId` VARCHAR(50), IN `query_type` VARCHAR(20))
BEGIN
IF query_type = 'insert' then
INSERT INTO surgical_note_temp(template,facilityId) VALUES (in_template,facId);
ELSEIF query_type='select' THEN
SELECT template FROM surgical_note_temp WHERE facilityId=facId ORDER BY id DESC LIMIT 1;
ELSEIF query_type='insert_surgical_note' THEN
INSERT INTO `surgical_note`(`patient_name`, `relative`, `agreed`, `witness_by`, `patient_id`, `created_at`, `created_by`,facilityId) VALUES (in_patient_name,in_relative,in_agreed,in_witness_by,in_patient_id,in_created_at, in_created_by,facId);
ELSEIF query_type='select_surgical_note' THEN
SELECT * FROM surgical_note WHERE patient_id=in_patient_id AND facilityId=facId;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_dispensary`(IN `in_query_type` VARCHAR(50), IN `in_status` VARCHAR(50), IN `in_pr_id` VARCHAR(50))
    NO SQL
IF in_query_type = 'new schedule' THEN
	UPDATE dispensary SET schedule_status = 'scheduled' WHERE id = in_pr_id;
ELSE 
	UPDATE dispensary SET schedule_status = in_status WHERE id = in_pr_id;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lab_test`(IN `in_query_type` VARCHAR(50), IN `in_booking_no` VARCHAR(50), IN `in_test` VARCHAR(50), IN `in_request_id` VARCHAR(50), IN `in_patient_id` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_status` VARCHAR(100), IN `in_user_id` VARCHAR(50), IN `in_doc_name` VARCHAR(150), IN `in_doc_title` VARCHAR(30), IN `in_dept` VARCHAR(50), IN `in_appearance` VARCHAR(500), IN `in_serology` VARCHAR(500), IN `in_culture_yielded` VARCHAR(500), IN `in_result` VARCHAR(500), IN `in_sensitivity` VARCHAR(500), IN `in_resistivity` VARCHAR(500), IN `in_intermediaryTo` VARCHAR(500), IN `in_o_value` VARCHAR(10), IN `in_h_value` VARCHAR(10), IN `in_unit` VARCHAR(20), IN `in_range_from` VARCHAR(20), IN `in_range_to` VARCHAR(20))
    NO SQL
IF in_query_type = 'remove' THEN
UPDATE lab_requisition SET status='removed', approval_status='removed' WHERE booking_no = in_booking_no AND test=in_test AND request_id=in_request_id;
    COMMIT;
ELSEIF in_query_type = 'by_booking' THEN
UPDATE lab_requisition SET status=in_status WHERE booking_no=in_booking_no AND facilityId=in_facId;
    
ELSEIF in_query_type = 'result' THEN
UPDATE lab_requisition SET appearance=in_appearance, serology=in_serology, culture_yielded=in_culture_yielded, result=in_result, status=in_status, sensitivity=in_sensitivity, resistivity=in_resistivity, intermediaryTo=in_intermediaryTo,unit=in_unit, 
        range_from=in_range_from, range_to=in_range_to, analyzed_by=in_user_id, analyzed_at=now(), o_value=in_o_value, h_value=in_h_value WHERE booking_no=in_booking_no AND test=in_test AND facilityId=in_facId;
        COMMIT;
    
ELSEIF in_query_type = 'comment' THEN
UPDATE lab_requisition SET status="result", token=lab_requisition.code,  result_by=in_user_id, result_at=now(),
        doctor_fullname=in_doc_name, doctor_signation=in_doc_title
        WHERE booking_no=in_booking_no AND department=in_dept
      AND facilityId=in_facId;
      COMMIT;
END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_number_generator`(IN `in_query_type` VARCHAR(50), IN `in_number` INT(50))
    NO SQL
BEGIN
UPDATE number_generator set code_no =in_number WHERE prefix=in_query_type;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_prescription`(IN `in_schedule_id` VARCHAR(50), IN `in_served_by` VARCHAR(50), IN `in_facId` VARCHAR(50), IN `in_reason` VARCHAR(500), IN `in_query_type` VARCHAR(20))
    NO SQL
IF in_query_type = 'served' THEN
	UPDATE drug_schedule SET status=in_query_type, served_by=in_served_by WHERE id=in_schedule_id AND facilityId=in_facId; 
ELSEIF in_query_type = 'not served' THEN
	UPDATE drug_schedule SET status=in_query_type, served_by=in_served_by, reason=in_reason WHERE id=in_schedule_id AND facilityId=in_facId; 
ELSEIF in_query_type = 'stop' THEN
	UPDATE drug_schedule SET status = in_query_type, stopped_by=in_served_by WHERE prescription_id = in_schedule_id AND status='scheduled' AND facilityId=in_facId;
    CALL update_dispensary(in_query_type,in_query_type,in_schedule_id);

END IF$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(IN `in_accessTo` VARCHAR(255), IN `in_functionality` VARCHAR(2000), IN `in_id` INT, IN `in_facilityId` VARCHAR(50), IN `in_firstname` VARCHAR(50), IN `in_lastname` VARCHAR(50), IN `in_role` VARCHAR(50), IN `in_department` VARCHAR(50))
UPDATE users SET accessTo = in_accessTo,functionality = in_functionality, firstname=in_firstname, lastname=in_lastname, role=in_role,department=in_department WHERE id = in_id AND facilityId = in_facilityId$$
DELIMITER ;
