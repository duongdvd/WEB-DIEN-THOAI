namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PhanHoiKH")]
    public partial class PhanHoiKH
    {
        public int ID { get; set; }

        [Required]
        [StringLength(250)]
        public string Name { get; set; }

        [StringLength(250)]
        public string Email { get; set; }

        [StringLength(500)]
        public string Message { get; set; }

        public DateTime NgayTao { get; set; }

        public bool TrangThai { get; set; }
    }
}
