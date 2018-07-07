using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class HomeController : BaseController
    {
        // GET: Admin/Home
        public ActionResult Index()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult _sanpham()
        {
            var model = new SanPhamDAO().ListAllsp();
            return PartialView(model);
        }



        [ChildActionOnly]
        public ActionResult _tinnhan()
        {
            var model = new LienHeDAO().ListAlltn();
            return PartialView(model);
        }

        [ChildActionOnly]
        public ActionResult _donhang()
        {
            var model = new HoaDonDAO().ListAllhd();
            return PartialView(model);
        }
    }
}