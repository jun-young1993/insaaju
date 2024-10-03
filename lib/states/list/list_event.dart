abstract class ListEvent {
  const ListEvent();
}

class AllListEvent extends ListEvent {
  final String? searchText;
  const AllListEvent({this.searchText});
}
