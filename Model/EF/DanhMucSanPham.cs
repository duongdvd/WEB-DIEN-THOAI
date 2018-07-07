namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DanhMucSanPham")]
    public partial class DanhMucSanPham
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DanhMucSanPham()
        {
            SanPhams = new HashSet<SanPham>();
        }

        public int ID { get; set; }

        [Required]
        [Display(Name = "Tên danh mục")]
        [StringLength(250)]
        public string TenDanhMuc { get; set; }

        [Display(Name = "Thứ tự")]
        public int? ThuTu { get; set; }

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

        [Display(Name = "Phụ kiện")]
        public bool PhuKien { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SanPham> SanPhams { get; set; }
    }
}
