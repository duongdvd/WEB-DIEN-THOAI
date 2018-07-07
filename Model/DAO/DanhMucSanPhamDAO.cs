using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Model.DAO
{
    public class DanhMucSanPhamDAO
    {
        private ShopDBContext db = null;

        public DanhMucSanPhamDAO()
        {
            db = new ShopDBContext();
        }

        public long Insert(DanhMucSanPham list)
        {
            db.DanhMucSanPhams.Add(list);
            db.SaveChanges();
            return list.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.DanhMucSanPhams.Find(id);
                user.TrangThai = false;

                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Update(DanhMucSanPham entity)
        {
            try
            {
                var user = db.DanhMucSanPhams.Find(entity.ID);
                user.TenDanhMuc = entity.TenDanhMuc;
                user.ThuTu = entity.ThuTu;
                user.PhuKien = entity.PhuKien;

                user.NgayUpdate = DateTime.Now;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public List<DanhMucSanPham> ListAllPhukien()
        {
            return db.DanhMucSanPhams.Where(x => x.TrangThai == true && x.PhuKien == true).ToList();
        }
        public List<DanhMucSanPham> ListAll()
        {
            return db.DanhMucSanPhams.Where(x => x.TrangThai == true).ToList();
        }

        public IEnumerable<DanhMucSanPham> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<DanhMucSanPham> model = db.DanhMucSanPhams.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.TenDanhMuc.Contains(searchString));
            }

            return model.OrderBy(x => x.ThuTu).ToPagedList(page, pageSize);
        }

        public DanhMucSanPham ViewDetail(long id)
        {
            return db.DanhMucSanPhams.Find(id);
        }
    }
}