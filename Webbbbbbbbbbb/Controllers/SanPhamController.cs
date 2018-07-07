using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.EF;
namespace Webbbbbbbbbbb.Controllers
{
    public class SanPhamController : Controller
    {
    

     
        public ActionResult CtSanPham(long id)
        {
            var product = new SanPhamDAO().ViewDetail(id);
            
            ViewBag.Splienquan = new SanPhamDAO().ListSpLienQuan(id);
            return View(product);
        }


        //public ActionResult Index(int searchString, int page = 1, int pageSize = 5)
        //{
        //    ViewBag.DanhMuc = new SanPhamDAO().ListAll();
        //    var dao = new SanPhamDAO();
        //    var model = new SanPhamDAO().DanhSachSanPham(searchString,page,pageSize);



        //    return View(model);
        //}





        public ActionResult SanPham(String searchString, long id, int page = 1, int pageSize = 9)
        {
            ViewBag.DanhMuc = new SanPhamDAO().ListAll();
            var dao = new SanPhamDAO();
            var model = new SanPhamDAO().DanhSachSanPham(searchString,id, page, pageSize);

            return View(model);
        }
    }
}