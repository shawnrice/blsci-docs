#!/bin/ruby

def do_settings_form
    version = File.read('version').chomp
    puts "Documentation version: <code>" + version + "</code>"
    if compare_semantic_versions(version,'0.0.1')
        puts "<h4>Update Available</h4>"
    else
        puts "<p>Up to date.</p>"
    end

end

def parse_semantic_version(version)
    version = version.chomp
    parts   = version.split('.')
    major = parts[0]
    minor = parts[1]
    patch = parts[2][0]
    label = parts[2][2..-1]
    label = 'null' if label.nil?

    version = { :major => major, :minor => minor, :patch => patch, :label => label }
    return version
end

def compare_semantic_versions(v1, v2)
    v1 = parse_semantic_version(v1)
    v2 = parse_semantic_version(v2)

    labels = ['alpha', 'beta', 'rc', 'null']
    values = Hash[labels.map.with_index.to_a]

    return true if v1[:major] > v2[:major]
    return true if v1[:minor] > v2[:minor]
    return true if v1[:patch] > v2[:patch]
    return true if values[v1[:label]] > values[v2[:label]]
    return false
end

puts <<-eos
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/>
    <title>BLSCI Internal Documentation</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/reset.css"/>
    <link rel="stylesheet" href="css/style.css"/>
  </head>
  <body>
    <div class='wrapper'>
      <div class='nav'>
        <ul class='nav-links'>
eos
        exclude = ['.', '..', '.DS_Store', 'templates', 'kramdown.html.erb']
        Dir.entries("markdown").each do |f|
            unless exclude.include?(f)
                puts "<li class='nav-link'>"
                puts "<a href='" + f.gsub('.md', '') + "'>" + f.gsub('.md', '').capitalize + "</a>"
                puts "</li>"
            end
        end
puts <<-eos
        <li>&nbsp;</li>
        <li><hr></li>
        <li>&nbsp;</li>
        <li><a href='settings'>Settings</a></li>
        </ul>
      </div>
      <div class='content'>
      <h1>Settings</h1>
eos

    do_settings_form

puts <<-eos

      </div>
    </div>
  </body>
</html>

eos



# post '/participants/create', :provides => :json do
#   # Do something with the params, then…
#   halt 200, params.to_json
# end

# javascript:
#   $('#contact').on('submit',function (event) {
#     event.preventDefault();
#     $.ajax({
#       url: 'participants/create',
#       dataType: 'json',
#       type: 'POST',
#       data : { name: "Dom"}, // or $(event.target).serialize()
#       accepts: "application/json",
#       success: function(json) {
#         alert(json);
#       }
#     })
#   })