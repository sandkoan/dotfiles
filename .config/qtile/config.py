from libqtile.config import Screen, Group, ScratchPad, DropDown, EzKey as Key, EzClick as Click, EzDrag as Drag 
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401

mod = "mod4"
my_term = "kitty"

keys = [
        Key("M-<Return>",
            lazy.spawn(my_term),
            desc='Launches My Terminal'
            ),
        Key("M-S-<Return>",
            lazy.spawncmd(),
            desc='Run Launcher'
            ),
        Key("M-<Tab>",
            lazy.next_layout(),
            desc='Toggle through layouts'
            ),
        Key("M-S-c",
            lazy.window.kill(),
            desc='Kill active window'
            ),
        Key("M-S-r",
            lazy.restart(),
            desc='Restart Qtile'
            ),
        Key("M-S-q",
            lazy.shutdown(),
            desc='Shutdown Qtile'
            ),
        Key("M-S-w",
            lazy.to_screen(0),
            desc='Keyboard focus to monitor 1'
            ),
        Key("M-e",
            lazy.to_screen(1),
            desc='Keyboard focus to monitor 2'
            ),
        Key("M-<period>",
            lazy.next_screen(),
            desc='Move focus to next monitor'
            ),
        Key("M-<comma>",
            lazy.prev_screen(),
            desc='Move focus to prev monitor'
            ),
        Key("M-C-k",
            lazy.layout.section_up(),
            desc='Move up a section in treetab'
            ),
        Key("M-C-j",
            lazy.layout.section_down(),
            desc='Move down a section in treetab'
            ),
        Key("M-k",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'
            ),
        Key("M-j",
                lazy.layout.up(),
                desc='Move focus up in current stack pane'
                ),
        Key("M-S-k",
                lazy.layout.shuffle_down(),
                desc='Move windows down in current stack'
                ),
        Key("M-S-j",
                lazy.layout.shuffle_up(),
                desc='Move windows up in current stack'
                ),
        Key("M-h",
                lazy.layout.grow(),
                lazy.layout.increase_nmaster(),
                desc='Expand window (MonadTall), increase number in master pane (Tile)'
                ),
        Key("M-l",
                lazy.layout.shrink(),
                lazy.layout.decrease_nmaster(),
                desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
                ),
        Key("M-n",
                lazy.layout.normalize(),
                desc='normalize window size ratios'
                ),
        Key("M-m",
                lazy.layout.maximize(),
                desc='toggle window between minimum and maximum sizes'
                ),
        Key("M-S-f",
                lazy.window.toggle_floating(),
                desc='toggle floating'
                ),
        Key("M-S-m",
                lazy.window.toggle_fullscreen(),
                desc='toggle fullscreen'
                ),
         Key("M-S-<space>",
                 lazy.layout.rotate(),
                 lazy.layout.flip(),
                 desc='Switch which side main pane occupies (XmonadTall)'
                 ),
         Key("M-<space>",
                 lazy.layout.next(),
                 desc='Switch window focus to other pane(s) of stack'
                 ),
         Key("M-C-<Return>",
                 lazy.layout.toggle_split(),
                 desc='Toggle between split and unsplit sides of stack'
                 ),
         Key("<F12>", lazy.group['scratchpad'].dropdown_toggle('term'), 
            desc='Drop down terminal'
            )
]

group_names = ["Web", "Term", "Mus", "Editor", "Yt", "Misc"]
groups = [Group(name) for name in group_names]

for i, name in enumerate(group_names):
    keys += [Key("M-" + str(i + 1), lazy.group[name].toscreen(), desc="Go to next group"), 
            Key("M-S-" + str(i + 1), lazy.window.togroup(name), desc="Move window to next group")]


groups += [ScratchPad("scratchpad", [DropDown("term", my_term, opacity=0.9)])]

layout_theme = {"border_width": 2,
                "margin": 6,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    #layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Stack(stacks=2, **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Stack(num_stacks=2),
    layout.TreeTab(
         font = "JetBrainsMono Nerd Font",
         fontsize = 10,
         sections = ["FIRST", "SECOND"],
         section_fontsize = 11,
         bg_color = "141414",
         active_bg = "90C435",
         active_fg = "000000",
         inactive_bg = "384323",
         inactive_fg = "a0a0a0",
         padding_y = 5,
         section_top = 10,
         panel_width = 320
         ),
    layout.Floating(**layout_theme)
]

widget_defaults = dict(font="JetBrainsMono Nerd Font", fontsize=14, padding=4,)
extension_defaults = widget_defaults.copy()

screens = [
        Screen(
            bottom=bar.Bar(
                [
                    widget.CurrentLayoutIcon(),
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Systray(),
                    widget.Clock(format="%m/%d %a %I:%M %p"),
                    widget.QuickExit(),
                    ],
                24,
                ),
            ),
        Screen(
            bottom=bar.Bar(
                [
                    widget.CurrentLayoutIcon(),
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Systray(),
                    widget.Clock(format="%m/%d %a %I:%M %p"),
                    widget.QuickExit(),
                    ],
                24,
                ),
            )
        ]

# Drag floating layouts
mouse = [
        Drag("M-1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag("M-3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click("M-2", lazy.window.bring_to_front())
        ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            {"wmclass": "confirm"},
            {"wmclass": "dialog"},
            {"wmclass": "download"},
            {"wmclass": "error"},
            {"wmclass": "file_progress"},
            {"wmclass": "notification"},
            {"wmclass": "splash"},
            {"wmclass": "toolbar"},
            {"wmclass": "confirmreset"},  # gitk
            {"wmclass": "makebranch"},  # gitk
            {"wmclass": "maketag"},  # gitk
            {"wname": "branchdialog"},  # gitk
            {"wname": "pinentry"},  # GPG key password entry
            {"wmclass": "ssh-askpass"},  # ssh-askpass
            ]
        )
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
#  wmname = "qtile"
