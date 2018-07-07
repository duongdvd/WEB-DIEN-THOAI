namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BaiViet")]
    public partial class BaiViet
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BaiViet()
        {
            TAGS = new HashSet<TAG>();
        }

        public int ID { get; set; }

        [Required]
        [StringLength(500)]
        [Display(Name = "Tên bài viết")]
        public string TenBaiViet { get; set; }
        [Display(Name = "Danh Mục")]
        public int DanhMucID { get; set; }

        public DateTime? NgayTao { get; set; }

        [StringLength(50)]
        public string NguoiTao { get; set; }

        public DateTime? NgayUpdate { get; set; }

        [StringLength(50)]
        public string NguoiUpdate { get; set; }
        [Display(Name = "Trạng thái")]
        public bool TrangThai { get; set; }

        [Display(Name = "Image")]
        [StringLength(500)]
        public string image { get; set; }

        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        public int? ViewCount { get; set; }

        [Column(TypeName = "xml")]
        public string MoreImage { get; set; }

        [Column(TypeName = "ntext")]
        public string NoiDung { get; set; }

        [Display(Name = "Tiêu đề")]
        [StringLength(500)]
        public string TieuDeBaiViet { get; set; }

        [Display(Name = "Mô tả")]
        [StringLength(500)]
        public string MoTa { get; set; }

        public virtual DanhMucBaiViet DanhMucBaiViet { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TAG> TAGS { get; set; }
    }
}
