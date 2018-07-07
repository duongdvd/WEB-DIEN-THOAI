using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;
using System.Text.RegularExpressions;

namespace Model.DAO
{
    public class HoaDonDAO
    {
        private ShopDBContext db = null;
        public HoaDonDAO()
        {
            db = new ShopDBContext();
        }

        public int Insert(HoaDon order)
        {
            order.TrangThai = false;
            db.HoaDons.Add(order);
            db.SaveChanges();
            return order.ID;
        }


        public bool Edit(int id)
        {
            try
            {
                var user = db.HoaDons.Find(id);
                user.TrangThai = true;
                

                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public IEnumerable<HoaDon> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<HoaDon> model = db.HoaDons.Where(x => x.ID > 0);
            if (!string.IsNullOrEmpty(searchString))
            {
                //model = model.Where(x => x.TenBaiViet.Contains(searchString) || x.TieuDeBaiViet.Contains(searchString));

                model = db.HoaDons.Where(delegate (HoaDon c)
                {
                    if (ConvertToUnSign(c.TenKhachHang).IndexOf(ConvertToUnSign(searchString), StringComparison.CurrentCultureIgnoreCase) >= 0 )
                        return true;
                    else
                        return false;
                }).AsQueryable();

                return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
            }
            else
            {
                return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
            }

        }


        public List<HoaDon> ListAllhd()
        {
            return db.HoaDons.Where(x => x.TrangThai == false).ToList();
        }




        public static string ConvertToUnSign(string text)
        {
            for (int i = 33; i < 48; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }

            for (int i = 58; i < 65; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }

            for (int i = 91; i < 97; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }
            for (int i = 123; i < 127; i++)
            {
                text = text.Replace(((char)i).ToString(), "");
            }
            text = text.Replace(" ", "-");
            Regex regex = new Regex(@"\p{IsCombiningDiacriticalMarks}+");
            string strFormD = text.Normalize(System.Text.NormalizationForm.FormD);
            return regex.Replace(strFormD, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
        }

    }


}
