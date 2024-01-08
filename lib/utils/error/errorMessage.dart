 String extractErrorMessage(String message) {
    // Intenta extraer el mensaje después del código de error
    var errorMessage = message.split(']').last.trim();
    if (errorMessage.isEmpty) {
      return "An error occurred during sign up";
    }
    return errorMessage;
  }