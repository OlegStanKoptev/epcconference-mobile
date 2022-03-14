

// TODO: Implement service class
class WebService {}
// TODO: Implement client class
class Client {}

typedef CreateServiceCallback = WebService Function();

class DatabaseRepository {
  DatabaseRepository({
    CreateServiceCallback? createService,
  }) : _createService = createService ?? createDefaultService;

  WebService? _service;
  final CreateServiceCallback _createService;

  void initializeService() {
    _service = _createService();
  }

  static WebService createDefaultService() {
    return WebService();
  }

  static Client createClient() {
    return Client();
  }
}

class Request {
  Request({
    required this.url,
    this.header,
    this.body
  });

  final String url;
  final Map<String, String>? header;
  final String? body;
}

class API {
  static final getEvents = Request(url: '/event/all');
}