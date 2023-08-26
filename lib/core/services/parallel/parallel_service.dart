import 'dart:async';

import 'parallel_model.dart';
import 'parallel_result.dart';

class ParallelService {
  // ignore: close_sinks
  late StreamController<ParallelResult> _streamController;
  late List<ParallelModel> _services = [];
  late final List<ParallelResult> _parallelResults = [];
  int _sumOfFinishedServices = 0;

  ParallelService({required List<ParallelModel> services}) {
    _streamController = StreamController();
    _services = services;
  }

  Future<List<ParallelResult>> getResults({int duration = 0}) async {
    int durationSum = 0;
    for (var service in _services) {
      service.service.then((value) {
        _streamController
            .add(ParallelResult(name: service.name, finalResult: value));
      });
    }

    _streamController.stream.listen((data) {
      _sumOfFinishedServices++;
      _parallelResults.add(data);
      if (_sumOfFinishedServices == _services.length) {
        _streamController.close();
      }
    });

    while (!_streamController.isClosed) {
      durationSum += 100;
      await Future.delayed(const Duration(milliseconds: 100));
    }
    while (durationSum <= duration) {
      durationSum += 100;
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return _parallelResults;
  }

  bool isServicesFailed() {
    return _parallelResults
        .where((element) => element.finalResult.hasError)
        .isNotEmpty;
  }
}
