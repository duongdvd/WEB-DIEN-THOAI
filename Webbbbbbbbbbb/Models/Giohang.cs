using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Webbbbbbbbbbb.Models
{
    [Serializable]
    public class Giohang
    {
        public SanPham SanPham { set; get; }
        public int SoLuong { set; get; }
    }
}