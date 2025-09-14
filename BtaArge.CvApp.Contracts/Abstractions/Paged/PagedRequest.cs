namespace BtaArge.CvApp.Contracts.Abstractions.Paged;

public record PagedRequest(int Page = 1, int PageSize = 20)
{
    public int Skip => (Page <= 1 ? 0 : (Page - 1) * PageSize);
}
