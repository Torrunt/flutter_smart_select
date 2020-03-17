import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_select/smart_select.dart';

class SmartSelectStateFilter<T> extends ChangeNotifier {
  final TextEditingController ctrl = TextEditingController();

  bool _activated = false;

  String _query;

  bool get activated => _activated;

  String get query => _query;

  List<SmartSelectOption<T>> options;
  Future<List<SmartSelectOption<T>>> Function(String) onSearch;

  SmartSelectStateFilter(this.options, this.onSearch);

  @override
  void dispose() {
    // Clean up the filter controller when the widget is disposed.
    ctrl.dispose();
    super.dispose();
  }

  void start() {
    _activated = true;
    notifyListeners();
  }

  void stop() {
    _activated = false;
    clear();
  }

  void clear() {
    ctrl.clear();
    setQuery(null);
  }

  void setQuery(String val) async {
    _query = val;
    List<SmartSelectOption<T>> result = await onSearch(val);
    if (result != null) options = result;
    notifyListeners();
  }
}
