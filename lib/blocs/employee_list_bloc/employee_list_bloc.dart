import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/employee.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState>
    with HydratedMixin {
  EmployeeListBloc() : super(EmployeeListState.initial()) {
    on<AddEmployeeDetailsEvent>(_addEmployeeDetails);
    on<RemoveEmployeeEvent>(_removeEmployee);
    on<EditEmployeeDetailsEvent>(_editEmployeeDetails);
  }

  void _addEmployeeDetails(
      AddEmployeeDetailsEvent event, Emitter<EmployeeListState> emit) {
    final Employee newEmployee = Employee(
      employeeName: event.employeeName,
      role: event.employeeRole,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    final List<Employee> newEmployeeList = [...state.employeeList, newEmployee];
    emit(state.copyWith(employeeList: newEmployeeList));
  }

  void _removeEmployee(
      RemoveEmployeeEvent event, Emitter<EmployeeListState> emit) {
    final List<Employee> newEmployeeList = state.employeeList
        .where((Employee t) => t.id != event.employee.id)
        .toList();

    emit(state.copyWith(employeeList: newEmployeeList));
  }

  void _editEmployeeDetails(
      EditEmployeeDetailsEvent event, Emitter<EmployeeListState> emit) {
    final newEmployeeList = state.employeeList.map((Employee employee) {
      if (employee.id == event.id) {
        return Employee(
          id: event.id,
          employeeName: event.employeeName,
          role: event.employeeRole,
          startDate: event.startDate,
          endDate: event.endDate,
        );
      }
      return employee;
    }).toList();

    emit(state.copyWith(employeeList: newEmployeeList));
  }

  @override
  EmployeeListState fromJson(Map<String, dynamic> json) {
    return EmployeeListState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(EmployeeListState state) {
    return state.toJson();
  }
}
