enum SelectStatus { none, all, some, zero }

class TableStatus {
  SelectStatus selectStatus;
  List<int> selectedIndexes;
  int rowLength;

  TableStatus(
      {this.selectStatus = SelectStatus.none,
      this.selectedIndexes = const [],
      this.rowLength = 0});
}
