import 'package:bloc/bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/data/repository/employee__repository.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/models/employee.dart';
import 'package:equatable/equatable.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc({ required this.employeeRepository }) : super(EmployeeInitial()) {

    on<AddEmployeeRequested>((event, emit) async {
      emit(LoadingState());
      try {
        emit(AddEmployeeState());
        await employeeRepository.addEmployee( event.data );
        emit(AddedEmployeeState());
        final data = await employeeRepository.getPlaces();
        emit(EmployeesLoaded(data));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });

    on<UpdateEmployeeRequested>((event, emit) async {
      emit(LoadingState());
      try {
        emit(UpdateEmployeeState());
        await employeeRepository.updateEmployee( event.data );
        emit(UpdatedEmployeeState());
        final data = await employeeRepository.getPlaces();
        emit(EmployeesLoaded(data));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });

    on<DeleteEmployeeRequested>((event, emit) async {
      emit(LoadingState());
      try {
        emit(DeleteEmployeeState());
        await employeeRepository.deleteEmployee( event.data );
        emit(DeletedEmployeeState());
        final data = await employeeRepository.getPlaces();
        emit(EmployeesLoaded(data));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });

    on<GetEmployees>((event, emit) async {
      emit( LoadingState() );      
      try {
        final data = await employeeRepository.getPlaces();
        emit( EmployeesLoaded( data ) );
      } catch( e ) {
        emit( EmployeeError( e.toString() ) );
      }
    });

  }
}
