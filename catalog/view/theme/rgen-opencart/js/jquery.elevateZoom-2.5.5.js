/* jQuery elevateZoom 2.5.5 - Demo's and documentation: - www.elevateweb.co.uk/image-zoom - Copyright (c) 2012 Andrew Eades - www.elevateweb.co.uk - Dual licensed under the LGPL licenses. - http://en.wikipedia.org/wiki/MIT_License - http://en.wikipedia.org/wiki/GNU_General_Public_License */
"function" !== typeof Object.create && (Object.create = function (d) {
    function e() {}
    e.prototype = d;
    return new e
});
(function (d) {
    var e = {
        init: function (a, b) {
            var c = this;
            c.elem = b;
            c.$elem = d(b);
            c.imageSrc = c.$elem.data("zoom-image") ? c.$elem.data("zoom-image") : c.$elem.attr("src");
            c.options = d.extend({}, d.fn.elevateZoom.options, a);
            c.options.tint && (c.options.lensColour = "none", c.options.lensOpacity = "1");
            "inner" == c.options.zoomType && (c.options.showLens = !1);
            c.$elem.parent().removeAttr("title").removeAttr("alt");
            c.zoomImage = c.imageSrc;
            c.refresh(1);
            d("#" + c.options.gallery + " a").click(function (a) {
                c.options.galleryActiveClass &&
                    (d("#" + c.options.gallery + " a").removeClass(c.options.galleryActiveClass), d(this).addClass(c.options.galleryActiveClass));
                a.preventDefault();
                c.zoomImagePre = d(this).data("zoom-image") ? d(this).data("zoom-image") : d(this).data("image");
                c.swaptheimage(d(this).data("image"), c.zoomImagePre);
                return !1
            })
        },
        refresh: function (a) {
            var b = this;
            setTimeout(function () {
                b.fetch(b.imageSrc)
            }, a || b.options.refresh)
        },
        fetch: function (a) {
            var b = this,
                c = new Image;
            c.onload = function () {
                b.largeWidth = c.width;
                b.largeHeight = c.height;
                b.startZoom();
                b.currentImage = b.imageSrc;
                b.options.onZoomedImageLoaded(b.$elem)
            };
            c.src = a
        },
        startZoom: function () {
            var a = this;
            a.nzWidth = a.$elem.width();
            a.nzHeight = a.$elem.height();
            a.nzOffset = a.$elem.offset();
            a.widthRatio = a.largeWidth / a.options.zoomLevel / a.nzWidth;
            a.heightRatio = a.largeHeight / a.options.zoomLevel / a.nzHeight;
            "window" == a.options.zoomType && (a.zoomWindowStyle = "overflow: hidden;background-position: 0px 0px;text-align:center;background-color: " + String(a.options.zoomWindowBgColour) + ";width: " + String(a.options.zoomWindowWidth) +
                "px;height: " + String(a.options.zoomWindowHeight) + "px;float: left;background-size: " + a.largeWidth / a.options.zoomLevel + "px " + a.largeHeight / a.options.zoomLevel + "px;display: none;z-index:100px;border: " + String(a.options.borderSize) + "px solid " + a.options.borderColour + ";background-repeat: no-repeat;position: absolute;");
            "inner" == a.options.zoomType && (a.zoomWindowStyle = "overflow: hidden;background-position: 0px 0px;width: " + String(a.nzWidth) + "px;height: " + String(a.nzHeight) + "px;float: left;display: none;cursor:" +
                a.options.cursor + ";px solid " + a.options.borderColour + ";background-repeat: no-repeat;position: absolute;");
            "window" == a.options.zoomType && (lensHeight = a.nzHeight < a.options.zoomWindowWidth / a.widthRatio ? a.nzHeight : String(a.options.zoomWindowHeight / a.heightRatio), lensWidth = a.largeWidth < a.options.zoomWindowWidth ? a.nzWidth : a.options.zoomWindowWidth / a.widthRatio, a.lensStyle = "background-position: 0px 0px;width: " + String(a.options.zoomWindowWidth / a.widthRatio) + "px;height: " + String(a.options.zoomWindowHeight /
                a.heightRatio) + "px;float: right;display: none;overflow: hidden;z-index: 999;-webkit-transform: translateZ(0);opacity:" + a.options.lensOpacity + ";filter: alpha(opacity = " + 100 * a.options.lensOpacity + "); zoom:1;width:" + lensWidth + "px;height:" + lensHeight + "px;background-color:" + a.options.lensColour + ";cursor:" + a.options.cursor + ";border: " + a.options.lensBorderSize + "px solid " + a.options.lensBorderColour + ";background-repeat: no-repeat;position: absolute;");
            a.tintStyle = "display: block;position: absolute;background-color: " +
                a.options.tintColour + ";filter:alpha(opacity=0);opacity: 0;width: " + a.nzWidth + "px;height: " + a.nzHeight + "px;";
            a.lensRound = "";
            "lens" == a.options.zoomType && (a.lensStyle = "background-position: 0px 0px;float: left;display: none;border: " + String(a.options.borderSize) + "px solid " + a.options.borderColour + ";width:" + String(a.options.lensSize) + "px;height:" + String(a.options.lensSize) + "px;background-repeat: no-repeat;position: absolute;");
            "round" == a.options.lensShape && (a.lensRound = "border-top-left-radius: " + String(a.options.lensSize /
                2 + a.options.borderSize) + "px;border-top-right-radius: " + String(a.options.lensSize / 2 + a.options.borderSize) + "px;border-bottom-left-radius: " + String(a.options.lensSize / 2 + a.options.borderSize) + "px;border-bottom-right-radius: " + String(a.options.lensSize / 2 + a.options.borderSize) + "px;");
            a.zoomContainer = d('<div class="zoomContainer" style="-webkit-transform: translateZ(0);position:absolute;left:' + a.nzOffset.left + "px;top:" + a.nzOffset.top + "px;height:" + a.nzHeight + "px;width:" + a.nzWidth + 'px;"></div>');
            d("body").append(a.zoomContainer);
            a.options.containLensZoom && "lens" == a.options.zoomType && a.zoomContainer.css("overflow", "hidden");
            "inner" != a.options.zoomType && (a.zoomLens = d("<div class='zoomLens' style='" + a.lensStyle + a.lensRound + "'>&nbsp;</div>").appendTo(a.zoomContainer).click(function () {
                a.$elem.trigger("click")
            }));
            a.options.tint && (a.tintContainer = d("<div/>").addClass("tintContainer"), a.zoomTint = d("<div class='zoomTint' style='" + a.tintStyle + "'></div>"), a.zoomLens.wrap(a.tintContainer), a.zoomTintcss = a.zoomLens.after(a.zoomTint), a.zoomTintImage =
                d('<img style="position: absolute; left: 0px; top: 0px; max-width: none; width: ' + a.nzWidth + "px; height: " + a.nzHeight + 'px;" src="' + a.imageSrc + '">').appendTo(a.zoomLens).click(function () {
                a.$elem.trigger("click")
            }));
            a.zoomWindow = isNaN(a.options.zoomWindowPosition) ? d("<div style='z-index:999;left:" + a.windowOffsetLeft + "px;top:" + a.windowOffsetTop + "px;" + a.zoomWindowStyle + "' class='zoomWindow'>&nbsp;</div>").appendTo("body").click(function () {
                a.$elem.trigger("click")
            }) : d("<div style='z-index:999;left:" + a.windowOffsetLeft +
                "px;top:" + a.windowOffsetTop + "px;" + a.zoomWindowStyle + "' class='zoomWindow'>&nbsp;</div>").appendTo(a.zoomContainer).click(function () {
                a.$elem.trigger("click")
            });
            a.zoomWindowContainer = d("<div/>").addClass("zoomWindowContainer").css("width", a.options.zoomWindowWidth);
            a.zoomWindow.wrap(a.zoomWindowContainer);
            "lens" == a.options.zoomType && a.zoomLens.css({
                backgroundImage: "url('" + a.imageSrc + "')"
            });
            "window" == a.options.zoomType && a.zoomWindow.css({
                backgroundImage: "url('" + a.imageSrc + "')"
            });
            "inner" == a.options.zoomType &&
                a.zoomWindow.css({
                backgroundImage: "url('" + a.imageSrc + "')"
            });
            a.$elem.bind("touchmove", function (b) {
                b.preventDefault();
                a.setPosition(b.originalEvent.touches[0] || b.originalEvent.changedTouches[0])
            });
            a.zoomContainer.bind("touchmove", function (b) {
                "inner" == a.options.zoomType && (a.options.zoomWindowFadeIn ? a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                b.preventDefault();
                a.setPosition(b.originalEvent.touches[0] || b.originalEvent.changedTouches[0])
            });
            a.zoomContainer.bind("touchend", function () {
                a.zoomWindow.hide();
                a.options.showLens && a.zoomLens.hide();
                a.options.tint && a.zoomTint.hide()
            });
            a.$elem.bind("touchend", function () {
                a.zoomWindow.hide();
                a.options.showLens && a.zoomLens.hide();
                a.options.tint && a.zoomTint.hide()
            });
            a.options.showLens && (a.zoomLens.bind("touchmove", function (b) {
                b.preventDefault();
                a.setPosition(b.originalEvent.touches[0] || b.originalEvent.changedTouches[0])
            }), a.zoomLens.bind("touchend", function () {
                a.zoomWindow.hide();
                a.options.showLens && a.zoomLens.hide();
                a.options.tint &&
                    a.zoomTint.hide()
            }));
            a.$elem.bind("mousemove", function (b) {
                (a.lastX !== b.clientX || a.lastY !== b.clientY) && a.setPosition(b);
                a.lastX = b.clientX;
                a.lastY = b.clientY
            });
            a.zoomContainer.bind("mousemove", function (b) {
                (a.lastX !== b.clientX || a.lastY !== b.clientY) && a.setPosition(b);
                a.lastX = b.clientX;
                a.lastY = b.clientY
            });
            "inner" != a.options.zoomType && a.zoomLens.bind("mousemove", function (b) {
                (a.lastX !== b.clientX || a.lastY !== b.clientY) && a.setPosition(b);
                a.lastX = b.clientX;
                a.lastY = b.clientY
            });
            a.options.tint && a.zoomTint.bind("mousemove", function (b) {
                (a.lastX !== b.clientX || a.lastY !== b.clientY) && a.setPosition(b);
                a.lastX = b.clientX;
                a.lastY = b.clientY
            });
            "inner" == a.options.zoomType && a.zoomWindow.bind("mousemove", function (b) {
                (a.lastX !== b.clientX || a.lastY !== b.clientY) && a.setPosition(b);
                a.lastX = b.clientX;
                a.lastY = b.clientY
            });
            a.zoomContainer.mouseenter(function () {
                "inner" == a.options.zoomType && (a.options.zoomWindowFadeIn ? a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                "window" == a.options.zoomType && (a.options.zoomWindowFadeIn ?
                    a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                a.options.showLens && (a.options.lensFadeIn ? a.zoomLens.stop(!0, !0).fadeIn(a.options.lensFadeIn) : a.zoomLens.show());
                a.options.tint && (a.options.zoomTintFadeIn ? a.zoomTint.stop(!0, !0).fadeIn(a.options.zoomTintFadeIn) : a.zoomTint.show())
            }).mouseleave(function () {
                a.zoomWindow.hide();
                a.options.showLens && a.zoomLens.hide();
                a.options.tint && a.zoomTint.hide()
            });
            a.$elem.mouseenter(function () {
                "inner" == a.options.zoomType && (a.options.zoomWindowFadeIn ?
                    a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                "window" == a.options.zoomType && (a.options.zoomWindowFadeIn ? a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                a.options.showLens && (a.options.lensFadeIn ? a.zoomLens.stop(!0, !0).fadeIn(a.options.lensFadeIn) : a.zoomLens.show());
                a.options.tint && (a.options.zoomTintFadeIn ? a.zoomTint.stop(!0, !0).fadeIn(a.options.zoomTintFadeIn) : a.zoomTint.show())
            }).mouseleave(function () {
                a.zoomWindow.hide();
                a.options.showLens &&
                    a.zoomLens.hide();
                a.options.tint && a.zoomTint.hide()
            });
            "inner" != a.options.zoomType && a.zoomLens.mouseenter(function () {
                "inner" == a.options.zoomType && (a.options.zoomWindowFadeIn ? a.zoomWindow.stop(!0, !0).fadeIn(a.options.zoomWindowFadeIn) : a.zoomWindow.show());
                "window" == a.options.zoomType && a.zoomWindow.show();
                a.options.showLens && a.zoomLens.show();
                a.options.tint && a.zoomTint.show()
            }).mouseleave(function () {
                a.options.zoomWindowFadeOut ? a.zoomWindow.stop(!0, !0).fadeOut(a.options.zoomWindowFadeOut) : a.zoomWindow.hide();
                "inner" != a.options.zoomType && a.zoomLens.hide();
                a.options.tint && a.zoomTint.hide()
            });
            a.options.tint && a.zoomTint.mouseenter(function () {
                "inner" == a.options.zoomType && a.zoomWindow.show();
                "window" == a.options.zoomType && a.zoomWindow.show();
                a.options.showLens && a.zoomLens.show();
                a.zoomTint.show()
            }).mouseleave(function () {
                a.zoomWindow.hide();
                "inner" != a.options.zoomType && a.zoomLens.hide();
                a.zoomTint.hide()
            });
            "inner" == a.options.zoomType && a.zoomWindow.mouseenter(function () {
                "inner" == a.options.zoomType && a.zoomWindow.show();
                "window" == a.options.zoomType && a.zoomWindow.show();
                a.options.showLens && a.zoomLens.show()
            }).mouseleave(function () {
                a.options.zoomWindowFadeOut ? a.zoomWindow.stop(!0, !0).fadeOut(a.options.zoomWindowFadeOut) : a.zoomWindow.hide();
                "inner" != a.options.zoomType && a.zoomLens.hide()
            })
        },
        setPosition: function (a) {
            this.nzHeight = this.$elem.height();
            this.nzWidth = this.$elem.width();
            this.nzOffset = this.$elem.offset();
            this.options.tint && (this.zoomTint.css({
                top: 0
            }), this.zoomTint.css({
                left: 0
            }));
            this.options.responsive && (lensHeight =
                this.nzHeight < this.options.zoomWindowWidth / this.widthRatio ? this.nzHeight : String(this.options.zoomWindowHeight / this.heightRatio), lensWidth = this.largeWidth < this.options.zoomWindowWidth ? this.nzHWidth : this.options.zoomWindowWidth / this.widthRatio, this.widthRatio = this.largeWidth / this.nzWidth, this.heightRatio = this.largeHeight / this.nzHeight, this.zoomLens.css({
                width: String(this.options.zoomWindowWidth / this.widthRatio) + "px",
                height: String(this.options.zoomWindowHeight / this.heightRatio) + "px"
            }));
            this.zoomContainer.css({
                top: this.nzOffset.top
            });
            this.zoomContainer.css({
                left: this.nzOffset.left
            });
            this.mouseLeft = parseInt(a.pageX - this.nzOffset.left);
            this.mouseTop = parseInt(a.pageY - this.nzOffset.top);
            "window" == this.options.zoomType && (this.Etoppos = this.mouseTop < this.zoomLens.height() / 2, this.Eboppos = this.mouseTop > this.nzHeight - this.zoomLens.height() / 2 - 2 * this.options.lensBorderSize, this.Eloppos = this.mouseLeft < 0 + this.zoomLens.width() / 2, this.Eroppos = this.mouseLeft > this.nzWidth - this.zoomLens.width() / 2 - 2 * this.options.lensBorderSize);
            "inner" == this.options.zoomType &&
                (this.Etoppos = this.mouseTop < this.nzHeight / 2 / this.heightRatio, this.Eboppos = this.mouseTop > this.nzHeight - this.nzHeight / 2 / this.heightRatio, this.Eloppos = this.mouseLeft < 0 + this.nzWidth / 2 / this.widthRatio, this.Eroppos = this.mouseLeft > this.nzWidth - this.nzWidth / 2 / this.widthRatio - 2 * this.options.lensBorderSize);
            0 > this.mouseLeft || 0 >= this.mouseTop || this.mouseLeft > this.nzWidth || this.mouseTop > this.nzHeight ? (this.zoomWindow.hide(), this.options.showLens && this.zoomLens.hide(), this.options.tint && this.zoomTint.hide()) :
                ("window" == this.options.zoomType && this.zoomWindow.show(), this.options.tint && this.zoomTint.show(), this.options.showLens && (this.zoomLens.show(), this.lensLeftPos = String(this.mouseLeft - this.zoomLens.width() / 2), this.lensTopPos = String(this.mouseTop - this.zoomLens.height() / 2)), this.Etoppos && (this.lensTopPos = 0), this.Eloppos && (this.tintpos = this.lensLeftPos = this.windowLeftPos = 0), "window" == this.options.zoomType && (this.Eboppos && (this.lensTopPos = Math.max(this.nzHeight - this.zoomLens.height() - 2 * this.options.lensBorderSize,
                0)), this.Eroppos && (this.lensLeftPos = this.nzWidth - this.zoomLens.width() - 2 * this.options.lensBorderSize)), "inner" == this.options.zoomType && (this.Eboppos && (this.lensTopPos = Math.max(this.nzHeight - 2 * this.options.lensBorderSize, 0)), this.Eroppos && (this.lensLeftPos = this.nzWidth - this.nzWidth - 2 * this.options.lensBorderSize)), "lens" == this.options.zoomType && (this.windowLeftPos = String(-1 * ((a.pageX - this.nzOffset.left) * this.widthRatio - this.zoomLens.width() / 2)), this.windowTopPos = String(-1 * ((a.pageY - this.nzOffset.top) *
                this.heightRatio - this.zoomLens.height() / 2)), this.zoomLens.css({
                backgroundPosition: this.windowLeftPos + "px " + this.windowTopPos + "px"
            }), this.setWindowPostition(a)), this.options.tint && this.setTintPosition(a), "window" == this.options.zoomType && this.setWindowPostition(a), "inner" == this.options.zoomType && this.setWindowPostition(a), this.options.showLens && this.zoomLens.css({
                left: this.lensLeftPos + "px",
                top: this.lensTopPos + "px"
            }))
        },
        setLensPostition: function () {},
        setWindowPostition: function (a) {
            var b = this;
            if (isNaN(b.options.zoomWindowPosition)) b.externalContainer =
                    d("#" + b.options.zoomWindowPosition), b.externalContainerWidth = b.externalContainer.width(), b.externalContainerHeight = b.externalContainer.height(), b.externalContainerOffset = b.externalContainer.offset(), b.windowOffsetTop = b.externalContainerOffset.top, b.windowOffsetLeft = b.externalContainerOffset.left;
            else switch (b.options.zoomWindowPosition) {
                case 1:
                    b.windowOffsetTop = b.options.zoomWindowOffety;
                    b.windowOffsetLeft = +b.nzWidth;
                    break;
                case 2:
                    b.options.zoomWindowHeight > b.nzHeight && (b.windowOffsetTop = -1 * (b.options.zoomWindowHeight /
                        2 - b.nzHeight / 2), b.windowOffsetLeft = b.nzWidth);
                    break;
                case 3:
                    b.windowOffsetTop = b.nzHeight - b.zoomWindow.height() - 2 * b.options.borderSize;
                    b.windowOffsetLeft = b.nzWidth;
                    break;
                case 4:
                    b.windowOffsetTop = b.nzHeight;
                    b.windowOffsetLeft = b.nzWidth;
                    break;
                case 5:
                    b.windowOffsetTop = b.nzHeight;
                    b.windowOffsetLeft = b.nzWidth - b.zoomWindow.width() - 2 * b.options.borderSize;
                    break;
                case 6:
                    b.options.zoomWindowHeight > b.nzHeight && (b.windowOffsetTop = b.nzHeight, b.windowOffsetLeft = -1 * (b.options.zoomWindowWidth / 2 - b.nzWidth / 2 + 2 * b.options.borderSize));
                    break;
                case 7:
                    b.windowOffsetTop = b.nzHeight;
                    b.windowOffsetLeft = 0;
                    break;
                case 8:
                    b.windowOffsetTop = b.nzHeight;
                    b.windowOffsetLeft = -1 * (b.zoomWindow.width() + 2 * b.options.borderSize);
                    break;
                case 9:
                    b.windowOffsetTop = b.nzHeight - b.zoomWindow.height() - 2 * b.options.borderSize;
                    b.windowOffsetLeft = -1 * (b.zoomWindow.width() + 2 * b.options.borderSize);
                    break;
                case 10:
                    b.options.zoomWindowHeight > b.nzHeight && (b.windowOffsetTop = -1 * (b.options.zoomWindowHeight / 2 - b.nzHeight / 2), b.windowOffsetLeft = -1 * (b.zoomWindow.width() + 2 * b.options.borderSize));
                    break;
                case 11:
                    b.windowOffsetTop = b.options.zoomWindowOffety;
                    b.windowOffsetLeft = -1 * (b.zoomWindow.width() + 2 * b.options.borderSize);
                    break;
                case 12:
                    b.windowOffsetTop = -1 * (b.zoomWindow.height() + 2 * b.options.borderSize);
                    b.windowOffsetLeft = -1 * (b.zoomWindow.width() + 2 * b.options.borderSize);
                    break;
                case 13:
                    b.windowOffsetTop = -1 * (b.zoomWindow.height() + 2 * b.options.borderSize);
                    b.windowOffsetLeft = 0;
                    break;
                case 14:
                    b.options.zoomWindowHeight > b.nzHeight && (b.windowOffsetTop = -1 * (b.zoomWindow.height() + 2 * b.options.borderSize),
                        b.windowOffsetLeft = -1 * (b.options.zoomWindowWidth / 2 - b.nzWidth / 2 + 2 * b.options.borderSize));
                    break;
                case 15:
                    b.windowOffsetTop = -1 * (b.zoomWindow.height() + 2 * b.options.borderSize);
                    b.windowOffsetLeft = b.nzWidth - b.zoomWindow.width() - 2 * b.options.borderSize;
                    break;
                case 16:
                    b.windowOffsetTop = -1 * (b.zoomWindow.height() + 2 * b.options.borderSize);
                    b.windowOffsetLeft = b.nzWidth;
                    break;
                default:
                    b.windowOffsetTop = b.options.zoomWindowOffety, b.windowOffsetLeft = b.nzWidth
            }
            b.windowOffsetTop += b.options.zoomWindowOffety;
            b.windowOffsetLeft +=
                b.options.zoomWindowOffetx;
            b.zoomWindow.css({
                top: b.windowOffsetTop
            });
            b.zoomWindow.css({
                left: b.windowOffsetLeft
            });
            "inner" == b.options.zoomType && (b.zoomWindow.css({
                top: 0
            }), b.zoomWindow.css({
                left: 0
            }));
            b.windowLeftPos = String(-1 * ((a.pageX - b.nzOffset.left) * b.widthRatio - b.zoomWindow.width() / 2));
            b.windowTopPos = String(-1 * ((a.pageY - b.nzOffset.top) * b.heightRatio - b.zoomWindow.height() / 2));
            b.Etoppos && (b.windowTopPos = 0);
            b.Eloppos && (b.windowLeftPos = 0);
            b.Eboppos && (b.windowTopPos = -1 * (b.largeHeight / b.options.zoomLevel -
                b.zoomWindow.height()));
            b.Eroppos && (b.windowLeftPos = -1 * (b.largeWidth / b.options.zoomLevel - b.zoomWindow.width()));
            if ("window" == b.options.zoomType || "inner" == b.options.zoomType) 1 >= b.widthRatio && (b.windowLeftPos = 0), 1 >= b.heightRatio && (b.windowTopPos = 0), b.largeHeight < b.options.zoomWindowHeight && (b.windowTopPos = 0), b.largeWidth < b.options.zoomWindowWidth && (b.windowLeftPos = 0), b.options.easing ? (b.xp || (b.xp = 0), b.yp || (b.yp = 0), b.loop || (b.loop = setInterval(function () {
                    b.xp += (b.windowLeftPos - b.xp) / b.options.easingAmount;
                    b.yp += (b.windowTopPos - b.yp) / b.options.easingAmount;
                    b.zoomWindow.css({
                        backgroundPosition: b.xp + "px " + b.yp + "px"
                    })
                }, 16))) : b.zoomWindow.css({
                    backgroundPosition: b.windowLeftPos + "px " + b.windowTopPos + "px"
                })
        },
        setTintPosition: function (a) {
            this.nzOffset = this.$elem.offset();
            this.tintpos = String(-1 * (a.pageX - this.nzOffset.left - this.zoomLens.width() / 2));
            this.tintposy = String(-1 * (a.pageY - this.nzOffset.top - this.zoomLens.height() / 2));
            this.Etoppos && (this.tintposy = 0);
            this.Eloppos && (this.tintpos = 0);
            this.Eboppos && (this.tintposy = -1 * (this.nzHeight - this.zoomLens.height() - 2 * this.options.lensBorderSize));
            this.Eroppos && (this.tintpos = -1 * (this.nzWidth - this.zoomLens.width() - 2 * this.options.lensBorderSize));
            this.options.tint && (this.zoomTint.css({
                opacity: this.options.tintOpacity
            }).animate().fadeIn("slow"), this.zoomTintImage.css({
                left: this.tintpos - this.options.lensBorderSize + "px"
            }), this.zoomTintImage.css({
                top: this.tintposy - this.options.lensBorderSize + "px"
            }))
        },
        swaptheimage: function (a, b) {
            var c = this,
                d = new Image;
            c.options.onImageSwap(c.$elem);
            d.onload = function () {
                c.largeWidth = d.width;
                c.largeHeight = d.height;
                c.zoomImage = b;
                c.zoomWindow.css({
                    "background-size": c.largeWidth + "px " + c.largeHeight + "px"
                });
                c.swapAction(a, b)
            };
            d.src = b
        },
        swapAction: function (a, b) {
            var c = this,
                d = new Image;
            d.onload = function () {
                c.nzHeight = d.height;
                c.nzWidth = d.width;
                c.options.onImageSwapComplete(c.$elem);
                c.doneCallback()
            };
            d.src = a;
            c.zoomWindow.css({
                backgroundImage: "url('" + b + "')"
            });
            c.currentImage = b;
            c.$elem.attr("src", a)
        },
        doneCallback: function () {
            this.options.tint && (this.zoomTintImage.attr("src",
                largeimage), this.zoomTintImage.attr("height", this.$elem.height()), this.zoomTintImage.css({
                height: this.$elem.height()
            }), this.zoomTint.css({
                height: this.$elem.height()
            }));
            this.nzOffset = this.$elem.offset();
            this.nzWidth = this.$elem.width();
            this.nzHeight = this.$elem.height();
            this.widthRatio = this.largeWidth / this.nzWidth;
            this.heightRatio = this.largeHeight / this.nzHeight;
            lensHeight = this.nzHeight < this.options.zoomWindowWidth / this.widthRatio ? this.nzHeight : String(this.options.zoomWindowHeight / this.heightRatio);
            lensWidth =
                this.largeWidth < this.options.zoomWindowWidth ? this.nzHWidth : this.options.zoomWindowWidth / this.widthRatio;
            this.zoomLens && (this.zoomLens.css("width", lensWidth), this.zoomLens.css("height", lensHeight))
        },
        getCurrentImage: function () {
            return this.zoomImage
        },
        getGalleryList: function () {
            var a = this;
            a.gallerylist = [];
            a.options.gallery ? d("#" + a.options.gallery + " a").each(function () {
                var b = "";
                d(this).data("zoom-image") ? b = d(this).data("zoom-image") : d(this).data("image") && (b = d(this).data("image"));
                b == a.zoomImage ? a.gallerylist.unshift({
                    href: "" + b + "",
                    title: d(this).find("img").attr("title")
                }) : a.gallerylist.push({
                    href: "" + b + "",
                    title: d(this).find("img").attr("title")
                })
            }) : a.gallerylist.push({
                href: "" + a.zoomImage + "",
                title: d(this).find("img").attr("title")
            });
            return a.gallerylist
			console.log(a.gallerylist);
        },
        changeZoomLevel: function (a) {
            this.widthRatio = this.largeWidth / a / this.nzWidth;
            this.heightRatio = this.largeHeight / a / this.nzHeight;
            this.zoomWindow.css({
                "background-size": this.largeWidth / a + "px " + this.largeHeight / a + "px"
            });
            this.zoomLens.css({
                width: String(this.options.zoomWindowWidth /
                    this.widthRatio) + "px",
                height: String(this.options.zoomWindowHeight / this.heightRatio) + "px"
            });
            this.options.zoomLevel = a
        },
        closeAll: function () {
            self.zoomWindow && self.zoomWindow.hide();
            self.zoomLens && self.zoomLens.hide();
            self.zoomTint && self.zoomTint.hide()
        }
    };
    d.fn.elevateZoom = function (a) {
        return this.each(function () {
            var b = Object.create(e);
            b.init(a, this);
            d.data(this, "elevateZoom", b)
        })
    };
    d.fn.elevateZoom.options = {
        zoomLevel: 1,
        easing: !1,
        easingAmount: 12,
        lensSize: 200,
        zoomWindowWidth: 400,
        zoomWindowHeight: 400,
        zoomWindowOffetx: 0,
        zoomWindowOffety: 0,
        zoomWindowPosition: 1,
        zoomWindowBgColour: "#fff",
        lensFadeIn: !1,
        lensFadeOut: !1,
        debug: !1,
        zoomWindowFadeIn: !1,
        zoomWindowFadeOut: !1,
        zoomWindowAlwaysShow: !1,
        zoomTintFadeIn: !1,
        zoomTintFadeOut: !1,
        borderSize: 4,
        showLens: !0,
        borderColour: "#888",
        lensBorderSize: 1,
        lensBorderColour: "#000",
        lensShape: "square",
        zoomType: "window",
        containLensZoom: !1,
        lensColour: "white",
        lensOpacity: 0.4,
        lenszoom: !1,
        tint: !1,
        tintColour: "#333",
        tintOpacity: 0.4,
        gallery: !1,
        galleryActiveClass: "zoomGalleryActive",
        cursor: "default",
        responsive: !1,
        onComplete: d.noop,
        onZoomedImageLoaded: function () {},
        onImageSwap: d.noop,
        onImageSwapComplete: d.noop
    }
})(jQuery, window, document);