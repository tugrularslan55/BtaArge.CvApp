using BtaArge.CvApp.Entities.Abstract;
using BtaArge.CvApp.Entities.Const;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BtaArge.CvApp.Entities.Concrete
{
    [Dapper.Contrib.Extensions.Table(DbTables.Educations)]
    public class Education : ITable
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string SubTitle { get; set; }
        public string Description { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}
