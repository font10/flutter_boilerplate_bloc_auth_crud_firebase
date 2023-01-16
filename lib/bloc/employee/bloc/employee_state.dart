part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
  
  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class InitialState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class AddEmployeeState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class AddedEmployeeState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class UpdateEmployeeState extends EmployeeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdatedEmployeeState extends EmployeeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeleteEmployeeState extends EmployeeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeletedEmployeeState extends EmployeeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EmployeesLoaded extends EmployeeState {
  List<Employee> data;

  EmployeesLoaded( this.data );

  @override
  List<Object> get props => [ data ];
}

class LoadingState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeError extends EmployeeState {
  final String error;

  EmployeeError( this.error );

  @override
  List<Object> get props => [error];
}



