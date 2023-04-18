import 'package:employee_management/constants.dart';
import 'package:employee_management/helpers/helper.dart';
import 'package:employee_management/pages/add_employee_details_page.dart';
import 'package:employee_management/pages/edit_employee_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';

import '../blocs/employee_list_bloc/employee_list_bloc.dart';
import '../models/employee.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Employee> employees =
        context.watch<EmployeeListBloc>().state.employeeList;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee List'),
        ),
        body: Center(
          child: employees.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: GroupedListView<Employee, String>(
                        shrinkWrap: true,
                        elements: employees,
                        padding: EdgeInsets.zero,
                        separator: const SizedBox.shrink(
                          child: Divider(
                            height: 0.5,
                          ),
                        ),
                        groupBy: (element) => element.endDate != null
                            ? 'Previous employees'
                            : 'Current employees',
                        itemComparator: (element1, element2) {
                          return parseDateString(element2.startDate)
                              .compareTo(parseDateString(element1.startDate));
                        },
                        groupSeparatorBuilder: (value) {
                          return Container(
                              height: 52,
                              color: const Color(0xFFF2F2F2),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Color(0xFF1DA1F2),
                                  fontFamily: defaultFontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ));
                        },
                        itemBuilder: (_, element) {
                          return Dismissible(
                            key: ValueKey(element.id),
                            background: showBackground(),
                            direction: DismissDirection.endToStart,
                            child: EmployeeItem(employee: element),
                            onDismissed: (direction) {
                              final Employee deletedEmployee = element;
                              context
                                  .read<EmployeeListBloc>()
                                  .add(RemoveEmployeeEvent(element));

                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  'Employe data has been deleted',
                                  style: TextStyle(
                                      fontFamily: defaultFontFamily,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.fixed,
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    context
                                        .read<EmployeeListBloc>()
                                        .add(AddEmployeeDetailsEvent(
                                          employeeName:
                                              deletedEmployee.employeeName,
                                          employeeRole: deletedEmployee.role,
                                          startDate: deletedEmployee.startDate,
                                          endDate: deletedEmployee.endDate,
                                        ));
                                  },
                                ),
                              ));
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 85,
                      width: double.infinity,
                      color: const Color(0xFFF2F2F2),
                      padding: const EdgeInsets.only(left: 16.0, top: 12.0),
                      child: const Text('Swipe left to delete',
                          style: TextStyle(
                              color: Color(0xFF949C9E),
                              fontFamily: defaultFontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                    )
                  ],
                )
              : SvgPicture.asset(noRecordsFoundImage),
        ),
        floatingActionButton: SizedBox(
          height: 50,
          child: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEmployeeDetails(),
                  ),
                );
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }

  Widget showBackground() {
    return Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: const Color(0xFFF34642),
        alignment: Alignment.centerRight,
        child: SvgPicture.asset('assets/dismiss_icon.svg'));
  }
}

class EmployeeItem extends StatelessWidget {
  const EmployeeItem({super.key, required this.employee});
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditEmployeeDetails(employee: employee),
        ));
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employee.employeeName,
              style: const TextStyle(
                color: Color(0xFF323238),
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              employee.role,
              style: const TextStyle(
                color: Color(0xFF949C9E),
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              employee.endDate == null
                  ? 'From ${employee.startDate}'
                  : '${employee.startDate} - ${employee.endDate}',
              style: const TextStyle(
                color: Color(0xFF949C9E),
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
