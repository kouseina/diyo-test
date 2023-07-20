// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diyo_test/enum.dart';
import 'package:diyo_test/features/main/entity/entity.dart';

class TableEntity {
  TableStatus status;
  int id;
  List<MenuEntity> menuList;

  TableEntity({
    required this.status,
    required this.id,
    required this.menuList,
  });
}
