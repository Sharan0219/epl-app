import 'package:dio/dio.dart';
// Import Get specifically without importing Response
import 'package:get/get.dart' hide Response;
import 'package:exam_prep_app/core/services/storage_service.dart';
import 'package:exam_prep_app/core/utils/app_constants.dart';

class ApiService extends GetxService {
  late Dio _dio;
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Add request interceptor for auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final userId = _storageService.getUserId();
        if (userId.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $userId';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          // Unauthorized - could handle token refresh or logout here
          // Get.find<AuthService>().signOut();
        }
        return handler.next(error);
      },
    ));
  }

  // Generic GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generic POST request
  Future<Response> post(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generic PUT request
  Future<Response> put(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Generic DELETE request
  Future<Response> delete(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Get daily challenge
  Future<Map<String, dynamic>> getDailyChallenge() async {
    try {
      final response = await get('/challenges/daily');
      return response.data;
    } catch (e) {
      return {'error': 'Failed to load daily challenge'};
    }
  }

  // Get question by ID
  Future<Map<String, dynamic>> getQuestion(String questionId) async {
    try {
      final response = await get('/questions/$questionId');
      return response.data;
    } catch (e) {
      return {'error': 'Failed to load question'};
    }
  }

  // Submit answer
  Future<Map<String, dynamic>> submitAnswer({
    required String questionId,
    required String answer,
    int? timeSpent,
  }) async {
    try {
      final response = await post('/answers/submit', data: {
        'questionId': questionId,
        'answer': answer,
        'timeSpent': timeSpent,
      });
      return response.data;
    } catch (e) {
      return {'error': 'Failed to submit answer'};
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      final response = await get('/users/stats');
      return response.data;
    } catch (e) {
      return {'error': 'Failed to load user statistics'};
    }
  }

  // Mock API methods for development
  Future<Map<String, dynamic>> getMockDailyChallenge() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return {
      'id': 'challenge-123',
      'title': 'General Knowledge Quiz',
      'description': 'Test your knowledge with these challenging questions!',
      'totalQuestions': 5,
      'timeLimit': 300, // seconds
      'questions': [
        {
          'id': 'q1',
          'type': 'mcq',
          'question': 'What is the capital of France?',
          'options': ['London', 'Berlin', 'Paris', 'Madrid'],
          'timeLimit': 30, // seconds per question
        },
        {
          'id': 'q2',
          'type': 'mcq',
          'question': 'Which planet is known as the Red Planet?',
          'options': ['Jupiter', 'Venus', 'Mars', 'Saturn'],
          'timeLimit': 30,
        },
        {
          'id': 'q3',
          'type': 'fill_blank',
          'question': 'The chemical symbol for gold is __.',
          'timeLimit': 40,
        },
        {
          'id': 'q4',
          'type': 'mcq',
          'question': 'Which of these is not a programming language?',
          'options': ['Java', 'Python', 'Cobra', 'HTML'],
          'timeLimit': 30,
        },
        {
          'id': 'q5',
          'type': 'fill_blank',
          'question': 'The largest ocean on Earth is the __ Ocean.',
          'timeLimit': 30,
        },
      ],
      'settings': {
        'skipEnabled': true,
        'showTimer': true,
        'musicEnabled': true,
      }
    };
  }
}