class RequestQr {
  String empCode, faceMachineCode, mode, createTime, wifiName;
  RequestQr(
      {this.empCode,
      this.createTime,
      this.faceMachineCode,
      this.mode = "2",
      this.wifiName});
}
