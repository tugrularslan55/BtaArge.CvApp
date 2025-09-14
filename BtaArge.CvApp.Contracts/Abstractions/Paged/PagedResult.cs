namespace BtaArge.CvApp.Contracts.Abstractions.Paged;

public record PagedResult<T>(IReadOnlyList<T> Items, int Page, int PageSize, int TotalCount);
