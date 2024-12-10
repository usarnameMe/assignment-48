import logging


def is_success(status_code):
    return 200 <= status_code < 300


class RecipeAppMonitoringMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        self.logger = logging.getLogger('recipe_app_monitoring')

    def __call__(self, request):
        try:
            self.process_request(request)
            response = self.get_response(request)
            response = self.process_response(request, response)
            if is_success(response.status_code):
                self._log_successful_request(request, response)
            return response
        except Exception as e:
            self.log_message(f"Error processing request: {e}")
            raise

    def process_request(self, request):
        self.log_message(f"Incoming request: {request.method} {request.path}")

    def process_response(self, request, response):
        self.log_message(f"Response: {response.status_code} for {request.path}")
        return response

    def log_message(self, message):
        self.logger.info(message)

    def _log_successful_request(self, request, response):
        self.logger.info(f"Successful request: {request.method} {request.path} with status {response.status_code}")
