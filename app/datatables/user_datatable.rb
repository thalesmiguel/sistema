class UserDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_user_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['User.username', 'User.email', 'User.created_at']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['User.username', 'User.email']
  end


  private

  def data
    records.map do |record|
      [
        record.username,
        record.email,
        record.created_at.to_s(:data_formatada),
        record.updated_at.to_s(:data_formatada),
        "#{link_to_edit edit_user_path(record) if permitido?}" "#{link_to_destroy record, 'excluir-user' if permitido?}"
      ]
    end
  end

  def get_raw_records
    User.all
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
