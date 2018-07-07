namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SanPham")]
    public partial class SanPham
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SanPham()
        {
            ChiTietHoaDons = new HashSet<ChiTietHoaDon>();
        }

        public int ID { get; set; }

        [StringLength(500)]
        [Display(Name = "Tên sản phẩm")]
        public string TenSanPham { get; set; }

        [Display(Name = "Danh Mục")]
        public int? DanhMucID { get; set; }

        public DateTime? NgayTao { get; set; }

        [StringLength(50)]
        public string NguoiTao { get; set; }

        public DateTime? NgayUpdate { get; set; }

        [StringLength(50)]
        public string NguoiUpdate { get; set; }

        [Display(Name = "Trạng thái")]
        public bool TrangThai { get; set; }

        [StringLength(500)]
        [Display(Name = "Image")]
        public string image { get; set; }

        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [Display(Name = "Sản phẩm hot")]
        public bool SPHOT { get; set; }

        public int? ViewCount { get; set; }

        [Column(TypeName = "xml")]
        public string MoreImage { get; set; }

        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }

        [Display(Name = "Nội dung")]
        public string NoiDung { get; set; }

        [Display(Name = "Giá")]
        public decimal? Gia { get; set; }

        [Display(Name = "Giá khuyến mãi")]
        public decimal? GiaKhuyenMai { get; set; }

        [Display(Name = "Bảo hành")]
        public int? BaoHanh { get; set; }

        [Display(Name = "Độ phân giải")]
        [StringLength(50)]
        public string DoPhanGiai { get; set; }

        [StringLength(20)]
        [Display(Name = "Màn hình")]
        public string ManHinh { get; set; }

        [StringLength(50)]
        [Display(Name = "Camera trước")]
        public string CamTruoc { get; set; }

        [StringLength(50)]
        [Display(Name = "Camera sau")]
        public string CamSau { get; set; }

        [StringLength(250)]
        public string CPU { get; set; }


        [StringLength(250)]
        [Display(Name = "Số nhân")]
        public string SoNhan { get; set; }

        [StringLength(250)]
        [Display(Name = "Chipset")]
        public string Chip { get; set; }

        [StringLength(50)]
        public string Ram { get; set; }

        [StringLength(50)]
        public string ROM { get; set; }

        [StringLength(250)]
        [Display(Name = "Hệ điều hành")]
        public string HeDieuHanh { get; set; }

        [StringLength(50)]
        [Display(Name = "Pin")]
        public string Pin { get; set; }

        [StringLength(50)]
        [Display(Name = "Dung lượng pin")]
        public string DungluongPin { get; set; }

        [StringLength(250)]
        public string Sim { get; set; }

        [StringLength(250)]
        public string wifi { get; set; }

        [StringLength(50)]
        public string Bluetooth { get; set; }


        [StringLength(50)]
        public string GPS { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDon> ChiTietHoaDons { get; set; }

        public virtual DanhMucSanPham DanhMucSanPham { get; set; }
    }
}
