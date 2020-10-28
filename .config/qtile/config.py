# -*- coding: utf-8 -*-
import os
import socket
from libqtile.config import Screen, Group, ScratchPad, DropDown, EzKey as Key, EzClick as Click, EzDrag as Drag
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401


######### Keys #########
my_term = "kitty"
my_font = "Mononoki Nerd Font"
my_editor = "nvim-gtk"
my_browser = "google-chrome-stable"
my_launcher = "dmenu_run -fn 'Mononoki Nerd Font:size=10' -nb '#292d3e' -nf '#bbc5ff' -sb '#82AAFF' -sf '#292d3e' -p 'dmenu:'"

keys = [
        Key("M-<Return>",
            lazy.spawn(my_term),
            desc='Launches My Terminal'
            ),
        Key("M-S-<Return>",
            lazy.spawn(my_launcher),
            desc='Run Launcher'
            ),
        Key("M-S-e",
            lazy.spawn(my_editor),
            desc='Launch editor'
            ),
        Key("M-S-b",
            lazy.spawn(my_browser),
            desc='Launch browser'
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
        Key("M-S-e",
            lazy.to_screen(1),
            desc='Keyboard focus to monitor 2'
            ),
        Key("M-<period>",
            lazy.next_screen(),
            desc='Move focus to next monitor'
            ),
        Key("M-<comma>",
            lazy.prev_screen(),
            desc='Move focus to previous monitor'
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
         Key("<F12>",
             lazy.group['scratchpad'].dropdown_toggle('term'),
             desc='Drop down terminal'
             )
]

group_names = ["Web", "Term", "Mus", "Editor", "Yt", "Misc"]
groups = [Group(name) for name in group_names]

for i, name in enumerate(group_names):
    keys += [Key("M-" + str(i + 1), lazy.group[name].toscreen(), desc="Go to next group"),
        Key("M-S-" + str(i + 1), lazy.window.togroup(name), desc="Move window to next group")]

# Drag floating layouts
mouse = [
        Drag("M-1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag("M-3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click("M-2", lazy.window.bring_to_front())
]

groups += [ScratchPad("scratchpad", [DropDown("term", my_term, opacity=0.9)])]

############## Layouts #############
layout_theme = {
    "border_width": 2,
    "margin": 6,
    "border_focus": "e1acff",
    "border_normal": "1D2330"
}

layouts = [
    #  layout.Max(**layout_theme),
    #  layout.Matrix(**layout_theme),
    #  layout.Stack(stacks=2, **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
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

######## Widgets ##############

colors = [["#292d3e", "#292d3e"], # panel background
          ["#434758", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#8d62a9", "#8d62a9"], # border line color for other tab and odd widgets
          ["#668bd7", "#668bd7"], # color for the even widgets
          ["#e1acff", "#e1acff"]] # window name

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font=my_font,
    fontsize = 12,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()
def init_widgets_list():
    widgets_list = [
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Image(
                       filename = "~/.config/qtile/icons/python.png",
                       mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(my_launcher)}
                       ),
              widget.GroupBox(
                       font = my_font,
                       fontsize = 14,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[2],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[3],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[0],
                       other_screen_border = colors[0],
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Prompt(
                       prompt = prompt,
                       font = my_font,
                       padding = 10,
                       foreground = colors[3],
                       background = colors[1]
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.WindowName(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              #  widget.TextBox(
                       #  text = " 🌡",
                       #  padding = 2,
                       #  foreground = colors[2],
                       #  background = colors[5],
                       #  fontsize = 11
                       #  ),
              #  widget.ThermalSensor(
                       #  foreground = colors[2],
                       #  background = colors[5],
                       #  threshold = 90,
                       #  padding = 5
                       #  ),
              #  widget.TextBox(
                       #  text='',
                       #  background = colors[5],
                       #  foreground = colors[4],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.TextBox(
                       text = " ⟳",
                       padding = 2,
                       foreground = colors[2],
                       background = colors[4],
                       fontsize = 14
                       ),
              widget.Pacman(
                       update_interval = 1800,
                       foreground = colors[2],
                       mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(my_term+ ' -e sudo pacman -Syu')},
                       background = colors[4]
                       ),
              widget.TextBox(
                       text = "Updates",
                       padding = 5,
                       mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(my_term+ ' -e sudo pacman -Syu')},
                       foreground = colors[2],
                       background = colors[4]
                       ),
              #  widget.TextBox(
                       #  text = '',
                       #  background = colors[4],
                       #  foreground = colors[5],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.TextBox(
                       text = " 🖬",
                       foreground = colors[2],
                       background = colors[5],
                       padding = 0,
                       fontsize = 14
                       ),
              widget.Memory(
                       foreground = colors[2],
                       background = colors[5],
                       mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e ytop')},
                       padding = 5
                       ),
              #  widget.TextBox(
                       #  text='',
                       #  background = colors[5],
                       #  foreground = colors[4],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.Net(
                       interface = "enp6s0",
                       format = '{down} ↓↑ {up}',
                       foreground = colors[2],
                       background = colors[4],
                       padding = 5
                       ),
              #  widget.TextBox(
                       #  text = '',
                       #  background = colors[4],
                       #  foreground = colors[5],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.TextBox(
                      text = " Vol:",
                       foreground = colors[2],
                       background = colors[5],
                       padding = 0
                       ),
              widget.Volume(
                       foreground = colors[2],
                       background = colors[5],
                       padding = 5
                       ),
              #  widget.TextBox( text = '',
                       #  background = colors[5],
                       #  foreground = colors[4],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       foreground = colors[0],
                       background = colors[4],
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       foreground = colors[2],
                       background = colors[4],
                       padding = 5
                       ),
              #  widget.TextBox(
                       #  text = '',
                       #  background = colors[4],
                       #  foreground = colors[5],
                       #  padding = 0,
                       #  fontsize = 37
                       #  ),
              widget.Clock(
                       foreground = colors[2],
                       background = colors[5],
                       format = "%A, %B %d  [ %H:%M ]"
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       foreground = colors[0],
                       background = colors[5]
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 5
                       ),
              ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

############## Group Rules ###############
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
