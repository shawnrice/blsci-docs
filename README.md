### README

This is some documentation for the BLSCI.


For earlier versions, we have to install rubygems manually, and we also need to change `settings.rb` to have
````
http://stackoverflow.com/questions/4697557/how-to-map-with-index-in-ruby

require 'enumerator'
arr.enum_for(:each_with_index).map { |x,i| [x, i+2] }

--- or ---

arr.each_with_index.map { |x,i| [x, i+2] }

````
