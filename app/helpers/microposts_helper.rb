module MicropostsHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/microposts/hashtag/#{word.delete("#").delete("＃")}", id: "hashtag"}.html_safe
  end 
end
