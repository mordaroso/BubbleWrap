require 'bubble-wrap/loader'
BubbleWrap.require('motion/active_record/*.rb') do
	file('motion/active_record/model.rb').uses_framework 'CoreData'
end
