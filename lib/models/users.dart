class UsersDto {
  final String id;
  final String name;
  final String email;

  UsersDto({required this.id, required this.name, required this.email});

  factory UsersDto.fromJson(Map<String, dynamic> json) {
    return UsersDto(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}