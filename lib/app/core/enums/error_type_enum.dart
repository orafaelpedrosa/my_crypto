enum ErrorHttpEnum {
  e401,
  e404,
  e429,
}

extension ErrorHttpEnumExtension on ErrorHttpEnum {
  String get value {
    switch (this) {
      case ErrorHttpEnum.e401:
        return '401';
      case ErrorHttpEnum.e404:
        return '404';
      case ErrorHttpEnum.e429:
        return '429';
      default:
        return '404';
    }
  }

  String get errorMessage {
    switch (this) {
      case ErrorHttpEnum.e401:
        return 'Não autorizado';
      case ErrorHttpEnum.e404:
        return 'Nenhum resultado encontrado';
      case ErrorHttpEnum.e429:
        return 'Muitos requisições.\nTente novamente mais tarde!';
      default:
        return '404';
    }
  }

  String get assetError {
    switch (this) {
      case ErrorHttpEnum.e401:
        return 'assets/error/error_401.svg';
      case ErrorHttpEnum.e404:
        return 'assets/error/error_404.svg';
      case ErrorHttpEnum.e429:
        return 'assets/error/error_429.svg';
      default:
        return 'assets/error/error_404.svg';
    }
  }
}
