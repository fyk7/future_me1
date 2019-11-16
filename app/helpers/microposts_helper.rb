module MicropostsHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/microposts/hashtag/#{word.delete("#").delete("＃")}", id: "hashtag"}.html_safe
  end 

  def tag_back_to_hash(content)
    content.split("").unshift("#").join()
  end

  def category_button_color(category)
    color_pair = {'大学生活前半' => 'btn btn-primary btn-sm', '大学生活後半' => 'btn btn-warning btn-sm', '就活中' => 'btn btn-danger btn-sm', '社会人ルーキー' => 'btn btn-info btn-sm', '社会人ミドル' => 'btn btn-success btn-sm', 'その他' => 'btn btn-secondary btn-sm'}
    color_pair[category]
  end
end
