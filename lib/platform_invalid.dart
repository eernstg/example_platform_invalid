import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

class InvalidBuilder implements Builder {
  BuilderOptions builderOptions;

  InvalidBuilder(this.builderOptions);

  Future build(BuildStep buildStep) async {
    var inputLibrary = await buildStep.inputLibrary;
    for (Element element in inputLibrary.topLevelElements) {
      if (element is VariableElement) {
        var typeElement = element.type.element;
        var resolvedLibrary = await typeElement.session
            .getResolvedLibraryByElement(typeElement.library);

        // Next line throws a `StateError`:
        // "Bad state: The result is not valid: ResultState.NOT_A_FILE"
        resolvedLibrary.getElementDeclaration(typeElement);
      }
    }
  }

  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.g.dart']
      };
}

InvalidBuilder invalidBuilder(BuilderOptions options) {
  var config = new Map<String, Object>.from(options.config);
  config.putIfAbsent('entry_points', () => ['**.dart']);
  return new InvalidBuilder(options);
}
