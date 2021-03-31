import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'package:hetu_binding_generator/generator.dart';

void main(args) {
  var parser = ArgParser();
  parser.addFlag('version', abbr: 'v', help: 'Show executable\'s version.', callback: (flag) async {
    if (flag) {
      print('Hetu Binding Generator: Version $version');
    }
  }, negatable: false);
  parser.addMultiOption('user-lib-paths',
      abbr: 'u',
      defaultsTo: [],
      valueHelp: 'path1, path2, ...',
      help: 'Will iterate over all the folders recursively.');
  parser.addMultiOption('package-lib-paths',
      abbr: 'p',
      defaultsTo: [],
      valueHelp: 'package1/lib, package2/lib, ...',
      help: 'Will iterate over all the package cache folders.');
  parser.addOption('flutter-lib-path',
      abbr: 'f',
      valueHelp: 'flutter-framework-path',
      help: 'Will iterate the Flutter/Dart framework recursively. The path should point to the Flutter root folder.');
  parser.addOption('output',
      abbr: 'o',
      defaultsTo: Directory.current.path.toString() + '/gen/dart',
      help: 'The output path for .dart code generation and .json intermediate files.');
  parser.addOption('script-output',
      abbr: 's',
      defaultsTo: Directory.current.path.toString() + '/gen/ht',
      help: 'The output path for .ht code generation.');
  parser.addOption('json-export',
      abbr: 'j', defaultsTo: null, help: 'Whether to export the intermediate JSON files for diagnostics.');
  parser.addFlag('help', abbr: 'h', negatable: false, callback: (f) {
    if (f) {
      print(parser.usage);
    }
  }, help: 'Show this help.');
  parser.addMultiOption('ignores',
      abbr: 'i',
      defaultsTo: [],
      valueHelp: 'ignored-file-name, ignored-file-name:ignored-class-name, ...',
      help:
          "The files/classes from this list will be ignored during the code generation. If only file name is provided, all classes from the file won't be exported. All function typedefs will be exported even the file is ignored.");
  parser.addMultiOption('whitelist',
      abbr: 'w',
      valueHelp: 'whitelist-file-name, whitelist-file-name2, ...',
      help: 'Only the files from the list will be parsed, working with \'ignores\' too.');
  var results = parser.parse(args);
  var userPaths = results['user-lib-paths'];

  var output = results['output'];
  var scriptOutput = results['script-output'];
  if (path.isRelative(output)) {
    output = path.absolute(output);
  }
  if (path.isRelative(scriptOutput)) {
    scriptOutput = path.absolute(scriptOutput);
  }
  var flutterPath = results['flutter-lib-path'];
  var packagePaths = results['package-lib-paths'];
  var jsonPath = results['json-export'];
  if (jsonPath != null) {
    if (path.isRelative(jsonPath)) {
      jsonPath = path.absolute(jsonPath);
    }
  }
  // print('json: $jsonPath');
  var ignores = results['ignores'];
  ignores.addAll([
    'core/annotations.dart',
    'core/object.dart',
    'core/errors.dart',
    'core/exceptions.dart',
    'core/expando.dart',
    'core/string.dart',
    'core/bool.dart',
    'core/num.dart',
    'convert/codec.dart',
    'foundation/annotations.dart',
    'foundation/assertions.dart',
    'foundation/basic_types.dart',
    'material/date_picker_deprecated.dart',
    'rendering/object.dart',
    'widgets/framework.dart',
    'ui/painting.dart:Codec',
    'ui/painting.dart:Image',
    'ui/painting.dart:Gradient',
    'painting/image_provider.dart:AssetBundleImageProvider',
    'ui/text.dart:TextStyle',
    'ui/text.dart:StrutStyle',
    'ui/platform_dispatcher.dart:ViewConfiguration',
    'foundation/diagnostics.dart',
  ]);
  var whitelist = results['whitelist'];
  if (results['help'] == true || results['version'] == true) {
    return;
  }
  print('Begin parsing...');
  Directory(output).create(recursive: true);
  parseBegin(userPaths, flutterPath, packagePaths, output, scriptOutput, ignores, whitelist, jsonPath: jsonPath);
}
