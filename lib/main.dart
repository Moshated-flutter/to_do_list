import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_list/injection.dart';
import 'package:to_do_list/presentation/core/app_widget.dart';

void main() {
  runApp(MyApp());
  configureInjection(Environment.prod);
}
