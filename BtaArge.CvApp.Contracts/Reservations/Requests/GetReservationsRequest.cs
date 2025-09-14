using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;
using BtaArge.CvApp.Contracts.Abstractions.Paged;

namespace BtaArge.CvApp.Contracts.Reservations.Requests;

public record GetReservationsRequest(
    int Page = 1,
    int PageSize = 20,
    string? Query = null,
    Guid? DormId = null,
    Guid? StudentId = null,
    DateTime? StartDate = null,
    DateTime? EndDate = null,
    string? Status = null,
    string? SortField = ""ReservedAt"",
    bool SortDesc = true
) : PagedRequest(Page, PageSize), IQueryContract;
