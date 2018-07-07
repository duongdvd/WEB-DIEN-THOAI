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
    public class SanPhamDAO
    {
        ShopDBContext db = null;
        public SanPhamDAO()
        {
            db = new ShopDBContext();
        }

        public IEnumerable<SanPham> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<SanPham> model = db.SanPhams.Where(x => x.TrangThai == true);
            if (!string.IsNullOrEmpty(searchString))
            {
                //model = model.Where(x => x.TenBaiViet.Contains(searchString) || x.TieuDeBaiViet.Contains(searchString));

                model = db.SanPhams.Where(delegate (SanPham c)
                {
                    if (ConvertToUnSign(c.TenSanPham).IndexOf(ConvertToUnSign(searchString), StringComparison.CurrentCultureIgnoreCase) >= 0 && c.TrangThai == true)
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

        public IEnumerable<SanPham> DanhSachSanPham(string searchString,long id, int page, int pageSize)
        {
            IQueryable<SanPham> model;
            if (id > 0)
            {
               model = db.SanPhams.Where(x => x.TrangThai == true && x.DanhMucID == id);
            }
            else
            {
                model = db.SanPhams.Where(x => x.TrangThai == true );
            }
            

            if (!string.IsNullOrEmpty(searchString))
            {
                //model = model.Where(x => x.TenBaiViet.Contains(searchString) || x.TieuDeBaiViet.Contains(searchString));

                model = db.SanPhams.Where(delegate (SanPham c)
                {
                    if (ConvertToUnSign(c.TenSanPham).IndexOf(ConvertToUnSign(searchString), StringComparison.CurrentCultureIgnoreCase) >= 0 && c.TrangThai == true)
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

        //public IEnumerable<SanPham> ListSPdanhMuc(int searchString, int page, int pageSize)
        //{
        //    IQueryable<SanPham> model = db.SanPhams.Where(x => x.TrangThai == true && x.DanhMucID == searchString);

        //    if (searchString == null)
        //    {
        //        return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);
        //    }

        //    return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, pageSize);



        //    return model.OrderByDescending(x => x.NgayTao).ToPagedList(page, 2);
        //}

        public List<SanPham> ListSPHot(int top)
        {
            return db.SanPhams.Where(x => x.SPHOT == true && x.TrangThai == true).OrderByDescending(x => x.NgayTao).Take(top).ToList();
        }

            public List<DanhMucSanPham> ListAll()
        {
            return db.DanhMucSanPhams.Where(x => x.TrangThai == true).ToList();
        }

        public List<SanPham> ListAllsp()
        {
            return db.SanPhams.Where(x => x.TrangThai == true).ToList();
        }
        public List<SanPham> ListSPNew(int top)
        {
            return db.SanPhams.Where(x => x.TrangThai == true).OrderByDescending(x => x.NgayTao).Take(top).ToList();
        }

        public List<SanPham> ListSPNoiBat(int top)
        {
            return db.SanPhams.Where(x => x.TrangThai == true ).Take(top).ToList();
        }

        public List<SanPham> ListSpLienQuan(long productId)
        {
            var product = db.SanPhams.Find(productId);
            return db.SanPhams.Where(x => x.ID != productId && x.DanhMucID == product.DanhMucID).ToList();
        }


        public SanPham ViewDetail(long id)
        {
            return db.SanPhams.Find(id);
        }


        public int Create(SanPham baiViet)
        {
           baiViet.NgayTao = DateTime.Now;
            baiViet.ViewCount = 0;
            db.SanPhams.Add(baiViet);
            db.SaveChanges();

            return baiViet.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.SanPhams.Find(id);
                user.TrangThai = false;
      
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Edit(SanPham entity)
        {
            try
            {
                var user = db.SanPhams.Find(entity.ID);
                user.TenSanPham = entity.TenSanPham;

                user.Gia = entity.Gia;
                user.GiaKhuyenMai = entity.GiaKhuyenMai;
          

                user.MoTa = entity.MoTa;
                user.image = entity.image;
                user.DanhMucID = entity.DanhMucID;
                user.NoiDung = entity.NoiDung;
                user.TrangThai = entity.TrangThai;
                user.SPHOT = entity.SPHOT;
                user.BaoHanh = entity.BaoHanh;
                user.ManHinh = entity.ManHinh;
                user.DoPhanGiai = entity.DoPhanGiai;
                user.CamTruoc = entity.CamTruoc;
                user.CamSau = entity.CamSau;
                user.CPU = entity.CPU;
                user.SoNhan = entity.SoNhan;
                user.Chip = entity.Chip;
                user.Ram = entity.ROM;
                user.HeDieuHanh = entity.HeDieuHanh;
                user.Pin = entity.Pin;
                user.DungluongPin = entity.DungluongPin;
                user.Sim = entity.Sim;
                user.wifi = entity.wifi;
                user.Bluetooth = entity.Bluetooth;
                user.GPS = entity.GPS;

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
    }
}
