namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("GioiThieu")]
    public partial class GioiThieu
    {
        public int ID { get; set; }

        [Required]
        [StringLength(250)]
        public string Name { get; set; }

        public string Conten { get; set; }
    }
}
