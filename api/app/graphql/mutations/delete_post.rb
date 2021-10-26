class Mutations::DeletePost < Mutations::BaseMutation
  field :post, Types::PostType, null: true
  field :result, Boolean, null: true

  argument :id, ID, required: true

  def resolve(input)
    post = Post.find(input[:id])
    post.destroy
    {
      post: post,
      result: post.errors.blank?
    }
  end
end
