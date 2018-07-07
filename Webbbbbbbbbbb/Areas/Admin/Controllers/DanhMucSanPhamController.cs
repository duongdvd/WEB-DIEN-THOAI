using Model.DAO;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Webbbbbbbbbbb.Common;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class DanhMucSanPhamController : BaseController
    {
        // GET: Admin/DanhMucSanPham
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new DanhMucSanPhamDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;

            return View(model);
        }

        public ActionResult Create()
        {
            return View();
        }


        public ActionResult Edit(int id)
        {
            var DMuc = new DanhMucSanPhamDAO().ViewDetail(id);
            return View(DMuc);
        }



        [HttpPost]
        public ActionResult Create(DanhMucSanPham model)
        {
            if (ModelState.IsValid)
            {
                var currentCulture = Session[CommonConstants.CurrentCulture];

                var id = new DanhMucSanPhamDAO().Insert(model);
                if (id > 0)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm danh mục không thành công");
                }
            }
            return View(model);
        }


        [HttpPost]
        public ActionResult Edit(DanhMucSanPham user)
        {

            var dao = new DanhMucSanPhamDAO();
            var result = dao.Update(user);
            if (result)
            {
                SetAlert("Sửa danh mục thành công", "success");
                return RedirectToAction("Index", "DanhMucSanPham");
            }
            else
            {
                ModelState.AddModelError("", "Cập nhật danh mục không thành công");
            }

            return View("Index");
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            new DanhMucSanPhamDAO().Delete(id);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }
    }
}