class ApplicationDatatable < AjaxDatatablesRails::Base

  private

  def filtra_check_box
    ->(column) { column.table[column.field].eq(string_to_boolean(column.search.value)) }
  end

  def permitido?
    options[:permitido]
  end

end
