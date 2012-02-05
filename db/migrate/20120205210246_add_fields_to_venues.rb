class AddFieldsToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :daily_trend_count, :integer
    add_column :venues, :daily_trend_time, :datetime
    add_column :venues, :weekly_trend_count, :integer
    add_column :venues, :weekly_trend_time, :datetime    
    add_column :venues, :monthly_trend_count, :integer
    add_column :venues, :monthly_trend_time, :datetime    
    add_column :venues, :yearly_trend_count, :integer
    add_column :venues, :yearly_trend_time, :datetime    
  end

  def self.down
    remove_column :venues, :daily_trend_count, :integer
    remove_column :venues, :daily_trend_time, :datetime
    remove_column :venues, :weekly_trend_count, :integer
    remove_column :venues, :weekly_trend_time, :datetime    
    remove_column :venues, :monthly_trend_count, :integer
    remove_column :venues, :monthly_trend_time, :datetime    
    remove_column :venues, :yearly_trend_count, :integer
    remove_column :venues, :yearly_trend_time, :datetime
  end
end
