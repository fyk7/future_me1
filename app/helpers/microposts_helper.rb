module MicropostsHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/microposts/hashtag/#{word.delete("#").delete("＃")}", id: "hashtag"}.html_safe
  end 

  def tag_back_to_hash(content)
    content.split("").unshift("#").join()
  end

  def tag_size(tags_count)
    font_size = 15 + (tags_count - 1) * 5
    min(font_size, 35)
  end

  def min(a, b)
    (a <= b) ? a : b
  end

  def category_button_color(category)
    color_pair = {'大学生活前半' => 'btn btn-primary btn-sm', '大学生活後半' => 'btn btn-warning btn-sm', '就活中' => 'btn btn-success btn-sm', '社会人ルーキー' => 'btn btn-info btn-sm', '社会人ミドル' => 'btn btn-success btn-sm', 'その他' => 'btn btn-secondary btn-sm'}
    color_pair[category]
  end
end
