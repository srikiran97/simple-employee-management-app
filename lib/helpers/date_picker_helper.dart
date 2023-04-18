import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants.dart';
import '../widget/selectable_button.dart';
import 'helper.dart';

Future<DateTime?> getStartDatePicker(
  BuildContext context,
  DateTime initialSelectedDate,
) {
  bool todaySelected = initialSelectedDate == today,
      nextMondaySelected = false,
      nextTuesdaySelected = false,
      afterOneWeekSelected = false;
  final DateRangePickerController startDateController =
      DateRangePickerController();
  return showDialog<DateTime>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(true),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width * 0.90,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SelectableButton(
                                  selected: todaySelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    setState(() {
                                      todaySelected = true;
                                      nextMondaySelected = false;
                                      nextTuesdaySelected = false;
                                      afterOneWeekSelected = false;
                                    });
                                    startDateController.selectedDate = today;
                                  },
                                  child: const Text('Today'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: SelectableButton(
                                  selected: nextMondaySelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    setState(() {
                                      todaySelected = false;
                                      nextMondaySelected = true;
                                      nextTuesdaySelected = false;
                                      afterOneWeekSelected = false;
                                    });
                                    startDateController.selectedDate =
                                        startDateController.displayDate =
                                            today.add(Duration(
                                                days: (DateTime.monday -
                                                        today.weekday) %
                                                    7));
                                  },
                                  child: const Text(
                                    'Next Monday',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SelectableButton(
                                  selected: nextTuesdaySelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    setState(() {
                                      todaySelected = false;
                                      nextMondaySelected = false;
                                      nextTuesdaySelected = true;
                                      afterOneWeekSelected = false;
                                    });
                                    startDateController.selectedDate =
                                        startDateController.displayDate =
                                            today.add(Duration(
                                                days: (DateTime.tuesday -
                                                        today.weekday) %
                                                    7));
                                  },
                                  child: const Text('Next Tuesday'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: SelectableButton(
                                  selected: afterOneWeekSelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    setState(() {
                                      todaySelected = false;
                                      nextMondaySelected = false;
                                      nextTuesdaySelected = false;
                                      afterOneWeekSelected = true;
                                    });
                                    startDateController.selectedDate =
                                        startDateController.displayDate =
                                            today.add(const Duration(days: 7));
                                  },
                                  child: const Text(
                                    'After 1 week',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SfDateRangePicker(
                            initialDisplayDate: initialSelectedDate,
                            initialSelectedDate: initialSelectedDate,
                            headerHeight: 50,
                            backgroundColor: Colors.white,
                            controller: startDateController,
                            showNavigationArrow: true,
                            todayHighlightColor: Colors.transparent,
                            onSelectionChanged: (args) {
                              setState(() {
                                todaySelected = args.value == today;
                                nextMondaySelected = args.value ==
                                    today.add(Duration(
                                        days:
                                            (DateTime.monday - today.weekday) %
                                                7));
                                nextTuesdaySelected = args.value ==
                                    today.add(Duration(
                                        days:
                                            (DateTime.tuesday - today.weekday) %
                                                7));
                                afterOneWeekSelected = args.value ==
                                    today.add(const Duration(days: 7));
                              });
                            },
                            headerStyle: const DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                color: Color(0xFF323238),
                                fontFamily: defaultFontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                              textStyle: TextStyle(
                                color: Color(0xFF323238),
                                fontFamily: defaultFontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            monthViewSettings:
                                const DateRangePickerMonthViewSettings(
                                    viewHeaderStyle:
                                        DateRangePickerViewHeaderStyle(
                                      textStyle: TextStyle(
                                        color: Color(0xFF323238),
                                        fontFamily: defaultFontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    dayFormat: 'E'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE5E5E5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              SizedBox(
                                height: 23,
                                child: SvgPicture.asset(
                                    'assets/calendar_icon.svg'),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                startDateController.selectedDate != null
                                    ? startDateController.selectedDate == today
                                        ? 'Today'
                                        : getDateinDateFormat(
                                            startDateController.selectedDate!)
                                    : initialSelectedDate == today
                                        ? 'Today'
                                        : getDateinDateFormat(
                                            initialSelectedDate),
                              )
                            ],
                          )),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, initialSelectedDate);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFEDF8FF)),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    startDateController.selectedDate ??
                                        initialSelectedDate);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white),
                              child: const Text('Save'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      );
    },
  );
}

Future<DateTime?> getEndDatePicker(
  BuildContext context,
  DateTime startDate,
  DateTime? initialSelectedDate,
) {
  final DateRangePickerController endDateController =
      DateRangePickerController();
  bool noDateSelected = initialSelectedDate != null ? false : true,
      todaySelected = false;
  return showDialog<DateTime>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.585,
              width: MediaQuery.of(context).size.width * 0.90,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SelectableButton(
                                  selected: noDateSelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    noDateSelected = true;
                                    todaySelected = false;
                                    setState(() {});
                                    endDateController.selectedDate = null;
                                  },
                                  child: const Text('No date'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: SelectableButton(
                                  selected: todaySelected,
                                  style: getTextButtonStyle(),
                                  onPressed: () {
                                    noDateSelected = false;
                                    todaySelected = true;
                                    setState(() {});
                                    endDateController.selectedDate =
                                        endDateController.displayDate =
                                            DateTime.now();
                                  },
                                  child: const Text(
                                    'Today',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SfDateRangePicker(
                            initialDisplayDate: initialSelectedDate,
                            initialSelectedDate: initialSelectedDate,
                            headerHeight: 50,
                            backgroundColor: Colors.white,
                            controller: endDateController,
                            minDate: startDate,
                            showNavigationArrow: true,
                            onSelectionChanged: (args) {
                              noDateSelected = args.value == null;
                              todaySelected = args.value == today;
                              setState(() {});
                            },
                            todayHighlightColor: Colors.transparent,
                            headerStyle: const DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                color: Color(0xFF323238),
                                fontFamily: defaultFontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                              textStyle: TextStyle(
                                color: Color(0xFF323238),
                                fontFamily: defaultFontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              disabledDatesTextStyle: TextStyle(
                                color: Color(0xFFE5E5E5),
                                fontFamily: defaultFontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            monthViewSettings:
                                const DateRangePickerMonthViewSettings(
                                    viewHeaderStyle:
                                        DateRangePickerViewHeaderStyle(
                                      textStyle: TextStyle(
                                        color: Color(0xFF323238),
                                        fontFamily: defaultFontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    dayFormat: 'E'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE5E5E5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              SizedBox(
                                height: 23,
                                child: SvgPicture.asset(
                                    'assets/calendar_icon.svg'),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(endDateController.selectedDate != null
                                  ? getDateinDateFormat(
                                      endDateController.selectedDate!)
                                  : 'No date')
                            ],
                          )),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, initialSelectedDate);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFEDF8FF)),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context, endDateController.selectedDate);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white),
                              child: const Text('Save'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      );
    },
  );
}
