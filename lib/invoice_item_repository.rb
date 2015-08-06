require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository

  def load_data(csv_path)
    map_data(InvoiceItem, File.join(csv_path, "invoice_items.csv"))
  end

  def item_data_by_invoice(method_name)
    output_hash = {}

    se.invoice_item_repository.table.each do |invoice_item|
      invoice_id = invoice_item.invoice_id
      item_id = invoice_item.item_id
      data = invoice_item.send(method_name)
      output_hash[invoice_id] ||= {}

      if output_hash[invoice_id][item_id].nil?
        output_hash[invoice_id][item_id] = data
      else
        output_hash[invoice_id][item_id] += data
      end

    end
    output_hash
  end

  def items_values(data_by_invoice)
    output = Hash.new(0)
    data_by_invoice.each do |invoice_id, items_with_values|
      invoice = se.invoice_repository.find_by_id(invoice_id)
      if invoice.successful?
        items_with_values.each {|item_id, value| output[item_id] += value}
      end
    end
    output
  end

  def add_invoice_items(items, invoice_id)
    items_by_id = items.group_by {|item| item.id}
    item_counts = items_by_id.map{|id, items| [id, items.count]}

    item_counts.each do |item_id, quantity|
      new_id = table.first.id + 1
      unit_price = se.item_repository.find_by(:id, item_id).unit_price
      created_at = Time.now.utc.to_s
      updated_at = created_at

      new_record = [new_id, item_id, invoice_id, quantity, unit_price,
                    created_at, updated_at]
      table.unshift(InvoiceItem.new(new_record, self))
      @quick_lookup_table = populate_quick_lookup_table(table)
    end
  end

end
