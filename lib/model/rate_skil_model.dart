// ignore_for_file: public_member_api_docs, sort_constructors_first
class RateSkilModel {
  double pace;
  double shooting;
  double passing;
  double dribbling;
  double defending;
  double physical;
  RateSkilModel({
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.dribbling,
    required this.defending,
    required this.physical,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pace': pace,
      'shooting': shooting,
      'passing': passing,
      'dribbling': dribbling,
      'defending': defending,
      'physical': physical,
    };
  }

  factory RateSkilModel.fromMap(Map<String, dynamic> map) {
    return RateSkilModel(
      pace: map['pace'] as double,
      shooting: map['shooting'] as double,
      passing: map['passing'] as double,
      dribbling: map['dribbling'] as double,
      defending: map['defending'] as double,
      physical: map['physical'] as double,
    );
  }
}

/* 

  Pace 
Shooting
Passing
Dribbling
Defending
Physical

 */
