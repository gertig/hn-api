class V1::HnPresenter < V1::BasePresenter

  def initialize(hn)
    @hn = hn
  end

  def as_json(options={})
    
    $redis.keys

    # @hn
    # {
    #   @hn
    # }
    # {
    #   id: @hn_user.id,
    #   handle: @hn_user.email,
    #   api_token: @hn_user.api_token
    # }
  end

end
