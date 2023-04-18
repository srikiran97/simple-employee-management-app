import 'package:employee_management/blocs/employee_list_bloc/employee_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../helpers/bottom_sheet_helper.dart';
import '../helpers/date_picker_helper.dart';
import '../helpers/helper.dart';

class AddEmployeeDetails extends StatefulWidget {
  const AddEmployeeDetails({super.key});

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  late final TextEditingController _textController;
  late String _selectedRole;
  late String startDate;
  late String endDate;
  final List<String> employeeRoles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _selectedRole = '';
    startDate = 'Today';
    endDate = 'No date';
  }

  @override
  void dispose() {
    _textController.dispose();
    _selectedRole = '';
    startDate = 'Today';
    endDate = 'No date';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee Details'),
            automaticallyImplyLeading: false,
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: getBottomInsets(context)),
            child: Container(
              height: 64,
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(width: 2, color: Color(0xFFF2F2F2)),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFEDF8FF)),
                      child: const Text('Cancel'),
                    ),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty &&
                            _selectedRole.isNotEmpty &&
                            startDate.isNotEmpty) {
                          context.read<EmployeeListBloc>().add(
                              AddEmployeeDetailsEvent(
                                  employeeName: _textController.text,
                                  employeeRole: _selectedRole,
                                  startDate: startDate == 'Today'
                                      ? getDateinDateFormat(DateTime.now())
                                      : startDate,
                                  endDate:
                                      endDate == 'No date' ? null : endDate));
                          Navigator.of(context).pop();
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white),
                      child: const Text('Save'),
                    ),
                  ))
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _textController,
                    style: fieldTextStyle,
                    decoration: InputDecoration(
                        hintText: 'Employee Name',
                        hintStyle: fieldTextStyle.copyWith(
                            color: const Color(0xFF949C9E)),
                        contentPadding:
                            const EdgeInsets.only(top: 10, bottom: 10),
                        focusedBorder: fieldBorder,
                        enabledBorder: fieldBorder,
                        prefixIconColor: Theme.of(context).primaryColor,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                        )),
                  ),
                ),
                const SizedBox(height: 23),
                StatefulBuilder(builder: (context, setState) {
                  return SizedBox(
                    height: 40,
                    child: TextField(
                      readOnly: true,
                      controller: _selectedRole != ''
                          ? TextEditingController(text: _selectedRole)
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Select role',
                        hintStyle: fieldTextStyle.copyWith(
                            color: const Color(0xFF949C9E)),
                        contentPadding:
                            const EdgeInsets.only(top: 10, bottom: 10),
                        prefixIconColor: Theme.of(context).primaryColor,
                        prefixIcon: const Icon(Icons.work_outline),
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 38,
                        ),
                        enabledBorder: fieldBorder,
                        focusedBorder: fieldBorder,
                      ),
                      style: fieldTextStyle,
                      onTap: () async {
                        _selectedRole =
                            await showModal(context, employeeRoles) ??
                                (_selectedRole != '' ? _selectedRole : '');
                        setState(() {});
                      },
                    ),
                  );
                }),
                const SizedBox(height: 23),
                Row(
                  children: [
                    Expanded(
                      child: StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: startDate),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                prefixIconColor: Theme.of(context).primaryColor,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9.0, bottom: 10),
                                  child: SvgPicture.asset(
                                      'assets/calendar_icon.svg'),
                                ),
                                enabledBorder: fieldBorder,
                                focusedBorder: fieldBorder,
                              ),
                              style: fieldTextStyle.copyWith(fontSize: 14),
                              onTap: () async {
                                DateTime? date = await getStartDatePicker(
                                    context,
                                    startDate == 'Today'
                                        ? today
                                        : parseDateString(startDate));
                                if (date != null) {
                                  setState(() {
                                    startDate = date == today
                                        ? 'Today'
                                        : getDateinDateFormat(date);
                                  });
                                }
                              },
                            ));
                      }),
                    ),
                    SizedBox(
                        width: 52,
                        child: SvgPicture.asset('assets/arrow_forward.svg')),
                    Expanded(
                      child: StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: endDate == 'No date' ? null : endDate),
                              decoration: InputDecoration(
                                hintText: 'No date',
                                hintStyle: fieldTextStyle.copyWith(
                                    color: const Color(0xFF949C9E),
                                    fontSize: 14),
                                contentPadding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                prefixIconColor: Theme.of(context).primaryColor,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9.0, bottom: 10),
                                  child: SvgPicture.asset(
                                      'assets/calendar_icon.svg'),
                                ),
                                enabledBorder: fieldBorder,
                                focusedBorder: fieldBorder,
                              ),
                              style: fieldTextStyle.copyWith(fontSize: 14),
                              onTap: () async {
                                DateTime? date = await getEndDatePicker(
                                    context,
                                    startDate == 'Today'
                                        ? today
                                        : parseDateString(startDate),
                                    endDate != 'No date'
                                        ? parseDateString(endDate)
                                        : null);
                                if (date != null) {
                                  setState(() {
                                    endDate = getDateinDateFormat(date);
                                  });
                                } else {
                                  setState(() {
                                    endDate = 'No date';
                                  });
                                }
                              },
                            ));
                      }),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
