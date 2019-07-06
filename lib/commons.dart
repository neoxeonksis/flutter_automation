import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

String scriptRoot = path.dirname(Platform.script.toFilePath()) + "/../";

const String pubspecPath = './pubspec.yaml';
const String stringsPath="./android/app/src/main/res/values/strings.xml";
const String manifestPath = "./android/app/src/main/AndroidManifest.xml";
const String appBuildPath = "./android/app/build.gradle";
const String projectBuildPath = "./android/build.gradle";

Map<String,dynamic> defaultConfig = {
  "plugins":{
    "firebase_auth":"^0.11.1+7",
    "google_sign_in":"^4.0.2",
    "provider":"^3.0.0+1"
  },
  "google_services": "4.2.0"
};

Map<String,dynamic> loadConfig() {
  if(!File("./flutter_automation.yaml").existsSync()) return defaultConfig;
  String configcontent = File("./flutter_automation.yaml").readAsStringSync();
  var configFile = loadYaml(configcontent);
  return Map<String,dynamic>.from(configFile);
}


void addDependencise(String dependencies) {
  String pubspec = getFileAsString(pubspecPath);
  pubspec = pubspec.replaceFirst("dev_dependencies:",   "$dependencies\ndev_dependencies:");
  
  writeStringToFile( pubspecPath, pubspec);
}

String getFileAsString(String path) {
  return File(path).readAsStringSync();
}

void writeStringToFile(String path, String contents) {
  File(path).writeAsStringSync(contents);
}

List<String> getFileAsLines(String path) {
  return File(path).readAsLinesSync();
}