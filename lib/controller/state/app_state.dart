class AppState<M> {

  AppStatus status;
  M data;
  String message;

  AppState.loading(this.message) : status = AppStatus.APP_LOADING;
  AppState.logged(this.data) : status = AppStatus.APP_LOGED;
  AppState.notLogged() : status = AppStatus.APP_NOT_LOGGED;
  AppState.error(this.message) : status = AppStatus.APP_ERROR;
}

enum AppStatus {
  APP_LOADING,
  APP_LOGED,
  APP_NOT_LOGGED,
  APP_ERROR
}