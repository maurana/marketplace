from drf_standardized_errors.types import ErrorResponse
from drf_standardized_errors.formatter import ExceptionFormatter

class Exception_Formatter(ExceptionFormatter):
    def format_error_response(self, error_response: ErrorResponse):
        error = error_response.errors[0]
        return {
            "type": error_response.type,
            "code": error.code,
            "message": error.detail,
            "field": error.attr
        }