using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Model.DAO
{
    public class BaiVietDAO
    {
        private ShopDBContext db = null;

        public BaiVietDAO()
        {
            db = new ShopDBContext();
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

    

        public IEnumerable<BaiViet> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<BaiViet> model = db.BaiViets.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                //model = model.Where(x => x.TenBaiViet.Contains(searchString) || x.TieuDeBaiViet.Contains(searchString));

                model = db.BaiViets.Where(delegate (BaiViet c)
                {
                    if (ConvertToUnSign(c.TenBaiViet).IndexOf(ConvertToUnSign(searchString), StringComparison.CurrentCultureIgnoreCase) >= 0 && c.TrangThai == true)
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

        public IEnumerable<BaiViet> DanhSachBaiViet(long searchString, int page, int pageSize)
        {
            IQueryable<BaiViet> model = db.BaiViets.Where(x => x.TrangThai == true && x.DanhMucID == searchString);

            return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
        }

        public BaiViet GetByID(long id)
        {
            return db.BaiViets.Find(id);
        }

        public List<BaiViet> ListbvNew(int top)
        {
            return db.BaiViets.Where(x => x.TrangThai == true).OrderByDescending(x => x.NgayTao).Take(top).ToList();
        }

        public List<BaiViet> ListbvLienQuan(long productId)
        {
            var product = db.BaiViets.Find(productId);
            return db.BaiViets.Where(x => x.ID != productId && x.DanhMucID == product.DanhMucID).Take(3).ToList();
        }

        public List<BaiViet> ListAll()
        {
            return db.BaiViets.Where(x => x.TrangThai == true).ToList();
        }

        public List<DanhMucBaiViet> GetDanhMucBaiViet()
        {
            return db.DanhMucBaiViets.Where(x => x.TrangThai == true).ToList();
        }

        public int Create(BaiViet baiViet)
        {
            baiViet.NgayTao = DateTime.Now;
            baiViet.ViewCount = 0;
            db.BaiViets.Add(baiViet);
            db.SaveChanges();

            return baiViet.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.BaiViets.Find(id);
                user.TrangThai = false;

                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Edit(BaiViet entity)
        {
            try
            {
                var user = db.BaiViets.Find(entity.ID);
                user.TenBaiViet = entity.TenBaiViet;

                user.TieuDeBaiViet = entity.TieuDeBaiViet;
                user.MoTa = entity.MoTa;
                user.image = entity.image;
                user.DanhMucID = entity.DanhMucID;
                user.NoiDung = entity.NoiDung;
                user.TrangThai = entity.TrangThai;

                user.NguoiUpdate = entity.NguoiUpdate;
                user.NgayUpdate = DateTime.Now;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public IEnumerable<BaiViet> ListAllPaging(int page, int pageSize)
        {
            IQueryable<BaiViet> model = db.BaiViets;
            return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
        }
    }
}