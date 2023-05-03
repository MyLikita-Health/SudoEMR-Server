var DataTypes = require("sequelize").DataTypes;
var _account = require("./account");
var _account2 = require("./account2");
var _account4 = require("./account4");
var _account_asym_old = require("./account_asym_old");
var _account_entries = require("./account_entries");
var _account_opt = require("./account_opt");
var _account_type = require("./account_type");
var _account_ubec = require("./account_ubec");
var _appconfig = require("./appconfig");
var _appointment = require("./appointment");
var _asset_schedule = require("./asset_schedule");
var _assignpatient = require("./assignpatient");
var _audit_trail = require("./audit_trail");
var _barcode = require("./barcode");
var _bed_allocation = require("./bed_allocation");
var _bedlist = require("./bedlist");
var _beds = require("./beds");
var _booking_no = require("./booking_no");
var _branches = require("./branches");
var _bulk_tx = require("./bulk_tx");
var _charges_fees = require("./charges_fees");
var _charges_fees_temp = require("./charges_fees_temp");
var _chartofaccount = require("./chartofaccount");
var _comment = require("./comment");
var _consultations = require("./consultations");
var _contacts = require("./contacts");
var _daily_register = require("./daily_register");
var _department = require("./department");
var _diagnosis = require("./diagnosis");
var _dieselrefuel = require("./dieselrefuel");
var _dieselusage = require("./dieselusage");
var _discount = require("./discount");
var _dispensary = require("./dispensary");
var _doctor_entries = require("./doctor_entries");
var _drug_frequency = require("./drug_frequency");
var _drug_frequency4 = require("./drug_frequency4");
var _drug_frequency4_x = require("./drug_frequency4_x");
var _drug_frequency4_y = require("./drug_frequency4_y");
var _drug_schedule = require("./drug_schedule");
var _druglist = require("./druglist");
var _drugpurchaserecords = require("./drugpurchaserecords");
var _drugs = require("./drugs");
var _feedbacks = require("./feedbacks");
var _fluid_chart = require("./fluid_chart");
var _group_service = require("./group_service");
var _hospitals = require("./hospitals");
var _hour_list = require("./hour_list");
var _hour_list_x = require("./hour_list_x");
var _lab = require("./lab");
var _lab_codes = require("./lab_codes");
var _lab_inventory_table = require("./lab_inventory_table");
var _lab_numbers = require("./lab_numbers");
var _lab_process_selected = require("./lab_process_selected");
var _lab_requisition = require("./lab_requisition");
var _lab_requisition_no_pid = require("./lab_requisition_no_pid");
var _lab_requisition_sub = require("./lab_requisition_sub");
var _lab_setup = require("./lab_setup");
var _lab_setup2 = require("./lab_setup2");
var _lab_setup3 = require("./lab_setup3");
var _lab_setup4 = require("./lab_setup4");
var _labservices = require("./labservices");
var _main_account = require("./main_account");
var _members = require("./members");
var _monthly_register = require("./monthly_register");
var _number_generator = require("./number_generator");
var _nursing_note = require("./nursing_note");
var _nursing_report = require("./nursing_report");
var _operationnotes = require("./operationnotes");
var _pagenavigation = require("./pagenavigation");
var _patient_history = require("./patient_history");
var _patientfileinfo = require("./patientfileinfo");
var _patientfileno = require("./patientfileno");
var _patientfileno2 = require("./patientfileno2");
var _patientfileno_test = require("./patientfileno_test");
var _patientrecords = require("./patientrecords");
var _pending_lab_txn = require("./pending_lab_txn");
var _pharm_branches = require("./pharm_branches");
var _pharm_store = require("./pharm_store");
var _pharm_store_entries = require("./pharm_store_entries");
var _prescriptionrequests = require("./prescriptionrequests");
var _previous_doc = require("./previous_doc");
var _prime_old_lab = require("./prime_old_lab");
var _referrals = require("./referrals");
var _repairlogs = require("./repairlogs");
var _report_templates = require("./report_templates");
var _sensitivity_list = require("./sensitivity_list");
var _sensitivity_results = require("./sensitivity_results");
var _servicelogs = require("./servicelogs");
var _services = require("./services");
var _specimen = require("./specimen");
var _staff = require("./staff");
var _supplier_entries = require("./supplier_entries");
var _suppliersinfo = require("./suppliersinfo");
var _surgeons_list = require("./surgeons_list");
var _surgical_note = require("./surgical_note");
var _surgical_note_temp = require("./surgical_note_temp");
var _t_patientr = require("./t_patientr");
var _test = require("./test");
var _transaction_backup = require("./transaction_backup");
var _transaction_entries = require("./transaction_entries");
var _transactions = require("./transactions");
var _transactions3 = require("./transactions3");
var _transactionsetup = require("./transactionsetup");
var _transfers = require("./transfers");
var _users = require("./users");
var _vital_signs = require("./vital_signs");
var _voucher = require("./voucher");
var _wholesale_transaction = require("./wholesale_transaction");

function initModels(sequelize) {
  var account = _account(sequelize, DataTypes);
  var account2 = _account2(sequelize, DataTypes);
  var account4 = _account4(sequelize, DataTypes);
  var account_asym_old = _account_asym_old(sequelize, DataTypes);
  var account_entries = _account_entries(sequelize, DataTypes);
  var account_opt = _account_opt(sequelize, DataTypes);
  var account_type = _account_type(sequelize, DataTypes);
  var account_ubec = _account_ubec(sequelize, DataTypes);
  var appconfig = _appconfig(sequelize, DataTypes);
  var appointment = _appointment(sequelize, DataTypes);
  var asset_schedule = _asset_schedule(sequelize, DataTypes);
  var assignpatient = _assignpatient(sequelize, DataTypes);
  var audit_trail = _audit_trail(sequelize, DataTypes);
  var barcode = _barcode(sequelize, DataTypes);
  var bed_allocation = _bed_allocation(sequelize, DataTypes);
  var bedlist = _bedlist(sequelize, DataTypes);
  var beds = _beds(sequelize, DataTypes);
  var booking_no = _booking_no(sequelize, DataTypes);
  var branches = _branches(sequelize, DataTypes);
  var bulk_tx = _bulk_tx(sequelize, DataTypes);
  var charges_fees = _charges_fees(sequelize, DataTypes);
  var charges_fees_temp = _charges_fees_temp(sequelize, DataTypes);
  var chartofaccount = _chartofaccount(sequelize, DataTypes);
  var comment = _comment(sequelize, DataTypes);
  var consultations = _consultations(sequelize, DataTypes);
  var contacts = _contacts(sequelize, DataTypes);
  var daily_register = _daily_register(sequelize, DataTypes);
  var department = _department(sequelize, DataTypes);
  var diagnosis = _diagnosis(sequelize, DataTypes);
  var dieselrefuel = _dieselrefuel(sequelize, DataTypes);
  var dieselusage = _dieselusage(sequelize, DataTypes);
  var discount = _discount(sequelize, DataTypes);
  var dispensary = _dispensary(sequelize, DataTypes);
  var doctor_entries = _doctor_entries(sequelize, DataTypes);
  var drug_frequency = _drug_frequency(sequelize, DataTypes);
  var drug_frequency4 = _drug_frequency4(sequelize, DataTypes);
  var drug_frequency4_x = _drug_frequency4_x(sequelize, DataTypes);
  var drug_frequency4_y = _drug_frequency4_y(sequelize, DataTypes);
  var drug_schedule = _drug_schedule(sequelize, DataTypes);
  var druglist = _druglist(sequelize, DataTypes);
  var drugpurchaserecords = _drugpurchaserecords(sequelize, DataTypes);
  var drugs = _drugs(sequelize, DataTypes);
  var feedbacks = _feedbacks(sequelize, DataTypes);
  var fluid_chart = _fluid_chart(sequelize, DataTypes);
  var group_service = _group_service(sequelize, DataTypes);
  var hospitals = _hospitals(sequelize, DataTypes);
  var hour_list = _hour_list(sequelize, DataTypes);
  var hour_list_x = _hour_list_x(sequelize, DataTypes);
  var lab = _lab(sequelize, DataTypes);
  var lab_codes = _lab_codes(sequelize, DataTypes);
  var lab_inventory_table = _lab_inventory_table(sequelize, DataTypes);
  var lab_numbers = _lab_numbers(sequelize, DataTypes);
  var lab_process_selected = _lab_process_selected(sequelize, DataTypes);
  var lab_requisition = _lab_requisition(sequelize, DataTypes);
  var lab_requisition_no_pid = _lab_requisition_no_pid(sequelize, DataTypes);
  var lab_requisition_sub = _lab_requisition_sub(sequelize, DataTypes);
  var lab_setup = _lab_setup(sequelize, DataTypes);
  var lab_setup2 = _lab_setup2(sequelize, DataTypes);
  var lab_setup3 = _lab_setup3(sequelize, DataTypes);
  var lab_setup4 = _lab_setup4(sequelize, DataTypes);
  var labservices = _labservices(sequelize, DataTypes);
  var main_account = _main_account(sequelize, DataTypes);
  var members = _members(sequelize, DataTypes);
  var monthly_register = _monthly_register(sequelize, DataTypes);
  var number_generator = _number_generator(sequelize, DataTypes);
  var nursing_note = _nursing_note(sequelize, DataTypes);
  var nursing_report = _nursing_report(sequelize, DataTypes);
  var operationnotes = _operationnotes(sequelize, DataTypes);
  var pagenavigation = _pagenavigation(sequelize, DataTypes);
  var patient_history = _patient_history(sequelize, DataTypes);
  var patientfileinfo = _patientfileinfo(sequelize, DataTypes);
  var patientfileno = _patientfileno(sequelize, DataTypes);
  var patientfileno2 = _patientfileno2(sequelize, DataTypes);
  var patientfileno_test = _patientfileno_test(sequelize, DataTypes);
  var patientrecords = _patientrecords(sequelize, DataTypes);
  var pending_lab_txn = _pending_lab_txn(sequelize, DataTypes);
  var pharm_branches = _pharm_branches(sequelize, DataTypes);
  var pharm_store = _pharm_store(sequelize, DataTypes);
  var pharm_store_entries = _pharm_store_entries(sequelize, DataTypes);
  var prescriptionrequests = _prescriptionrequests(sequelize, DataTypes);
  var previous_doc = _previous_doc(sequelize, DataTypes);
  var prime_old_lab = _prime_old_lab(sequelize, DataTypes);
  var referrals = _referrals(sequelize, DataTypes);
  var repairlogs = _repairlogs(sequelize, DataTypes);
  var report_templates = _report_templates(sequelize, DataTypes);
  var sensitivity_list = _sensitivity_list(sequelize, DataTypes);
  var sensitivity_results = _sensitivity_results(sequelize, DataTypes);
  var servicelogs = _servicelogs(sequelize, DataTypes);
  var services = _services(sequelize, DataTypes);
  var specimen = _specimen(sequelize, DataTypes);
  var staff = _staff(sequelize, DataTypes);
  var supplier_entries = _supplier_entries(sequelize, DataTypes);
  var suppliersinfo = _suppliersinfo(sequelize, DataTypes);
  var surgeons_list = _surgeons_list(sequelize, DataTypes);
  var surgical_note = _surgical_note(sequelize, DataTypes);
  var surgical_note_temp = _surgical_note_temp(sequelize, DataTypes);
  var t_patientr = _t_patientr(sequelize, DataTypes);
  var test = _test(sequelize, DataTypes);
  var transaction_backup = _transaction_backup(sequelize, DataTypes);
  var transaction_entries = _transaction_entries(sequelize, DataTypes);
  var transactions = _transactions(sequelize, DataTypes);
  var transactions3 = _transactions3(sequelize, DataTypes);
  var transactionsetup = _transactionsetup(sequelize, DataTypes);
  var transfers = _transfers(sequelize, DataTypes);
  var users = _users(sequelize, DataTypes);
  var vital_signs = _vital_signs(sequelize, DataTypes);
  var voucher = _voucher(sequelize, DataTypes);
  var wholesale_transaction = _wholesale_transaction(sequelize, DataTypes);


  return {
    account,
    account2,
    account4,
    account_asym_old,
    account_entries,
    account_opt,
    account_type,
    account_ubec,
    appconfig,
    appointment,
    asset_schedule,
    assignpatient,
    audit_trail,
    barcode,
    bed_allocation,
    bedlist,
    beds,
    booking_no,
    branches,
    bulk_tx,
    charges_fees,
    charges_fees_temp,
    chartofaccount,
    comment,
    consultations,
    contacts,
    daily_register,
    department,
    diagnosis,
    dieselrefuel,
    dieselusage,
    discount,
    dispensary,
    doctor_entries,
    drug_frequency,
    drug_frequency4,
    drug_frequency4_x,
    drug_frequency4_y,
    drug_schedule,
    druglist,
    drugpurchaserecords,
    drugs,
    feedbacks,
    fluid_chart,
    group_service,
    hospitals,
    hour_list,
    hour_list_x,
    lab,
    lab_codes,
    lab_inventory_table,
    lab_numbers,
    lab_process_selected,
    lab_requisition,
    lab_requisition_no_pid,
    lab_requisition_sub,
    lab_setup,
    lab_setup2,
    lab_setup3,
    lab_setup4,
    labservices,
    main_account,
    members,
    monthly_register,
    number_generator,
    nursing_note,
    nursing_report,
    operationnotes,
    pagenavigation,
    patient_history,
    patientfileinfo,
    patientfileno,
    patientfileno2,
    patientfileno_test,
    patientrecords,
    pending_lab_txn,
    pharm_branches,
    pharm_store,
    pharm_store_entries,
    prescriptionrequests,
    previous_doc,
    prime_old_lab,
    referrals,
    repairlogs,
    report_templates,
    sensitivity_list,
    sensitivity_results,
    servicelogs,
    services,
    specimen,
    staff,
    supplier_entries,
    suppliersinfo,
    surgeons_list,
    surgical_note,
    surgical_note_temp,
    t_patientr,
    test,
    transaction_backup,
    transaction_entries,
    transactions,
    transactions3,
    transactionsetup,
    transfers,
    users,
    vital_signs,
    voucher,
    wholesale_transaction,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
