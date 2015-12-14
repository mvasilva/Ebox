﻿// jQuery Mask Plugin v0.10.1
// github.com/igorescobar/jQuery-Mask-Plugin
(function (k) {
    var p = function (n, f, h) {
        var g = this, a = k(n), m = { byPassKeys: [8, 9, 37, 38, 39, 40], maskChars: { ":": ":", "-": "-", ".": "\\.", "(": "\\(", ")": "\\)", "/": "/", ",": ",", _: "_", " ": "\\s", "+": "\\+" }, translationNumbers: { 0: "\\d", 1: "\\d", 2: "\\d", 3: "\\d", 4: "\\d", 5: "\\d", 6: "\\d", 7: "\\d", 8: "\\d", 9: "\\d" }, translation: { A: "[a-zA-Z0-9]", S: "[a-zA-Z]" } }; g.init = function () {
            g.settings = {}; h = h || {}; m.translation = k.extend({}, m.translation, m.translationNumbers); g.settings = k.extend(!0, {}, m, h); g.settings.specialChars = k.extend({}, g.settings.maskChars,
            g.settings.translation); a.each(function () { f = d.resolveMask(); f = d.fixRangeMask(f); a.attr("maxlength", f.length); a.attr("autocomplete", "off"); d.destroyEvents(); d.setOnKeyUp(); d.setOnPaste() })
        }; var d = {
            onPasteMethod: function () { setTimeout(function () { a.trigger("keyup") }, 100) }, setOnPaste: function () { a.bind("paste", d.onPasteMethod) }, setOnKeyUp: function () { a.keyup(d.maskBehaviour).trigger("keyup") }, destroyEvents: function () { a.unbind("keyup").unbind("paste") }, resolveMask: function () {
                return "function" == typeof f ? f(d.getVal(),
                void 0, h) : f
            }, setVal: function (c) { "input" === a.get(0).tagName.toLowerCase() ? a.val(c) : a.html(c); return a }, getVal: function () { return "input" === a.get(0).tagName.toLowerCase() ? a.val() : a.text() }, specialChar: function (c, b) { return g.settings.specialChars[c.charAt(b)] }, maskChar: function (c, b) { return g.settings.maskChars[c.charAt(b)] }, maskBehaviour: function (c) {
                c = c || window.event; if (-1 < k.inArray(c.keyCode || c.which, g.settings.byPassKeys)) return !0; var b = d.applyMask(f); b !== d.getVal() && d.setVal(b).trigger("change"); return d.seekCallbacks(c,
                b)
            }, applyMask: function (c) {
                if ("" !== d.getVal()) {
                    var b = function (c, b) { for (; b < c.length;) { if (void 0 !== c[b]) return !0; b++ } return !1 }, l = function (b) { b = "string" === typeof b ? b : b.join(""); b = b.match(RegExp(d.maskToRegex(c))) || []; b.shift(); return b }, e = d.getVal(); c = d.getMask(e, c); for (var e = h.reverse ? d.removeMaskChars(e) : e, a = l(e) ; a.join("").length < d.removeMaskChars(e).length;) a = a.join("").split(""), e = d.removeMaskChars(a.join("") + e.substring(a.length + 1)), c = d.getMask(e, c), a = l(e); for (e = 0; e < a.length; e++) if (l = d.specialChar(c,
                    e), d.maskChar(c, e) && b(a, e)) a[e] = c.charAt(e); else if (l) if (void 0 !== a[e]) { if (null === a[e].match(RegExp(l))) break } else if (null === "".match(RegExp(l))) { a = a.slice(0, e); break } return a.join("")
                }
            }, getMask: function (c) { if (h.reverse) { c = d.removeMaskChars(c); for (var b = 0, a = 0, e = 0, b = f.length, a = b = 1 <= b ? b : b - 1; e < c.length;) { for (; d.maskChar(f, a - 1) ;) a--; a--; e++ } a = 1 <= f.length ? a : a - 1; c = f.substring(b, a) } else c = f; return c }, maskToRegex: function (c) { for (var b, a = 0, e = ""; a < c.length; a++) (b = d.specialChar(c, a)) && (e += "(" + b + ")?"); return e },
            fixRangeMask: function (a) { return a.replace(/([A-Z0-9])\{(\d+)?,([(\d+)])\}/g, function () { var b = arguments, a = [], c = g.settings.translationNumbers[b[1]] ? String.fromCharCode(parseInt("6" + b[1], 16)) : b[1].toLowerCase(); a[0] = b[1]; a[1] = Array(b[2] - 1 + 1).join(b[1]); a[2] = Array(b[3] - b[2] + 1).join(c).toLowerCase(); g.settings.specialChars[c] = d.specialChar(b[1]) + "?"; return a.join("") }) }, removeMaskChars: function (a) {
                k.each(g.settings.maskChars, function (b, d) { a = a.replace(RegExp("(" + g.settings.maskChars[b] + ")?", "g"), "") });
                return a
            }, seekCallbacks: function (c, b) { if (h.onKeyPress && void 0 === c.isTrigger && "function" == typeof h.onKeyPress) h.onKeyPress(b, c, a, h); if (h.onComplete && void 0 === c.isTrigger && b.length === f.length && "function" == typeof h.onComplete) h.onComplete(b, c, a, h) }
        }; "boolean" === typeof QUNIT && (g.__p = d); g.remove = function () { d.destroyEvents(); d.setVal(d.removeMaskChars(d.getVal())); a.removeAttr("maxlength") }; g.init()
    }; k.fn.mask = function (n, f) { return this.each(function () { k(this).data("mask", new p(this, n, f)) }) }; k("input[data-mask]").each(function () { k(this).mask(k(this).attr("data-mask")) })
})(window.jQuery ||
window.Zepto);