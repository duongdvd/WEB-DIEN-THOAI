using Model.DAO;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml.Linq;
using Webbbbbbbbbbb.Common;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class SanPhamController : Controller
    {
        // GET: Admin/SanPham
        public ActionResult Index(string searchString, int page = 1, int pageSize = 10)
        {
            var dao = new SanPhamDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;
            return View(model);
        }


        [HttpGet]
        public ActionResult Create()
        {
            LoadDanhMuc();
            return View();
        }


        [HttpGet]
        public ActionResult Edit(long id)
        {
            var dao = new SanPhamDAO();
            var content = dao.ViewDetail(id);
            LoadDanhMuc(content.DanhMucID);

            return View(content);
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            new SanPhamDAO().Delete(id);
          //  SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(SanPham model)
        {

            if (ModelState.IsValid)
            {
                var dao = new SanPhamDAO();
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                model.NguoiUpdate = session.UserName;

                var culture = Session[CommonConstants.CurrentCulture];

                var result = dao.Edit(model);
                if (result)
                {
               //     SetAlert("Sửa sản phẩm thành công", "success");
                    return RedirectToAction("Index", "SanPham");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật sản phẩm không thành công");
                }
            }
            LoadDanhMuc();
            return View();
        }


        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(SanPham model)
        {
          
            if (ModelState.IsValid)
            {
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                model.NguoiTao = session.UserName;

                var culture = Session[CommonConstants.CurrentCulture];

                new SanPhamDAO().Create(model);
           //     SetAlert("Thêm bài viết thành công", "success");
                return RedirectToAction("Index", "SanPham");
            }
            LoadDanhMuc();
            return View();
        }

   


       

        public void LoadDanhMuc(long? selectedId = null)
        {
            var dao = new DanhMucSanPhamDAO();
            ViewBag.DanhMucID = new SelectList(dao.ListAll(), "ID", "TenDanhMuc", selectedId);
        }

    }
}