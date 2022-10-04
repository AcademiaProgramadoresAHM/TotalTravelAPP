    class EmailVerificationViewModel
    {
        String? Email;
        Map<String, dynamic> toJson() => {'to': Email,
                                          "toName": "string",
                                          "subject": "string",
                                          "bodyData": "string"};
    }
