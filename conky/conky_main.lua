conky.config={
  alignment='top_right',
  gap_x=1100,
  gap_y=35,

  --xinerama_head=1,
  background=true,
  border_inner_margin=5,
  border_outer_margin=0,
  border_width=2,
  cpu_avg_samples=2,
  default_bar_height=5,
  default_bar_width=80,
  default_color="C0C0C0",
  default_graph_height=25,
  default_graph_width=200,
  default_outline_color="000000",
  default_shade_color="000000",
  diskio_avg_samples=2,
  double_buffer=true,
  draw_borders=false,
  draw_graph_borders=false,
  draw_outline=false,
  draw_shades=false,
  font="DejaVu Sans:size=8",
  maximum_width=250,
  minimum_width=250,
  net_avg_samples=2,
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
  top_cpu_separate=true,
  top_name_width=25,
  total_run_times=0,
  update_interval=2,
  uppercase=false,
  use_spacer="none",
  use_xft=true,
  xftalpha=0.8,

  --Network Template
  template3=[[${if_up \1}${font}\1 down: ${downspeed \1} (${totaldown \1}) ${alignr}up: ${upspeed \1} (${totalup \1})\n${font}${downspeedgraph \1 25,140 C0C0C0 5F9EA0 -t} ${alignr}${upspeedgraph \1 25,140 C0C0C0 5F9EA0 -t}\n${endif}]],
    
  color1='#5F9EA0',
  color2='#CD5C5C',
  color3='#FFC274',

};

conky.text=[[

${font Aerial:style=Bold:pixelsize=10}CPU ${voffset -2}${hr 2}${font}
${font}${alignr}${cpugraph cpu0 50,95C0C0C0 5F9EA0 -t}${voffset -59}
${font}CPU1 ${tab} ${cpubar cpu2 5,80}  ${cpu cpu2}%  ${platform coretemp.0/hwmon/hwmon0 temp 2}°C
${font}CPU2 ${tab} ${cpubar cpu3 5,80}  ${cpu cpu3}%  ${platform coretemp.0/hwmon/hwmon0 temp 3}°C
${font}CPU3 ${tab} ${cpubar cpu4 5,80}  ${cpu cpu4}%  ${platform coretemp.0/hwmon/hwmon0 temp 4}°C
${font}CPU4 ${tab} ${cpubar cpu5 5,80}  ${cpu cpu5}%  ${platform coretemp.0/hwmon/hwmon0 temp 5}°C

${font}CPU ${tab} ${cpubar cpu1 5,80}  ${cpu cpu1}%  ${platform coretemp.0/hwmon/hwmon0 temp 1}°C ${alignr}${freq_g} GHz

${font Aerial:style=Bold:pixelsize=10}MEMORY ${voffset -2}${hr 2}${font}${voffset 3}
${font}${membar 5,215} ${alignr}${memperc}% (${mem})${voffset 5}
${font}${memgraph 15,300 C0C0C0 5F9EA0 -t}
${color1}${voffset 5}Name${goto 180}MEM%${alignr}MEM${color}
${top_mem name 1} ${goto 180}${top_mem mem 1}${alignr}${top_mem mem_res 1}
${top_mem name 2} ${goto 180}${top_mem mem 2}${alignr}${top_mem mem_res 2}
${top_mem name 3} ${goto 180}${top_mem mem 3}${alignr}${top_mem mem_res 3}
${top_mem name 4} ${goto 180}${top_mem mem 4}${alignr}${top_mem mem_res 4}
${top_mem name 5} ${goto 180}${top_mem mem 5}${alignr}${top_mem mem_res 5}

${font Aerial:style=Bold:pixelsize=10}PROCESSES ${voffset -2}${hr 2}${font}${voffset 5}
${color1}${top_cpu_separate=false}NAME ${alignr}PID    CPU   MEM${color}
${top name 1} ${alignr}${top pid 1} ${top cpu 1} ${top mem 1}
${top name 2} ${alignr}${top pid 2} ${top cpu 2} ${top mem 2}
${top name 3} ${alignr}${top pid 3} ${top cpu 3} ${top mem 3}
${top name 4} ${alignr}${top pid 4} ${top cpu 4} ${top mem 4}
${top name 5} ${alignr}${top pid 5} ${top cpu 5} ${top mem 5}

${voffset 10}${font Aerial:style=Bold:pixelsize=10}GPU ${voffset -2}${hr 2}${font}${voffset 5}
${color1}Driver ${color}:$alignr${execi 6000 nvidia-smi --query-gpu=driver_version --format=csv,noheader,nounits}
${color1}Utilization ${color}:$alignr${exec nvidia-smi -i 0 | grep % | cut -c 61-63} %
${color1}VRAM Utilization ${color}:$alignr${exec nvidia-smi -i 0| grep % | cut -c 37-40} MB

${font Aerial:style=Bold:pixelsize=10}NETWORK ${voffset -2}${hr 2}${font}${voffset 5}
${font}Local IP address: ${addr enp0s31f6}

${template3 enp0s31f6}\
${template3 wlp3s0}\

${font Aerial:style=Bold:pixelsize=10}DISK USAGE ${voffset -2}${hr 2}${font}${voffset 5}
${texecpi 120 /home/smgr/.config/conky/conky-diskio.sh}
${texecpi 120 /home/smgr/.config/conky/conky-disk-usage.sh}

]]

--${font Aerial:style=Bold:pixelsize=10}BIG FILES ${hr 2}${font}
--${texecpi 30 conky-biggest-files.sh ~}
--
--${font Aerial:style=Bold:pixelsize=10}DIRECTORY USAGE ${hr 2}${font}
--${texecpi 30 conky-directory-usage.sh ~}
