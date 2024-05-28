/// Google Auth Configurations
///
/// To get the values of the keys below:
/// 1. CLIENT_ID: Go to the Google Developer Console, create a new project or select an existing one,
///    then navigate to "APIs & Services" > "Credentials" and create an OAuth 2.0 Client ID for iOS.
/// 2. SCOPES: Define the scopes your app needs access to. Example: "email, profile".
/// 3. SERVER_CLIENT_ID: If you need to authenticate to a backend server, create a new Web Application
///    OAuth 2.0 Client ID and use its client ID value.

const googleAuthConfigs = {
  'CLIENT_ID': String.fromEnvironment('CLIENT_ID'),
  'SCOPES': String.fromEnvironment('SCOPES'),
  'SERVER_CLIENT_ID': String.fromEnvironment('SERVER_CLIENT_ID'),
};
