class CreateSubModel {
  String planId;
  String userId;
  CreateSubModel({required this.planId, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'planId': this.planId,
      'userId': this.userId,
    };
  }
}
