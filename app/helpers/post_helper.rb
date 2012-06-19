module PostHelper

def wrap(content)
  sanitize(raw(content.split.map{|s| wrap_string(s)}.join(' ') ))
end

  def wrap_string(text, max_width=40)
     #what?
    zero_width_space = "&#8203;"
    regex = /.{1,#{max_width}}/
    (text.length < max_width) ? text :
        text.scan(regex).join(zero_width_space)
  end



end
