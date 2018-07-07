using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.DAO;
using Webbbbbbbbbbb.Common;
using Webbbbbbbbbbb.Models;
namespace Webbbbbbbbbbb.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index(string searchString)
        {
            if(searchString == null) {
                ViewBag.Sanphamhot = new SanPhamDAO().ListSPHot(10);
                ViewBag.Sanphamnew = new SanPhamDAO().ListSPNew(10);
                ViewBag.Sanphamnoibat = new SanPhamDAO().ListSPNoiBat(10);
                return View();
            }
            else
            {
               return RedirectToAction("SanPham","SanPham/" , new { searchString = searchString.ToString(), id = 0 });
            }
            
        }

        //public ActionResult Index()
        //{
        //    ViewBag.Sanphamhot = new SanPhamDAO().ListSPHot(10);
        //    ViewBag.Sanphamnew = new SanPhamDAO().ListSPNew(10);
        //    ViewBag.Sanphamnoibat = new SanPhamDAO().ListSPNoiBat(10);
        //    return View();
        //}

        [ChildActionOnly]
        public ActionResult DropDanhMuc()
        {
            var model = new DanhMucSanPhamDAO().ListAll();
            return PartialView(model);
        }


        [ChildActionOnly]
        public ActionResult DiaChi()
        {
            var model = new LienHeDAO().ListAll(1);
            return PartialView(model);
        }

        [ChildActionOnly]
        public PartialViewResult GioHang()
        {
            var giohang = Session[CommonConstants.GioHang_Session];
            var list = new List<Giohang>();
            if (giohang != null)
            {
                list = (List<Giohang>)giohang;
            }

            return PartialView(list);
        }

        [ChildActionOnly]
        public ActionResult Slide()
        {
            var model = new SlideDAO().ListAll();
            return PartialView(model);
        }

        [ChildActionOnly]
        public ActionResult DropBaiViet()
        {
            var model = new DanhMucDAO().ListAll();
            return PartialView(model);
        }

        [ChildActionOnly]
        public ActionResult DropPhuKien()
        {
            var model = new DanhMucSanPhamDAO().ListAllPhukien();
            return PartialView(model);
            
        }

    }
}