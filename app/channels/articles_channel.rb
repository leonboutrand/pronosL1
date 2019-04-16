class ArticlesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "article_#{params[:article_id]}"
  end
end
