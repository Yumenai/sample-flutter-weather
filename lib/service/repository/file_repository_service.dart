import 'package:weather/utility/file_storage_utility.dart';

const _weatherFilePath = 'weather.txt';

class FileRepositoryService {
  const FileRepositoryService();

  Future<void> setPastWeatherJson(final String jsonString) async {
    await FileStorageUtility.setString(
      text: jsonString,
      filePath: _weatherFilePath,
    );
  }

  Future<String> getPastWeatherJson() async {
    final file = await FileStorageUtility.get(
      _weatherFilePath,
      isDocumentDirectory: true,
    );

    if (file == null) return '';

    return file.readAsString();
  }
}