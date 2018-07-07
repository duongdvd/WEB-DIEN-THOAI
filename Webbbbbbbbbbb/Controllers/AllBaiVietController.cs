using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Controllers
{
    public class AllBaiVietController : Controller
    {
        // GET: AllBaiViet
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new BaiVietDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;

            return View(model);

        }

        public ActionResult ListBaiViet(long id, int page = 1, int pageSize = 6)
        {
            ViewBag.DanhMuc = new BaiVietDAO().ListAll();
            var dao = new BaiVietDAO();
            var model = new BaiVietDAO().DanhSachBaiViet(id, page, pageSize);

            return View(model);
        }

        public ActionResult BaiViet(long id)
        {
            ViewBag.BaiVietNew = new BaiVietDAO().ListbvNew(3);
            ViewBag.DanhMuc = new BaiVietDAO().GetDanhMucBaiViet();
            ViewBag.Bvlienquan = new BaiVietDAO().ListbvLienQuan(id);
            var sp = new BaiVietDAO().GetByID(id);
            return View(sp);
        }
    }
}