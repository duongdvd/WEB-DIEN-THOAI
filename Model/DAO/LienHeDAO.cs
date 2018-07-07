using Model.EF;
using System;
using System.Linq;
using PagedList;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Model.DAO
{
    public class LienHeDAO
    {
        private ShopDBContext db = null;

        public LienHeDAO()
        {
            db = new ShopDBContext();
        }

        public GioiThieu ListAll(long id)
        {
            return db.GioiThieus.Find(id);
        }

        public bool Edit(GioiThieu entity)
        {
            try
            {
                var user = db.GioiThieus.Find(1);
                user.Name = entity.Name;
                user.Conten = entity.Conten;

                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public IEnumerable<PhanHoiKH> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<PhanHoiKH> model = db.PhanHoiKHs.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                //model = model.Where(x => x.TenBaiViet.Contains(searchString) || x.TieuDeBaiViet.Contains(searchString));

                model = db.PhanHoiKHs.Where(delegate (PhanHoiKH c)
                {
                    if (ConvertToUnSign(c.Name).IndexOf(ConvertToUnSign(searchString), StringComparison.CurrentCultureIgnoreCase) >= 0 && c.TrangThai == true)
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


        public List<PhanHoiKH> ListAlltn()
        {
            return db.PhanHoiKHs.Where(x => x.TrangThai == true).ToList();
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


        public bool add(string ten, string sdt, string email, string ghichu)
        {
            try
            {
                PhanHoiKH PH = new PhanHoiKH();
                PH.Name = ten;
                PH.Email = email;
                PH.Message = ghichu;
                PH.NgayTao = DateTime.Now;
                PH.TrangThai = true;
                db.PhanHoiKHs.Add(PH);
                db.SaveChanges();
                
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}