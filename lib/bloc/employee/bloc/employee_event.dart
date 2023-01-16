part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEmployeeRequested extends EmployeeEvent {
  final Employee data;

  AddEmployeeRequested( this.data );
}

class UpdateEmployeeRequested extends EmployeeEvent {
  final Employee data;

  UpdateEmployeeRequested( this.data );
}

class DeleteEmployeeRequested extends EmployeeEvent {
  final Employee data;

  DeleteEmployeeRequested( this.data );
}

class GetEmployees extends EmployeeEvent {
  GetEmployees();
}