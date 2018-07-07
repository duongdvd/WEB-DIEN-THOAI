namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SupportOnline")]
    public partial class SupportOnline
    {
        public int ID { get; set; }

        [StringLength(250)]
        public string FB { get; set; }

        [StringLength(250)]
        public string Zalo { get; set; }

        [StringLength(250)]
        public string MAIL { get; set; }

        public bool? TrangThai { get; set; }
    }
}
