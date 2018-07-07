using Model.DAO;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class SlideController : BaseController
    {
        // GET: Admin/Slide
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new SlideDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;
            return View(model);
        }

        [HttpGet]
        public ActionResult Create()
        {
           
            return View();
        }

        [HttpGet]
        public ActionResult Edit(long id)
        {
            var dao = new SlideDAO();
            var content = dao.GetByID(id);
        

            return View(content);
        }
        [HttpDelete]
        public ActionResult Delete(int id)
        {
            new SlideDAO().Delete(id);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Slide model)
        {

            if (ModelState.IsValid)
            {
                var dao = new SlideDAO();
               

                var result = dao.Edit(model);
                if (result)
                {
                    SetAlert("Sửa slide thành công", "success");
                    return RedirectToAction("Index", "Slide");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật Slide không thành công");
                }
            }
       
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(Slide model)
        {
           
            if (ModelState.IsValid)
            {
                new SlideDAO().Create(model);
                SetAlert("Thêm Slide thành công", "success");
                return RedirectToAction("Index", "Slide");
            }
         
            return View();
        }
    }
}