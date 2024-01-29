import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/services/accountService/account_service.dart';
import 'package:greycell_app/src/services/analysisService/analysis_service.dart';
import 'package:greycell_app/src/services/attendanceService/attendance_service.dart';
import 'package:greycell_app/src/services/authService/auth_service.dart';
import 'package:greycell_app/src/services/authService/school_service.dart';
import 'package:greycell_app/src/services/courseService/course_service.dart';
import 'package:greycell_app/src/services/eventsService/event_calendar_service.dart';
import 'package:greycell_app/src/services/examService/exam_service.dart';
import 'package:greycell_app/src/services/generalViews/general_service.dart';
import 'package:greycell_app/src/services/leaveBalanceService/leave_balance_service.dart';
import 'package:greycell_app/src/services/noticeService/notice_service.dart';
import 'package:greycell_app/src/services/staffService/staff_service.dart';
import 'package:greycell_app/src/services/studentService/student_service.dart';
import 'package:greycell_app/src/services/timeTableService/timeTable.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with
        DataManager,
        DataHandler,
        SchoolService,
        AuthService,
        AnalysisService,
        StudentService,
        AttendanceService,
        ExamService,
        LeaveBalanceService,
        NoticeService,
        CalendarService,
        AccountService,
        CourseService,
        GeneralService,
        StaffService,
        TimeTableService {}
