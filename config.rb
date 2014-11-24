require 'pry'

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload do |livereload|
    # http://forum.middlemanapp.com/t/howto-livereload-on-mobiles-tablets/1244
    livereload.host = Socket.ip_address_list.detect{ |intf| intf.ipv4_private? }.ip_address
  end
end

# Methods defined in the helpers block are available in templates
helpers do
  def nav_active(page)
    current_page.path.chomp(File.extname(current_page.path)) == page ? 'active' : nil
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

set :relative_links, true # In case we don't deploy to the root of a server

activate :deploy do |deploy|
  deploy.method       = :ftp
  deploy.host         = 'swiss-handicap.access-for-all.ch'
  deploy.path         = '/'
  deploy.user         = 'josh'
  deploy.password     = 'nMqgnFWpX7MPJJKGqcfX'
  deploy.build_before = true
end
