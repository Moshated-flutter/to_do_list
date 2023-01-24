import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/domain/core/failure.dart';

@immutable
abstract class ValueObjects<T> {
  const ValueObjects();
  Either<ValueFailure<T>, T> get value;
  bool isValid() => value.isRight();
  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObjects && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
