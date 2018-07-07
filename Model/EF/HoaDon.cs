namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("HoaDon")]
    public partial class HoaDon
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public HoaDon()
        {
            ChiTietHoaDons = new HashSet<ChiTietHoaDon>();
        }

        public int ID { get; set; }

        [Required]
        [StringLength(50)]
        public string TenKhachHang { get; set; }

        [Required]
        [StringLength(500)]
        public string DiaChi { get; set; }

        [Required]
        [StringLength(50)]
        public string SDT { get; set; }

        public string GhiChu { get; set; }

        public DateTime? NgayTao { get; set; }

        [StringLength(50)]
        public string NguoiTao { get; set; }

        [StringLength(250)]
        public string PhuongThucThanhToan { get; set; }

        public bool TrangThai { get; set; }

        [Required]
        [StringLength(500)]
        public string Gmail { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDon> ChiTietHoaDons { get; set; }
    }
}
