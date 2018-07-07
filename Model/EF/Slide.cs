namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Slide")]
    public partial class Slide
    {
        public int ID { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(500)]
        public string Image { get; set; }

        [StringLength(500)]
        public string url { get; set; }

        public int? STT { get; set; }

        public bool Trangthai { get; set; }

        public string NoiDung { get; set; }

        [StringLength(100)]
        public string btn { get; set; }
    }
}
