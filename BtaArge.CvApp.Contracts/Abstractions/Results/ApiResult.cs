namespace BtaArge.CvApp.Contracts.Abstractions.Results;

public class ApiResult<T>
{
    public bool Success { get; init; }
    public string? Message { get; init; }
    public string? ErrorCode { get; init; }
    public T? Data { get; init; }

    public static ApiResult<T> Ok(T data, string? message = null) =>
        new() { Success = true, Data = data, Message = message };

    public static ApiResult<T> Fail(string errorCode, string? message = null) =>
        new() { Success = false, ErrorCode = errorCode, Message = message };
}
