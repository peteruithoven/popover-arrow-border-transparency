const string STYLESHEET = """
window {
  background-color: #bbb;
}
popover,
popover.osd,
.popover,
.popover.osd {
    border-radius: 4px;
    border: 2px solid alpha (#00f, 0.3);
    background-color: #fff; /* gives inconsistent border */
    /* background-color: transparent; */ /* gives consistent border */
    box-shadow: none;
    margin: 10px 6px;
    text-shadow: none;
}
""";

public class MyApp : Gtk.Application {

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_width = 200;
        main_window.default_height = 200;

        Gtk.CssProvider css_provider = new Gtk.CssProvider ();
        css_provider.load_from_data (STYLESHEET, -1);
        Gtk.StyleContext.add_provider_for_screen (main_window.get_screen (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        var button = new Gtk.Button.with_label ("Button");
        button.halign = Gtk.Align.CENTER;
        button.valign = Gtk.Align.CENTER;
        main_window.add(button);

        var popover = new Gtk.Popover (button);
        popover.border_width = 20;
        var label = new Gtk.Label ("Hello, world!");
        popover.add (label);
        popover.show_all ();

        button.button_release_event.connect(() => {
            popover.popup ();
            return false;
        });

        main_window.show_all ();

        popover.popup ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}
