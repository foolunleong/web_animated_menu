class SubMenu {
  int? id;
  String? name;
  String? route;
  Function()? onTap;

  SubMenu({this.id, this.name, this.route, this.onTap});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SubMenu && runtimeType == other.runtimeType && name == other.name;
}
