import 'package:greycell_app/src/manager/authManger.dart';
import 'package:greycell_app/src/models/analysis/available_term.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:greycell_app/src/models/calendar/academic_events.dart';
import 'package:greycell_app/src/models/coreModel/package_info.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/models/school/school.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';
import 'package:greycell_app/src/models/user/user.dart';
import 'package:greycell_app/src/services/authService/school_service.dart';
import 'package:greycell_app/src/services/tokenService/token_service.dart';
import 'package:scoped_model/scoped_model.dart';

mixin DataManager on Model {
  bool isLoading = false;
  bool? isLoggedIn = false;

  late GCPackageInfo gCPackageInfo;

  late SchoolService _schoolService;

  SchoolService get schoolService => _schoolService;

//  AuthService authService;

  DataFilter? _dataFilter;

  DataFilter get dataFilter =>
      _dataFilter == null ? DataFilter() : _dataFilter!;

  Authentication? _authentication;

  Authentication get authentication =>
      _authentication == null ? Authentication() : _authentication!;

  School? school;
  User? user;
  Student? student;
  late Staff staff;

//**********************************//
  // Analysis Data
  late List<AvailableSession> availableSessionList;
  List<Exam>? examList;
  List<SubjectMark>? subjectMarkList;
  int currentExamIndex = 0;
  int currentSessionIndex = 0;

  // *******************************//
  // Academic Calendar
  Map<DateTime?, List<AcademicEvent>> calendarEventList = {};
  List<AcademicEvent> originalEventList = [];

  /// Calendar Actions
  late DateTime selectedCalendarDate;
  late List<AcademicEvent> selectedCalendarEvents;
  int currentBottomNavigationIndex = 0;

  // Payment Module
  List<PayableFee> selectedPayableFees = <PayableFee>[];
  double totalPayableAmount = 0.0;

  // When User Tap One Of Abailable Gateway SUch As PayU
  List? selectedGateway;
}

mixin DataHandler on Model, DataManager {
  // Payment Module Handler
  void addPayableFee(PayableFee selectedFee) {
    selectedPayableFees.add(selectedFee);
    _updatePayableAmount();
    notifyListeners();
//    if (shouldAddPayment(selectedFee.id)) {
//      removePayableFee(selectedFee);
//    } else {
//      selectedPayableFees.add(selectedFee);
//      _updatePayableAmount();
//      notifyListeners();
//    }
  }

  void _updatePayableAmount() {
    print("Called Upate");
    totalPayableAmount = 0.0;
    selectedPayableFees.forEach((element) {
      totalPayableAmount += element.netPayAbleAmount!;
    });
  }

  void editPayableAmount(int id, PayableFee fee) {
    print("Fee Amount: ${fee.netPayAbleAmount}");
    if (shouldAddPayment(fee.id)) {
      // Item is in List
      // Find and Update
      selectedPayableFees.forEach((element) {
        if (element.id == fee.id) {
          element.netPayAbleAmount = fee.netPayAbleAmount;
        }
        print("Updated Price: ${element.netPayAbleAmount}");
      });
      _updatePayableAmount();
      notifyListeners();
    } else {
      // Item Is not in List
      // Simply Add to new one
      addPayableFee(fee);
    }
  }

  void clearSelectedPayable() {
    selectedPayableFees.clear();
    notifyListeners();
  }

  void removePayableFee(PayableFee fee) {
    print("Id: ${fee.id}");
    selectedPayableFees.removeWhere((element) => element.id == fee.id);
    _updatePayableAmount();
    notifyListeners();
  }

  bool shouldAddPayment(int? payId) =>
      selectedPayableFees.any((element) => element.id == payId);

  void bottomNavigationIndexChanger(int index) {
    currentBottomNavigationIndex = index;
    notifyListeners();
  }

  // Analysis Action
  void onExamChanged(int index) {
    currentExamIndex = index;
    notifyListeners();
  }

  void onSessionChanged(int index) {
    print("Index: $index");
    currentSessionIndex = index;
    notifyListeners();
  }

//  DateTime keepFirstDateSafe;
//  DateTime keepEndDateSafe;
  void onDateChange(DateTime dateTime, List events) {
    selectedCalendarDate = dateTime;
    if (events.length != 0) {
      selectedCalendarEvents = events as List<AcademicEvent>;
    } else {
      selectedCalendarEvents = [];
    }
    print(selectedCalendarEvents.length);
    notifyListeners();
  }

  void onMonthChanged(
    DateTime first,
  ) {
    int month = first.month;
    final test = originalEventList.where((e) => e.dateTime!.month == month);
//    keepFirstDateSafe = first;
//    keepEndDateSafe = last;
    selectedCalendarEvents = List.from(test);
    notifyListeners();
  }

  void onResetToDefault() {
    selectedCalendarEvents = List.from(originalEventList);
    notifyListeners();
  }
}
