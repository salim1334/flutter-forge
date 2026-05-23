import 'package:get/get.dart';
import 'package:<%= packageName %>/core/config/app_config.dart';
import 'package:<%= packageName %>/core/constants/app_enums.dart';
import 'package:<%= packageName %>/core/utils/logging/app_logger.dart';
<% if (includeNotes) { %>
import 'package:<%= packageName %>/data/local/daos/notes_dao.dart';
<% } %>

class ExploreController extends GetxController {
  final AppLogger _logger = Get.find<AppLogger>();
<% if (includeNotes) { %>
  final NotesDao _notesDao = NotesDao();
<% } %>

  final Rx<LoadingState> loadingState = LoadingState.idle.obs;
  final RxList<String> items = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _logger.info('API base: ${AppConfig.apiBaseUrl} (key: ${AppConfig.maskedApiKey()})');
    loadItems();
  }

  Future<void> loadItems() async {
    loadingState.value = LoadingState.loading;
    try {
<% if (includeNotes) { %>
      final notes = await _notesDao.getAll();
      if (notes.isEmpty) {
        await _notesDao.insert(title: 'Welcome note', body: 'Forged with Flutter Forge');
      }
      final refreshed = await _notesDao.getAll();
      items.assignAll(
        refreshed.map((n) => n['title']?.toString() ?? 'Untitled'),
      );
<% } else { %>
      await Future<void>.delayed(const Duration(milliseconds: 600));
      items.assignAll(['Sample item A', 'Sample item B', 'Sample item C']);
<% } %>
      loadingState.value = LoadingState.success;
    } catch (e) {
      loadingState.value = LoadingState.error;
      _logger.error('Failed to load explore items', e);
    }
  }

  Future<void> reload() => loadItems();
}
