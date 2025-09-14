using BtaArge.CvApp.Contracts.Abstractions.Markers;
using BtaArge.CvApp.Contracts.Abstractions.Paged;

namespace BtaArge.CvApp.Contracts.Students.Requests;

public record GetStudentsRequest(
    int Page = 1,
    int PageSize = 20,
    string? Query = null,
    string? SortField = null,
    bool SortDesc = true
) : PagedRequest(Page, PageSize), IQueryContract;
