import 'package:hetu_script/hetu_script.dart';
import 'ht_library_script_binding.dart';

class HetuScriptBinding extends HetuLibraryScriptBinding {
  @override
  void loadAutoBindingFunction(Hetu interpreter) {
    super.loadAutoBindingFunction(interpreter);
    var functionWrappers = <String, HTExternalFunctionTypedef>{};
    functionWrappers.forEach((key, value) {
      interpreter.bindExternalFunctionType(key, value);
    });
  }

  @override
  void loadAutoBinding(Hetu interpreter) {
    super.loadAutoBinding(interpreter);
var bindings = [
    ];
    bindings.forEach((value) {
      interpreter.bindExternalClass(value);
    });
  }

  @override
  Future loadAutoBindingScripts(Hetu interpreter, String path) {
    var future = super.loadAutoBindingScripts(interpreter, path);
    var futures = <Future>[];
    futures.add(future);
    return Future.wait(futures);
  }
}