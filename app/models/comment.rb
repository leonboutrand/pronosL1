class Comment < ApplicationRecord
  after_create :broadcast_comment
  belongs_to :user
  belongs_to :article

  validates :content, presence: true

  def broadcast_comment
    ActionCable.server.broadcast("article_#{article.id}", {
      comments_list: ApplicationController.renderer.render(
        partial: "articles/comments_list",
        locals: { comments: article.comments }
      ),
      current_user_id: user.id,
      comments_number: "#{article.comments.count} commentaires"
    })
  end
end
