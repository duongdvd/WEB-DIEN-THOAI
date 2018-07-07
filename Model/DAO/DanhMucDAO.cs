using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Model.DAO
{
    public class DanhMucDAO
    {
        private ShopDBContext db = null;

        public DanhMucDAO()
        {
            db = new ShopDBContext();
        }

        public long Insert(DanhMucBaiViet list)
        {
            db.DanhMucBaiViets.Add(list);
            db.SaveChanges();
            return list.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.DanhMucBaiViets.Find(id);
                user.TrangThai = false;

                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }



        public bool Update(DanhMucBaiViet entity)
        {
            try
            {
                var user = db.DanhMucBaiViets.Find(entity.ID);
                user.TenDanhMuc = entity.TenDanhMuc;
                user.ThuTu = entity.ThuTu;
               
                user.NgayUpdate = DateTime.Now;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<DanhMucBaiViet> ListAll()
        {
            return db.DanhMucBaiViets.Where(x => x.TrangThai == true).ToList();
        }

        public IEnumerable<DanhMucBaiViet> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<DanhMucBaiViet> model = db.DanhMucBaiViets.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.TenDanhMuc.Contains(searchString));
            }

            return model.OrderBy(x => x.ThuTu).ToPagedList(page, pageSize);
        }

        public DanhMucBaiViet ViewDetail(long id)
        {
            return db.DanhMucBaiViets.Find(id);
        }
    }
}