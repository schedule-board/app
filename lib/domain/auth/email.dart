import 'package:equatable/equatable.dart';

class Email extends Equatable{
  final String value;
  Email(this.value) {
    if (value.isEmpty) {
      throw Exception('UserName can not be empty');
    }
    
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      throw Exception('invalid email');
    }

  }

  @override
  List<Object?> get props => [value];
}
