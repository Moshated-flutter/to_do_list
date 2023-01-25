import 'package:to_do_list/domain/core/failure.dart';

class UnexpactedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpactedValueError(this.valueFailure);
  @override
  String toString() {
    final explanation =
        'Encoutered a ValueFailure at a unrecoverable State.Terminate';
    return Error.safeToString('$explanation. Failure was:$valueFailure ');
  }
}
