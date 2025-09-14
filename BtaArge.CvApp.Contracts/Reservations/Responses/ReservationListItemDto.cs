using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Reservations.Responses;

public record ReservationListItemDto(
    Guid Id,
    string StudentName,
    string DormName,
    DateTime ReservedAt,
    string Status,
    decimal? MonthlyPrice
) : IResponseContract;
