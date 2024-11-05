setwd("E:/Rworkspace/map")

#开始
library(ggplot2)
library(sf)
library(raster)
library(ggalt)
library(viridis)
library(viridisLite)
library(RColorBrewer)

rm(list = ls())
# 读取世界地图数据
world <- map_data("world")

# 读取自己的数据
data <- read.csv("E:/Rworkspace/map/map.csv")

# 创建一个ggplot对象
g <- ggplot()

# 添加多边形图层，绘制世界地图
g <- g + geom_polygon(
  data = world, 
  aes(x = long, y = lat, group = group),
  fill = "#dedede"
)

# 设置黑白主题
g <- g + theme_bw()

#绘制温度信息
avgtemp <- raster("E:/Rworkspace/map/wc2.1_10m_bio_1.tif")
sf_data <- st_as_sf(rasterToPolygons(avgtemp), crs = st_crs(avgtemp))
colnames(sf_data)[1]="Average_temperature"
g<-g+ geom_sf(data = sf_data,aes(fill=Average_temperature),shape=22,size=0.5,stroke=0,color=NA)+ scale_fill_gradient2(low = "#4a7298",mid = "white",high = "#bd4146")+ ggnewscale::new_scale_fill()


# 添加点图层，绘制自己的数据
g <- g + geom_point( data = data, show.legend = FALSE,aes(x = lon, y = lat, size = Count , fill = Strains, shape = Strains), alpha = 0.7, color = "black", stroke = 0.3 )

# 设置不同物种的颜色形状
g <- g + scale_fill_manual(values = c("#7cb167","#7cb167","#7cb167","#eacb2b","#eacb2b","#eacb2b","#98bdcf","#98bdcf","#98bdcf","#98bdcf","#98bdcf","#98bdcf","#8ec4a6","#8ec4a6","#8ec4a6","#8ec4a6","#8ec4a6","#8ec4a6","#9c7eab","#9c7eab","#9c7eab","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#f2d391","#adc65f","#adc65f","#adc65f","#d97566","#d97566","#d97566","#e4a320","#e4a320","#e4a320","#e4a320","#3a78ae","#3a78ae","#3a78ae","#8378b1","#8378b1","#8378b1","#adaaaa","#adaaaa","#adaaaa","#adaaaa","#adaaaa","#adaaaa","#6991c5","#6991c5","#6991c5","#6991c5","#6991c5","#6991c5","#6991c5","#6991c5"))
g <- g + scale_shape_manual(values = c(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21))


# 设置坐标轴范围
g <- g + scale_y_continuous(expand = expansion(mult=c(0,0))) 
g <- g + scale_x_continuous(expand = expansion(add=c(0,0)))

# 隐藏坐标轴和网格线
#g <- g + theme(
  axis.line    = element_blank(),
  axis.text.x  = element_blank(),
  axis.text.y  = element_blank(),
  axis.ticks   = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.border = element_blank()
)

# 设置点的大小比例
g <- g + scale_size_area(max_size=3)

# 设置坐标系为 Robinson 投影
#g <- g + coord_sf(crs= "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

# 设置图例中的圆的大小为3
g <- g + guides(fill=guide_legend(keywidth=0.1, keyheight=0.1,override.aes=list(size=3)))

g

#geom_point里加上show.legend = FALSE隐藏图例
ggsave("E:/Rworkspace/map/myplot-4.11.pdf", plot = g, dpi = 300)

#geom_point里加删去show.legend = FALSE显示图例
library(gridExtra)
library(grid)
# 定义 g_legend() 函数
g_legend <- function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}
# 提取图例
legend <- g_legend(g)
# 绘制图例
grid.newpage()
grid.draw(legend)
ggsave("legend.tiff", plot = legend, device = "tiff", dpi = 300)


