import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/domain/core/errors.dart';
import 'package:to_do_list/domain/core/failure.dart';

@immutable
abstract class ValueObjects<T> {
  const ValueObjects();
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  /// Thorws [UnexpactedValueError] containin the [ValueFailure]
  T getOrCrash() {
    return value.fold((l) => throw UnexpactedValueError(l), (r) => r);
  }

  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObjects && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
