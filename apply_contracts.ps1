param(
  [string]$ContractsRelativeDir
)

Write-Host "== Ogrency/BtaArge Contracts setup ==" -ForegroundColor Cyan

# 1) Contracts projesi dizinini bul
$guesses = @("src\BtaArge.CvApp.Contracts","BtaArge.CvApp.Contracts")
$contractsDir = $null

if ($ContractsRelativeDir -and (Test-Path $ContractsRelativeDir)) {
  $contractsDir = $ContractsRelativeDir
} else {
  foreach ($g in $guesses) { if (Test-Path $g) { $contractsDir = $g; break } }
}

if (-not $contractsDir) {
  Write-Error "Contracts projesi bulunamadı. 'src\BtaArge.CvApp.Contracts' veya 'BtaArge.CvApp.Contracts' olmalı.
İstersen parametre ile ver: .\apply_contracts.ps1 -ContractsRelativeDir 'D:\...\BtaArge.CvApp.Contracts'"
  exit 1
}

Write-Host "Contracts dizini: $contractsDir" -ForegroundColor Yellow

function Write-File($path, $content) {
  $dir = Split-Path -Parent $path
  if ($dir) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  $content | Out-File -FilePath $path -Encoding utf8 -Force
  Write-Host "  + $path"
}

# 2) Klasörler
$folders = @(
  "\Abstractions\Markers",
  "\Abstractions\Paged",
  "\Abstractions\Results",
  "\AssemblyInfo",
  "\Students\Requests",
  "\Students\Responses",
  "\Reservations\Requests",
  "\Reservations\Responses"
)
foreach ($f in $folders) { New-Item -ItemType Directory -Path ($contractsDir + $f) -Force | Out-Null }

# 3) Marker arayüzleri
Write-File "$contractsDir\Abstractions\Markers\IContract.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Markers;
public interface IContract { }
"@

Write-File "$contractsDir\Abstractions\Markers\IRequestContract.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Markers;
public interface IRequestContract : IContract { }
"@

Write-File "$contractsDir\Abstractions\Markers\IResponseContract.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Markers;
public interface IResponseContract : IContract { }
"@

# (Opsiyonel) CQRS ayrımı
Write-File "$contractsDir\Abstractions\Markers\ICommandContract.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Markers;
public interface ICommandContract : IRequestContract { }
"@

Write-File "$contractsDir\Abstractions\Markers\IQueryContract.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Markers;
public interface IQueryContract : IRequestContract { }
"@

# 4) Paged & Result
Write-File "$contractsDir\Abstractions\Paged\PagedRequest.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Paged;

public record PagedRequest(int Page = 1, int PageSize = 20)
{
    public int Skip => (Page <= 1 ? 0 : (Page - 1) * PageSize);
}
"@

Write-File "$contractsDir\Abstractions\Paged\PagedResult.cs" @"
namespace BtaArge.CvApp.Contracts.Abstractions.Paged;

public record PagedResult<T>(IReadOnlyList<T> Items, int Page, int PageSize, int TotalCount);
"@

Write-File "$contractsDir\Abstractions\Results\ApiResult.cs" @"
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
"@

# 5) Assembly marker
Write-File "$contractsDir\AssemblyInfo\ContractsAssembly.cs" @"
namespace BtaArge.CvApp.Contracts.AssemblyInfo;
public sealed class ContractsAssembly { }
"@

# 6) Students - Requests
Write-File "$contractsDir\Students\Requests\GetStudentsRequest.cs" @"
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
"@

Write-File "$contractsDir\Students\Requests\CreateStudentRequest.cs" @"
using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Students.Requests;

public record CreateStudentRequest(
    string FullName,
    string Email,
    Guid FacultyId,
    DateTime? BirthDate = null,
    string? Phone = null
) : ICommandContract;
"@

Write-File "$contractsDir\Students\Requests\UpdateStudentRequest.cs" @"
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
"@

# 7) Students - Responses
Write-File "$contractsDir\Students\Responses\StudentListItemDto.cs" @"
using System;
using BtaArge.CvApp.Contracts.Abstractions.Markers;

namespace BtaArge.CvApp.Contracts.Students.Responses;

public record StudentListItemDto(
    Guid Id,
    string FullName,
    string Email,
    DateTime RegisteredAt
) : IResponseContract;
"@

Write-File "$contractsDir\Students\Responses\StudentDetailDto.cs" @"
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
"@

# 8) Reservations - Requests
Write-File "$contractsDir\Reservations\Requests\GetReservationsRequest.cs" @"
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
"@

# 9) Reservations - Responses
Write-File "$contractsDir\Reservations\Responses\ReservationListItemDto.cs" @"
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
"@

Write-Host "✅ Contracts katmanı dosyaları oluşturuldu/güncellendi." -ForegroundColor Green
