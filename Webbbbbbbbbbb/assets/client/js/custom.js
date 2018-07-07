//(function ($) {
//    $('#btnthanhtoan').off('click').on('click', function () {
//        alert("ccc");
//        var listProduct = $('.txtQuantity');
//        var cartList = [];
//        $.each(listProduct, function (i, item) {
//            cartList.push({
//                SoLuong: $(item).val(),
//                SanPham: {
//                    ID: $(item).data('id')
//                }
//            });
//        });

//        $.ajax({
//            url: '/GioHang/Update',
//            data: { cartModel: JSON.stringify(cartList) },
//            dataType: 'json',
//            type: 'POST',
//            success: function (res) {
//                if (res.status == true) {
//                    window.location.href = "/GioHang";
//                }
//            }
//        })
//    });
//});




var cart = {
    init: function () {
        cart.regEvents();
    },
    regEvents: function () {
        $('#btnthanhtoan').off('click').on('click', function () {
           
            var listProduct = $('.txtQuantity');
            var cartList = [];
            $.each(listProduct, function (i, item) {
                cartList.push({
                    SoLuong: $(item).val(),
                    SanPham: {
                        ID: $(item).data('id')
                    }
                });
            });

            $.ajax({
                url: '/GioHang/Update',
                data: { cartModel: JSON.stringify(cartList) },
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    if (res.status == true) {
                        window.location.href = "/GioHang/ThanhToan";
                    }
                }
            })
        });
    }
}
cart.init();

