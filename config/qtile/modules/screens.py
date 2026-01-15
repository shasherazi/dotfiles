from libqtile import bar, widget
from libqtile.config import Screen

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    disable_drag=True, fontsize=18, highlight_method="text"
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.Clock(format="%a, %b %d, %Y %H:%M"),
                widget.Spacer(),
                widget.CurrentLayout(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Volume(limit_max_volume=True),
                widget.Battery(format="{char} {percent:2.0%}", notify_below=50),
                widget.QuickExit(),
            ],
            30,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]
