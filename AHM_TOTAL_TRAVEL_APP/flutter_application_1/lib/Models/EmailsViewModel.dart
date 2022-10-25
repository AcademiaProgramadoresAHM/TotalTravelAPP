class EmailVerificationViewModel {
  String? Email;
  Map<String, dynamic> toJson() => {
        'to': Email,
        "toName": "string",
        "subject": "string",
        "bodyData": "string"
      };
}

class EmailContactViewModel {
  String? BodyData;
  String? User;

  Map<String, dynamic> toJson() => {
        "to": "string",
        "toName": User,
        "subject": "string",
        "bodyData": BodyData
      };
}
