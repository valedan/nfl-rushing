class PlayerQuery < ApplicationService
  def initialize(context, **args)
    @args = args
    @context = context
    @query = Player.joins(:stats)
  end

  def call
    apply_filters
    apply_sort
    set_total_count
    apply_pagination
    @query
  end

  private

  def apply_filters
    if @args[:nameFilter].present?
      @query = @query.where("name ILIKE '#{@args[:nameFilter]}%'")
    end
  end

  def apply_sort
    if @args[:sortBy].present?
      field = @args[:sortBy].field.underscore
      order = @args[:sortBy].order
      @query = @query.order("player_statistics.#{field} #{order}")
    end
  end

  def set_total_count
    # Need to count players that match the filters before we apply pagination
    @context[:total_query_count] = @query.count
  end

  def apply_pagination
    if @args[:limit].present?
      @query = @query.limit(@args[:limit])
    end

    if @args[:offset].present?
      @query = @query.offset(@args[:offset])
    end
  end


end