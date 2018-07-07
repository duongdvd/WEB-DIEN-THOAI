using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.ModelView;
namespace Model.DAO
{
   public class ChiTietHoaDonDAO
    {
        private ShopDBContext db = null;

        public ChiTietHoaDonDAO()
        {
            db = new ShopDBContext();
        }
        public List<ChitietHD> ListAllct(long id)
        {
            return db.Database.SqlQuery<ChitietHD>("EXEC cthoadon '" + id + "'").ToList();
        }

        public bool Insert(ChiTietHoaDon detail)
        {
           
                db.ChiTietHoaDons.Add(detail);
                db.SaveChanges();
                return true;
  
        }


    }
}
