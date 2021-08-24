conky.config={
  alignment='middle_middle',
  gap_x=718,
  gap_y=500,

  background=true,
  border_inner_margin=5,
  border_outer_margin=0,
  border_width=2,
  default_bar_height=5,
  default_bar_width=120,
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
  maximum_width=370,
  minimum_width=370,
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
  update_interval=1,
  uppercase=false,
  use_spacer="none",
  use_xft=true,
  xftalpha=1.0,
};

conky.text=[[

${alignc}${font Ubuntu mono:weight=Bold:size=70}${color0}${time %H:%M:%S}${voffset -55}
${alignc}${font Ubuntu mono:weight=Bold:italic:size=25}${color}${time %d %B, %Y}

${font Source Code Pro:size=10}${texecpi 10000 fortune -a -s | fmt -w 45 -g 40}${voffset 15}

${font}${alignr}${cpugraph cpu0 30,370 C0C0C0 5F9EA0 -t}
${font}CPU     ${cpubar cpu1 5,165} ${alignr}${platform coretemp.0/hwmon/hwmon0 temp 1}°C  ${cpu cpu1}%  (${freq_g}GHz)

${font}MEMORY  ${membar 5,165} ${alignr}${memperc}%  (${mem})${voffset 30}

${font DejaVu Sans:size=8}${texecpi 18 flock /home/smgr/.task /home/smgr/.config/conky/conky-task-progress.sh}${font}
]]
