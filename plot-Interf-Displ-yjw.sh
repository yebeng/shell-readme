#!/bin/bash
J=M30
#R=99.7/100.1/25.4/25.8
R=77.75/79.5/40.5/41.75
output="Interf-Displ.ps"

#坐标轴刻度的长度
gmt gmtset MAP_TICK_LENGTH_PRIMARY    0.7c
#坐标轴的字体大小
gmt gmtset FONT_ANNOT_PRIMARY    40
#坐标轴字体距轴线的距离
gmt gmtset  MAP_ANNOT_OFFSET_PRIMARY   0.5c
#画布大小
gmt gmtset PS_MEDIA A0                                       
#边框类型，plain为细线，fancy为铁轨式
gmt set MAP_FRAME_TYPE=plain

#将*.tif格式文件转换为*.grd格式
#gdal_translate -of GSBG Asc.tif Asc.grd
#gdal_translate -of GSBG Des.tif Des.grd

#生成画干涉图的周期性色阶
gmt makecpt -Cjet  -T-0.8/-0.784/0.001 -V -Z >Iraq.cpt
gmt makecpt -Cjet  -T-0.784/-0.728/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.728/-0.672/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.672/-0.616/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.616/-0.56/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.56/-0.504/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.504/-0.448/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.448/-0.392/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.392/-0.336/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.336/-0.28/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.28/-0.224/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.224/-0.168/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.168/-0.112/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.112/-0.056/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T-0.056/0/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0/0.056/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.056/0.112/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.112/0.168/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.168/0.224/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.224/0.28/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.28/0.336/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.336/0.392/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.392/0.448/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.448/0.504/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.504/0.56/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.56/0.616/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.616/0.672/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.672/0.728/0.001 -V -Z >> Iraq.cpt
gmt makecpt -Cjet  -T0.728/0.784/0.001 -V -Z >> Iraq.cpt 
gmt makecpt -Cjet  -T0.784/0.8/0.001 -V -Z >> Iraq.cpt 

gmt makecpt -Cjet  -T0/0.056/0.001 -V  > scale.cpt  
gmt grdgradient dem.grd -A300 -Gdem_int.grd.int -Ne1.5 -fg 
#gmt grdgradient dem.grd -A300 -Gdem_int.grd.int -Ne1.5 -fg 
#对grd数据进行0.001的降采样
#gmt grdsample Asc.grd -GAsc-new.grd -R$R -I0.001
#gmt grdsample Des.grd -GDes-new.grd -R$R -I0.001



#画升轨的干涉条纹图
gmt grdimage Asc.grd -J$J -R$R -CIraq.cpt -Ba0.5f0.25/f0.25a0.5::WseN -N  -Q -K -X10 -Y47 >$output
gmt psxy xingjiang_wushi_M71_fault.txt -J$J -R$R -W3p,black -N  -K -V -O>>$output
#gmt psscale -D31/9/17/1.0v -B0.056/:"m":  -Cscale.cpt -K  -V -O  >>$output
echo "77.815 41.71 (a)" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output
echo "79.3 41.71 Ascending" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output 
#画升轨的干涉形变场图
gmt makecpt -Cjet -T-0.8/0.8/0.001 -V > weiyi.cpt
gmt grdimage Asc.grd  -J$J -R$R -Cweiyi.cpt -Ba0.5f0.25/f0.25a0.5::wseN -V -Q  -N -K -O  -X34 >> $output
gmt psxy xingjiang_wushi_M71_fault.txt -J$J -R$R -W3p,black -N  -K -V -O>>$output
#gmt psscale -D31/9/17/1.0v -B0.8/:"m":  -Cweiyi.cpt -K  -V -O  >>$output
echo "77.815 41.71 (b)" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output
echo "79.3 41.71 Ascending" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output 
#画震中
gmt psxy -J$J -R$R -Sa2c -Gblue -W0.1p,black -K -O -V -N>>$output<<EOF
78.63 41.26
EOF

#以中心画剖面线(注：以0度为起点（东方向），顺时针旋转为负，逆时针旋转为正)
gmt psxy -J$J -R$R -Sv1.6+jb+et+h2 -W4p--,black -Gblack  -K -O -V >>$output<<EOF
78.55 41.2 -50 6 1
78.55 41.2 130 6 1
EOF

#绘制断层线
gmt psxy -R$R -J$J -W7p,red -O   -K   -V -N>>$output<<EOF
79.1712   41.3446
78.1930   41.0043
EOF
#绘制断层面在地表的投影线
gmt psxy -R$R -J$J -W7p,blue,- -O   -K   -V -N>>$output<<EOF
78.1930   41.0043
78.0874   41.1754
79.0656   41.5157
79.1712   41.3446
EOF

#画降轨的干涉条纹图
gmt makecpt -Cgray   -T0/10/10  -Z>sc.cpt
gmt grdimage dem.grd -J$J -R$R -Idem_int.grd.int -Ba0.5f0.25/f0.25a0.5::Wsen -Csc.cpt -V -K -O -X-34 -Y-31.5 >>$output
#gmt grdimage Des.grd -J$J -R$R -CIraq.cpt -Ba0.5f0.25/f0.25a0.5::Wsen -N  -Q -O -K -X-34 -Y-31.5 >>$output
gmt grdimage Des.grd -J$J -R$R -CIraq.cpt  -V -N   -Q -K -O -P >>$output
gmt psxy xingjiang_wushi_M71_fault.txt -J$J -R$R -W3p,black -N  -K -V -O>>$output
gmt psscale -D15/-2/17/1.0h -B0.056/:"m":  -Cscale.cpt -K  -V -O  >>$output
echo "77.815 41.71 (c)" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output
echo "79.3 41.71 Descending" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output

#画降轨的干涉形变场图
gmt makecpt -Cjet -T-0.8/0.8/0.001 -V > weiyi.cpt
gmt grdimage dem.grd -J$J -R$R -Idem_int.grd.int -Ba0.5f0.25/f0.25a0.5::wsen -Csc.cpt -V -K -O -X34 >>$output
#gmt grdimage Des.grd  -J$J -R$R -Cweiyi.cpt -Ba0.5f0.25/f0.25a0.5::wsen -V -Q  -N -K -O  -X34 >> $output
gmt grdimage Des.grd  -J$J -R$R -Cweiyi.cpt  -V -N  -Q -K -O -P >> $output
gmt psxy xingjiang_wushi_M71_fault.txt -J$J -R$R -W3p,black -N  -K -V -O>>$output
gmt psscale -D15/-2/17/1.0h -B0.8/:"m":  -Cweiyi.cpt -K  -V -O  >>$output
echo "77.815 41.71 (d)" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output
echo "79.3 41.71 Descending" |gmt pstext -J$J -R$R -F+f40p,4,black -Gwhite -K -O  -V >> $output
#画震中
gmt psxy -J$J -R$R -Sa2c -Gblue -W0.1p,black -K -O -V -N>>$output<<EOF
78.63 41.26
EOF

#以中心画剖面线(注：以0度为起点（东方向），顺时针旋转为负，逆时针旋转为正)
gmt psxy -J$J -R$R -Sv1.6+jb+et+h2 -W4p--,black -Gblack  -K -O -V >>$output<<EOF
78.63 41.23 -50 6 1
78.63 41.23 130 6 1
EOF

#绘制断层线
gmt psxy -R$R -J$J -W7p,red -O   -K   -V -N>>$output<<EOF
79.1712   41.3446
78.1930   41.0043
EOF

#绘制断层面在地表的投影线
gmt psxy -R$R -J$J -W7p,blue,- -O   -K   -V -N>>$output<<EOF
78.1930   41.0043
78.0874   41.1754
79.0656   41.5157
79.1712   41.3446
EOF


ps2pdf Interf-Displ.ps
evince Interf-Displ.pdf

