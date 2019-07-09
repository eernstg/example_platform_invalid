import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_config/build_config.dart';
import 'package:build_runner_core/build_runner_core.dart';

class InvalidBuilder implements Builder {
  BuilderOptions builderOptions;

  InvalidBuilder(this.builderOptions);

  Future build(BuildStep buildStep) async {
    var inputLibrary = await buildStep.inputLibrary;
    var resolver = buildStep.resolver;
    print("Hello!");
  }

  Map<String, List<String>> get buildExtensions =>
      const { '.dart': ['.g.dart'] };
}

InvalidBuilder invalidBuilder(BuilderOptions options) {
  var config = new Map<String, Object>.from(options.config);
  config.putIfAbsent('entry_points', () => ['**.dart']);
  return new InvalidBuilder(options);
}
