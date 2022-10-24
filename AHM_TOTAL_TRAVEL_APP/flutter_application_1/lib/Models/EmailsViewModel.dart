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
  String? Email;

  Map<String, dynamic> toJson() => {
        "to": Email,
        "toName": "totaltravelenterprise@gmail.com",
        "subject": "string",
        "bodyData": BodyData
      };
}
