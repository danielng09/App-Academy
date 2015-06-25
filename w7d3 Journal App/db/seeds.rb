
(1..10).each do |n|
  Post.create!(title: "Post #{n}", body: "Body #{n}")
end
