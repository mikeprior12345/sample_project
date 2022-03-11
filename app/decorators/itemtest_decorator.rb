class ItemtestDecorator < Draper::Decorator
  delegate_all
  def alias
  string = object.user.email
  last_char = "@"
  string.partition(last_char)[0..1].join.chop 
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
