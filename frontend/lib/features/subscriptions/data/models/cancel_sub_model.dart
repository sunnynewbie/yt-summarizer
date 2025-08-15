class CancelSubModel{
  String userId;

  CancelSubModel({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
    };
  }
}