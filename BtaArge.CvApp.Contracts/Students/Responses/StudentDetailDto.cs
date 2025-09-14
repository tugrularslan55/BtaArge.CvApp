using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Students.Responses;

public record StudentDetailDto(
    Guid Id,
    string FullName,
    string Email,
    Guid FacultyId,
    DateTime RegisteredAt,
    DateTime? BirthDate,
    string? Phone
) : IResponseContract;
