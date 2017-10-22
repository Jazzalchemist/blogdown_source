options(editor = "internal")
library(blogdown)
new_site() # default theme is lithium
# need to stop serving so can use the console again
install_theme("gcushen/hugo-academic", theme_example = TRUE, update_config = TRUE)
serve_site()
install_theme("gcushen/hugo-academic")
install_theme("kakawait/hugo-tranquilpeak-theme")
serve_site()
install.packages("blogdown")
build_site()