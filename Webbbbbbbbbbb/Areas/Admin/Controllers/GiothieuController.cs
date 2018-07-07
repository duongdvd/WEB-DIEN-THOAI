using Model.DAO;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class GiothieuController : BaseController
    {
        // GET: Admin/Giothieu
        public ActionResult Index()
        {
            var dao = new LienHeDAO();
            var model = dao.ListAll(1);
            return View(model);
        }

        [HttpGet]
        public ActionResult Edit(long id)
        {
            var dao = new LienHeDAO();
            var content = dao.ListAll(id);
          

            return View(content);
        }



        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(GioiThieu model)
        {

            if (ModelState.IsValid)
            {
                var dao = new LienHeDAO();


                var result = dao.Edit(model);
                if (result)
                {
                    SetAlert("Sửa giới thiệu thành công", "success");
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật giới thiệu không thành công");
                }
            }

            return View();
        }
    }
}