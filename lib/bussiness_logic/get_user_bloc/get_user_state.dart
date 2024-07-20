// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoginState {
  final String cloumn_id;
  final String column_user_name;
  final String coloumn_rules;
  final int coloumn_active;
  final String coloumn_experience_year;
  final String coloumn_level;
  final String coloumn_created_at;
  final String coloumn_updated_at;
  final int coloumn_version;
  final String coloumn_access_token;
  final String coloumn_refresh_token;
  LoginState({
    this.cloumn_id = '',
    this.column_user_name = '',
    this.coloumn_rules = '',
    this.coloumn_active = 0,
    this.coloumn_experience_year = '',
    this.coloumn_level = '',
    this.coloumn_created_at = '',
    this.coloumn_updated_at = '',
    this.coloumn_version = 0,
    this.coloumn_access_token = '',
    this.coloumn_refresh_token = '',
  });

  LoginState copyWith({
    String? cloumn_id,
    String? column_user_name,
    String? coloumn_rules,
    int? coloumn_active,
    String? coloumn_experience_year,
    String? coloumn_level,
    String? coloumn_created_at,
    String? coloumn_updated_at,
    int? coloumn_version,
    String? coloumn_access_token,
    String? coloumn_refresh_token,
  }) {
    return LoginState(
      cloumn_id: cloumn_id ?? this.cloumn_id,
      column_user_name: column_user_name ?? this.column_user_name,
      coloumn_rules: coloumn_rules ?? this.coloumn_rules,
      coloumn_active: coloumn_active ?? this.coloumn_active,
      coloumn_experience_year:
          coloumn_experience_year ?? this.coloumn_experience_year,
      coloumn_level: coloumn_level ?? this.coloumn_level,
      coloumn_created_at: coloumn_created_at ?? this.coloumn_created_at,
      coloumn_updated_at: coloumn_updated_at ?? this.coloumn_updated_at,
      coloumn_version: coloumn_version ?? this.coloumn_version,
      coloumn_access_token: coloumn_access_token ?? this.coloumn_access_token,
      coloumn_refresh_token:
          coloumn_refresh_token ?? this.coloumn_refresh_token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cloumn_id': cloumn_id,
      'column_user_name': column_user_name,
      'coloumn_rules': coloumn_rules,
      'coloumn_active': coloumn_active,
      'coloumn_experience_year': coloumn_experience_year,
      'coloumn_level': coloumn_level,
      'coloumn_created_at': coloumn_created_at,
      'coloumn_updated_at': coloumn_updated_at,
      'coloumn_version': coloumn_version,
      'coloumn_access_token': coloumn_access_token,
      'coloumn_refresh_token': coloumn_refresh_token,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      cloumn_id: map['cloumn_id'] as String,
      column_user_name: map['column_user_name'] as String,
      coloumn_rules: map['coloumn_rules'] as String,
      coloumn_active: map['coloumn_active'] as int,
      coloumn_experience_year: map['coloumn_experience_year'] as String,
      coloumn_level: map['coloumn_level'] as String,
      coloumn_created_at: map['coloumn_created_at'] as String,
      coloumn_updated_at: map['coloumn_updated_at'] as String,
      coloumn_version: map['coloumn_version'] as int,
      coloumn_access_token: map['coloumn_access_token'] as String,
      coloumn_refresh_token: map['coloumn_refresh_token'] as String,
    );
  }

  @override
  String toString() {
    return 'GetUserModel(cloumn_id: $cloumn_id, column_user_name: $column_user_name, coloumn_rules: $coloumn_rules, coloumn_active: $coloumn_active, coloumn_experience_year: $coloumn_experience_year, coloumn_level: $coloumn_level, coloumn_created_at: $coloumn_created_at, coloumn_updated_at: $coloumn_updated_at, coloumn_version: $coloumn_version, coloumn_access_token: $coloumn_access_token, coloumn_refresh_token: $coloumn_refresh_token)';
  }
}
