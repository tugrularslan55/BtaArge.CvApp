using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Students.Responses;

public record StudentListItemDto(
    Guid Id,
    string FullName,
    string Email,
    DateTime RegisteredAt
) : IResponseContract;
