import 'package:hetu_script/hetu_script.dart';
import 'package:meta/meta.dart';

class HetuLibraryScriptBinding {

  @mustCallSuper
  void loadAutoBindingFunction(Hetu interpreter) {
    var functionWrappers = <String, HTExternalFunctionTypedef>{};
    functionWrappers.forEach((key, value) {
      interpreter.bindExternalFunctionType(key, value);
    });
  }

  @mustCallSuper
  void loadAutoBinding(Hetu interpreter) {
    loadAutoBindingFunction(interpreter);
    var bindings = [
    ];
    bindings.forEach((value) {
      interpreter.bindExternalClass(value);
    });
  }

  @mustCallSuper
  Future loadAutoBindingScripts(Hetu interpreter, String path) {
    var futures = <Future>[];
    return Future.wait(futures);
  }
}