import 'package:driver_mate/feature/ai/data/repo/ai_diagnosis_response_repo.dart';
import 'package:driver_mate/feature/ai/manager/state/get_diagnosis_history_state.dart';
import 'package:driver_mate/feature/ai/data/model/get_diagnosis_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDiagnosisHistoryCubit extends Cubit<GetDiagnosisHistoryState> {
  GetDiagnosisHistoryCubit() : super(GetDiagnosisHistoryInitial());

  final AiDiagnosisRepo _repo = AiDiagnosisRepo();

  static const int _pageSize = 10;

  int _page = 1;
  bool _hasMore = true;
  final List<GetDiagnosisHistoryModel> _items = [];

  // ── Initial load ──────────────────────────────────────────────────────────
  Future<void> fetchHistory() async {
    emit(GetDiagnosisHistoryLoading());
    _page = 1;
    _items.clear();
    _hasMore = true;

    try {
      final result = await _repo.getDiagnosisHistory(
        page: _page,
        limit: _pageSize,
      );
      _items.addAll(result);
      _hasMore = result.length >= _pageSize;
      _emitSuccess();
    } catch (e) {
      emit(GetDiagnosisHistoryError(e.toString()));
    }
  }

  // ── Load next page (called when user scrolls to bottom) ───────────────────
  Future<void> loadMore() async {
    if (!_hasMore) return;

    final current = state;
    if (current is! GetDiagnosisHistorySuccess || current.isLoadingMore) return;

    // Emit loading-more without clearing existing items
    emit(
      GetDiagnosisHistorySuccess(
        items: List.from(_items),
        hasMore: _hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      _page++;
      final result = await _repo.getDiagnosisHistory(
        page: _page,
        limit: _pageSize,
      );
      _items.addAll(result);
      _hasMore = result.length >= _pageSize;
      _emitSuccess();
    } catch (_) {
      _page--; // revert on failure so next attempt retries the same page
      emit(
        GetDiagnosisHistorySuccess(
          items: List.from(_items),
          hasMore: _hasMore,
          isLoadingMore: false,
        ),
      );
    }
  }

  void _emitSuccess() {
    emit(
      GetDiagnosisHistorySuccess(
        items: List.from(_items),
        hasMore: _hasMore,
        isLoadingMore: false,
      ),
    );
  }

  List<GetDiagnosisHistoryModel> get items => List.unmodifiable(_items);
}
