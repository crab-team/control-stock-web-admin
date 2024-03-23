class Failure {
  final String message;

  Failure(this.message);
}

class GeneralFailure extends Failure {
  GeneralFailure({message = 'Ha ocurrido un error, intentelo de nuevo más tarde'}) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure({message = 'Ha ocurrido un error en el servidor'}) : super(message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({message = 'Usuario no autorizado'}) : super(message);
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({message = 'Usuario no encontrado'}) : super(message);
}

class EmailAlreadyInUseFailure extends Failure {
  EmailAlreadyInUseFailure({message = 'El correo ya está en uso'}) : super(message);
}

class EmailNotVerifiedFailure extends Failure {
  EmailNotVerifiedFailure({message = 'El correo no ha sido verificado'}) : super(message);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({message = 'Ha ocurrido un error inesperado'}) : super(message);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure({message = 'Credenciales inválidas'}) : super(message);
}

class UserDisabledFailure extends Failure {
  UserDisabledFailure({message = 'Usuario deshabilitado'}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({message = 'Ha ocurrido un error en la caché'}) : super(message);
}

class NoUserStored extends Failure {
  NoUserStored({message = 'No hay usuario almacenado'}) : super(message);
}

// Upload csv
class FormatFailure extends Failure {
  FormatFailure(
      {message = 'Error en alguno de los campos que se esta intentando subir. Revise el csv y vuelva a intentarlo'})
      : super(message);
}
