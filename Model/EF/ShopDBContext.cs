namespace Model.EF
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class ShopDBContext : DbContext
    {
        public ShopDBContext()
            : base("name=ShopDBContext")
        {
        }

        public virtual DbSet<BaiViet> BaiViets { get; set; }
        public virtual DbSet<ChiTietHoaDon> ChiTietHoaDons { get; set; }
        public virtual DbSet<DanhMucBaiViet> DanhMucBaiViets { get; set; }
        public virtual DbSet<DanhMucSanPham> DanhMucSanPhams { get; set; }
        public virtual DbSet<Footer> Footers { get; set; }
        public virtual DbSet<GioiThieu> GioiThieus { get; set; }
        public virtual DbSet<HoaDon> HoaDons { get; set; }
        public virtual DbSet<Menu> Menus { get; set; }
        public virtual DbSet<MenuGroup> MenuGroups { get; set; }
        public virtual DbSet<PhanHoiKH> PhanHoiKHs { get; set; }
        public virtual DbSet<SanPham> SanPhams { get; set; }
        public virtual DbSet<Slide> Slides { get; set; }
        public virtual DbSet<SupportOnline> SupportOnlines { get; set; }
        public virtual DbSet<SystemConfig> SystemConfigs { get; set; }
        public virtual DbSet<TAG> TAGS { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BaiViet>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<BaiViet>()
                .Property(e => e.NguoiUpdate)
                .IsUnicode(false);

            modelBuilder.Entity<BaiViet>()
                .HasMany(e => e.TAGS)
                .WithMany(e => e.BaiViets)
                .Map(m => m.ToTable("BaiVietTag").MapLeftKey("ID").MapRightKey("TagID"));

            modelBuilder.Entity<ChiTietHoaDon>()
                .Property(e => e.Gia)
                .HasPrecision(18, 0);

            modelBuilder.Entity<DanhMucBaiViet>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<DanhMucBaiViet>()
                .Property(e => e.NguoiUpdate)
                .IsUnicode(false);

            modelBuilder.Entity<DanhMucBaiViet>()
                .HasMany(e => e.BaiViets)
                .WithRequired(e => e.DanhMucBaiViet)
                .HasForeignKey(e => e.DanhMucID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<DanhMucSanPham>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<DanhMucSanPham>()
                .Property(e => e.NguoiUpdate)
                .IsUnicode(false);

            modelBuilder.Entity<DanhMucSanPham>()
                .HasMany(e => e.SanPhams)
                .WithOptional(e => e.DanhMucSanPham)
                .HasForeignKey(e => e.DanhMucID);

            modelBuilder.Entity<HoaDon>()
                .Property(e => e.SDT)
                .IsUnicode(false);

            modelBuilder.Entity<HoaDon>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<HoaDon>()
                .HasMany(e => e.ChiTietHoaDons)
                .WithRequired(e => e.HoaDon)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<MenuGroup>()
                .HasMany(e => e.Menus)
                .WithOptional(e => e.MenuGroup)
                .HasForeignKey(e => e.GroupID);

            modelBuilder.Entity<SanPham>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<SanPham>()
                .Property(e => e.NguoiUpdate)
                .IsUnicode(false);

            modelBuilder.Entity<SanPham>()
                .Property(e => e.Gia)
                .HasPrecision(18, 0);

            modelBuilder.Entity<SanPham>()
                .Property(e => e.GiaKhuyenMai)
                .HasPrecision(18, 0);

            modelBuilder.Entity<SanPham>()
                .HasMany(e => e.ChiTietHoaDons)
                .WithRequired(e => e.SanPham)
                .HasForeignKey(e => e.IDSanPham)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SystemConfig>()
                .Property(e => e.Code)
                .IsUnicode(false);

            modelBuilder.Entity<TAG>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Pass)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.NguoiTao)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.NguoiUpdate)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.SDT)
                .IsUnicode(false);
        }
    }
}
