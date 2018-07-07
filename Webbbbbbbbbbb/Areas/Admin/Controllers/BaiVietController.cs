using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.DAO;
using Model.EF;
using Webbbbbbbbbbb.Common;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class BaiVietController : BaseController
    {
        // GET: Admin/BaiViet
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new BaiVietDAO();
            var model = dao.ListAllPaging(searchString, page, pageSize);

            ViewBag.SearchString = searchString;
            return View(model);
            
        }

        [HttpDelete]

        public ActionResult Delete(int id)
        {
            new BaiVietDAO().Delete(id);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Edit(long id)
        {
            var dao = new BaiVietDAO();
            var content = dao.GetByID(id);
            LoadDanhMuc(content.DanhMucID);

            return View(content);
        }


        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(BaiViet model)
        {
           
            if (ModelState.IsValid)
            {
                var dao = new BaiVietDAO();
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                model.NguoiUpdate = session.UserName;

                var culture = Session[CommonConstants.CurrentCulture];

                var result = dao.Edit(model);
                if (result)
                {
                    SetAlert("Sửa bài viết thành công", "success");
                    return RedirectToAction("Index", "BaiViet");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật bài viết không thành công");
                }
            }
            LoadDanhMuc();
            return View();
        }

        [HttpGet]
        public ActionResult Create()
        {
            LoadDanhMuc();
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(BaiViet model)
        {
            bool t = true;
            if(model.NoiDung == null)
            {
                t = false;
            }
            if (ModelState.IsValid)
            {
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                model.NguoiTao = session.UserName;
               
                var culture = Session[CommonConstants.CurrentCulture];
                
                new BaiVietDAO().Create(model);
                SetAlert("Thêm bài viết thành công", "success");
                return RedirectToAction("Index", "BaiViet");
            }
            LoadDanhMuc();
            return View();
        }

        public void LoadDanhMuc(long? selectedId = null)
        {
            var dao = new DanhMucDAO();
            ViewBag.DanhMucID = new SelectList(dao.ListAll(), "ID", "TenDanhMuc", selectedId);
        }
    }
}