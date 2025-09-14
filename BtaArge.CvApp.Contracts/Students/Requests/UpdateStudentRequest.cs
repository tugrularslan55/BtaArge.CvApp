using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Students.Requests;

public record UpdateStudentRequest(
    Guid Id,
    string FullName,
    string Email,
    Guid FacultyId,
    DateTime? BirthDate = null,
    string? Phone = null,
    byte[]? RowVersion = null
) : ICommandContract;
