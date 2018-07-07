using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class PhanHoiKHController : Controller
    {
        // GET: Admin/PhanHoiKH
        public ActionResult Index(string searchString, int page = 1, int pageSize = 10)
        {
            var dao = new LienHeDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;
            return View(model);
        }
    }
}