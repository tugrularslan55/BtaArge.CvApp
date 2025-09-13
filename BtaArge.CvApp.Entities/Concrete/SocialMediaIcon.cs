using BtaArge.CvApp.Entities.Abstract;
using BtaArge.CvApp.Entities.Const;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BtaArge.CvApp.Entities.Concrete
{

    [Dapper.Contrib.Extensions.Table(DbTables.SocialMediaIcons)]

    public class SocialMediaIcon : ITable
    {
        public int Id { get; set; }
        public string Link { get; set; }
        public string Icon { get; set; }

        // Foreign Key
        public int AppUserId { get; set; }
        public AppUser AppUser { get; set; }
    }
}
