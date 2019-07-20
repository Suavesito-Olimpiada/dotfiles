#!/usr/bin/python

from gi import require_version
require_version("Gtk", "3.0")
from gi.repository import Gtk, Pango

class Text:
    def __init__(self):
        self.win = Gtk.Window(border_width=2,
                              title="Text",
                              resizable=True)

        self.win.set_size_request(640, 480)

        self.win.set_position(1)
        self.win.connect("destroy", self.destroy)

        font = Pango.FontDescription("Bitocra13")

        self.txt = Gtk.TextView()
        self.txt.modify_font(font)

        scroll = Gtk.ScrolledWindow(vexpand=True, hexpand=True)
        scroll.add(self.txt)

        self.win.add(scroll)
        self.win.show_all()

    def destroy(self, widget):
        Gtk.main_quit()

App = Text()

App.win.show_all()

Gtk.main()
