class PlayerQuery < ApplicationService
  def initialize(**args)
    @args = args
    @query = Player.includes(:stats)
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
      field = parse_sort_field(@args[:sortBy].field)

      order = @args[:sortBy].order
      @query = @query.order("player_statistics.#{field} #{order}")
    end
  end

  def parse_sort_field(field)
    if field == "longestRush"
      "longest_rush_distance"
    elsif field == "rushing20Plus"
      "rushing_20_plus"
    elsif field == "rushing40Plus"
      "rushing_40_plus"
    else
      field.underscore
    end
  end

  def set_total_count
    # Need to count players that match the filters before we apply pagination
    if @args[:context]
      @args[:context][:total_query_count] = @query.count
    end
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