using Model.EF;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;
namespace Model.DAO
{
    public class ReportDAO
    {

        ShopDBContext db = null;
        public ReportDAO()
        {
            db = new ShopDBContext();
        }

        public IEnumerable<ThongKeSP> ListAllPaging(String searchString, int page, int pageSize)
        {
            if (searchString.Length < 1)
            {
                DateTime dt = DateTime.Now;


                return db.Database.SqlQuery<ThongKeSP>("exec thongke '" + dt.Month + "' ,'" + dt.Year + "'").ToPagedList(page, pageSize);
            }
            else
            {
                DateTime t = DateTime.Parse(searchString);

                return db.Database.SqlQuery<ThongKeSP>("exec thongke '" + t.Month + "' ,'" + t.Year + "'").ToPagedList(page, pageSize);
            }


        }

        public IEnumerable<ThongKeNam> ThongKeNam(String searchString)
        {
            if (searchString.Length < 1)
            {
                DateTime dt = DateTime.Now;


                return db.Database.SqlQuery<ThongKeNam>("EXEC doanhthunam '" + dt.Year + "'");
            }
            else
            {
                int t = int.Parse(searchString);

                return db.Database.SqlQuery<ThongKeNam>("EXEC doanhthunam '" + t + "'");
            }


        }

    }
}
