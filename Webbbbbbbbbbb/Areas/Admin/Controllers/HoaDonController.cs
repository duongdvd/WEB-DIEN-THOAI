using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class HoaDonController : BaseController
    {
        // GET: Admin/HoaDon
        public ActionResult Index(string searchString, int page = 1, int pageSize = 10)
        {
            var dao = new HoaDonDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;
            return View(model);
       
        }


        public ActionResult ChiTiet(long id)
        {
            var dao = new ChiTietHoaDonDAO();
            var model = dao.ListAllct(id);

       
            return View(model);

        }

        [HttpPost]
        public ActionResult ChiTiet(int id)
        {
            if (ModelState.IsValid)
            {
                var dao = new HoaDonDAO();


                var result = dao.Edit(id);
                if (result)
                {
                    SetAlert("Sửa thành công", "success");
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật không thành công");
                }
            }

            return View();

        }
    }
}