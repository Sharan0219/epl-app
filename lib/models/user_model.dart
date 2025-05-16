class UserModel {
  final String uid;
  final String? phoneNumber;
  final String name;
  final String examPreparingFor;
  final String address;
  final String? profileImageUrl;
  final String? panCardUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.uid,
    this.phoneNumber,
    required this.name,
    required this.examPreparingFor,
    required this.address,
    this.profileImageUrl,
    this.panCardUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      phoneNumber: json['phoneNumber'],
      name: json['name'] ?? '',
      examPreparingFor: json['examPreparingFor'] ?? '',
      address: json['address'] ?? '',
      profileImageUrl: json['profileImageUrl'],
      panCardUrl: json['panCardUrl'],
      createdAt: json['createdAt'] != null 
          ? (json['createdAt'] is DateTime 
              ? json['createdAt'] 
              : DateTime.parse(json['createdAt']))
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? (json['updatedAt'] is DateTime 
              ? json['updatedAt'] 
              : DateTime.parse(json['updatedAt']))
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'name': name,
      'examPreparingFor': examPreparingFor,
      'address': address,
      'profileImageUrl': profileImageUrl,
      'panCardUrl': panCardUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? phoneNumber,
    String? name,
    String? examPreparingFor,
    String? address,
    String? profileImageUrl,
    String? panCardUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      examPreparingFor: examPreparingFor ?? this.examPreparingFor,
      address: address ?? this.address,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      panCardUrl: panCardUrl ?? this.panCardUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}