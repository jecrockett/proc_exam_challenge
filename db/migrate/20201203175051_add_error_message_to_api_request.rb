class AddErrorMessageToApiRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :api_requests, :error_message, :string
  end
end
