class ListPdf < Prawn::Document
  def initialize(list, view)
    super(top_margin: 70)
    @list = list
    @view = view
    line_items
    total_price
  end
  
  def line_items
    table line_item_rows do 
      row(0).font_style = :bold
      columns(1).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def line_item_rows
    [["Items", "Value"]] +
    @list.map do |item|
      [item.item, price(item.value)]
    end
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
  
  def total_price
    move_down 15
    text "Total Value: #{price(@list.sum(:value))}", size: 16, style: :bold
    text "Total Items: #{@list.count(:item)}", size: 16, style: :bold
  end
end

