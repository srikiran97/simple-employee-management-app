part of 'employee_list_bloc.dart';

class EmployeeListState extends Equatable {
  const EmployeeListState({required this.employeeList});

  final List<Employee> employeeList;

  factory EmployeeListState.initial() {
    return EmployeeListState(employeeList: [
      Employee(
          employeeName: 'A',
          role: 'Flutter Developer',
          startDate: '11 Oct 2019'),
      Employee(
          employeeName: 'B',
          role: 'Flutter Developer',
          startDate: '12 Oct 2019'),
      Employee(
          employeeName: 'C',
          role: 'Flutter Developer',
          startDate: '14 Oct 2019',
          endDate: '20 Oct 2022'),
      Employee(
          employeeName: 'D',
          role: 'Flutter Developer',
          startDate: '14 Oct 2019'),
      Employee(
          employeeName: 'E',
          role: 'Flutter Developer',
          startDate: '15 Oct 2019'),
      Employee(
          employeeName: 'F',
          role: 'Flutter Developer',
          startDate: '16 Oct 2019',
          endDate: '20 Oct 2022'),
    ]);
  }

  @override
  List<Object> get props => [employeeList];

  EmployeeListState copyWith({
    List<Employee>? employeeList,
  }) {
    return EmployeeListState(
      employeeList: employeeList ?? this.employeeList,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'employeeList': employeeList.map((x) => x.toMap()).toList(),
    };
  }

  factory EmployeeListState.fromJson(Map<String, dynamic> map) {
    return EmployeeListState(
      employeeList: List<Employee>.from(
        (map['employeeList'] as List<dynamic>).map<Employee>(
          (x) => Employee.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
