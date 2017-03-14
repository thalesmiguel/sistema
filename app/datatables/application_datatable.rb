class ApplicationDatatable < AjaxDatatablesRails::Base

  private

  def filtra_check_box
    ->(column) { column.table[column.field].eq(string_to_boolean(column.search.value)) }
  end

  def filtra_data
    # ->(column) { column.table[column.field].matches("#{ column.search.value.to_time.to_s(:data_banco) }%" ) if column.search.value.to_time }
    ->(column) { column.table[column.field].matches("#{ (Time.parse(column.search.value).to_s(:data_banco) + "%" rescue nil) }" ) }
  end

  def filtra_hora
    # ->(column) { column.table[column.field].matches("#{ column.search.value.to_time.to_s(:data_banco) }%" ) if column.search.value.to_time }
    ->(column) { column.table[column.field].matches("%#{ (Time.parse(column.search.value).to_s(:hora_banco) + "%" rescue nil) }" ) }
  end

  def permitido?
    options[:permitido]
  end

  def boolean_pt(boolean)
    boolean == true ? 'verdadeiro' : 'falso'
  end

  def string_to_boolean(boolean)
    (1 if boolean == 'verdadeiro') || (0 if boolean == 'falso') || -1
  end

  def created_by(record)
    record.audits.first.user.username unless record.audits.first.user.nil?
  end

  def updated_by(record)
    record.audits.last.user.username unless record.audits.last.user.nil?
  end

end
