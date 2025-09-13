using BtaArge.CvApp.Entities.Abstract;
using BtaArge.CvApp.Entities.Const;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BtaArge.CvApp.Entities.Concrete
{
    [Dapper.Contrib.Extensions.Table(DbTables.Certifications)]
    public class Certification : ITable
    {
        public int Id { get; set; }
        public string Description { get; set; }
    }
}
