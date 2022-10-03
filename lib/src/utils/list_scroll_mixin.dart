import 'package:flutter/material.dart';

abstract class FetchProvider {
  void fetch([int offset]);
}

mixin ListScrollMixin<T extends StatefulWidget> on State<T>
    implements FetchProvider {
  static const _scrollDelta = 200.0;
  static const _refreshTrigger = -60.0;
  ScrollController scrollController = ScrollController();
  late bool canFetch;
  late bool canRefresh;

  @override
  void initState() {
    super.initState();
    canFetch = false;
    canRefresh = true;
    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollDelta &&
        canFetch &&
        fetch != null) {
      fetch();
    } else if (currentScroll < _refreshTrigger && canRefresh && fetch != null) {
      canRefresh = false;
      fetch(0);
    } else if (currentScroll == 0) {
      canRefresh = true;
    }
  }
}

// USAGE
// ========================================
// just add 'with ...' to the class declaration
// class _MyScreenState extends State<MyScreen> with ListScrollMixin {

  // remove most of the old code

  // and implement fetch method 
  // void fetch([int offset]) {
    // print('Fetching items, starting at ${offset ?? dummyWinesData.data.length}');
    // ...
    // Here can be a direct api call something like api.fetchWines(...)
    // or you can dispatch some redux actions --> store.dispatch(FetchWinesAction())
    // etc

    // Also don't forget to lock / canFetch = false; / while loading new data 
    // to prevent triggering fetch event multiple times
    // (you can do it in a reducer if you use redux)
//   }
  
//   @override
//   Widget build(BuildContext context) => SomeWidgetWithTheListOfItems() 
// }