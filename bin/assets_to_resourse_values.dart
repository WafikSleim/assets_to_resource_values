import 'dart:io';

void main(List<String> arguments) async {
    final currentPath = Directory.current.path;
    final list = Directory("$currentPath/assets").listSync();
    final valuesFile = File("$currentPath/values.dart");
    await valuesFile.writeAsString("");
    valuesFile.writeAsStringSync("final class AssetsManager {", mode: FileMode.append);
    valuesFile.writeAsStringSync("  const AssetsManager._();", mode: FileMode.append);
    valuesFile.writeAsStringSync("  static const String _basePath = 'assets/icons';", mode: FileMode.append);
    for (var element in list) {
        final originalFileName = element.path.split("\\").last;
        final fileName = originalFileName.split(".")[0];
        String key = "";
        final splitedString = fileName.split("_");
        for(int i = 0; i < splitedString.length; i++) {
            if(i == 0) {
                key += splitedString[i];
            } else {
                key += splitedString[i].replaceFirst(splitedString[i].split("")[0], splitedString[i].split("")[0].toUpperCase());
            }
        }
        valuesFile.writeAsStringSync('  static const String $key = "\$_basePath/$originalFileName";', mode: FileMode.append);
    }
    valuesFile.writeAsStringSync("}", mode: FileMode.append);
}
