using Model.DAO;
using System.Web.Mvc;
using Model.EF;
using Webbbbbbbbbbb.Common;

namespace Webbbbbbbbbbb.Areas.Admin.Controllers
{
    public class DanhMucBaiVietController : BaseController
    {
        // GET: Admin/DanhMucBaiViet
        public ActionResult Index(string searchString, int page = 1, int pageSize = 5)
        {
            var dao = new DanhMucDAO();
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
            var DMuc = new DanhMucDAO().ViewDetail(id);
            return View(DMuc);
        }

      

        [HttpPost]
        public ActionResult Create(DanhMucBaiViet model)
        {
            if (ModelState.IsValid)
            {
                var currentCulture = Session[CommonConstants.CurrentCulture];
               
                var id = new DanhMucDAO().Insert(model);
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
        public ActionResult Edit(DanhMucBaiViet user)
        {
            
                var dao = new DanhMucDAO();
                var result = dao.Update(user);
                if (result)
                {
                    SetAlert("Sửa danh mục thành công", "success");
                return RedirectToAction("Index", "DanhMucBaiViet");
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
            new DanhMucDAO().Delete(id);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index");
        }



    }
}