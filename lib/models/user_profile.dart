class UserProfile {
  late String? name;
  late String? entryNo;

  UserProfile({
    this.name,
    this.entryNo,
  });

  @override
  String toString() {
    return 'UserProfile(legalName: $name, role: $entryNo)';
  }

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    entryNo = json['entry_no'];
  }
}
