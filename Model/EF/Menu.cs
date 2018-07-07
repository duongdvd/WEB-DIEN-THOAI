namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Menu")]
    public partial class Menu
    {
        public int ID { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(500)]
        public string url { get; set; }

        public int? STT { get; set; }

        public int? GroupID { get; set; }

        public virtual MenuGroup MenuGroup { get; set; }
    }
}
