import 'repository/file_repository_service.dart';
import 'repository/network_repository_service.dart';

class RepositoryService {
  static const network = NetworkRepositoryService();
  static const file = FileRepositoryService();

  const RepositoryService._();
}
