namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("User")]
    public partial class User
    {
        public int ID { get; set; }

        [StringLength(32)]
        public string Pass { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(500)]
        public string Address { get; set; }

        public DateTime? NgayTao { get; set; }

        [StringLength(50)]
        public string NguoiTao { get; set; }

        public DateTime? NgayUpdate { get; set; }

        [StringLength(50)]
        public string NguoiUpdate { get; set; }

        public bool TrangThai { get; set; }

        public int? GroupID { get; set; }

        [StringLength(50)]
        public string SDT { get; set; }

        [StringLength(500)]
        public string Email { get; set; }

        [StringLength(250)]
        public string HoTen { get; set; }
    }
}
