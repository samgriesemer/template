conky.config={
  alignment='top_left',
  gap_x=15,
  gap_y=30,

  background=true,
  border_inner_margin=5,
  border_outer_margin=0,
  border_width=2,
  default_bar_height=5,
  default_bar_width=80,
  default_color="C0C0C0",

  --default_color = '#000000',  				-- default color and border color
  color1 = '#68A1DF', 						-- title_color
  color2 = '#FAA916',						    -- top memory or processe, graphs
  color3 = '#FBFFFE',						    -- text color

  default_graph_height=25,
  default_graph_width=200,

  default_outline_color="000000",
  default_shade_color="000000",

  double_buffer=true,
  draw_borders=false,
  draw_graph_borders=false,
  draw_outline=false,
  draw_shades=false,
  font="DejaVu Sans Mono:size=7.8",
  maximum_width=500,
  minimum_width=500,
  no_buffers=true,
  override_utf8_locale=true,

  own_window_class="conky",
  own_window_hints="undecorated,below,skip_taskbar,skip_pager,sticky",
  own_window_transparent=true,
  own_window=true,
  own_window_type="desktop",
  own_window_argb_value = 0,
  own_window_argb_visual = true,

  stippled_borders=0,
  text_buffer_size=6144,
  total_run_times=0,
  update_interval=5,
  uppercase=false,
  use_spacer="none",
  use_xft=true,
  xftalpha=1.0,
};

conky.text=[[

${font Aerial:style=Bold:pixelsize=10}ACTIVE ${voffset -2}${hr 2}${font}
${texecpi 60 flock /home/smgr/.task task limit:15 rc.defaultwidth:83 rc._forcecolor:on rc.verbose:affected,blank +ACTIVE | ansito - | sed -r 's/([^ ])#/\1\\#/g'}

${font Aerial:style=Bold:pixelsize=10}PROGRESS ${voffset -2}${hr 2}${font}
${font DejaVu Sans:size=8}${texecpi 180 flock /home/smgr/.task /home/smgr/.config/conky/conky-task-progress.sh}${font}

]]

--${font Aerial:style=Bold:pixelsize=10}PENDING ${voffset -2}${hr 2}${font}
--${texecpi 60 flock /home/smgr/.task task limit:20 rc.defaultwidth:83 rc._forcecolor:on rc.verbose:affected,blank +PENDING -ACTIVE | ansito - | sed -r 's/([^ ])#/\1\\#/g'}

--${font Aerial:style=Bold:pixelsize=10}BURNDOWN ${voffset -2}${hr 2}${font}
--${font FreeMono:style=Bold:size=8}${texecpi 120 flock /home/smgr/.task task rc._forcecolor:on burndown.monthly | tail -n+2 | head -n-2 | /home/smgr/.config/conky/conky-bg-space-to-fg.sh | ansito - | sed -r 's/([^ ])#/\1\\#/g'}${font}

