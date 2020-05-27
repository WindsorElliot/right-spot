class ApiResponse<M> {
  Status status;
  M data;
  String message;

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data): status = Status.COMPLETED;
  ApiResponse.error(this.message): status = Status.ERROR;
  ApiResponse.none(this.data) : status = Status.NONE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

}

enum Status {
  LOADING,
  COMPLETED,
  ERROR,
  NONE
}