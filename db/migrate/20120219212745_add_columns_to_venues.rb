class AddColumnsToVenues < ActiveRecord::Migration
    def self.up
      add_column :venues, :frat_score, :integer
      add_column :venues, :sport_score, :integer
      add_column :venues, :hipster_score, :integer
      add_column :venues, :dive_score, :integer    
      add_column :venues, :exclusive_score, :integer
      add_column :venues, :dance_score, :integer    
    end

    def self.down
      remove_column :venues, :frat_score
      remove_column :venues, :sport_score
      remove_column :venues, :hipster_score
      remove_column :venues, :dive_score    
      remove_column :venues, :exclusive_score
      remove_column :venues, :dance_score
    end
end
