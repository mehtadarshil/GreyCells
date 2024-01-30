class ApiAuth {
  static final String KSPLID = "kspl_123";

  // LOGIN APICODE AND CALLBACK
  static final String LOGIN_API_CODE = 'LOG_IN';
  static final String LOGIN_CALLBACKS = 'logInCall';

  // SCHOOL APICODE AND CALLBACK
  static final String SCHOOL_VERIFY_API_CODE = 'CLIENT_VALIDATE';
  static final String SCHOOL_VERIFY_CALLBACKS = 'clientList';

  // STUDENT PROFILE INFO
  static final String STUDENT_INFO_API_CODE = 'STUDENT_INFO';
  static final String STUDENT_INFO_CALLBACKS = 'studentInfo';

  // STUDENT PROFILE INFO
  static final String ATTENDANCE_API_CODE = 'MY_ATTND';
  static final String ATTENDANCE_CALLBACKS = 'logInCall';

  // AVAILABLE SESSION
  static final String AVAILABLE_SESSION_API_CODE = 'AVAILABLE_TERM';
  static final String AVAILABLE_SESSION_CALLBACKS = 'myAvailTermCall';

  // TERM_WISE_EXAMS
  static final String EXAM_API_CODE = 'TERMWISE_STDNEXAMS';
  static final String EXAM_CALLBACKS = 'myAvailTermCall';

  // SUBJECT_MARKS
  static final String MARK_API_CODE = 'TERMEXAMWISE_STDNMARKS';
  static final String MARK_CALLBACKS = 'myAvailTermCall';

  // ACADEMIC EVENTS
  static final String ACADEMIC_CALENDAR_API_CODE = 'CLS_ACDMC_CALENDAR';
  static final String ACADEMIC_CALENDAR_CALLBACKS = 'classAcdmcCalendar';

  // ACADEMIC NOTICES
  static final String NOTICE_API_CODE = 'VIEW_NOTICE';
  static final String NOTICE_CALLBACKS = 'viewNoticeCall';

  // CLIENT ADDRESS
  static final String CONTACT_API_CODE = 'CLIENT_ADDRESS';
  static final String CONTACT_CALLBACKS = 'clientAddress';

  // ACCOUNT DUE
  static final String ACCOUNT_DUE_API_CODE = 'ONLINE_PAY_DUE_LIST';
  static final String ACCOUNT_DUE_CALLBACKS = 'onlineDueDetail';

  // COURSE
  static final String COURSE_API_CODE = 'MY_SUBJECT';
  static final String COURSE_CALLBACKS = 'mySubject';
  static final String STDN_TIMETABLE_DTLS = "STDN_TIMETABLE_DTLS";

  // PayMessage
  static final String PAY_MESSAGE_API_CODE = 'ONLINE_PAY_MSG';
  static final String ONLINE_PAY_RPT = "ONLINE_PAY_RPT";
  static final String PAY_MESSAGE_CALLBACKS = 'onlinePayMessage';
  static final String STDNPAYMENT_DETAILS_LIST = "STDNPAYMENT_DETAILS_LIST";
  static final String STDNFEE_RECEIPT_REPORT = "STDNFEE_RECEIPT_REPORT";

  // Faculty / Staff
  static final String STAFF_PPROFILE_API_CODE = 'STAFF_INFO';
  static final String STAFF_PPROFILE_CALLBACKS = 'staffInformation';

  // Faculty TimeTable
  static final String STAFF_TIMETABLE_API_CODE = 'STAFF_TIMETABLE';
  static final String STAFF_TIMETABLE_CALLBACKS = 'StaffTimeTable';

  // Menu List
  static final String MENU_LIST_API_CODE = 'MY_MENULIST';
  static final String MENU_LIST_CALLBACKS = 'myMenusList';

  // Attendance My School Scheme Entry
  static final String ATTENDANCE_ENTRY_API_CODE = 'STUD_ATTND_SAVE';
  static final String ATTENDANCE_ENTRY_SCHOOL_SCHEME_CALLBACKS =
      'mySchoolSchemeDtl';

  // Attendance My School Entry
  static final String ATTENDANCE_ENTRY_SCHOOL_CALLBACKS = 'mySchoolDtl';

  // Attendance Criteria
  static final String ATTENDANCE_ENTRY_CRITERIA_CALLBACKS = 'attndCriteria';

  // Attendance Student List
  static final String ATTENDANCE_ENTRY_STUDLIST_CALLBACKS = 'studentListDtl';

  // Attendance Student List
  static final String ATTENDANCE_ENTRY_STATUS_CALLBACKS =
      'attendStatusListVector';

  // Attendance Student List
  static final String ATTENDANCE_ENTRY_SAVE_CALLBACKS = 'attendSave';

  // AVAILABLE_EXAMRPT_TERM
  static final String AVAILABLE_EXAMRPT_TERM_API_CODE =
      'AVAILABLE_EXAMRPT_TERM';
  static final String AVAILABLE_EXAMRPT_TERM_CALLBACKS = 'myAvailExamRptTerm';

  // MY_EXAMREPORTLIST
  static final String MY_EXAMREPORTLIST_API_CODE = 'MY_EXAMREPORTLIST';
  static final String MY_EXAMREPORTLIST_CALLBACKS = 'myExamReportsList';

  // MY_EXAMREPORT
  static final String MY_EXAMREPORT_API_CODE = 'MY_EXAMREPORT';
  static final String MY_EXAMREPORT_CALLBACKS = 'myReportCardDtl';

  // STAFF_LEAVE_BALANCE
  static final String STAFF_LEAVE_BALANCE_API_CODE = 'STAFF_LEAVE_BALANCE';
  static final String STAFF_LEAVE_BALANCE_CALLBACKS = 'StaffLeaveBalance';
}

class RestAPIs {
  // static final String _GREYCELL_SERVER_URL = "http://103.139.89.125";
  static final String _GREYCELL_SERVER_URL = "http://erp.vordurja.in";

  // WebView
  static final String WEB_VIEW_URL =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/api_folder/index.html";
//old = GSLRestAPI
  // App
  static final String KSPL_LOGO_URL =
      "$_GREYCELL_SERVER_URL/images/logos/KSPL.jpg";
  static final String GREYCELL_SCHOOL_VALIDATE_URL =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/1/getAPIClientList";
  static final String GREYCELL_TOKEN_URL =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/1/GetAPPSToken";

  static final String GREYCELL_REPORT_URL =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/reports/";

  // Dynamic Srver EndPoints
  static final String LOGIN_URL = "/1/LoginAPI";
  static final String TOKEN_URL = "/1/GetAPPSToken";
  static final String PROFILE_URL = "/1/APIgetStudDtl";
  static final String STAFF_PROFILE_URL = "/1/APIgetStaffDtl";
  static final String ATTENDANCE_URL = "/1/APIStudMyAttndDtl";
  static final String MENU_LIST_URL = "/1/APIStdnMenusList";
  static final String ATTENDANCE_ENTRY_SCHOOL_SCHEME_URL =
      "/1/APIGetSchoolSchemeAttendance";
  static final String ATTENDANCE_ENTRY_SCHOOL_URL =
      "/1/APIGetSchoolDtlAttendance";
  static final String ATTENDANCE_ENTRY_CRITERIA_URL =
      "/1/APIGetAttendanceCriteria";
  static final String ATTENDANCE_ENTRY_STUDLIST_URL =
      "/1/APIGetStdnListForAttendance";
  static final String ATTENDANCE_ENTRY_STATUS_URL =
      "/1/APIGetAttendanceStatusVector";
  static final String ATTENDANCE_ENTRY_SAVE_URL =
      "/1/APIGetAttendanceAddUpdate";
  static final String SESSION_URL = "/1/APIGetMyTermList";
  static final String AVAILABLE_EXAMRPT_TERM_URL = "/1/APIGetMyExamRptTermList";
  static final String MY_EXAMREPORTLIST_URL = "/1/APIStudExamReportsList";
  static final String MY_EXAMREPORT_URL = "/1/APIStudReportCardDtl";

  static final String EXAM_URL = "/1/APIGetMyTermwiseExam";
  static final String MARK_URL = "/1/APIGetMyTermExamwiseMark";
  static final String ACADEMIC_CALENDAR_URL = "/1/getAPIClassAcdmcCal";
  static final String NOTICE_URL = "/1/APIViewNoticeList";
  static final String CONTACT_URL = "/1/getAPIClientAddress";
  static final String ACCOUNT_DUE_URL = "/1/APIStudPayDueDtl";
  static final String COURSE_URL = "/1/APIStudMySubjectDtl";
  static final String APIStudTimeTableDtl = "/1/APIStudTimeTableDtl";
  static final String PAY_MESSAGE_URL = "/1/APIStudPayMessageTransNo";
  static final String Receipt_Url =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/1/APIStudOnlinePayReport";
  static final String Receipt_List_Url =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/1/APIStudPaymentDtlList";
  static final String Fee_Receipt_To_View =
      "$_GREYCELL_SERVER_URL/IITBRestAPI/1/APIStudFeeReceiptToView";
  static final String STAFF_TIMETABLE_URL = "/1/APIgetStaffTimeTbl";
  static final String SCHOOL_LOGO_URL = "/images/logos/Logo.jpg";
  static final String STAFF_LEAVE_BALANCE_URL = "/1/APIgetStaffLeaveBlnc";
}

enum ResponseStatus { INITIAL, SUCCESS, FAILURE, ERROR }
