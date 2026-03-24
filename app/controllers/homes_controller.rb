class HomesController < ApplicationController
  def index
    @popular_communities = Community
      .left_joins(:posts, :memberships)
      .select(
        "communities.*",
        "COUNT(DISTINCT posts.id) AS posts_count",
        "COUNT(DISTINCT memberships.id) AS members_count"
      )
      .group("communities.id")
      .order(Arel.sql("posts_count DESC, members_count DESC, communities.created_at DESC"))
      .limit(5)
  end
end
