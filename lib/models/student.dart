/// Student model representing a student profile
class Student {
  final int id;
  final String fullName;
  final String admissionNumber;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String? profilePhotoUrl;
  final String collegeId;
  final String departmentId;
  final String enrollmentYear;
  final String currentSemester;
  final String registrationDate;
  final String? bloodGroup;
  final String? emergencyContact;
  final String? emergencyPhone;

  Student({
    required this.id,
    required this.fullName,
    required this.admissionNumber,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    this.profilePhotoUrl,
    required this.collegeId,
    required this.departmentId,
    required this.enrollmentYear,
    required this.currentSemester,
    required this.registrationDate,
    this.bloodGroup,
    this.emergencyContact,
    this.emergencyPhone,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      admissionNumber: json['admission_number'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      profilePhotoUrl: json['profile_photo_url'],
      collegeId: json['college_id'] ?? '',
      departmentId: json['department_id'] ?? '',
      enrollmentYear: json['enrollment_year'] ?? '',
      currentSemester: json['current_semester'] ?? '',
      registrationDate: json['registration_date'] ?? '',
      bloodGroup: json['blood_group'],
      emergencyContact: json['emergency_contact'],
      emergencyPhone: json['emergency_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'admission_number': admissionNumber,
      'email': email,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'profile_photo_url': profilePhotoUrl,
      'college_id': collegeId,
      'department_id': departmentId,
      'enrollment_year': enrollmentYear,
      'current_semester': currentSemester,
      'registration_date': registrationDate,
      'blood_group': bloodGroup,
      'emergency_contact': emergencyContact,
      'emergency_phone': emergencyPhone,
    };
  }
}

/// Guardian model
class Guardian {
  final int id;
  final int studentId;
  final String name;
  final String relation;
  final String phone;
  final String email;
  final String address;
  final String? designation;

  Guardian({
    required this.id,
    required this.studentId,
    required this.name,
    required this.relation,
    required this.phone,
    required this.email,
    required this.address,
    this.designation,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      name: json['name'] ?? '',
      relation: json['relation'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      designation: json['designation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'name': name,
      'relation': relation,
      'phone': phone,
      'email': email,
      'address': address,
      'designation': designation,
    };
  }
}

/// Student Address model
class StudentAddress {
  final int id;
  final int studentId;
  final String addressType; // Home, Hostel, etc.
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final bool isPrimary;

  StudentAddress({
    required this.id,
    required this.studentId,
    required this.addressType,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.isPrimary,
  });

  factory StudentAddress.fromJson(Map<String, dynamic> json) {
    return StudentAddress(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      addressType: json['address_type'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? '',
      isPrimary: json['is_primary'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'address_type': addressType,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'is_primary': isPrimary,
    };
  }
}

/// Student Document model
class StudentDocument {
  final int id;
  final int studentId;
  final String documentType; // Aadhar, PAN, etc.
  final String documentNumber;
  final String? documentUrl;
  final String uploadedAt;
  final String? verificationStatus; // Pending, Verified, Rejected

  StudentDocument({
    required this.id,
    required this.studentId,
    required this.documentType,
    required this.documentNumber,
    this.documentUrl,
    required this.uploadedAt,
    this.verificationStatus,
  });

  factory StudentDocument.fromJson(Map<String, dynamic> json) {
    return StudentDocument(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      documentType: json['document_type'] ?? '',
      documentNumber: json['document_number'] ?? '',
      documentUrl: json['document_url'],
      uploadedAt: json['uploaded_at'] ?? '',
      verificationStatus: json['verification_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'document_type': documentType,
      'document_number': documentNumber,
      'document_url': documentUrl,
      'uploaded_at': uploadedAt,
      'verification_status': verificationStatus,
    };
  }
}
