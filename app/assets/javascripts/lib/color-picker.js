/*
 *
 * jQuery Color Picker Plugin
 * URL: http://www.codecanyon.net/user/bamdaa
 * Version: 1.2.1
 * Author: BamDaa
 * Author URL: http://www.codecanyon.net/user/bamdaa
 http://codecanyon.net/item/jquery-color-picker/full_screen_preview/5946602?ref=jqueryrain&ref=jqueryrain&clickthrough_id=228120585&redirect_back=true
 *
 */

if (typeof Object.create !== 'function') {
    Object.create = function (a) {
        function F() {};
        F.prototype = a;
        return new F()
    }
}(function ($, h, i, j) {
    var k = {
        init: function (b, c) {
            var d = this;
            d.elem = c;
            d.$elem = $(c);
            d.options = $.extend({}, $.fn.colorPicker.options, b);
            if (typeof d.options.colors == "string") {
                $.ajax({
                    dataType: "json",
                    url: d.options.colors,
                    success: function (a) {
                        d.options.colors = a;
                        d.build()
                    }
                }).error(function () {
                    alert("Can't load " + d.options.colors + " file.")
                })
            } else {
                d.build()
            }
            d.$elem.bind("click", function (a) {
                a.preventDefault();
                if (d.pWindow.attr("data-picker-open") == "false") {
                    $(".bmd-picker-window").attr("data-picker-open", "false").fadeOut();
                    d.pWindow.attr("data-picker-open", "true");
                    d.setPosition();
                    d.pWindow.show()
                } else {
                    d.pWindow.attr("data-picker-open", "false");
                    d.pWindow.fadeOut()
                }
            })
        },
        build: function (e) {
            var d = this;
            d.pWindow = $(d.template.window);
            d.pColorList = $(d.template.list);
            if (d.options.customColors.length > 0) {
                d.options.colors = d.options.colors.concat(d.options.customColors)
            }
            if (d.$elem.attr("data-custom-colors")) {
                var f = eval(d.$elem.data("custom-colors"));
                d.options.colors = d.options.colors.concat(f)
            }
            $.each(d.options.colors, function (a, b) {
                var c = $(d.template.item);
                if (a > 0 && (a) % d.options.rowItem == 0) d.pColorList.append('<li class="split-color-row"></li>');
                c.find("a").css("background", b).attr("href", b).data("color", b).bind("click", function (e) {
                    e.preventDefault();
                    d.options.onSelect(d.$elem, $(this).data("color"));
                    d.pWindow.attr("data-picker-open", "false");
                    d.pWindow.fadeOut()
                });
                c.appendTo(d.pColorList)
            });
            d.pColorList.appendTo(d.pWindow);
            var g = 0;
            if (d.options.insertCode == 1) {
                if (d.$elem.attr("data-insert-code") != "0") {
                    g = 1
                }
            } else {
                if (d.$elem.attr("data-insert-code") == "1") {
                    g = 1
                }
            } if (g == 1) {
                d.newColor = $(d.template.form);
                d.newColor.find("#hexColorButton").bind("click", function () {
                    var a = d.newColor.find("#hexColorInput").val();
                    d.options.onSelect(d.$elem, a);
                    d.pWindow.attr("data-picker-open", "false");
                    d.pWindow.fadeOut()
                });
                d.newColor.appendTo(d.pWindow)
            }
            d.pWindow.appendTo("body");
            d.pickerIs = false;
            $(i).mouseup(function (e) {
                if (!d.pWindow.is(e.target) && !d.$elem.is(e.target) && d.pWindow.has(e.target).length === 0) {
                    d.pWindow.attr("data-picker-open", "false");
                    d.pWindow.fadeOut()
                }
            })
        },
        setPosition: function () {
            var a = this;
            var b = a.elem.offsetHeight;
            var c = a.$elem.offset().left;
            var d = a.$elem.offset().top;
            a.pWindow.css({
                left: c,
                top: d + b + 2
            })
        },
        template: {
            window: '<div class="bmd-picker-window" data-picker-open="false"></div>',
            list: '<ul class="bmd-color-list"></ul>',
            item: '<li><a href=""></a></li>',
            form: '<div class="hexColorForm"><input type="text" id="hexColorInput" placeholder="#FF6600"/><input type="button" id="hexColorButton" value="Set" /></div>'
        }
    };
    $.fn.colorPicker = function (b) {
        return this.each(function () {
            var a = Object.create(k);
            a.init(b, this)
        })
    };
    $.fn.colorPicker.options = {
        colors: ['#ffffff', '#000000', '#eeece1', '#1f497d', '#4f81bd', '#c0504d', '#9bbb59', '#8064a2', '#4bacc6', '#f79646', '#ffff00', '#f2f2f2', '#7f7f7f', '#ddd9c3', '#c6d9f0', '#dbe5f1', '#f2dcdb', '#ebf1dd', '#e5e0ec', '#dbeef3', '#fdeada', '#fff2ca', '#d8d8d8', '#595959', '#c4bd97', '#8db3e2', '#b8cce4', '#e5b9b7', '#d7e3bc', '#ccc1d9', '#b7dde8', '#fbd5b5', '#ffe694', '#bfbfbf', '#3f3f3f', '#938953', '#548dd4', '#95b3d7', '#d99694', '#c3d69b', '#b2a2c7', '#b7dde8', '#fac08f', '#f2c314', '#a5a5a5', '#262626', '#494429', '#17365d', '#366092', '#953734', '#76923c', '#5f497a', '#92cddc', '#e36c09', '#c09100', '#7f7f7f', '#0c0c0c', '#1d1b10', '#0f243e', '#244061', '#632423', '#4f6128', '#3f3151', '#31859b', '#974806', '#7f6000'],
        customColors: [],
        insertCode: 0,
        rowItem: 11,
        onSelect: function (a, b) {
            console.log(b)
        }
    }
})(jQuery, window, document)