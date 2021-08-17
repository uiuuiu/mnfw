module Api
  class ApiController < ::ActionController::API
    include HandleControllerError

    attr_accessor :message
    attr_writer :status
    attr_reader :current_user

    before_action :authenticate_request

    private

    def authenticate_request
      @current_user = AuthorizeApiRequestService.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end

    def render_paginate_data(objects, options:, meta: {})
      meta[:message] ||= ''
      meta[:status]  ||= 200
      options[:root] ||= 'data'

      render json: objects, **options, meta: meta_attributes(objects, extra_meta: meta)
    end

    def render_data(objects, options:, meta:)
      meta[:message] ||= ''
      meta[:status]  ||= 200
      options[:root] ||= 'data'

      render json: objects, **options, meta: meta
    end

    def render_blank_with_message(meta: {})
      meta[:message] ||= ''
      meta[:status]  ||= 200
      render json: { data: {}, meta: meta }
    end

    def render_yaml_data(objects, status: 200)
      render json: objects, adapter: :json, root: 'data', meta: { status: status }
    end

    def meta_attributes(collection, extra_meta:)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
        total_pages: collection.total_pages,
        total_count: collection.total_count,
      }.merge(extra_meta)
    end

    def limit_param
      if Const::Paginate::LIMIT.include?(params[:limit].to_i)
        return params[:limit]
      end

      25
    end

    def page_param
      params[:page] || 1
    end

    def init_message_and_status(object)
      # @message is set in yield block
      yield

      # @status is set here
      @status = object.errors.present? ? :unprocessable_entity : :ok
    end

    # Override status: convert from symbol to number
    def status
      Rack::Utils::SYMBOL_TO_STATUS_CODE[@status]
    end

  end
end