defmodule TwitterCloneWeb.PostLive.PostComponent do
  use TwitterCloneWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
        </div>

        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b>
          <br/>
          <%= @post.body %>
        </div>
      </div>

      <div class="row">
        <div class="column">
          <a href="#" phx-click="like" phx-target="<%= @myself %>">
            <i class="far fa-heart"></i> <%= @post.likes_count %>
          </a>
        </div>
        <div class="column">
          <a href="#" phx-click="repost" phx-target="<%= @myself %>">
            <i class="far fa-retweet"></i> <%= @post.reposts_count %>
          </a>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    TwitterClone.Timeline.inc_likes(socket.assigns.post)

    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    TwitterClone.Timeline.inc_reposts(socket.assigns.post)

    {:noreply, socket}
  end
end
