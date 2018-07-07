
using Webbbbbbbbbbb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Model.EF;
using Common;
using System.Configuration;
using System.IO;
using Model.DAO;

namespace Webbbbbbbbbbb.Controllers
{
    public class GioHangController : Controller
    {
        // GET: GioHang
        private const string GioHangSession = "GioHangSession";
        public ActionResult Index()
        {
            var sp = Session[GioHangSession];
            var list = new List<Giohang>();
            if (sp != null)
            {
                list = (List<Giohang>)sp;
            }
            return View(list);
        }

        public ActionResult Delete(int id)
        {
            var sessionCart = (List<Giohang>)Session[GioHangSession];
            var item = sessionCart.Single(x => x.SanPham.ID == id);
            sessionCart.Remove(item);
            Session[GioHangSession] = sessionCart;

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult ThanhToan()
        {
            var giohang = Session[GioHangSession];
            var list = new List<Giohang>();
            if (giohang != null)
            {
                list = (List<Giohang>)giohang;
            }
            return View(list);
           
        }
        public ActionResult Success()
        {
            return View();
        }

        public JsonResult Update(string cartModel)
        {
         
            var jsonCart = new JavaScriptSerializer().Deserialize<List<Giohang>>(cartModel);
            var sessionCart = (List<Giohang>)Session[GioHangSession];

            foreach (var item in sessionCart)
            {
                var jsonItem = jsonCart.SingleOrDefault(x => x.SanPham.ID == item.SanPham.ID);
                if (jsonItem != null)
                {
                    item.SoLuong = jsonItem.SoLuong;
                }
            }
            Session[GioHangSession] = sessionCart;
            return Json(new
            {
                status = true
            });

            
           
        }


        [HttpPost]
        public ActionResult ThanhToan(string Ten, string diachi, string sdt, string email, string ghichu)
        {
            var hoadon = new HoaDon();
            hoadon.TenKhachHang = Ten;
            hoadon.DiaChi = diachi;
            hoadon.SDT = sdt;
            hoadon.Gmail = email;
            hoadon.GhiChu = ghichu;
            hoadon.NgayTao = DateTime.Now;
            hoadon.TrangThai = true;
            decimal? gia = 0;
            int id = new HoaDonDAO().Insert(hoadon);
            var giohang = (List<Giohang>)Session[GioHangSession];
            var dao = new ChiTietHoaDonDAO();

            foreach (var item in giohang)
            {
                var cthoadon = new ChiTietHoaDon();
                cthoadon.ID = id;
                cthoadon.IDSanPham = item.SanPham.ID;
                cthoadon.SoLuong = item.SoLuong;
                if (item.SanPham.GiaKhuyenMai != null)
                {
                    cthoadon.Gia = item.SanPham.GiaKhuyenMai;
                }
                else
                {
                    cthoadon.Gia = item.SanPham.Gia;
                }
                dao.Insert(cthoadon);

                
            }
            string content = System.IO.File.ReadAllText(Server.MapPath("~/assets/client/template/neworder.html"));

            content = content.Replace("{{CustomerName}}", Ten);
            content = content.Replace("{{Phone}}", sdt);
            content = content.Replace("{{Email}}", email);
            content = content.Replace("{{Address}}", diachi);
      
            var toEmail = ConfigurationManager.AppSettings["ToEmailAddress"].ToString();

            new GuiMail().SendMail(email, "MobileShop đã nhận đơn hàng của bạn", content);
            new GuiMail().SendMail(toEmail, " Đơn hàng mới từ MobileShop ", content);

            Session.Remove("GioHangSession");

            return View("Success");
        }

        public ActionResult AddGioHang(long masp, int sl)
        {
            var sp = new SanPhamDAO().ViewDetail(masp);
            var cart = Session[GioHangSession];
            if (cart != null)
            {
                var list = (List<Giohang>)cart;
                if (list.Exists(x => x.SanPham.ID == masp))
                {

                    foreach (var item in list)
                    {
                        if (item.SanPham.ID == masp)
                        {
                            item.SoLuong += sl;
                        }
                    }
                }
                else
                {
                    //tạo mới đối tượng cart item
                    var item = new Giohang();
                    item.SanPham = sp;
                    item.SoLuong = sl;
                    list.Add(item);
                }
                //Gán vào session
                Session[GioHangSession] = list;
            }
            else
            {
                //tạo mới đối tượng cart item
                var item = new Giohang();
                item.SanPham = sp;
                item.SoLuong = sl;
                var list = new List<Giohang>();
                list.Add(item);
                //Gán vào session
                Session[GioHangSession] = list;
            }
            return RedirectToAction("Index");
        }
    }
}