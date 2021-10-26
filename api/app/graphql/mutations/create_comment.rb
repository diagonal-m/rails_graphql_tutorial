class Mutations::CreateComment < Mutations::BaseMutation
  field :comment, Types::CommentType, null: true
  field :result, Boolean, null: true

  argument :post_id, ID, required: true
  argument :content, String, required: true

  def resolve(input)
    post = Post.find(input[:post_id])
    comment = post.comments.build(content: input[:content])
    comment.save
    {
      comment: comment,
      result: post.errors.blank?
    }
  end
end

