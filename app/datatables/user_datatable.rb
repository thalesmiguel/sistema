class UserDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      username: { source: "User.username", cond: :like },
      email: { source: "User.email", cond: :like },
      created_at: { source: "User.created_at", cond: :like },
      updated_at: { source: "User.updated_at", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        username: record.username,
        email: record.email,
        created_at: record.created_at.to_s(:data_formatada),
        updated_at: record.updated_at.to_s(:data_formatada),
        DT_RowId: "user_#{record.id}",
      }
    end
  end

  def get_raw_records
    User.all
  end

  def permitido?
    options[:permitido]
  end
end
