#画一个断裂；
gmt begin 2025f169 png


gmt set MAP_FRAME_TYPE = plain

gmt basemap -R99.8/100.3/26/26.5 -JM10c -Ba0.2f0.2 -BWeSn -X2c -Y8c

gmt grdgradient aa.grd -A8/12 -Ne0.4 -Gaa_i.grd


gmt makecpt -Ctopo -T700/6500/100 -Z -H >1.cpt
gmt grdimage aa.grd -Iaa_i.grd -C1.cpt  
gmt pscoast  -Slightblue -Df 

#切割区域海拔；
gmt grdcut earth_yn_3s.grd -R99.8/100.3/26/26.5 -G169sealevel.grd

#海拔数据由栅格变为文本格式；
grd2xyz 169sealevel.grd > 169sealevel.txt


#画断裂上段
gmt psxy D:\gmt6.1.1\plot202211\plot\data\F169.txt -W0.6p,red

#画断裂下段
gmt psxy D:\gmt6.1.1\plot202211\plot\data\F169-1.txt -W0.6p,red

#画断裂名称
gmt pstext  D:\gmt6.1.1\plot202211\plot\usedata\169fault.txt -D0/-0.1i -F+f6p,4 -Gwhite

#画城市
cat city.txt |gawk "{print $1,$2,$7}" |gmt pstext -D0c/-0.25c -F+f11p,41,black
cat city.txt |gawk "{print $1,$2,$7}" |gmt psxy -Sc0.2c -Gblack

#画示例图
gmt inset begin -DjBL+w2.8c/2.8c+o0c -F+gwhite+p1p
    gmt coast -R90/105/21/36 -JM? -ECN+glightbrown+p0.2p -A10000
    echo 100 26 101 27 |gmt plot -Sr+s -W1p,black
gmt inset end

gmt end show
