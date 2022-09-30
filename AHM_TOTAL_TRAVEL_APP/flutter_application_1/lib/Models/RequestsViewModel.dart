class RequestStatus {
  int? CodeStatus;
  String? MessageStatus;

  RequestStatus(this.CodeStatus, this.MessageStatus);

  RequestStatus.fromJson(Map<String, dynamic> json)
      : CodeStatus = json['codeStatus'],
        MessageStatus = json['messageStatus'];
}
