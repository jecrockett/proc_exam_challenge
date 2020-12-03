class CreateApiRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :api_requests do |t|
      t.string :request_method
      t.string :endpoint
      t.string :payload
      t.string :remote_ip
      t.string :response_code
      t.string :response_body

      t.timestamps
    end
  end
end
