part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}

class AddEmployeeDetailsEvent extends EmployeeListEvent {
  final String employeeName;
  final String employeeRole;
  final String startDate;
  final String? endDate;
  const AddEmployeeDetailsEvent({
    required this.employeeName,
    required this.employeeRole,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object> get props => [employeeName, employeeRole, startDate];
}

class RemoveEmployeeEvent extends EmployeeListEvent {
  final Employee employee;
  const RemoveEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class EditEmployeeDetailsEvent extends EmployeeListEvent {
  final String id;
  final String employeeName;
  final String employeeRole;
  final String startDate;
  final String? endDate;
  const EditEmployeeDetailsEvent({
    required this.id,
    required this.employeeName,
    required this.employeeRole,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object> get props => [id, employeeName, employeeRole, startDate];
}
